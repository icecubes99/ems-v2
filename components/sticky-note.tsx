'use client'

import React, { useState } from 'react'
import Draggable from 'react-draggable'
import { X } from 'lucide-react'

interface StickyNoteProps {
    initialPos?: { x: number; y: number }
    onClose?: () => void
    color?: string
    children?: React.ReactNode
}

const StickyNote: React.FC<StickyNoteProps> = ({
    initialPos = { x: 0, y: 0 },
    onClose,
    color = 'yellow',
    children
}) => {
    const [position, setPosition] = useState(initialPos)

    const handleDrag = (e: any, data: { x: number; y: number }) => {
        setPosition({ x: data.x, y: data.y })
    }

    const colorClasses = {
        yellow: 'bg-yellow-200 hover:bg-yellow-300',
        blue: 'bg-blue-200 hover:bg-blue-300',
        green: 'bg-green-200 hover:bg-green-300',
        pink: 'bg-pink-200 hover:bg-pink-300',
        red: 'bg-red-200 hover:bg-red-300',
        violet: `bg-violet-200 hover:bg-violet-300`
    }

    return (
        <Draggable
            position={position}
            onDrag={handleDrag}
            bounds="parent"
        >
            <div className={`absolute cursor-move p-4 rounded-md shadow-md w-64 z-50 ${colorClasses[color as keyof typeof colorClasses]}`}>
                {onClose && (
                    <button
                        onClick={onClose}
                        className="absolute top-2 right-2 w-3 h-3 rounded-full bg-black/20 hover:bg-red-500 group transition-all duration-200"
                    >
                        <X
                            size={8}
                            className="text-transparent group-hover:text-white absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 transition-colors"
                        />
                    </button>
                )}
                <div className="font-sans text-sm">
                    {children}
                </div>
            </div>
        </Draggable>
    )
}

export default StickyNote

