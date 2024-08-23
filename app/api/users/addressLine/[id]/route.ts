import { db } from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(
    request: Request,
    { params }: { params: { id: string } }
) {
    const id = params.id;
    const designation = await db.addressLine.findUnique({
        where: { id },
    });

    return NextResponse.json(designation);
}
