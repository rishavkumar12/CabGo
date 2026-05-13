<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account – CabGo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        :root{--primary:#1a56db;--primary-dark:#1e429f;--primary-light:#ebf5ff;--accent:#f59e0b;--success:#057a55;--danger:#c81e1e;--bg:#f0f4f8;--white:#ffffff;--text:#111827;--muted:#6b7280;--border:#e5e7eb;}
        body{background:var(--bg);color:var(--text);font-family:'Inter',sans-serif;min-height:100vh;display:flex;}
        .left-panel{flex:1;background:linear-gradient(135deg,#1a56db 0%,#1e429f 50%,#0f2878 100%);display:flex;flex-direction:column;justify-content:center;align-items:center;padding:60px;position:relative;overflow:hidden;}
        .left-panel::before{content:'';position:absolute;top:-100px;right:-100px;width:400px;height:400px;border-radius:50%;background:rgba(255,255,255,0.05);}
        .left-panel::after{content:'';position:absolute;bottom:-80px;left:-80px;width:300px;height:300px;border-radius:50%;background:rgba(255,255,255,0.05);}
        .brand{display:flex;align-items:center;gap:14px;margin-bottom:40px;position:relative;z-index:1;}
        .brand-icon{width:52px;height:52px;background:var(--accent);border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:1.4rem;color:#fff;}
        .brand-name{font-family:'Poppins',sans-serif;font-size:2rem;font-weight:800;color:#fff;}
        .brand-name span{color:var(--accent);}
        .panel-title{font-family:'Poppins',sans-serif;font-size:2.2rem;font-weight:800;color:#fff;line-height:1.2;margin-bottom:16px;position:relative;z-index:1;}
        .panel-sub{color:rgba(255,255,255,0.7);font-size:0.95rem;line-height:1.6;margin-bottom:36px;position:relative;z-index:1;}
        .stats-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px;position:relative;z-index:1;width:100%;}
        .stat-card{background:rgba(255,255,255,0.1);border-radius:16px;padding:20px;text-align:center;backdrop-filter:blur(10px);}
        .stat-num{font-family:'Poppins',sans-serif;font-size:1.8rem;font-weight:800;color:#fff;}
        .stat-label{font-size:0.78rem;color:rgba(255,255,255,0.65);margin-top:4px;}
        .panel-img{margin-top:32px;position:relative;z-index:1;border-radius:16px;overflow:hidden;width:100%;}
        .panel-img img{width:100%;height:160px;object-fit:cover;opacity:0.8;}
        .right-panel{width:520px;display:flex;flex-direction:column;justify-content:center;padding:50px 48px;background:var(--white);overflow-y:auto;}
        .form-header{margin-bottom:28px;}
        .form-header h2{font-family:'Poppins',sans-serif;font-size:1.7rem;font-weight:700;color:var(--text);margin-bottom:6px;}
        .form-header p{color:var(--muted);font-size:0.88rem;}
        .perks{display:flex;gap:8px;margin-bottom:24px;flex-wrap:wrap;}
        .perk{display:flex;align-items:center;gap:6px;font-size:0.75rem;font-weight:600;color:var(--success);background:#f0fdf4;border:1px solid #bbf7d0;border-radius:20px;padding:5px 12px;}
        .alert-error{background:#fef2f2;border:1px solid #fecaca;border-radius:10px;padding:12px 16px;font-size:.88rem;color:var(--danger);margin-bottom:16px;display:flex;align-items:center;gap:8px;}
        .row{display:grid;grid-template-columns:1fr 1fr;gap:14px;}
        .form-group{margin-bottom:16px;}
        label{display:block;font-size:0.8rem;font-weight:600;margin-bottom:6px;color:var(--text);}
        .input-wrap{position:relative;}
        .input-wrap i{position:absolute;left:13px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:0.85rem;}
        input,textarea{width:100%;background:#f9fafb;border:1.5px solid var(--border);border-radius:10px;padding:11px 12px 11px 38px;color:var(--text);font-family:'Inter',sans-serif;font-size:0.88rem;outline:none;transition:all .2s;}
        textarea{padding:11px 12px;resize:vertical;min-height:65px;}
        input:focus,textarea:focus{border-color:var(--primary);background:#fff;box-shadow:0 0 0 3px rgba(26,86,219,0.1);}
        input::placeholder,textarea::placeholder{color:#9ca3af;}
        .btn-primary{width:100%;background:linear-gradient(135deg,var(--primary),var(--primary-dark));color:#fff;border:none;border-radius:10px;padding:13px;font-family:'Poppins',sans-serif;font-weight:700;font-size:0.95rem;cursor:pointer;transition:all .2s;margin-top:4px;display:flex;align-items:center;justify-content:center;gap:8px;}
        .btn-primary:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(26,86,219,0.35);}
        .links{text-align:center;font-size:0.88rem;color:var(--muted);margin-top:18px;}
        .links a{color:var(--primary);text-decoration:none;font-weight:600;}
        @media(max-width:900px){.left-panel{display:none;}.right-panel{width:100%;padding:32px 20px;}}
    </style>
</head>
<body>
<div class="left-panel">
    <div class="brand">
        <div class="brand-icon"><i class="fa-solid fa-taxi"></i></div>
        <div class="brand-name">Cab<span>Go</span></div>
    </div>
    <div class="panel-title">Join 50,000+<br>Happy Riders</div>
    <p class="panel-sub">Create your free account and start booking pocket-friendly rides instantly. No hidden charges, ever.</p>
    <div class="stats-grid">
        <div class="stat-card"><div class="stat-num">50K+</div><div class="stat-label">Active Riders</div></div>
        <div class="stat-card"><div class="stat-num">1200+</div><div class="stat-label">Verified Drivers</div></div>
        <div class="stat-card"><div class="stat-num">4.8★</div><div class="stat-label">Average Rating</div></div>
        <div class="stat-card"><div class="stat-num">24/7</div><div class="stat-label">Support</div></div>
    </div>
    <div class="panel-img">
        <img src="https://images.unsplash.com/photo-1486325212027-8081e485255e?w=500&q=80&auto=format" alt="City rides">
    </div>
</div>
<div class="right-panel">
    <div class="form-header">
        <h2>Create Account 🚀</h2>
        <p>Fill in your details to get started in seconds</p>
    </div>
    <div class="perks">
        <div class="perk"><i class="fa-solid fa-check"></i> Free to join</div>
        <div class="perk"><i class="fa-solid fa-check"></i> 30% off first ride</div>
        <div class="perk"><i class="fa-solid fa-check"></i> No hidden fees</div>
    </div>
    <% if(request.getAttribute("error") != null) { %>
    <div class="alert-error"><i class="fa-solid fa-circle-exclamation"></i> <%=request.getAttribute("error")%></div>
    <% } %>
    <form action="<%=request.getContextPath()%>/user/register" method="post">
        <div class="row">
            <div class="form-group">
                <label>Full Name</label>
                <div class="input-wrap"><i class="fa-solid fa-user"></i>
                    <input type="text" name="fullName" placeholder="Your full name" required>
                </div>
            </div>
            <div class="form-group">
                <label>Phone Number</label>
                <div class="input-wrap"><i class="fa-solid fa-phone"></i>
                    <input type="tel" name="phone" placeholder="10-digit mobile" maxlength="10" required>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label>Email Address</label>
            <div class="input-wrap"><i class="fa-solid fa-envelope"></i>
                <input type="email" name="email" placeholder="you@example.com" required>
            </div>
        </div>
        <div class="form-group">
            <label>Password</label>
            <div class="input-wrap"><i class="fa-solid fa-lock"></i>
                <input type="password" name="password" placeholder="Minimum 6 characters" minlength="6" required>
            </div>
        </div>
        <div class="form-group">
            <label>Address <span style="color:#9ca3af;font-weight:400;">(Optional)</span></label>
            <textarea name="address" placeholder="Your home / office address" style="padding-left:12px;"></textarea>
        </div>
        <button type="submit" class="btn-primary"><i class="fa-solid fa-user-plus"></i> Create My Account</button>
    </form>
    <div class="links">Already have an account? <a href="<%=request.getContextPath()%>/pages/login.jsp">Sign In</a></div>
</div>
</body>
</html>
