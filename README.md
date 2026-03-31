# Trim — URL Shortener
A real, shareable URL shortener. Anyone with a short link can use it from any device.

---

## Files in this folder

| File | Purpose |
|------|---------|
| `index.html` | The entire app (frontend + redirect logic) |
| `config.js` | Your Supabase credentials go here |
| `setup.sql` | Run once in Supabase to create the database |
| `netlify.toml` | Makes clean URLs work on Netlify |

---

## Setup (15 minutes, all free)

### Step 1 — Create Supabase database

1. Go to **https://supabase.com** → sign up free
2. Click **New project** → give it a name → wait ~2 minutes
3. Click **SQL Editor** in the left sidebar
4. Click **New query**
5. Paste the entire contents of `setup.sql` → click **Run**
6. You should see "Success. No rows returned."

### Step 2 — Get your API keys

1. In Supabase, go to **Project Settings** (gear icon) → **API**
2. Copy **Project URL** — looks like `https://abcxyz.supabase.co`
3. Copy **anon public** key — a long string starting with `eyJ...`

### Step 3 — Add keys to config.js

Open `config.js` and replace the placeholder values:

```js
const SUPABASE_URL = "https://YOUR-PROJECT.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGci...your-long-key...";
```

### Step 4 — Deploy to Netlify (free)

1. Go to **https://netlify.com** → sign up free
2. Click **Add new site** → **Deploy manually**
3. Drag the entire `url-shortener` folder onto the page
4. Netlify gives you a URL like `https://random-name.netlify.app`
5. That's your shortener! Share that URL with anyone.

### Optional — Custom domain

1. Buy a short domain (e.g. `trm.io`) on Namecheap or Porkbun (~$10/yr)
2. In Netlify: **Site settings → Domain management → Add custom domain**
3. Follow the DNS instructions
4. Your links will be like `trm.io/ab3x9`

---

## How it works

```
User visits yoursite.com/ab3x9
         ↓
index.html loads, reads "ab3x9" from URL path
         ↓
Queries Supabase: SELECT * FROM links WHERE code = 'ab3x9'
         ↓
Finds original URL → increments click count → redirects user
         ↓
User arrives at the original website ✓
```

Links are stored in Supabase (a cloud database).
Anyone, anywhere, on any device can use your short links.

---

## Deploying to Vercel instead of Netlify

1. Go to **https://vercel.com** → sign up
2. Click **Add New → Project** → drag folder
3. In project settings, add a **Rewrite rule**: `/(.*) → /index.html`
4. Done.
