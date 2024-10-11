"use server"

import { db } from '@/lib/db'
import { addDays, eachDayOfInterval, endOfYear, format, isWeekend, startOfDay, startOfYear } from 'date-fns'
import crypto from 'crypto'
import { currentUser } from '@/lib/auth'
import { HolidaySchema } from '@/schemas/superadminIndex'
import * as z from "zod";
import { getUserById } from '@/data/user'
import { superAdmin } from './superAdmin'
import { auditAction } from '../auditAction'

// Define constant holidays
const CONSTANT_HOLIDAYS = [
    { month: 1, day: 1, name: "New Year's Day" },
    { month: 2, day: 25, name: "EDSA People Power Revolution Anniversary" },
    { month: 4, day: 9, name: "Araw ng Kagitingan" },
    { month: 5, day: 1, name: "Labor Day" },
    { month: 6, day: 12, name: "Independence Day" },
    { month: 8, day: 21, name: "Ninoy Aquino Day" },
    { month: 8, day: 31, name: "National Heroes Day" }, // Last Monday of August
    { month: 11, day: 1, name: "All Saints' Day" },
    { month: 11, day: 2, name: "All Souls' Day" },
    { month: 11, day: 30, name: "Bonifacio Day" },
    { month: 12, day: 25, name: "Christmas Day" },
    { month: 12, day: 30, name: "Rizal Day" },
    { month: 12, day: 31, name: "New Year's Eve" },
    // Add more constant holidays as needed
]

export async function checkWorkingDaysExist() {
    const currentYear = new Date().getFullYear()
    const startDate = startOfYear(new Date(currentYear, 0, 1))
    const endDate = endOfYear(startDate)

    const workingDaysCount = await db.workingDay.count({
        where: {
            date: {
                gte: startDate,
                lte: endDate
            }
        }
    })

    return workingDaysCount > 0
}

export async function generateWorkingMonthsAndDays() {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" }
    }

    const dbUser = await getUserById(user.id);
    if (!dbUser) {
        return { error: "User not found in database!" }
    }

    const superadminResult = await superAdmin();
    if (superadminResult.error) {
        return { error: superadminResult.error }
    }

    const startDate = new Date()
    const endDate = endOfYear(startDate)
    const year = startDate.getFullYear()

    const daysInYear = eachDayOfInterval({ start: startDate, end: endDate })

    try {
        await db.$transaction(async (tx) => {
            for (const day of daysInYear) {
                const month = day.getMonth() + 1

                // Create or find the WorkingMonth
                const workingMonth = await tx.workingMonth.upsert({
                    where: { month_year: { month, year } },
                    update: {},
                    create: { month, year }
                })


                if (!isWeekend(day)) {
                    const password = generatePassword()
                    await tx.workingDay.upsert({
                        where: { date_monthId: { date: day, monthId: workingMonth.id } },
                        update: { password },
                        create: {
                            date: day,
                            password,
                            monthId: workingMonth.id
                        }
                    })
                }

                // Resets the Vacation and Incentive days for all users
                await tx.user.updateMany({
                    data: {
                        vacationDays: 5,
                        incentiveDays: 5
                    }
                });

            }

            // Generate constant holidays
            for (const holiday of CONSTANT_HOLIDAYS) {
                const holidayDate = new Date(year, holiday.month - 1, holiday.day)
                await tx.holiday.upsert({
                    where: {
                        date: holidayDate,
                    },
                    update: {
                        name: holiday.name,
                    },
                    create: {
                        date: holidayDate,
                        name: holiday.name,
                    },
                })

                // Remove corresponding working day if it exists
                await tx.workingDay.deleteMany({
                    where: {
                        date: holidayDate,
                    },
                })
            }
        })

        const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;
        await auditAction(dbUser.id, `Working Days, Months, and Constant Holidays For The Year Generated by Superadmin: ${superAdminName}`)

        return { success: "Working days, months, and constant holidays generated successfully" }
    } catch (error) {
        console.error("Error generating working year:", error)
        return { error: "Failed to generate working year" }
    }
}

