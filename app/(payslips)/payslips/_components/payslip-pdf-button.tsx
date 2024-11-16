'use client'

import { useState, useEffect, useRef } from 'react'
import { Button } from "@/components/ui/button"
import jsPDF from "jspdf"
import "jspdf-autotable"
import { PayrollItemWithUser, TimesheetBreakdown } from '@/types/types'
import { FileDown } from 'lucide-react'
import { CellHookData } from 'jspdf-autotable'
import React from 'react'
import { DaysNotWorked } from '@prisma/client'

declare module 'jspdf' {
    interface jsPDF {
        autoTable: (options: any) => jsPDF;
    }
}

interface PayslipPDFButtonProps {
    payslip: PayrollItemWithUser
}

export default function PayslipPDFButton({ payslip }: PayslipPDFButtonProps) {
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

        // First page (existing payslip)
        addPayslipPage(doc)

        // Second page (lates and overtimes breakdown)
        if (payslip.timesheets) {
            doc.addPage()
            addLatesOvertimesPage(doc)
        }

        doc.addPage()
        addAbsencesPage(doc)

        doc.save(`Payslip_${payslip.user.lastName}_${new Date(payslip.payroll.payPeriodEnd).toISOString().split('T')[0]}.pdf`)
        setGeneratingPDF(false)
    }

    const addPayslipPage = (doc: jsPDF) => {
        // Set the background to white
        doc.setFillColor(255, 255, 255)
        doc.rect(0, 0, doc.internal.pageSize.width, doc.internal.pageSize.height, 'F')

        // Add logo
        doc.addImage(jpgDataUrl!, 'JPG', 14, 10, 50, 20)

        // Add company name and details
        doc.setFontSize(18)
        doc.setTextColor(66, 44, 141) // Purple color
        doc.setFont('helvetica', 'bold')
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
            [
                'Basic Salary',
                (payslip.minutesWorked / 60).toFixed(2), // Actual hours worked
                (payslip.basicSalary / payslip.daysWorked).toFixed(2), // Daily rate
                payslip.basicSalary.toFixed(2)
            ],
            ['Overtime Pay', (payslip.minutesOvertime / 60).toFixed(2), (payslip.overtimeSalary / (payslip.minutesOvertime / 60)).toFixed(2), payslip.overtimeSalary.toFixed(2)],
            [
                'Special Day Work',
                (Number(payslip.specialDayMinutes || 0) / 60).toFixed(2),
                (Number(payslip.specialDayMinutes || 0) === 0 ? '0.00' :
                    (Number(payslip.specialDayEarnings || 0) / (Number(payslip.specialDayMinutes || 0) / 60)).toFixed(2)
                ),
                Number(payslip.specialDayEarnings || 0).toFixed(2)
            ],]
        earningsBody.push(['Total Additional Earnings', '-', '-', '-'])
        // Add additional earnings
        if (payslip.additionalEarningsArray && payslip.additionalEarningsArray.length > 0) {
            payslip.additionalEarningsArray.forEach((earning) => {
                earningsBody.push(['\t' + earning.earningType, '-', '-', earning.amount.toFixed(2)])
            })
        }

        // Add gross pay
        earningsBody.push(['', '', '', ''])
        earningsBody.push(['GROSS PAY', '', '', (payslip.basicSalary + payslip.overtimeSalary + payslip.additionalEarnings + Number(payslip.specialDayEarnings || 0)).toFixed(2)])

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

        const daysNotWorkedHours = payslip.daysNotWorked * 10
        let additionalDeductionsAmount = 0
        // Add additional deductions
        if (payslip.deductions && payslip.deductions.length > 0) {
            payslip.deductions.forEach((deduction) => {
                additionalDeductionsAmount += deduction.amount
            })
        }

        // Add deductions table
        const finalY = (doc as any).lastAutoTable.finalY || 100;

        const dailyRate = payslip.basicSalary / (payslip.daysWorked + payslip.daysNotWorked); // Use total working days
        const minuteRate = dailyRate / 600;
        const daysNotWorkedDeductions = (payslip.daysNotWorked * 600) * minuteRate;

        const deductionsBody = [
            ['Days Not Worked Deductions', daysNotWorkedDeductions.toFixed(2)],
            ['Late Deductions', payslip.lateDeductions.toFixed(2)],
            ['Early Clock Out Deductions', payslip.earlyClockOutDeductions.toFixed(2)],
            ['Additional Deductions', '-'],
        ]

        // Add additional deductions
        if (payslip.deductions && payslip.deductions.length > 0) {
            payslip.deductions.forEach((deduction) => {
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
    }

    const addLatesOvertimesPage = (doc: jsPDF) => {
        // Set the background to white
        doc.setFillColor(255, 255, 255)
        doc.rect(0, 0, doc.internal.pageSize.width, doc.internal.pageSize.height, 'F')

        // Add logo
        doc.addImage(jpgDataUrl!, 'JPG', 14, 10, 50, 20)

        // Add company name and details (same as first page)
        doc.setFontSize(18)
        doc.setTextColor(66, 44, 141) // Purple color
        doc.setFont('helvetica', 'bold')
        doc.text('Kupler Industries Incorporated', 14, 40)
        doc.setFontSize(10)
        doc.setTextColor(52, 73, 94) // Dark gray
        doc.text('Door 4 & 5, Don Pedro Building, Lapu-Lapu St,', 14, 46)
        doc.text('Agdao, Davao City, 8000 Davao del Sur, Philippines', 14, 51)
        doc.text('Phone: 221-0323 / 221-0520', 14, 56)
        doc.text("Email: info@kuplerindustries.com", 14, 61)

        // Add title
        doc.setFontSize(24)
        doc.setTextColor(66, 44, 141) // Purple color
        doc.text('LATES AND OVERTIMES', doc.internal.pageSize.width - 16, 18, { align: 'right' })

        // Add employee info
        doc.setFontSize(12)
        doc.setTextColor(52, 73, 94) // Dark gray
        doc.setFont('helvetica', 'bold')
        doc.text('EMPLOYEE INFORMATION', 14, 70)
        doc.setFont('helvetica', 'normal')
        doc.setFontSize(10)
        doc.text(`Full Name: ${payslip.user.firstName} ${payslip.user.middleName || ''} ${payslip.user.lastName}`, 14, 77)
        doc.text(`Job Title: ${payslip.user.jobTitle || 'N/A'}`, 14, 83)
        doc.text(`Email: ${payslip.user.email || 'N/A'}`, 14, 89)

        // Add pay information
        doc.setFontSize(12)
        doc.setFont('helvetica', 'bold')
        doc.text('PAY INFORMATION', 120, 70)
        doc.setFont('helvetica', 'normal')
        doc.setFontSize(10)
        doc.text(`Pay Period: ${new Date(payslip.payroll.payPeriodStart).toLocaleDateString()} - ${new Date(payslip.payroll.payPeriodEnd).toLocaleDateString()}`, 120, 77)
        doc.text(`Payroll #: ${payslip.payrollId}`, 120, 83)

        // Add lates breakdown
        doc.setFontSize(14)
        doc.setTextColor(66, 44, 141) // Purple color
        doc.setFont('helvetica', 'bold')
        doc.text('Lates', 14, 100)

        const latesData = [
            ['Date', 'Clock In Time', 'Minutes Late'],
            ...(payslip.timesheets || [])
                .filter((ts: TimesheetBreakdown) => ts.minutesLate > 0)
                .map((ts: TimesheetBreakdown) => [
                    new Date(ts.date).toLocaleDateString(),
                    ts.clockIn.toLocaleString() || 'N/A',

                    ts.minutesLate.toString()
                ])
        ]

        doc.autoTable({
            startY: 105,
            head: [latesData[0]],
            body: latesData.slice(1),
            styles: { fontSize: 9, cellPadding: 2 },
            headStyles: { fillColor: [66, 44, 141], textColor: 255 },
            columnStyles: {
                0: { cellWidth: 70, halign: 'left' },
                1: { cellWidth: 55, halign: 'right' },
                2: { cellWidth: 55, halign: 'right' }
            }, didParseCell: (data: CellHookData) => {
                if (data.section === 'head' && data.column.index > 0) {
                    data.cell.styles.halign = 'right';
                }
            }
        })

        // Add total lates
        doc.setFontSize(10)
        doc.setTextColor(52, 73, 94) // Dark gray
        doc.setFont('helvetica', 'bold')
        doc.text(`Total Minutes Late: ${payslip.minutesLate}`, 14, (doc as any).lastAutoTable.finalY + 10)

        // Add overtimes breakdown
        doc.setFontSize(14)
        doc.setTextColor(66, 44, 141) // Purple color
        doc.setFont('helvetica', 'bold')
        doc.text('Overtimes', 14, (doc as any).lastAutoTable.finalY + 25)

        const overtimesData = [
            ['Date', 'Clock Out Time', 'Minutes Overtime'],
            ...(payslip.timesheets || [])
                .filter((ts: TimesheetBreakdown) => ts.minutesOvertime > 0)
                .map((ts: TimesheetBreakdown) => [
                    new Date(ts.date).toLocaleDateString(),
                    ts.clockOut?.toLocaleString() || 'N/A',
                    ts.minutesOvertime.toString()
                ])
        ]

        doc.autoTable({
            startY: (doc as any).lastAutoTable.finalY + 30,
            head: [overtimesData[0]],
            body: overtimesData.slice(1),
            styles: { fontSize: 9, cellPadding: 2 },
            headStyles: { fillColor: [66, 44, 141], textColor: 255 },
            columnStyles: {
                0: { cellWidth: 70, halign: 'left' },
                1: { cellWidth: 55, halign: 'right' },
                2: { cellWidth: 55, halign: 'right' }
            }, didParseCell: (data: CellHookData) => {
                if (data.section === 'head' && data.column.index > 0) {
                    data.cell.styles.halign = 'right';
                }
            }
        })

        // Add total overtimes
        doc.setFontSize(10)
        doc.setTextColor(52, 73, 94) // Dark gray
        doc.setFont('helvetica', 'bold')
        doc.text(`Total Minutes Overtime: ${payslip.minutesOvertime}`, 14, (doc as any).lastAutoTable.finalY + 10)

        // Add footer
        doc.setFontSize(8)
        doc.setTextColor(127, 140, 141) // Light gray
        doc.text(`Generated on: ${new Date().toLocaleString()}`, 14, doc.internal.pageSize.height - 10)
    }


    const addAbsencesPage = (doc: jsPDF) => {
        // Set the background to white
        doc.setFillColor(255, 255, 255)
        doc.rect(0, 0, doc.internal.pageSize.width, doc.internal.pageSize.height, 'F')

        // Add logo
        doc.addImage(jpgDataUrl!, 'JPG', 14, 10, 50, 20)

        // Add company name and details (same as first page)
        doc.setFontSize(18)
        doc.setTextColor(66, 44, 141) // Purple color
        doc.text('Kupler Industries Incorporated', 14, 40)
        doc.setFontSize(10)
        doc.setFont('helvetica', 'normal')
        doc.setTextColor(52, 73, 94) // Dark gray
        doc.text('Door 4 & 5, Don Pedro Building, Lapu-Lapu St,', 14, 46)
        doc.text('Agdao, Davao City, 8000 Davao del Sur, Philippines', 14, 51)
        doc.text('Phone: 221-0323 / 221-0520', 14, 56)
        doc.text("Email: info@kuplerindustries.com", 14, 61)

        // Add title
        doc.setFontSize(24)
        doc.setTextColor(66, 44, 141) // Purple color
        doc.setFont('helvetica', 'bold')
        doc.text('ABSENCES', doc.internal.pageSize.width - 16, 18, { align: 'right' })

        // Add employee info
        doc.setFontSize(12)
        doc.setTextColor(52, 73, 94) // Dark gray
        doc.setFont('helvetica', 'bold')
        doc.text('EMPLOYEE INFORMATION', 14, 70)
        doc.setFont('helvetica', 'normal')
        doc.setFontSize(10)
        doc.text(`Full Name: ${payslip.user.firstName} ${payslip.user.middleName || ''} ${payslip.user.lastName}`, 14, 77)
        doc.text(`Job Title: ${payslip.user.jobTitle || 'N/A'}`, 14, 83)
        doc.text(`Email: ${payslip.user.email || 'N/A'}`, 14, 89)

        // Add pay information
        doc.setFontSize(12)
        doc.setFont('helvetica', 'bold')
        doc.text('PAY INFORMATION', 120, 70)
        doc.setFont('helvetica', 'normal')
        doc.setFontSize(10)
        doc.text(`Pay Period: ${new Date(payslip.payroll.payPeriodStart).toLocaleDateString()} - ${new Date(payslip.payroll.payPeriodEnd).toLocaleDateString()}`, 120, 77)
        doc.text(`Payroll #: ${payslip.payrollId}`, 120, 83)

        // Add Absences  breakdown
        doc.setFontSize(14)
        doc.setTextColor(66, 44, 141) // Purple color
        doc.setFont('helvetica', 'bold')
        doc.text('Absences', 14, 100)


        const absencesData = [
            ['Date', 'Deducted Amount'],
            ...(payslip.daysNotWorkedArray || [])
                .filter((wd: DaysNotWorked) => wd)
                .map((wd) => [
                    new Date(wd.date).toLocaleDateString(),
                    ((payslip.basicSalary / (payslip.daysWorked + payslip.daysNotWorked)) * 1).toFixed(2)
                ])
        ]

        doc.autoTable({
            startY: 105,
            head: [absencesData[0]],
            body: absencesData.slice(1),
            styles: { fontSize: 9, cellPadding: 2 },
            headStyles: { fillColor: [66, 44, 141], textColor: 255 },
            columnStyles: {
                0: { cellWidth: 70, halign: 'left' },
                1: { cellWidth: 55, halign: 'right' },
            },
            didParseCell: (data: CellHookData) => {
                if (data.section === 'head' && data.column.index > 0) {
                    data.cell.styles.halign = 'right';
                }
            }
        })

        // Add total absences
        doc.setFontSize(10)
        doc.setTextColor(52, 73, 94) // Dark gray
        doc.setFont('helvetica', 'bold')
        doc.text(`Total Absences: ${payslip.daysNotWorked}`, 14, (doc as any).lastAutoTable.finalY + 10)

        // Add footer
        doc.setFontSize(8)
        doc.setTextColor(127, 140, 141) // Light gray
        doc.text(`Generated on: ${new Date().toLocaleString()}`, 14, doc.internal.pageSize.height - 10)


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
                    </>
                )}
            </Button>
        </>
    )
}