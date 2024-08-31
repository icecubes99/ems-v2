import { db } from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(request: Request) {
    const allUsers = await db.user.findMany({
        where: {
            department: null
        }
    });

    return NextResponse.json(allUsers);
}   