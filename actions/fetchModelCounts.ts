"use server"

import { db } from "@/lib/db"

export async function fetchUsersCount() {
    try {
        const userCount = await db.user.count({})
        return userCount
    } catch (error) {
        console.error("Error fetching user count: ", error);
        throw new Error("Failed to fetch Users Count")
    }
}

export async function fetchDepartmentsCount() {
    try {
        const departmentCount = await db.department.count({})
        return departmentCount
    } catch (error) {
        console.error("Error fetching department count: ", error);
        throw new Error("Failed to fetch Department Count")
    }
}

export async function fetchDesignationsCount() {
    try {
        const designationCount = await db.designation.count({})
        return designationCount
    } catch (error) {
        console.error("Error fetching designation count: ", error);
        throw new Error("Failed to fetch Designation Count")
    }
}

export async function fetchOvertimesPendingCount() {
    try {
        const pendingOvertimesCount = await db.overtimes.count({
            where: {
                status: "PENDING"
            }
        })
        return pendingOvertimesCount
    } catch (error) {
        console.error("Error fetching pending overtimes count: ", error);
        throw new Error("Failed to fetch Pending Overtimes Count")
    }
}

export async function fetchLeavesPendingCount() {
    try {
        const pendingLeavesCount = await db.leaves.count({
            where: {
                leaveStatus: "PENDING"
            }
        })
        return pendingLeavesCount
    } catch (error) {
        console.error("Error fetching pending leaves count: ", error);
        throw new Error("Failed to fetch Pending Leaves Count")
    }
}