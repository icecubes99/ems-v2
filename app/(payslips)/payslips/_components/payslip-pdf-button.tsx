'use client'

import { useState, useEffect, useRef } from 'react'
import { Button } from "@/components/ui/button"
import jsPDF from "jspdf"
import "jspdf-autotable"
import { PayrollItemWithUser, AdditionalEarnings, Deductions } from '@/types/types'
import { FileDown } from 'lucide-react'
import { CellHookData } from 'jspdf-autotable'
import React from 'react'

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

        // Add company name and details
        doc.setFontSize(18)
        doc.setTextColor(66, 44, 141) // Purple color
        doc.text('Kupler Industries Incorporated', 14, 40)
        doc.setFontSize(10)
        doc.setTextColor(52, 73, 94) // Dark gray
        doc.text('Door 4 & 5, Don Pedro Building, Lapu-Lapu St,', 14, 46)
        doc.text('Agdao, Davao City, 8000 Davao del Sur, Philippines', 14, 51)
        doc.text('Phone: 221-0323 / 221-0520', 14, 56)
        doc.text("Email: info@kuplerindustries.com", 14, 61)

        // Add PAYSLIP title
        doc.setFontSize(24)
        doc.setTextColor(66, 44, 141) // Purple color
        doc.text('PAYSLIP', doc.internal.pageSize.width - 16, 18, { align: 'right' })

        // Add employee info
        doc.setFontSize(12);
        doc.setTextColor(52, 73, 94); // Dark gray
        doc.setFont('helvetica', 'bold');
        doc.text('EMPLOYEE INFORMATION', 14, 70);
        doc.setFont('helvetica', 'normal');
        doc.setFontSize(10);
        doc.text(`Full Name: ${payslip.user.firstName} ${payslip.user.middleName || ''} ${payslip.user.lastName}`, 14, 77);
        doc.text(`Job Title: ${payslip.user.jobTitle || 'N/A'}`, 14, 83);
        doc.text(`Email: ${payslip.user.email || 'N/A'}`, 14, 89);
        // Add pay information
        doc.setFontSize(12)
        doc.setFont('helvetica', 'bold');
        doc.text('PAY INFORMATION', 120, 70)
        doc.setFont('helvetica', 'normal');
        doc.setFontSize(10)
        doc.text(`Pay Period: ${new Date(payslip.payroll.payPeriodStart).toLocaleDateString()} - ${new Date(payslip.payroll.payPeriodEnd).toLocaleDateString()}`, 120, 77)
        doc.text(`Payroll #: ${payslip.payrollId}`, 120, 83)
        doc.text(`Payment Method: Direct Deposit`, 120, 89)

        // Add earnings table
        const earningsBody = [
            ['Basic Salary', payslip.daysWorked * 8, (payslip.basicSalary / (payslip.daysWorked * 8)).toFixed(2), payslip.basicSalary.toFixed(2)],
            ['Overtime Pay', (payslip.minutesOvertime / 60).toFixed(2), (payslip.overtimeSalary / (payslip.minutesOvertime / 60)).toFixed(2), payslip.overtimeSalary.toFixed(2)],
        ]
        earningsBody.push(['Total Additional Earnings', '-', '-', '-'])
        // Add additional earnings
        if (payslip.additionalEarningsArray && payslip.additionalEarningsArray.length > 0) {
            payslip.additionalEarningsArray.forEach((earning: AdditionalEarnings) => {
                earningsBody.push(['\t' + earning.earningType, '-', '-', earning.amount.toFixed(2)])
            })
        }

        // Add gross pay
        earningsBody.push(['', '', '', ''])
        earningsBody.push(['GROSS PAY', '', '', (payslip.basicSalary + payslip.overtimeSalary + payslip.additionalEarnings).toFixed(2)])

        doc.autoTable({
            startY: 100,
            head: [['EARNINGS', 'HOURS', 'RATE', 'CURRENT']],
            body: earningsBody,
            styles: { fontSize: 9, cellPadding: 2 },
            headStyles: { fillColor: [66, 44, 141], textColor: 255 },
            columnStyles: {
                0: { cellWidth: 70, halign: 'left' },
                1: { cellWidth: 30, halign: 'right' },
                2: { cellWidth: 30, halign: 'right' },
                3: { cellWidth: 50, halign: 'right' }
            },
            didParseCell: (data: CellHookData) => {
                if (data.section === 'head' && data.column.index > 0) {
                    data.cell.styles.halign = 'right';
                }
            }
        });

        const daysNotWorkedHours = payslip.daysNotWorked * 8
        const daysNotWorkedDeductions = (payslip.basicSalary / (payslip.daysWorked * 8)) * daysNotWorkedHours

        // Add deductions table
        const finalY = (doc as any).lastAutoTable.finalY || 100;
        const deductionsBody = [
            ['Days Not Worked Deductions', daysNotWorkedDeductions.toFixed(2)],
            ['Late Deductions', payslip.lateDeductions.toFixed(2)],
            ['Early Clock Out Deductions', payslip.earlyClockOutDeductions.toFixed(2)],
            ['Additional Deductions', '-'],
        ]

        // Add additional deductions
        if (payslip.deductions && payslip.deductions.length > 0) {
            payslip.deductions.forEach((deduction: Deductions) => {
                deductionsBody.push(['\t' + deduction.deductionType, deduction.amount.toFixed(2)])
            })
        }

        // Add total deductions
        deductionsBody.push(['', ''])
        deductionsBody.push(['TOTAL DEDUCTIONS', payslip.totalDeductions.toFixed(2)])

        doc.autoTable({
            startY: finalY + 10,
            head: [['DEDUCTIONS', 'CURRENT']],
            body: deductionsBody,
            styles: { fontSize: 9, cellPadding: 2 },
            headStyles: {
                fillColor: [66, 44, 141],
                textColor: 255,
            },
            columnStyles: {
                0: { cellWidth: 130, halign: 'left' },
                1: { cellWidth: 50, halign: 'right' }
            },
            didParseCell: (data: CellHookData) => {
                if (data.section === 'head' && data.column.index === 1) {
                    data.cell.styles.halign = 'right';
                }
            }
        });

        // Add net pay
        const finalY2 = (doc as any).lastAutoTable.finalY || finalY + 8
        doc.setFillColor(220, 31, 25) // Red
        doc.rect(14, finalY2 + 10, 180, 10, 'F')
        doc.setTextColor(255, 255, 255) // White
        doc.setFontSize(11)
        doc.text('NET PAY', 16, finalY2 + 17)
        doc.text(`PHP ${payslip.netSalary.toFixed(2)}`, 190, finalY2 + 17, { align: 'right' })

        // Add footer
        doc.setFontSize(8)
        doc.setTextColor(127, 140, 141) // Light gray
        doc.text(`Generated on: ${new Date().toLocaleString()}`, 14, doc.internal.pageSize.height - 10)

        doc.save(`Payslip_${payslip.user.lastName}_${new Date(payslip.payroll.payPeriodEnd).toISOString().split('T')[0]}.pdf`)
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