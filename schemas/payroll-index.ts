import * as z from "zod";

export const DeductionsSchema = z.object({
    userId: z.string().min(1, {
        message: "User is required",
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
    userId: z.string().min(1, {
        message: "User is required",
    }),
    earningType: z.string().min(1, {
        message: "Earning Type is required",
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

export const AdditionalEarningsSchemaWithUser = z.object({
    earningType: z.string().min(1, {
        message: "Earning Type is required",
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