import { db } from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(request: Request) {
    // Get the designation head ID from the URL search params
    const { searchParams } = new URL(request.url);
    const currentHeadId = searchParams.get('currentHeadId');

    const users = await db.user.findMany({
        where: {
            OR: [
                { designation: null },
                // Include the current head if their ID is provided
                ...(currentHeadId ? [{ id: currentHeadId }] : [])
            ]
        }
    });

    return NextResponse.json(users);
}