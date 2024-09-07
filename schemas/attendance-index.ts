import { Gender, UserRole } from "@prisma/client";
import * as z from "zod";


export const TimesheetSchema = z.object({
    password: z.string().optional()
})