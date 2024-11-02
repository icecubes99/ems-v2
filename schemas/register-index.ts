import { EmployeeType, Gender, Status, UserRole } from "@prisma/client";
import * as z from "zod";

export const newRegisterSchema = z.object({
    email: z.string().email({
        message: "Email is required",
    }),
    password: z.string().min(6, {
        message: "Minimum 6 characters required",
    }),
    firstName: z.string().min(1, {
        message: "First Name is required",
    }),
    middleName: z.string().min(1, {
        message: "Middle Name is required",
    }),
    lastName: z.string().min(1, {
        message: "Last Name is required",
    }),
    gender: z.enum([Gender.MALE, Gender.FEMALE, Gender.OTHER]),
    birthDate: z.string().min(1, {
        message: "Birth Date is Required"
    }),

    role: z.enum([UserRole.USER, UserRole.SUPERADMIN, UserRole.ADMIN]),

    jobTitle: z.string().min(1, {
        message: "Job Title is required",
    }), // Select Component Based on the designation Id of the user

    // Assign Designation Model    
    designationId: z.string().min(1, {
        message: "Designation is required",
    }),
    employeeType: z.enum([EmployeeType.CONTRACTUAL, EmployeeType.REGULAR, EmployeeType.PROBATIONARY]),
    status: z.enum([Status.ACTIVE, Status.INACTIVE]),

    // UserSalary Model

    basicSalary: z.number().min(1, {
        message: "Basic Salary"
    }),

    // GovernmentId Model

    sssNumber: z.string().min(1, {
        message: "SSS Number is required",
    }),
    tinNumber: z.string().min(1, {
        message: "TIN Number is required",
    }),
    philHealthNumber: z.string().min(1, {
        message: "PhilHealth Number is required",
    }),
    pagIbigNumber: z.string().min(1, {
        message: "Pag-Ibig Number is required",
    }),


})

export const ChangeUserRoleSchema = z.object({
    userId: z.string(),
    role: z.enum([UserRole.USER, UserRole.ADMIN, UserRole.SUPERADMIN])
});