const nodemailer = require('nodemailer');

export default async function handler(req, res) {
    if (req.method === 'POST') {
        const { from, to, subject, html } = req.body;

        // Create a transporter using SMTP
        let transporter = nodemailer.createTransport({
            host: process.env.SMTP_HOST,
            port: parseInt(process.env.SMTP_PORT),
            secure: process.env.SMTP_SECURE === 'true',
            auth: {
                user: process.env.SMTP_USER,
                pass: process.env.SMTP_PASS,
            },
        });

        try {
            // Send email
            let info = await transporter.sendMail({
                from: from,
                to: to,
                subject: subject,
                html: html,
            });

            console.log("Message sent: %s", info.messageId);
            res.status(200).json({ id: info.messageId });
        } catch (error) {
            console.error("Error sending email:", error);
            res.status(500).json({ error: error.message });
        }
    } else {
        res.setHeader('Allow', ['POST']);
        res.status(405).end(`Method ${req.method} Not Allowed`);
    }
}