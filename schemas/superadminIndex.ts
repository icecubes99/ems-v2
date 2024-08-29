import { Gender, Status, UserRole } from "@prisma/client";
import * as z from "zod";

export const DepartmentSchema = z.object({
    departmentName: z.string().min(1, {
        message: "Department Name is required",
    }),
    departmentDescription: z.string().min(1, {
        message: "Department Description is required",
    }),
    status: z.enum([Status.ACTIVE, Status.INACTIVE]),
    departmentHeadUserId: z.string().min(1, {
        message: "Department Head is required",
    }),
})


export const DesignationSchema = z.object({
    designationName: z.string().min(1, {
        message: "Designation Name is required",
    }),
    designationDescription: z.string().min(1, {
        message: "Designation Description is required",
    }),
    status: z.enum([Status.ACTIVE, Status.INACTIVE]),
    departmentId: z.string().min(1, {
        message: "Department ID is required",
    }),
    designationHeadUserId: z.string().min(1, {
        message: "Designation Head is required",
    }),
})