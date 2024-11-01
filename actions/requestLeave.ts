"use server"

import { LeaveRequestSchema } from "@/schemas/attendance-index"
import { db } from "@/lib/db"
import * as z from "zod";
import { currentUser } from "@/lib/auth";
import { auditAction } from "./auditAction";
import { LeaveType, LeaveStatus, Prisma } from "@prisma/client";
import { put } from '@vercel/blob'

export const requestLeave = async (formData: FormData) => {
    const user = await currentUser();
    if (!user) {
        return { error: "Unauthorized!" };
    }

    const values = {
        startDate: formData.get('startDate') as string,
        endDate: formData.get('endDate') as string,
        reason: formData.get('reason') as string,
        leaveType: formData.get('leaveType') as LeaveType,
        document: formData.get('document') as File,
    };

    const validatedFields = LeaveRequestSchema.safeParse(values);
    if (!validatedFields.success) {
        return { error: "Invalid fields!" };
    }

    const { startDate, endDate, reason, leaveType, document } = validatedFields.data;
    if (!startDate || !endDate || !reason) {
        return { error: "Please fill in all fields!" }
    }

    const parsedStartDate = new Date(startDate);
    const parsedEndDate = new Date(endDate);

    if (parsedStartDate > parsedEndDate) {
        return { error: "Start date cannot be after end date!" };
    }

    if (!document) {
        return { error: 'No file provided' }
    }

    // Calculate the number of days requested
    const daysDifference = Math.ceil((parsedEndDate.getTime() - parsedStartDate.getTime()) / (1000 * 3600 * 24)) + 1;

    // Fetch user with their leave records
    const dbUser = await db.user.findUnique({
        where: { id: user.id },
        include: {
            leaves: {
                where: {
                    startDate: { gte: new Date(new Date().getFullYear(), 0, 1) }, // From start of current year
                    leaveStatus: { not: LeaveStatus.REJECTED }
                }
            }
        }
    });

    if (!dbUser) {
        return { error: "User not found in database!" };
    }

    // Calculate used leave days
    const usedVacationDays = dbUser.leaves
        .filter(leave => leave.leaveType === LeaveType.VACATION && leave.leaveStatus !== LeaveStatus.REJECTED)
        .reduce((total, leave) => total + Math.ceil((leave.endDate.getTime() - leave.startDate.getTime()) / (1000 * 3600 * 24)) + 1, 0);

    const usedIncentiveDays = dbUser.leaves
        .filter(leave => leave.leaveType === LeaveType.INCENTIVE && leave.leaveStatus !== LeaveStatus.REJECTED)
        .reduce((total, leave) => total + Math.ceil((leave.endDate.getTime() - leave.startDate.getTime()) / (1000 * 3600 * 24)) + 1, 0);

    const availableVacationDays = (dbUser.vacationDays ?? 0);
    const availableIncentiveDays = (dbUser.incentiveDays ?? 0);

    // Check if the user has enough leave days
    if (leaveType === LeaveType.VACATION && availableVacationDays < daysDifference) {
        return { error: `Not enough vacation days! You have ${availableVacationDays} days available, but requested ${daysDifference} days.` };
    }

    if (leaveType === LeaveType.INCENTIVE && availableIncentiveDays < daysDifference) {
        return { error: `Not enough incentive days! You have ${availableIncentiveDays} days available, but requested ${daysDifference} days.` };
    }

    try {
        const blob = await put(`leaveRequests/${dbUser.id}-${document.name}`, document, {
            access: 'public',
        })

        await db.leaves.create({
            data: {
                startDate: parsedStartDate,
                endDate: parsedEndDate,
                reason,
                leaveType,
                userId: dbUser.id,
                documentLink: blob.url,
            },
        });

        await auditAction(dbUser.id, `User requested ${leaveType} leave from ${startDate} to ${endDate}`);
        return { success: "Leave request submitted!" };
    } catch (error) {
        if (error instanceof Prisma.PrismaClientKnownRequestError) {
            if (error.code === 'P2002') {
                return { error: "You already have a leave request for this date range." };
            }
        }
        console.error("Error submitting leave request:", error);
        return { error: "An error occurred while submitting your leave request." };
    }
}