export async function addHoliday(values: z.infer<typeof HolidaySchema>) {
    const user = await currentUser();
    const validatedFields = HolidaySchema.safeParse(values);

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const dbUser = await getUserById(user.id);

    if (!validatedFields.success) {
        return { error: "Invalid Fields!" };
    }

    if (!dbUser) {
        return { error: "User not found in database!" }
    }

    const superadminResult = await superAdmin();
    if (superadminResult.error) {
        return { error: superadminResult.error }
    }

    const { date, name } = validatedFields.data

    const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;

    await auditAction(dbUser.id, `Holiday Created by Superadmin: ${superAdminName}`)

    const holidayDate = startOfDay(new Date(date))
    // Find the WorkingDay for this date
    const workingDay = await db.workingDay.findFirst({
        where: {
            date: holidayDate
        }
    })

    if (workingDay) {
        // If a WorkingDay exists, delete it as it's now a holiday
        await db.workingDay.delete({
            where: { id: workingDay.id }
        })
    }

    // Add the holiday
    await db.holiday.create({
        data: {
            date: holidayDate,
            name: name
        }
    });

    return { success: "Holiday Created" }
}

export async function editHoliday(holidayId: string, values: z.infer<typeof HolidaySchema>) {
    const user = await currentUser();
    const validatedFields = HolidaySchema.safeParse(values);

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const dbUser = await getUserById(user.id);

    if (!validatedFields.success) {
        return { error: "Invalid Fields!" };
    }

    if (!dbUser) {
        return { error: "User not found in database!" }
    }

    const superadminResult = await superAdmin();
    if (superadminResult.error) {
        return { error: superadminResult.error }
    }

    const { date, name } = validatedFields.data

    const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;

    try {
        await db.$transaction(async (tx) => {
            // Find the existing holiday
            const existingHoliday = await tx.holiday.findUnique({
                where: { id: holidayId }
            });

            if (!existingHoliday) {
                throw new Error("Holiday not found");
            }

            const newHolidayDate = startOfDay(new Date(date));

            // Check if the date has changed
            if (existingHoliday.date.getTime() !== newHolidayDate.getTime()) {
                // Delete the working day for the new holiday date if it exists
                await tx.workingDay.deleteMany({
                    where: { date: newHolidayDate }
                });

                // If the new date is a weekday, create a working day for the old holiday date
                if (!isWeekend(existingHoliday.date)) {
                    const workingMonth = await tx.workingMonth.findFirst({
                        where: {
                            month: existingHoliday.date.getMonth() + 1,
                            year: existingHoliday.date.getFullYear()
                        }
                    });

                    if (workingMonth) {
                        await tx.workingDay.create({
                            data: {
                                date: existingHoliday.date,
                                password: generatePassword(),
                                monthId: workingMonth.id
                            }
                        });
                    }
                }
            }

            // Update the holiday
            await tx.holiday.update({
                where: { id: holidayId },
                data: {
                    date: newHolidayDate,
                    name: name
                }
            });
        });

        await auditAction(dbUser.id, `Holiday Edited by Superadmin: ${superAdminName}`);

        return { success: "Holiday Updated Successfully" };
    } catch (error) {
        console.error("Error editing holiday:", error);
        return { error: "Failed to edit holiday" };
    }
}

export async function removeHoliday(holidayId: string) {
    const user = await currentUser();

    if (!user) {
        return { error: "Unauthorized!" }
    }

    const dbUser = await getUserById(user.id);

    if (!dbUser) {
        return { error: "User not found in database!" }
    }

    const superadminResult = await superAdmin();
    if (superadminResult.error) {
        return { error: superadminResult.error }
    }

    const superAdminName = user.name || dbUser.firstName + " " + dbUser.lastName;

    try {
        await db.$transaction(async (tx) => {
            // Find the existing holiday
            const existingHoliday = await tx.holiday.findUnique({
                where: { id: holidayId }
            });

            if (!existingHoliday) {
                throw new Error("Holiday not found");
            }

            // Delete the holiday
            await tx.holiday.delete({
                where: { id: holidayId }
            });

            // If the holiday date is a weekday, create a working day
            if (!isWeekend(existingHoliday.date)) {
                const workingMonth = await tx.workingMonth.findFirst({
                    where: {
                        month: existingHoliday.date.getMonth() + 1,
                        year: existingHoliday.date.getFullYear()
                    }
                });

                if (workingMonth) {
                    await tx.workingDay.create({
                        data: {
                            date: existingHoliday.date,
                            password: generatePassword(),
                            monthId: workingMonth.id
                        }
                    });
                }
            }
        });

        await auditAction(dbUser.id, `Holiday Removed by Superadmin: ${superAdminName}`);

        return { success: "Holiday Removed Successfully" };
    } catch (error) {
        console.error("Error removing holiday:", error);
        return { error: "Failed to remove holiday" };
    }
}


function generatePassword(): string {
    return crypto.randomBytes(3).toString('hex')
}