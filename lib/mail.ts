import { Resend } from "resend";

const resend = new Resend(process.env.RESEND_API_KEY);

const domain = process.env.NEXT_PUBLIC_APP_URL;

export const sendPasswordResetEmail = async (email: string, token: string) => {
  const resetLink = `${domain}/auth/new-password?token=${token}`;

  await resend.emails.send({
    from: "onboarding@resend.dev",
    to: "aguadojr.emmanueldiaz@gmail.com",
    subject: "Reset your password",
    html: `
    <div style="font-family: Arial, sans-serif; line-height: 1.6; color: #333;">
      <h2 style="color: #5B21B6;">Reset Your Password</h2>
      <p>Dear User,</p>
      <p>We received a request to reset your password. Please click the link below to proceed:</p>
      <p><a href="${resetLink}" style="color: #5B21B6; text-decoration: none;">Reset Password</a></p>
      <p>If you did not request this email, please ignore it.</p>
      <p>Best regards,<br>Kupler Industries</p>
      <hr style="border: 0; border-top: 1px solid #eee;">
      <p style="font-size: 0.9em; color: #999;">This email was sent to ${email}. If you have any questions, please contact our support team.</p>
    </div>
  `,
  });
};

export const sendVerificationEmail = async (email: string, token: string) => {
  const confirmLink = `${domain}/auth/new-verification?token=${token}`;

  await resend.emails.send({
    from: "onboarding@resend.dev",
    to: "aguadojr.emmanueldiaz@gmail.com",
    subject: "Confirm your email",
    html: `
      <div style="font-family: Arial, sans-serif; line-height: 1.6; color: #333;">
        <h2 style="color: #5B21B6;">Confirm Your Email Address</h2>
        <p>Dear User,</p>
        <p>Thank you for registering with us. Please click the link below to verify your email address:</p>
        <p>
          <a href="${confirmLink}" style="color: #5B21B6; text-decoration: none;" 
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
  });
};

export const sendTwoFactorTokenEmail = async (email: string, token: string) => {
  await resend.emails.send({
    from: "onboarding@resend.dev",
    to: email,
    subject: "2FA Code",
    html: `<p>Your 2FA code: ${token}</p> <p>This is sent to ${email}</p>`,
  });
};
