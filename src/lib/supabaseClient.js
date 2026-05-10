// Supabase client initializer (scaffold)

// Usage: import { supabase } from './lib/supabaseClient'

import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js/+esm'

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL || window.SUPABASE_URL || '<YOUR_SUPABASE_URL>'
const SUPABASE_ANON = import.meta.env.VITE_SUPABASE_ANON || window.SUPABASE_ANON || '<YOUR_SUPABASE_ANON_KEY>'

export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON)
