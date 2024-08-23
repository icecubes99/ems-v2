import { db } from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(request: Request) {
    const allAddresses = await db.addressLine.findMany();


    return NextResponse.json(allAddresses);
}