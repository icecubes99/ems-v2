"use client"

import * as React from "react"
import { Check, ChevronDown, X } from "lucide-react"
import * as PopoverPrimitive from "@radix-ui/react-popover"

import { cn } from "@/lib/utils"
import { Button } from "@/components/ui/button"

interface Option {
    label: string
    value: string
}

interface LiteMultiSelectProps {
    options: Option[]
    onChange: (selectedValues: string[]) => void
    placeholder?: string
    itemName?: string
}

export function LiteMultiSelect({
    itemName = "item",
    options,
    onChange,
    placeholder = "Select options",
}: LiteMultiSelectProps) {
    const [selectedValues, setSelectedValues] = React.useState<string[]>([])
    const [open, setOpen] = React.useState(false)

    const handleToggleOption = (value: string) => {
        const newSelectedValues = selectedValues.includes(value)
            ? selectedValues.filter((v) => v !== value)
            : [...selectedValues, value]
        setSelectedValues(newSelectedValues)
        onChange(newSelectedValues)
    }

    const handleClear = (e: React.MouseEvent) => {
        e.stopPropagation()
        setSelectedValues([])
        onChange([])
    }

    const handleSelectAll = (e: React.MouseEvent) => {
        e.stopPropagation()
        const allValues = options.map((option) => option.value)
        setSelectedValues(allValues)
        onChange(allValues)
    }

    return (
        <PopoverPrimitive.Root open={open} onOpenChange={setOpen}>
            <PopoverPrimitive.Trigger asChild>
                <Button
                    variant="outline"
                    role="combobox"
                    aria-expanded={open}
                    className="w-full justify-between"
                >
                    {selectedValues.length > 0 ? (
                        <span className="truncate">
                            {selectedValues.length} {itemName}
                            {selectedValues.length > 1 ? "s" : ""} selected
                        </span>
                    ) : (
                        <span className="text-muted-foreground">{placeholder}</span>
                    )}
                    <div className="flex items-center">
                        {selectedValues.length > 0 && (
                            <X
                                className="mr-2 h-4 w-4 text-muted-foreground cursor-pointer"
                                onClick={handleClear}
                            />
                        )}
                        <ChevronDown className="ml-2 h-4 w-4 shrink-0 opacity-50" />
                    </div>
                </Button>
            </PopoverPrimitive.Trigger>
            <PopoverPrimitive.Content
                className="z-50 w-[var(--radix-popover-trigger-width)] p-0 bg-popover border rounded-md shadow-md"
                align="start"
            >
                <div className="p-1 border-b">
                    <div className="flex justify-between">
                        <Button variant="ghost" size="sm" onClick={handleSelectAll}>
                            Select All
                        </Button>
                        {/* <Button variant="ghost" size="sm" onClick={handleClear}>
                            Clear All
                        </Button> */}
                    </div>
                </div>
                <div className="max-h-[200px] overflow-auto p-1">
                    {options.map((option) => (
                        <div
                            key={option.value}
                            className={cn(
                                "relative flex w-full cursor-default select-none items-center rounded-sm py-1.5 pl-2 pr-8 text-sm outline-none",
                                "hover:bg-accent hover:text-accent-foreground",
                                "focus:bg-accent focus:text-accent-foreground"
                            )}
                            onClick={() => handleToggleOption(option.value)}
                        >
                            <div
                                className={cn(
                                    "mr-2 h-4 w-4 border rounded-sm flex items-center justify-center",
                                    selectedValues.includes(option.value)
                                        ? "bg-primary border-primary"
                                        : "border-input"
                                )}
                            >
                                {selectedValues.includes(option.value) && (
                                    <Check className="h-3 w-3 text-primary-foreground" />
                                )}
                            </div>
                            {option.label}
                        </div>
                    ))}
                </div>
            </PopoverPrimitive.Content>
        </PopoverPrimitive.Root>
    )
}