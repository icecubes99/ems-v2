export function formatPeso(amount: number): string {
    // Convert the number to a string with commas as thousand separators
    const formattedAmount = amount.toLocaleString('en-US', {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    });

    // Append the peso symbol at the beginning
    return `₱${formattedAmount}`;
}

