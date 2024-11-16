import { Status } from "@prisma/client";
import { start } from "repl";
import * as z from "zod";

export const DeductionsSchema = z.object({
    userIds: z.array(z.string()).min(1, {
        message: "At least one user must be selected",
    }),
    deductionType: z.string().min(1, {
        message: "Deduction Type is required",
    }),
    amount: z.number().min(1, {
        message: "Amount is required",
    }).max(10000, {
        message: "Amount must be less than PHP 10,000",
    }),
    description: z.string().min(1, {
        message: "Description is required",
    }),
})

export const DeductionsSoloSchema = z.object({
    userId: z.string().min(1, {
        message: "At least one user must be selected",
    }),
    deductionType: z.string().min(1, {
        message: "Deduction Type is required",
    }),
    amount: z.number().min(1, {
        message: "Amount is required",
    }).max(10000, {
        message: "Amount must be less than PHP 10,000",
    }),
    description: z.string().min(1, {
        message: "Description is required",
    }),
})


export const DeductionsSchemaWithUser = z.object({
    deductionType: z.string().min(1, {
        message: "Deduction Type is required",
    }),
    amount: z.number().min(1, {
        message: "Amount is required",
    }).max(10000, {
        message: "Amount must be less than PHP 10,000",
    }),
    description: z.string().min(1, {
        message: "Description is required",
    }),
})

export const AdditionalEarningsSchema = z.object({
    userIds: z.array(z.string()).min(1, {
        message: "At least one user must be selected",
    }),
    earningType: z.string().min(1, {
        message: "Earning Type is required",
    }),
    amount: z.number().min(1, {
        message: "Amount is required",
    }).max(20000, {
        message: "Amount must be less than PHP 10,000",
    }),
    description: z.string().min(1, {
        message: "Description is required",
    }),
})

export const AdditionalEarningsSoloSchema = z.object({
    userId: z.string().min(1, {
        message: "At least one user must be selected",
    }),
    earningType: z.string().min(1, {
        message: "Earning Type is required",
    }),
    amount: z.number().min(1, {
        message: "Amount is required",
    }).max(20000, {
        message: "Amount must be less than PHP 10,000",
    }),
    description: z.string().min(1, {
        message: "Description is required",
    }),
})

export const AdditionalEarningsSchemaWithUser = z.object({
    earningType: z.string().min(1, {
        message: "Earning Type is required",
    }),
    amount: z.number().min(1, {
        message: "Amount is required",
    }).max(20000, {
        message: "Amount must be less than PHP 10,000",
    }),
    description: z.string().min(1, {
        message: "Description is required",
    }),
})

export const IncreaseDepartmentSalarySchema = z.object({
    departmentIds: z.array(z.string()).min(1, {
        message: "At least one Department must be selected",
    }),
    increaseType: z.enum(['percentage', 'amount']),
    value: z.number().positive(),
});
export const DecreaseDepartmentSalarySchema = z.object({
    departmentIds: z.array(z.string()).min(1, {
        message: "At least one Department must be selected",
    }),
    decreaseType: z.enum(['percentage', 'amount']),
    value: z.number().positive(),
});

export const IncreaseDesignationSalarySchema = z.object({
    designationIds: z.array(z.string()).min(1, {
        message: "At least one Department must be selected",
    }),
    increaseType: z.enum(['percentage', 'amount']),
    value: z.number().positive(),
});
export const DecreaseDesignationSalarySchema = z.object({
    designationIds: z.array(z.string()).min(1, {
        message: "At least one Department must be selected",
    }),
    decreaseType: z.enum(['percentage', 'amount']),
    value: z.number().positive(),
});

export const PayrollFirstsStep = z.object({
    payPeriodStart: z.string().min(1, "Start date is required"),
    payPeriodEnd: z.string().min(1, "End date is required"),
}).refine(data => new Date(data.payPeriodEnd) >= new Date(data.payPeriodStart), {
    message: "End date cannot be before start date",
    path: ["endDate"],
});

export const AddEmployeeToPayrollCalculatedSchema = z.object({
    userIds: z.array(z.string()).min(1, "User is required"),
})

export const EmployeeAllowanceSchema = z.object({
    userId: z.string().min(1, "User is required"),
    type: z.string().min(1, "Allowance Type is required"),
    amount: z.number().min(1, "Amount is required"),
    startDate: z.string().min(1, "Start Date is required"),
    endDate: z.string().min(1, "End Date is required"),
    status: z.enum([Status.ACTIVE, Status.INACTIVE]),
}).refine(data => new Date(data.endDate) >= new Date(data.startDate), {
    message: "End date cannot be before start date",
    path: ["endDate"],
});

export const EditDesignationSalarySchema = z.object({
    designationId: z.string(),
    newSalary: z.number().positive(),
});

export const EditPayrollItemTimesheetSchema = z.object({
    isLate: z.boolean(),
    isOvertime: z.boolean(),
    minutesOvertime: z.number().min(1, "Overtime minutes must be greater than 1").max(180, "Overtime minutes must be less than 180"),
    minutesLate: z.number().min(1, "Late minutes must be greater than 1").max(540, "Late minutes must be less than 540"),
})