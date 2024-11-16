import path from "path";

export const routes = [
    {
        path: "/payslips",
        label: "Payslips",
    },
    {
        path: "/leaveRequests",
        label: "Leave Requests",
    },
    {
        path: "/administrator",
        label: "Administrator Panel",
        subRoutes: [
            {
                path: "/administrator/dataTable",
                label: "Data Table",
            },
            {
                path: "/administrator/departments/",
                label: "Departments",
            },
            {
                path: "/administrator/designations/",
                label: "Designations",
            },
            {
                path: "/administrator/manageLeaves",
                label: "Manage Leaves",
            },
            {
                path: "/administrator/manageOvertimes",
                label: "Manage Overtimes",
            },
            {
                path: "/administrator/userList",
                label: "User List",
            }
        ]
    },
    {
        path: "/employee",
        label: "Profile Details",
    },
    {
        path: "/homepage",
        label: "Homepage",
    },
    {
        path: "/superadministrator",
        label: "Super Administrator Panel",
        subRoutes: [
            {
                path: "/superadministrator/attendancePanel",
                label: "Attendance Panel",
            },
            {
                path: "/superadministrator/employeePanel",
                label: "Employee Panel",
                subRoutes: [
                    {
                        path: "/superadministrator/employeePanel/createEmployee",
                        label: "Create Employee",
                    },
                    {
                        path: "/superadministrator/employeePanel/user/[id]",
                        label: "User",
                    },
                    {
                        path: "/superadministrator/employeePanel/allowancesPanel",
                        label: "Allowances Panel",
                    },
                    {
                        path: "/superadministrator/employeePanel/user",
                        label: "User",
                    }
                ]
            },
            {
                path: "/superadministrator/auditLogs",
                label: "Audit Logs",
            },
            {
                path: "/superadministrator/departments",
                label: "Departments",
                subRoutes: [
                    {
                        path: "/superadministrator/departments/designations/[id]",
                        label: "Designations",
                    }
                ]
            },
            {
                path: "/superadministrator/payrollPanel",
                label: "Payroll Panel",
                subRoutes: [
                    {
                        path: "/superadministrator/payrollPanel/payroll/approved/[id]",
                        label: "Approved",
                    },
                    {
                        path: "/superadministrator/payrollPanel/payroll/pending/[id]",
                        label: "Pending",
                    },
                    {
                        path: "/superadministrator/payrollPanel/editGovernmentContributions",
                        label: "Edit Government Contributions"
                    },
                    {
                        path: "/superadministrator/payrollPanel/payroll",
                        label: "Payroll Dashboard",
                        subRoutes: [
                            {
                                path: "/superadministrator/payrollPanel/payroll/pending",
                                label: "Pending",
                                subRoutes: [
                                    {
                                        path: "/superadministrator/payrollPanel/payroll/pending/[id]",
                                        label: "Payroll",
                                        subRoutes: [
                                            {
                                                path: "/superadministrator/payrollPanel/payroll/pending/[id]/item",
                                                label: "Item",
                                            }
                                        ]
                                    }
                                ]
                            },
                            {
                                path: "/superadministrator/payrollPanel/payroll/approved",
                                label: "Approved",
                            }
                        ]
                    }
                ]
            }
        ]
    }
]