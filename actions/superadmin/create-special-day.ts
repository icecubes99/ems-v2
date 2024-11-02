"use server"

import { db } from "@/lib/db";
import { currentUser } from "@/lib/auth";
import { auditAction } from "../auditAction";
import { superAdmin } from "./superAdmin";
import * as z from "zod";
import { startOfDay } from "date-fns";
import crypto from 'crypto';
import { SpecialDaySchema } from "@/schemas/attendance-index";

export async function createSpecialDay(values: z.infer<typeof SpecialDaySchema>) {
    try {
        // Steps 1-3 remain the same
        const user = await currentUser();
        if (!user) {
            return { error: "Unauthorized!" };
        }

        const superAdminResult = await superAdmin();
        if (superAdminResult.error) {
            return { error: superAdminResult.error };
        }

        const validatedFields = SpecialDaySchema.safeParse(values);
        if (!validatedFields.success) {
            return { error: "Invalid fields!" };
        }

        const { date } = validatedFields.data;
        const normalizedDate = startOfDay(new Date(date));

        // New Step: Check and delete holiday if exists
        const existingHoliday = await db.holiday.findFirst({
            where: {
                date: normalizedDate
            }
        });

        if (existingHoliday) {
            await db.holiday.delete({
                where: {
                    id: existingHoliday.id
                }
            });
        }

        // Remaining steps continue as before
        const workingMonth = await db.workingMonth.findFirst({
            where: {
                month: normalizedDate.getMonth() + 1,
                year: normalizedDate.getFullYear()
            }
        });

        if (!workingMonth) {
            return { error: "Working month not found for this date" };
        }

        const existingDay = await db.workingDay.findFirst({
            where: {
                date: normalizedDate
            }
        });

        if (existingDay) {
            await db.workingDay.update({
                where: { id: existingDay.id },
                data: {
                    isRequired: false,
                }
            });
        } else {
            await db.workingDay.create({
                data: {
                    date: normalizedDate,
                    monthId: workingMonth.id,
                    password: crypto.randomBytes(3).toString('hex'),
                    isRequired: false,
                }
            });
        }

        await auditAction(
            user.id,
            `Special working day created for ${normalizedDate.toLocaleDateString()} by SuperAdmin: ${user.name}`
        );

        return { success: "Special working day created successfully" };
    } catch (error) {
        console.error("Error creating special day:", error);
        return { error: "Failed to create special working day" };
    }
}