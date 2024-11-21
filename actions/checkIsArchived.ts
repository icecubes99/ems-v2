import { db } from "@/lib/db";

export async function checkIsArchived(userId: string) {
    try {
        const user = await db.user.findFirst({
            where: {
                id: userId
            }
        });
        if (!user) {
            return { error: "User not found in database!" }
        }
        if (user.isArchived) {
            return { error: "User is already archived!" }
        }
        return { success: "User is not archived!" }
    } catch (error) {
        console.log("Error in checking if user is archived", error)
        return { error: "Error checking if user is archived" }
    }
}