import { RoleGate } from '@/components/auth/role-gate'
import LayoutSideHead from '@/components/LayoutSideHead'
import React from 'react'
import NewRegisterForm from '../_components/new-register-form'

const page = () => {
    return (
        <RoleGate allowedRoles={["SUPERADMIN"]}>
            <LayoutSideHead classname='' label='Create Employee'>
                <div className='mt-5'>
                    <p className='font-bold text-4xl'>EMPLOYEE REGISTRATION</p>
                    <div className='flex items-center'>
                        <div className='mr-6 w-10/12'>
                            <NewRegisterForm />

                        </div>
                    </div>
                </div>
            </LayoutSideHead>
        </RoleGate>
    )
}

export default page