'use client'

import { useState, useEffect } from 'react'
import { updateGovernmentContribution, getGovernmentContributions } from '@/actions/superadmin/payroll-government-contributions'
import { Button } from '@/components/ui/button'
import { Textarea } from '@/components/ui/textarea'

interface Contribution {
    id: string
    type: string
    brackets: any
    createdAt: Date
    updatedAt: Date
}

export default function GovernmentContributionsEditor() {
    const [contributions, setContributions] = useState<Contribution[]>([])
    const [editingType, setEditingType] = useState<string | null>(null)
    const [editingBrackets, setEditingBrackets] = useState<string>('')

    useEffect(() => {
        fetchContributions()
    }, [])

    async function fetchContributions() {
        const result = await getGovernmentContributions()
        if (result.success && result.data) {
            setContributions(result.data as Contribution[])
            console.log('Set contributions:', result.data)
        } else {
            console.error(result.error)
        }
    }

    async function handleUpdate(type: string) {
        try {
            const brackets = JSON.parse(editingBrackets)
            const result = await updateGovernmentContribution(type, brackets)
            if (result.success) {
                setEditingType(null)
                setEditingBrackets('')
                fetchContributions()
            } else {
                console.error(result.error)
            }
        } catch (error) {
            console.error('Invalid JSON format:', error)
        }
    }

    return (
        <div className="mr-6">
            <h1 className="text-2xl font-bold mb-4">Government Contributions Editor</h1>
            {contributions.map((contribution) => (
                <div key={contribution.id} className="mb-4 p-4 border rounded">
                    <h2 className="text-xl font-semibold">{contribution.type}</h2>
                    <p className="text-sm text-gray-500">
                        Last updated: {new Date(contribution.updatedAt).toLocaleString()}
                    </p>
                    {editingType === contribution.type ? (
                        <div>
                            <Textarea
                                className="w-full h-96 p-2 border rounded mt-2 text-md font-mono bg-slate-50"
                                value={editingBrackets}
                                onChange={(e) => setEditingBrackets(e.target.value)}
                            />
                            <div className="mt-2">
                                <Button
                                    variant={"success"}
                                    className="mr-2"
                                    onClick={() => handleUpdate(contribution.type)}
                                >
                                    Save
                                </Button>
                                <Button
                                    variant={"outline"}
                                    onClick={() => {
                                        setEditingType(null)
                                        setEditingBrackets('')
                                    }}
                                >
                                    Cancel
                                </Button>
                            </div>
                        </div>
                    ) : (
                        <div>
                            <pre className="mt-2 max-h-96 overflow-y-auto bg-slate-100 text-md font-mono p-2 rounded-md">
                                {JSON.stringify(contribution.brackets, null, 2)}
                            </pre>
                            <Button
                                variant={"superadmin"}
                                className='mt-2'
                                onClick={() => {
                                    setEditingType(contribution.type)
                                    setEditingBrackets(JSON.stringify(contribution.brackets, null, 2))
                                }}
                            >
                                Edit
                            </Button>
                        </div>
                    )}
                </div>
            ))}
        </div>
    )
}