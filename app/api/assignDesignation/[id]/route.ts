import { db } from "@/lib/db";
import { NextResponse } from "next/server";
import { AssignDesignationWithUser } from "@/types/types";


export async function GET(
    request: Request,
    { params }: { params: { id: string } }
) {
    try {
        const assignedUsersWithData = await db.assignDesignation.findMany({
            where: {
                designationId: params.id
            },
            include: {
                user: true // This includes the related user data
            }
        });

        // The result is already in the format of AssignDesignationWithUser[]
        return NextResponse.json(assignedUsersWithData);
    } catch (error) {
        console.error("Error fetching assigned users:", error);
        return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
    }
}