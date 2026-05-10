/* Frontend bridge (scaffold)

This file contains example functions that replace localStorage demo operations with Supabase calls.

You must complete values and install @supabase/supabase-js in your project, or use the CDN import pattern.
*/

import { supabase } from './lib/supabaseClient.js'

// Example: create profile (after sign up via Supabase Auth)
export async function createProfile({ id, full_name, username, phone, role='customer' }){
  const { data, error } = await supabase.from('profiles').upsert({ id, full_name, username, phone, role })
  if(error) throw error
  return data
}

export async function createBooking({ user_id, service_type, bins, price, address, preferred_at }){
  const { data, error } = await supabase.from('bookings').insert([{ user_id, service_type, bins, price, address, preferred_at }]).select()
  if(error) throw error
  return data[0]
}

export async function listBookingsForAdmin(){
  const { data, error } = await supabase.from('bookings').select('*').order('created_at', { ascending:false })
  if(error) throw error
  return data
}

export async function listBookingsForUser(user_id){
  const { data, error } = await supabase.from('bookings').select('*').eq('user_id', user_id).order('created_at', { ascending:false })
  if(error) throw error
  return data
}

export async function createAnnouncement({ title, message, active=true }){
  const { data, error } = await supabase.from('announcements').insert([{ title, message, active }]).select()
  if(error) throw error
  return data[0]
}

// Timer control: start/stop via Edge Function or direct table updates when authenticated with service role.
export async function startJobTimer(booking_id){
  const { data, error } = await supabase.from('job_timers').insert([{ booking_id, started_at: new Date().toISOString(), status: 'running' }]).select()
  if(error) throw error
  return data[0]
}
