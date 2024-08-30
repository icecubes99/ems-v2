"use client"

import React from 'react'
import { Dialog as ShadcnDialog, DialogContent as ShadcnDialogContent, DialogTrigger as ShadcnDialogTrigger } from '@/components/ui/dialog'
import { useRouter } from 'next/navigation'

interface RefreshingDialogProps extends React.ComponentProps<typeof ShadcnDialog> {
    children: React.ReactNode
}

export function RefreshingDialog({ children, ...props }: RefreshingDialogProps) {
    const router = useRouter()

    const handleOpenChange = (open: boolean) => {
        if (!open) {
            router.refresh()
        }
        if (props.onOpenChange) {
            props.onOpenChange(open)
        }
    }

    return (
        <ShadcnDialog {...props} onOpenChange={handleOpenChange}>
            {children}
        </ShadcnDialog>
    )
}

export const DialogContent = ShadcnDialogContent
export const DialogTrigger = ShadcnDialogTrigger