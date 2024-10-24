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

export const IncreaseDesignationSalarySchema = z.object({
    designationIds: z.array(z.string()).min(1, {
        message: "At least one Department must be selected",
    }),
    increaseType: z.enum(['percentage', 'amount']),
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