'use client'

import { useState, useEffect } from 'react'
import { fetchDepartmentHeadUserList, fetchDesignationHeadUserList, fetchUserList } from '@/data/fetch-user-list'
import { User } from '@prisma/client'

export function useUserList() {
    const [users, setUsers] = useState<User[]>([])
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState<Error | null>(null)

    useEffect(() => {
        async function loadUsers() {
            try {
                setLoading(true)
                const fetchedUsers = await fetchUserList()
                setUsers(fetchedUsers)
            } catch (e) {
                setError(e instanceof Error ? e : new Error('An error occurred while fetching users'))
            } finally {
                setLoading(false)
            }
        }

        loadUsers()
    }, [])

    return { users, loading, error }
}

export function useUserListWithDesignationHead(designationHeadId: string) {
    const [users, setUsers] = useState<User[]>([])
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState<Error | null>(null)

    useEffect(() => {
        async function loadUsers() {
            try {
                setLoading(true)
                const fetchedUsers = await fetchDesignationHeadUserList(designationHeadId)
                setUsers(fetchedUsers)
            } catch (e) {
                setError(e instanceof Error ? e : new Error('An error occurred while fetching users'))
            } finally {
                setLoading(false)
            }
        }

        loadUsers()
    }, [])

    return { users, loading, error }
}

export function useUserListWithDepartmentHead(departmentHeadId: string) {
    const [users, setUsers] = useState<User[]>([])
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState<Error | null>(null)

    useEffect(() => {
        async function loadUsers() {
            try {
                setLoading(true)
                const fetchedUsers = await fetchDepartmentHeadUserList(departmentHeadId)
                setUsers(fetchedUsers)
            } catch (e) {
                setError(e instanceof Error ? e : new Error('An error occurred while fetching users'))
            } finally {
                setLoading(false)
            }
        }

        loadUsers()
    }, [])

    return { users, loading, error }
}