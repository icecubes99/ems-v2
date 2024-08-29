import { getUserNameById } from "@/data/user";
import { db } from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(request: Request) {
    const allDepartments = await db.department.findMany({
        include: {
            departmentHeadUser: true
        }
    });

    const departmentsWithUserNames = await Promise.all(allDepartments.map(async (department) => {
        if (department.departmentHeadUserId) {
            const userName = await getUserNameById(department.departmentHeadUserId);
            return {
                ...department,
                departmentHeadUserName: userName
            };
        }
        return department;
    }));



    return NextResponse.json(departmentsWithUserNames);
}