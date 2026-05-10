// Example Edge Function template: timer_control
// Endpoint to start/stop timers centrally using a service_role key.

export default async function (req, res){
  try{
    const body = await req.json()
    // expected body: { action: 'start'|'stop'|'pause', booking_id }
    // validate incoming service role token server-side
    console.log('timer_control received', body)
    return new Response(JSON.stringify({ ok:true }), { status:200 })
  }catch(e){
    console.error(e)
    return new Response(JSON.stringify({ error: e.message }), { status:500 })
  }
}
