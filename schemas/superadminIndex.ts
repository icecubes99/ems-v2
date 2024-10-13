import { EmployeeType, Gender, Status, UserRole } from "@prisma/client";
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
    designationSalary: z.number().min(1, "Salary is required"),
})

export const AssignedDesignationSchema = z.object({
    userId: z.string().min(1, {
        message: "User ID is required",
    }),
    employeeType: z.enum([EmployeeType.REGULAR, EmployeeType.CONTRACTUAL, EmployeeType.PROBATIONARY]),
    status: z.enum([Status.ACTIVE, Status.INACTIVE]),
    designationId: z.string().min(1, {
        message: "Designation ID is required",
    }),

})

export const HolidaySchema = z.object({
    date: z.string().min(1, {
        message: "Date is required",
    }),
    name: z.string().min(1, {
        message: "Name is required",
    }),
})