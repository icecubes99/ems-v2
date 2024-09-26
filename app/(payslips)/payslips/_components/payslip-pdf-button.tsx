'use client'

import { useState, useEffect, useRef } from 'react'
import { Button } from "@/components/ui/button"
import jsPDF from "jspdf"
import "jspdf-autotable"
import { PayrollItemWithUser } from '@/types/types'
import { FileDown } from 'lucide-react'

declare module 'jspdf' {
    interface jsPDF {
        autoTable: (options: any) => jsPDF;
    }
}

interface PayslipPDFButtonProps {
    payslip: PayrollItemWithUser
}

export function PayslipPDFButton({ payslip }: PayslipPDFButtonProps) {
    const [generatingPDF, setGeneratingPDF] = useState(false)
    const [jpgDataUrl, setJpgDataUrl] = useState<string | null>(null)
    const canvasRef = useRef<HTMLCanvasElement>(null)

    useEffect(() => {
        const convertSvgToJpg = async () => {
            const svgUrl = '/kupler.svg' // Replace with your SVG path
            const response = await fetch(svgUrl)
            const svgText = await response.text()

            const img = new Image()
            img.onload = () => {
                if (canvasRef.current) {
                    const canvas = canvasRef.current
                    canvas.width = img.width
                    canvas.height = img.height
                    const ctx = canvas.getContext('2d')
                    if (ctx) {
                        ctx.fillStyle = 'white'
                        ctx.fillRect(0, 0, canvas.width, canvas.height)
                        ctx.drawImage(img, 0, 0)
                        setJpgDataUrl(canvas.toDataURL('image/jpeg'))
                    }
                }
            }
            img.src = 'data:image/svg+xml;base64,' + btoa(svgText)
        }

        convertSvgToJpg()
    }, [])

    const generatePDF = () => {
        if (!jpgDataUrl) {
            console.error('JPG not ready yet')
            return
        }

        setGeneratingPDF(true)

        const doc = new jsPDF()

        // Set the background to white
        doc.setFillColor(255, 255, 255)
        doc.rect(0, 0, doc.internal.pageSize.width, doc.internal.pageSize.height, 'F')

        // Add logo
        doc.addImage(jpgDataUrl, 'JPG', 14, 10, 50, 20)

        // Add title
        doc.setFontSize(24)
        doc.setTextColor(44, 62, 80) // Dark blue color
        doc.text('PAYSLIP', doc.internal.pageSize.width / 2, 40, { align: 'center' })

        // Add employee info
        doc.setFontSize(12)
        doc.setTextColor(52, 73, 94) // Slightly lighter blue
        doc.text(`Employee: ${payslip.user.firstName} ${payslip.user.lastName}`, 14, 55)
        doc.text(`Pay Period: ${new Date(payslip.payroll.payPeriodStart).toLocaleDateString()} - ${new Date(payslip.payroll.payPeriodEnd).toLocaleDateString()}`, 14, 62)

        // Add table
        doc.autoTable({
            startY: 70,
            head: [['Description', 'Amount']],
            body: [
                ['Basic Salary', `PHP ${payslip.basicSalary.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`],
                ['Overtime Salary', `PHP ${payslip.overtimeSalary.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`],
                ['Additional Earnings', `PHP ${payslip.additionalEarnings.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`],
                ['Late Deductions', `PHP ${payslip.lateDeductions.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`],
                ['Early Clock Out Deductions', `PHP ${payslip.earlyClockOutDeductions.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`],
                ['Total Deductions', `PHP ${payslip.totalDeductions.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`],
                ['Net Salary', `PHP ${payslip.netSalary.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`],
            ],
            styles: {
                textColor: [52, 73, 94],
                fontSize: 10,
                cellPadding: 5,
            },
            headStyles: {
                fillColor: [41, 128, 185],
                textColor: 255,
                fontStyle: 'bold',
            },
            alternateRowStyles: {
                fillColor: [236, 240, 241],
            },
            columnStyles: {
                0: { cellWidth: 100 },
                1: { cellWidth: 'auto', halign: 'right' },
            },
        })

        const finalY = (doc as any).lastAutoTable.finalY || 70

        // Add footer
        doc.setFontSize(10)
        doc.setTextColor(127, 140, 141) // Gray color
        doc.text(`Generated on: ${new Date().toLocaleString()}`, 14, finalY + 10)

        doc.save(`payslip_${payslip.user.lastName}_${new Date(payslip.payroll.payPeriodEnd).toISOString().split('T')[0]}.pdf`)
        setGeneratingPDF(false)
    }

    return (
        <>
            <canvas ref={canvasRef} style={{ display: 'none' }} />
            <Button
                onClick={generatePDF}
                disabled={generatingPDF || !jpgDataUrl}
                size="sm"
                variant="outline"
            >
                {generatingPDF ? (
                    'Generating...'
                ) : (
                    <>
                        <FileDown className="mr-2 h-4 w-4" />
                        Download PDF
                    </>
                )}
            </Button>
        </>
    )
}