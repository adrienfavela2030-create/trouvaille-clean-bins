// Example Supabase Edge Function: send_booking_email
// This is a template. Replace with your email provider logic, e.g., SendGrid.

// Found in: supabase/functions/send_booking_email/index.js

export default async function (req, res) {
  try {
    const payload = await req.json()
    // payload expected: { booking }
    const booking = payload.booking || {}

    // TODO: integrate SendGrid or SMTP here using process.env.SENDGRID_API_KEY
    console.log('Received booking, would send email to owner:', booking)

    return new Response(JSON.stringify({ ok: true }), { status: 200 })
  } catch (err) {
    console.error(err)
    return new Response(JSON.stringify({ error: err.message }), { status: 500 })
  }
}
