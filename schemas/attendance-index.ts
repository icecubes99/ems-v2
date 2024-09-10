import { Gender, LeaveStatus, LeaveType, OvertimeType, UserRole } from "@prisma/client";
import * as z from "zod";


export const TimesheetSchema = z.object({
    password: z.string().optional()
})

export const LeaveRequestSchema = z.object({
    startDate: z.string().min(1, "Start date is required"),
    endDate: z.string().min(1, "End date is required"),
    reason: z.string().min(1, "Reason is required"),
    leaveType: z.enum([LeaveType.VACATION, LeaveType.SICK, LeaveType.INCENTIVE, LeaveType.MATERNITY])
}).refine(data => new Date(data.endDate) >= new Date(data.startDate), {
    message: "End date cannot be before start date",
    path: ["endDate"],
});

export const PendingLeavesSchema = z.object({
    leaveStatus: z.enum([LeaveStatus.PENDING, LeaveStatus.APPROVED, LeaveStatus.REJECTED])
})

export const OvertimeSchema = z.object({
    reason: z.string().min(1, "Reason is Required"),
    overtimeType: z.enum([OvertimeType.HOLIDAY, OvertimeType.MANDATORY, OvertimeType.REGULAR])
})