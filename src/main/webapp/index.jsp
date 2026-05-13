<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CabGo – Smart & Pocket-Friendly Rides</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }

        :root {
            --night: #0a0a0f;
            --deep: #10101a;
            --card: #15151f;
            --border: rgba(255,255,255,0.07);
            --gold: #f5c842;
            --gold2: #ffdb70;
            --text: #e8e8f0;
            --muted: #7878a0;
            --green: #22c55e;
            --red: #ef4444;
        }

        html { scroll-behavior: smooth; }

        body {
            background: var(--night);
            color: var(--text);
            font-family: 'Inter', sans-serif;
            overflow-x: hidden;
        }

        /* ── NAV ── */
        nav {
            position: fixed; top: 0; left: 0; right: 0; z-index: 999;
            display: flex; align-items: center; justify-content: space-between;
            padding: 18px 60px;
            background: rgba(10,10,15,0.85);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border);
        }
        .nav-logo {
            font-family: 'Poppins', sans-serif;
            font-size: 1.8rem; font-weight: 800;
            color: var(--gold);
            text-decoration: none;
            letter-spacing: -1px;
        }
        .nav-logo span { color: var(--text); }
        .nav-links { display: flex; gap: 36px; align-items: center; }
        .nav-links a {
            color: var(--muted); text-decoration: none;
            font-size: 0.9rem; font-weight: 500;
            transition: color 0.2s;
        }
        .nav-links a:hover { color: var(--text); }
        .nav-cta {
            background: var(--gold) !important;
            color: var(--night) !important;
            padding: 10px 24px !important;
            border-radius: 50px !important;
            font-weight: 700 !important;
            font-size: 0.88rem !important;
            transition: transform 0.2s, box-shadow 0.2s !important;
        }
        .nav-cta:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(245,200,66,0.35) !important; }

        /* ── HERO ── */
        .hero {
            min-height: 100vh;
            display: flex; align-items: center;
            padding: 120px 60px 80px;
            position: relative;
            overflow: hidden;
        }
        .hero-bg {
            position: absolute; inset: 0; z-index: 0;
            background:
                radial-gradient(ellipse 60% 50% at 70% 50%, rgba(245,200,66,0.08) 0%, transparent 70%),
                radial-gradient(ellipse 40% 40% at 20% 80%, rgba(34,197,94,0.05) 0%, transparent 60%);
        }
        .hero-grid {
            position: absolute; inset: 0; z-index: 0;
            background-image:
                linear-gradient(rgba(255,255,255,0.02) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,0.02) 1px, transparent 1px);
            background-size: 60px 60px;
        }
        .hero-content { position: relative; z-index: 1; max-width: 620px; }
        .hero-badge {
            display: inline-flex; align-items: center; gap: 8px;
            background: rgba(245,200,66,0.1);
            border: 1px solid rgba(245,200,66,0.25);
            border-radius: 50px;
            padding: 6px 16px;
            font-size: 0.8rem; font-weight: 500;
            color: var(--gold2);
            margin-bottom: 28px;
            animation: fadeSlideUp 0.6s ease both;
        }
        .hero-title {
            font-family: 'Poppins', sans-serif;
            font-size: clamp(3rem, 6vw, 5rem);
            font-weight: 800;
            line-height: 1.05;
            letter-spacing: -2px;
            margin-bottom: 24px;
            animation: fadeSlideUp 0.7s ease 0.1s both;
        }
        .hero-title .accent { color: var(--gold); }
        .hero-sub {
            font-size: 1.1rem; color: var(--muted); line-height: 1.7;
            max-width: 480px; margin-bottom: 40px;
            animation: fadeSlideUp 0.7s ease 0.2s both;
        }
        .hero-actions {
            display: flex; gap: 16px; flex-wrap: wrap;
            animation: fadeSlideUp 0.7s ease 0.3s both;
        }
        .btn-primary {
            background: var(--gold);
            color: var(--night);
            padding: 14px 32px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.95rem;
            text-decoration: none;
            display: inline-flex; align-items: center; gap: 8px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-primary:hover { transform: translateY(-3px); box-shadow: 0 12px 32px rgba(245,200,66,0.4); }
        .btn-ghost {
            background: transparent;
            color: var(--text);
            padding: 14px 32px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.95rem;
            text-decoration: none;
            border: 1px solid var(--border);
            display: inline-flex; align-items: center; gap: 8px;
            transition: border-color 0.2s, background 0.2s;
        }
        .btn-ghost:hover { border-color: rgba(255,255,255,0.2); background: rgba(255,255,255,0.04); }
        .hero-stats {
            display: flex; gap: 40px; margin-top: 56px;
            animation: fadeSlideUp 0.7s ease 0.4s both;
        }
        .hero-stat-num {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem; font-weight: 800; color: var(--gold);
        }
        .hero-stat-lbl { font-size: 0.8rem; color: var(--muted); margin-top: 2px; }

        /* ── FLOATING CARD ── */
        .hero-visual {
            position: absolute; right: 60px; top: 50%;
            transform: translateY(-50%);
            z-index: 1;
            animation: floatCard 4s ease-in-out infinite;
        }
        .ride-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 28px;
            width: 300px;
            box-shadow: 0 40px 80px rgba(0,0,0,0.5);
        }
        .ride-card-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 20px;
        }
        .live-badge {
            display: flex; align-items: center; gap: 6px;
            font-size: 0.75rem; color: var(--green);
            font-weight: 600;
        }
        .live-dot {
            width: 8px; height: 8px; border-radius: 50%;
            background: var(--green);
            animation: pulse 2s ease-in-out infinite;
        }
        .route-line {
            display: flex; flex-direction: column; gap: 12px;
            position: relative; padding-left: 24px;
            margin-bottom: 20px;
        }
        .route-line::before {
            content: '';
            position: absolute; left: 7px; top: 8px; bottom: 8px;
            width: 2px; background: linear-gradient(to bottom, var(--gold), var(--green));
            border-radius: 2px;
        }
        .route-dot {
            position: absolute; left: 2px;
            width: 12px; height: 12px; border-radius: 50%;
            border: 2px solid;
        }
        .route-dot.pickup { top: 4px; border-color: var(--gold); background: var(--gold); }
        .route-dot.drop   { bottom: 4px; border-color: var(--green); background: var(--green); }
        .route-text { font-size: 0.82rem; color: var(--text); line-height: 1.4; }
        .route-text .label { font-size: 0.72rem; color: var(--muted); }
        .fare-row {
            display: flex; justify-content: space-between; align-items: center;
            background: rgba(245,200,66,0.08);
            border-radius: 12px; padding: 12px 16px;
        }
        .fare-amount {
            font-family: 'Poppins', sans-serif;
            font-size: 1.4rem; font-weight: 800; color: var(--gold);
        }
        .fare-label { font-size: 0.75rem; color: var(--muted); }
        .fare-discount { font-size: 0.75rem; color: var(--green); font-weight: 600; }

        /* ── HOW IT WORKS ── */
        .section { padding: 100px 60px; }
        .section-tag {
            font-size: 0.8rem; font-weight: 700; letter-spacing: 3px;
            color: var(--gold); text-transform: uppercase;
            margin-bottom: 12px;
        }
        .section-title {
            font-family: 'Poppins', sans-serif;
            font-size: clamp(2rem, 4vw, 3rem);
            font-weight: 800; letter-spacing: -1px;
            margin-bottom: 16px;
        }
        .section-sub { color: var(--muted); max-width: 480px; line-height: 1.7; }

        .steps-grid {
            display: grid; grid-template-columns: repeat(4, 1fr);
            gap: 24px; margin-top: 60px;
        }
        .step-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 32px 24px;
            position: relative;
            transition: transform 0.3s, border-color 0.3s;
        }
        .step-card:hover { transform: translateY(-6px); border-color: rgba(245,200,66,0.3); }
        .step-num {
            font-family: 'Poppins', sans-serif;
            font-size: 3.5rem; font-weight: 800;
            color: rgba(245,200,66,0.08);
            position: absolute; top: 16px; right: 20px;
            line-height: 1;
        }
        .step-icon {
            width: 52px; height: 52px; border-radius: 14px;
            background: rgba(245,200,66,0.1);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem; color: var(--gold);
            margin-bottom: 20px;
        }
        .step-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.1rem; font-weight: 700;
            margin-bottom: 10px;
        }
        .step-desc { font-size: 0.88rem; color: var(--muted); line-height: 1.6; }

        /* ── CAB TYPES ── */
        .cabs-section { background: var(--deep); }
        .cabs-grid {
            display: grid; grid-template-columns: repeat(3, 1fr);
            gap: 28px; margin-top: 60px;
        }
        .cab-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 36px;
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s, border-color 0.3s;
            text-decoration: none; color: inherit; display: block;
        }
        .cab-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 24px 60px rgba(0,0,0,0.4);
            border-color: rgba(245,200,66,0.3);
        }
        .cab-card.featured {
            border-color: rgba(245,200,66,0.4);
            background: linear-gradient(135deg, rgba(245,200,66,0.06), var(--card));
        }
        .cab-badge {
            display: inline-block;
            background: var(--gold);
            color: var(--night);
            font-size: 0.7rem; font-weight: 700;
            padding: 3px 10px; border-radius: 50px;
            margin-bottom: 16px;
        }
        .cab-icon {
            font-size: 3rem; margin-bottom: 16px;
            color: var(--gold);
        }
        .cab-name {
            font-family: 'Poppins', sans-serif;
            font-size: 1.5rem; font-weight: 800;
            margin-bottom: 8px;
        }
        .cab-desc { font-size: 0.88rem; color: var(--muted); margin-bottom: 24px; line-height: 1.5; }
        .cab-fare {
            font-family: 'Poppins', sans-serif;
            font-size: 2rem; font-weight: 800; color: var(--gold);
        }
        .cab-fare-sub { font-size: 0.8rem; color: var(--muted); margin-top: 4px; }
        .cab-features {
            margin-top: 20px; display: flex; flex-direction: column; gap: 8px;
            text-align: left;
        }
        .cab-feat {
            display: flex; align-items: center; gap: 8px;
            font-size: 0.82rem; color: var(--muted);
        }
        .cab-feat i { color: var(--green); font-size: 0.75rem; }

        /* ── FEATURES ── */
        .features-grid {
            display: grid; grid-template-columns: repeat(3, 1fr);
            gap: 24px; margin-top: 60px;
        }
        .feature-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 32px;
            transition: transform 0.3s;
        }
        .feature-card:hover { transform: translateY(-4px); }
        .feature-icon {
            width: 48px; height: 48px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.2rem;
            margin-bottom: 16px;
        }
        .feature-icon.yellow { background: rgba(245,200,66,0.1); color: var(--gold); }
        .feature-icon.green  { background: rgba(34,197,94,0.1); color: var(--green); }
        .feature-icon.blue   { background: rgba(59,130,246,0.1); color: #60a5fa; }
        .feature-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.05rem; font-weight: 700;
            margin-bottom: 8px;
        }
        .feature-desc { font-size: 0.87rem; color: var(--muted); line-height: 1.6; }

        /* ── FOOTER ── */
        footer {
            background: var(--deep);
            border-top: 1px solid var(--border);
            padding: 60px;
        }
        .footer-grid {
            display: grid; grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 48px; margin-bottom: 48px;
        }
        .footer-logo {
            font-family: 'Poppins', sans-serif;
            font-size: 1.8rem; font-weight: 800;
            color: var(--gold); margin-bottom: 16px;
        }
        .footer-desc { font-size: 0.88rem; color: var(--muted); line-height: 1.7; }
        .footer-col h4 {
            font-family: 'Poppins', sans-serif;
            font-size: 0.9rem; font-weight: 700;
            margin-bottom: 16px; color: var(--text);
        }
        .footer-col a {
            display: block; color: var(--muted); text-decoration: none;
            font-size: 0.85rem; margin-bottom: 10px;
            transition: color 0.2s;
        }
        .footer-col a:hover { color: var(--gold); }
        .footer-bottom {
            border-top: 1px solid var(--border);
            padding-top: 28px;
            display: flex; justify-content: space-between;
            font-size: 0.83rem; color: var(--muted);
        }

        /* ── ANIMATIONS ── */
        @keyframes fadeSlideUp {
            from { opacity: 0; transform: translateY(30px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        @keyframes floatCard {
            0%,100% { transform: translateY(-50%) translateY(0); }
            50%      { transform: translateY(-50%) translateY(-16px); }
        }
        @keyframes pulse {
            0%,100% { opacity: 1; }
            50%      { opacity: 0.4; }
        }

        @media (max-width: 1200px) {
            .hero-visual { display: none; }
            .steps-grid, .cabs-grid, .features-grid { grid-template-columns: repeat(2,1fr); }
        }
        @media (max-width: 768px) {
            nav { padding: 16px 24px; }
            .hero, .section { padding: 100px 24px 60px; }
            .steps-grid, .cabs-grid, .features-grid { grid-template-columns: 1fr; }
            .footer-grid { grid-template-columns: 1fr 1fr; }
            footer { padding: 40px 24px; }
        }
    </style>
</head>
<body>

<!-- NAV -->
<nav>
    <a href="index.jsp" class="nav-logo">Cab<span>Go</span></a>
    <div class="nav-links">
        <a href="#how-it-works">How It Works</a>
        <a href="#cab-types">Cab Types</a>
        <a href="${pageContext.request.contextPath}/pages/driver-login.jsp">Drive With Us</a>
        <a href="${pageContext.request.contextPath}/pages/login.jsp" class="nav-cta">Book a Ride</a>
    </div>
</nav>

<!-- HERO -->
<section class="hero">
    <div class="hero-bg"></div>
    <div class="hero-grid"></div>
    <div class="hero-content">
        <div class="hero-badge">
            <i class="fa-solid fa-bolt"></i> Smart Pricing &bull; Zero Hidden Charges
        </div>
        <h1 class="hero-title">
            Your Ride,<br><span class="accent">Your Price.</span><br>Every Time.
        </h1>
        <p class="hero-sub">
            CabGo uses distance-based smart pricing to give you the most affordable ride.
            No surge, no surprises — just honest fares and fast pickups.
        </p>
        <div class="hero-actions">
            <a href="${pageContext.request.contextPath}/pages/login.jsp" class="btn-primary">
                <i class="fa-solid fa-car"></i> Book Now
            </a>
            <a href="${pageContext.request.contextPath}/pages/register.jsp" class="btn-ghost">
                <i class="fa-solid fa-user-plus"></i> Create Account
            </a>
        </div>
        <div class="hero-stats">
            <div>
                <div class="hero-stat-num">₹6</div>
                <div class="hero-stat-lbl">Starting per km</div>
            </div>
            <div>
                <div class="hero-stat-num">3</div>
                <div class="hero-stat-lbl">Cab types available</div>
            </div>
            <div>
                <div class="hero-stat-num">20%</div>
                <div class="hero-stat-lbl">Off-peak discount</div>
            </div>
        </div>
    </div>

    <!-- Floating Ride Card -->
    <div class="hero-visual">
        <div class="ride-card">
            <div class="ride-card-header">
                <span style="font-family:'Poppins',sans-serif;font-weight:700;font-size:0.9rem;">Active Booking</span>
                <span class="live-badge"><span class="live-dot"></span> LIVE</span>
            </div>
            <div class="route-line" style="margin-bottom:20px;">
                <span class="route-dot pickup"></span>
                <div class="route-text">
                    <div class="label">PICKUP</div>
                    Connaught Place, Delhi
                </div>
                <div style="height:16px;"></div>
                <span class="route-dot drop"></span>
                <div class="route-text">
                    <div class="label">DROP</div>
                    Indira Gandhi Airport T3
                </div>
            </div>
            <div class="fare-row">
                <div>
                    <div class="fare-label">Mini Cab &bull; 14.2 km</div>
                    <div class="fare-amount">₹152.80</div>
                    <div class="fare-discount"><i class="fa-solid fa-tag"></i> Saved ₹17 today</div>
                </div>
                <div style="text-align:right;">
                    <div style="font-size:0.75rem;color:var(--muted);">ETA</div>
                    <div style="font-family:'Poppins',sans-serif;font-weight:700;font-size:1.2rem;color:var(--green);">~28 min</div>
                </div>
            </div>
            <div style="margin-top:16px;display:flex;align-items:center;gap:10px;">
                <div style="width:36px;height:36px;border-radius:50%;background:rgba(245,200,66,0.15);display:flex;align-items:center;justify-content:center;font-size:0.9rem;color:var(--gold);">
                    <i class="fa-solid fa-user"></i>
                </div>
                <div>
                    <div style="font-size:0.82rem;font-weight:600;">Rajesh Kumar</div>
                    <div style="font-size:0.72rem;color:var(--muted);">⭐ 4.8 · DL3C AB1234</div>
                </div>
                <div style="margin-left:auto;background:rgba(34,197,94,0.1);border-radius:8px;padding:4px 10px;font-size:0.75rem;color:var(--green);font-weight:600;">
                    On the way
                </div>
            </div>
        </div>
    </div>
</section>

<!-- HOW IT WORKS -->
<section class="section" id="how-it-works">
    <div class="section-tag">Process</div>
    <h2 class="section-title">Ride in 4 Simple Steps</h2>
    <p class="section-sub">From login to destination — CabGo makes it ridiculously simple to book an affordable ride.</p>

    <div class="steps-grid">
        <div class="step-card">
            <div class="step-num">01</div>
            <div class="step-icon"><i class="fa-solid fa-user-circle"></i></div>
            <div class="step-title">Sign Up & Log In</div>
            <div class="step-desc">Create your free account in under 60 seconds. No lengthy forms — just name, phone, and you're in.</div>
        </div>
        <div class="step-card">
            <div class="step-num">02</div>
            <div class="step-icon"><i class="fa-solid fa-map-marker-alt"></i></div>
            <div class="step-title">Enter Locations</div>
            <div class="step-desc">Type your pickup and drop address. Our system instantly calculates real distance and minimum fare.</div>
        </div>
        <div class="step-card">
            <div class="step-num">03</div>
            <div class="step-icon"><i class="fa-solid fa-car"></i></div>
            <div class="step-title">Choose Cab Type</div>
            <div class="step-desc">Pick Bike, Mini, or Sedan. See transparent pricing upfront — no hidden charges, ever.</div>
        </div>
        <div class="step-card">
            <div class="step-num">04</div>
            <div class="step-icon"><i class="fa-solid fa-route"></i></div>
            <div class="step-title">Confirm & Ride</div>
            <div class="step-desc">Confirm booking and get matched with the nearest available driver. Sit back and enjoy the ride!</div>
        </div>
    </div>
</section>

<!-- CAB TYPES -->
<section class="section cabs-section" id="cab-types">
    <div class="section-tag">Vehicles</div>
    <h2 class="section-title">Choose Your Ride</h2>
    <p class="section-sub">Every budget, every occasion. Pick the cab that matches your pocket and comfort level.</p>

    <div class="cabs-grid">
        <a href="${pageContext.request.contextPath}/pages/login.jsp" class="cab-card">
            <div class="cab-icon"><i class="fa-solid fa-motorcycle"></i></div>
            <div class="cab-name">Bike</div>
            <div class="cab-desc">Beat traffic with lightning-fast solo rides. Perfect for short distances during rush hour.</div>
            <div class="cab-fare">₹6<span style="font-size:1rem;font-weight:400;color:var(--muted)">/km</span></div>
            <div class="cab-fare-sub">Base fare ₹15 · 1 passenger</div>
            <div class="cab-features">
                <div class="cab-feat"><i class="fa-solid fa-check"></i> Fastest option</div>
                <div class="cab-feat"><i class="fa-solid fa-check"></i> No traffic delays</div>
                <div class="cab-feat"><i class="fa-solid fa-check"></i> Cheapest fare</div>
            </div>
        </a>
        <a href="${pageContext.request.contextPath}/pages/login.jsp" class="cab-card featured">
            <div class="cab-badge">POPULAR</div>
            <div class="cab-icon"><i class="fa-solid fa-car"></i></div>
            <div class="cab-name">Mini</div>
            <div class="cab-desc">Affordable hatchbacks for everyday commutes. Great value for small groups up to 3 passengers.</div>
            <div class="cab-fare">₹9<span style="font-size:1rem;font-weight:400;color:var(--muted)">/km</span></div>
            <div class="cab-fare-sub">Base fare ₹25 · Up to 3 passengers</div>
            <div class="cab-features">
                <div class="cab-feat"><i class="fa-solid fa-check"></i> Best value</div>
                <div class="cab-feat"><i class="fa-solid fa-check"></i> Air-conditioned</div>
                <div class="cab-feat"><i class="fa-solid fa-check"></i> Most drivers available</div>
            </div>
        </a>
        <a href="${pageContext.request.contextPath}/pages/login.jsp" class="cab-card">
            <div class="cab-icon"><i class="fa-solid fa-car-side"></i></div>
            <div class="cab-name">Sedan</div>
            <div class="cab-desc">Premium comfort for airport runs, business travel, and family outings up to 4 passengers.</div>
            <div class="cab-fare">₹13<span style="font-size:1rem;font-weight:400;color:var(--muted)">/km</span></div>
            <div class="cab-fare-sub">Base fare ₹40 · Up to 4 passengers</div>
            <div class="cab-features">
                <div class="cab-feat"><i class="fa-solid fa-check"></i> Premium comfort</div>
                <div class="cab-feat"><i class="fa-solid fa-check"></i> Extra luggage space</div>
                <div class="cab-feat"><i class="fa-solid fa-check"></i> Top-rated drivers</div>
            </div>
        </a>
    </div>
</section>

<!-- SMART FEATURES -->
<section class="section">
    <div class="section-tag">Why CabGo</div>
    <h2 class="section-title">Built to Save You Money</h2>
    <p class="section-sub">Every feature is designed around one goal: giving you the most affordable, reliable ride possible.</p>

    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon yellow"><i class="fa-solid fa-route"></i></div>
            <div class="feature-title">Distance-Based Pricing</div>
            <div class="feature-desc">Pay only for what you travel. Our fare engine calculates the exact distance and charges accordingly — no flat inflated rates.</div>
        </div>
        <div class="feature-card">
            <div class="feature-icon green"><i class="fa-solid fa-location-dot"></i></div>
            <div class="feature-title">Nearest Driver Matching</div>
            <div class="feature-desc">Our smart assignment algorithm matches you with the closest available driver, reducing wait time and cutting down empty-run fuel costs.</div>
        </div>
        <div class="feature-card">
            <div class="feature-icon blue"><i class="fa-solid fa-moon"></i></div>
            <div class="feature-title">Off-Peak Discounts</div>
            <div class="feature-desc">Ride between 10 PM and 6 AM and automatically get 20% off. No coupon needed — the discount applies at checkout.</div>
        </div>
        <div class="feature-card">
            <div class="feature-icon yellow"><i class="fa-solid fa-receipt"></i></div>
            <div class="feature-title">Zero Hidden Charges</div>
            <div class="feature-desc">The fare you see at booking is the fare you pay. No surprise add-ons, no dynamic surge pricing that catches you off-guard.</div>
        </div>
        <div class="feature-card">
            <div class="feature-icon green"><i class="fa-solid fa-tag"></i></div>
            <div class="feature-title">Promo Codes & Offers</div>
            <div class="feature-desc">Frequent riders unlock special promo codes. First-time riders get 30% off on their first trip — because we love new passengers.</div>
        </div>
        <div class="feature-card">
            <div class="feature-icon blue"><i class="fa-solid fa-clock-rotate-left"></i></div>
            <div class="feature-title">Full Ride History</div>
            <div class="feature-desc">Every trip logged — date, route, driver, and fare. Review, rate, and track your spending all from your personal dashboard.</div>
        </div>
    </div>
</section>

<!-- FOOTER -->
<footer>
    <div class="footer-grid">
        <div>
            <div class="footer-logo">CabGo</div>
            <p class="footer-desc">Smart & Pocket-Friendly Cab Booking. Affordable rides powered by transparent pricing and intelligent driver matching.</p>
        </div>
        <div class="footer-col">
            <h4>Riders</h4>
            <a href="${pageContext.request.contextPath}/pages/register.jsp">Register</a>
            <a href="${pageContext.request.contextPath}/pages/login.jsp">Login</a>
            <a href="${pageContext.request.contextPath}/pages/book-cab.jsp">Book a Ride</a>
            <a href="${pageContext.request.contextPath}/booking/history">Ride History</a>
        </div>
        <div class="footer-col">
            <h4>Drivers</h4>
            <a href="${pageContext.request.contextPath}/pages/driver-register.jsp">Become a Driver</a>
            <a href="${pageContext.request.contextPath}/pages/driver-login.jsp">Driver Login</a>
            <a href="${pageContext.request.contextPath}/driver/dashboard">Dashboard</a>
        </div>
        <div class="footer-col">
            <h4>Admin</h4>
            <a href="${pageContext.request.contextPath}/pages/admin-login.jsp">Admin Login</a>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        </div>
    </div>
    <div class="footer-bottom">
        <span>&copy; 2025 CabGo. All rights reserved.</span>
        <span>Built with Java &bull; JSP &bull; MySQL &bull; Maven</span>
    </div>
</footer>

</body>
</html>
