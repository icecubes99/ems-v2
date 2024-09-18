import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import Link from 'next/link'
import React from 'react'
import EmployeeCards from './EmployeeCards'


const EmployeePageContent = () => {
    return (
        <div className='mt-5'>
            <p className='font-bold text-4xl'>EMPLOYEE MANAGEMENT</p>
            <EmployeeCards />
        </div >
    )
}

export default EmployeePageContent