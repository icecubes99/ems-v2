import { getUserNameById } from "@/data/user";
import { db } from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(request: Request) {
    const allDesignations = await db.designation.findMany({
        include: {
            designationHeadUser: true
        }
    });

    const designationWithUserNames = await Promise.all(allDesignations.map(async (designation) => {
        if (designation.designationHeadUserId) {
            const userName = await getUserNameById(designation.designationHeadUserId)
            return {
                ...designation,
                designationHeadUserName: userName
            }
        }
        return designation
    }));

    return NextResponse.json(designationWithUserNames);
}