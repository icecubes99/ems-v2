import React from 'react'

const HomepageCards = () => {
    return (
        <div className='m-4 grid grid-cols-2 gap-6'>
            <div className='bg-gray-600 h-96'>
                Col 1 Row 1
            </div>
            <div className='bg-green'>
                Col 2 Row 1
            </div>
            <div className='bg-blue-600 h-96'>
                Col 1 Row 2
            </div>
            <div className='bg-gray-200'>
                Col 2 Row 2
            </div>
        </div>
    )
}

export default HomepageCards