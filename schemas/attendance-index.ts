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
    reason: z.string().min(1, "Reason is required"),
    overtimeType: z.nativeEnum(OvertimeType),
    timeOut: z.string().refine((time) => {
        const [hours, minutes] = time.split(':').map(Number);
        const totalMinutes = hours * 60 + minutes;
        return totalMinutes >= 18 * 60 + 1 && totalMinutes <= 21 * 60;
    }, {
        message: "Time out must be between 6:01 PM and 9:00 PM",
    }),
});
export const PendingOvertimesSchema = z.object({
    status: z.enum([LeaveStatus.PENDING, LeaveStatus.APPROVED, LeaveStatus.REJECTED])
})

export const AdvanceClockInSchema = z.object({
    userIds: z.array(z.string()).min(1, "At least one user must be selected"),
    startDate: z.string().min(1, "Start date is required"),
    endDate: z.string().min(1, "End date is required"),
    type: z.string().min(1, "Type is required")
}).refine(data => new Date(data.endDate) >= new Date(data.startDate), {
    message: "End date cannot be before start date",
    path: ["endDate"],
});