'use server'

import nodemailer from 'nodemailer'

// This function creates a nodemailer transporter
function createTransporter() {
    return nodemailer.createTransport({
        host: process.env.SMTP_HOST,
        port: parseInt(process.env.SMTP_PORT || '587'),
        secure: process.env.SMTP_SECURE === 'true',
        auth: {
            user: process.env.SMTP_USER,
            pass: process.env.SMTP_PASS,
        },
    })
}

export async function sendVerificationEmail(email: string, verificationToken: string) {
    const transporter = createTransporter()

    const verificationLink = `${process.env.NEXT_PUBLIC_APP_URL}/verify?token=${verificationToken}`

    const mailOptions = {
        from: process.env.SMTP_FROM_EMAIL,
        to: "aguadojr.emmanueldiaz@gmail.com",
        subject: 'Verify Your Email',
        html: `
      <div style="font-family: Arial, sans-serif; line-height: 1.6; color: #333;">
        <h2 style="color: #5B21B6;">Confirm Your Email Address</h2>
        <p>Dear User,</p>
        <p>Thank you for registering with us. Please click the link below to verify your email address:</p>
        <p>
          <a href="${verificationLink}" style="color: #5B21B6; text-decoration: none;" 
            onmouseover="this.style.color='#3B0D99';" 
            onmouseout="this.style.color='#5B21B6';">
            Verify Email Address
          </a>
        </p>
        <p>If you did not request this email, please ignore it.</p>
        <p>Best regards,<br>Kupler Industries</p>
        <hr style="border: 0; border-top: 1px solid #eee;">
        <p style="font-size: 0.9em; color: #999;">This email was sent to ${email}. If you have any questions, please contact our support team.</p>
      </div>
    `,
    }

    try {
        const info = await transporter.sendMail(mailOptions)
        console.log('Verification email sent:', info.messageId)
        return { success: true, messageId: info.messageId }
    } catch (error) {
        console.error('Error sending verification email:', error)
        let errorMessage = 'An unknown error occurred';
        if (error instanceof Error) {
            errorMessage = error.message;
        }
        return { success: false, error: errorMessage }
    }
}