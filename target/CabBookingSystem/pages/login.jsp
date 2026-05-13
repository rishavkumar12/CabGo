<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In – CabGo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        :root{
            --primary:#1a56db;--primary-dark:#1e429f;--primary-light:#ebf5ff;
            --accent:#f59e0b;--success:#057a55;--danger:#c81e1e;
            --bg:#f0f4f8;--white:#ffffff;--text:#111827;--muted:#6b7280;
            --border:#e5e7eb;--shadow:0 4px 24px rgba(0,0,0,0.08);
        }
        body{background:var(--bg);color:var(--text);font-family:'Inter',sans-serif;min-height:100vh;display:flex;}
        .left-panel{flex:1;background:linear-gradient(135deg,#1a56db 0%,#1e429f 50%,#0f2878 100%);display:flex;flex-direction:column;justify-content:center;align-items:center;padding:60px;position:relative;overflow:hidden;}
        .left-panel::before{content:'';position:absolute;top:-100px;right:-100px;width:400px;height:400px;border-radius:50%;background:rgba(255,255,255,0.05);}
        .left-panel::after{content:'';position:absolute;bottom:-80px;left:-80px;width:300px;height:300px;border-radius:50%;background:rgba(255,255,255,0.05);}
        .brand{display:flex;align-items:center;gap:14px;margin-bottom:50px;position:relative;z-index:1;}
        .brand-icon{width:52px;height:52px;background:var(--accent);border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:1.4rem;color:#fff;}
        .brand-name{font-family:'Poppins',sans-serif;font-size:2rem;font-weight:800;color:#fff;letter-spacing:-0.5px;}
        .brand-name span{color:var(--accent);}
        .panel-title{font-family:'Poppins',sans-serif;font-size:2.4rem;font-weight:800;color:#fff;line-height:1.2;margin-bottom:16px;position:relative;z-index:1;}
        .panel-sub{color:rgba(255,255,255,0.7);font-size:1rem;line-height:1.6;margin-bottom:40px;position:relative;z-index:1;}
        .feature-list{display:flex;flex-direction:column;gap:16px;position:relative;z-index:1;}
        .feature-item{display:flex;align-items:center;gap:14px;color:rgba(255,255,255,0.9);font-size:0.95rem;}
        .feature-icon{width:38px;height:38px;background:rgba(255,255,255,0.12);border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1rem;flex-shrink:0;}
        .cab-illustration{margin-top:40px;position:relative;z-index:1;text-align:center;}
        .cab-illustration img{width:280px;opacity:0.9;filter:drop-shadow(0 20px 40px rgba(0,0,0,0.3));}
        .right-panel{width:480px;display:flex;flex-direction:column;justify-content:center;padding:60px 50px;background:var(--white);}
        .form-header{margin-bottom:36px;}
        .form-header h2{font-family:'Poppins',sans-serif;font-size:1.8rem;font-weight:700;color:var(--text);margin-bottom:8px;}
        .form-header p{color:var(--muted);font-size:0.92rem;}
        .alert{padding:12px 16px;border-radius:10px;font-size:0.88rem;margin-bottom:20px;display:flex;align-items:center;gap:10px;}
        .alert-error{background:#fef2f2;border:1px solid #fecaca;color:var(--danger);}
        .alert-success{background:#f0fdf4;border:1px solid #bbf7d0;color:var(--success);}
        .form-group{margin-bottom:20px;}
        label{display:block;font-size:0.82rem;font-weight:600;margin-bottom:7px;color:var(--text);}
        .input-wrap{position:relative;}
        .input-wrap i{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:0.9rem;}
        input{width:100%;background:#f9fafb;border:1.5px solid var(--border);border-radius:10px;padding:13px 14px 13px 42px;color:var(--text);font-family:'Inter',sans-serif;font-size:0.92rem;outline:none;transition:all .2s;}
        input:focus{border-color:var(--primary);background:#fff;box-shadow:0 0 0 3px rgba(26,86,219,0.1);}
        input::placeholder{color:#9ca3af;}
        .btn-primary{width:100%;background:linear-gradient(135deg,var(--primary),var(--primary-dark));color:#fff;border:none;border-radius:10px;padding:14px;font-family:'Poppins',sans-serif;font-weight:700;font-size:0.95rem;cursor:pointer;transition:all .2s;margin-top:4px;display:flex;align-items:center;justify-content:center;gap:8px;}
        .btn-primary:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(26,86,219,0.35);}
        .divider{display:flex;align-items:center;gap:12px;margin:24px 0;color:var(--muted);font-size:0.82rem;}
        .divider::before,.divider::after{content:'';flex:1;height:1px;background:var(--border);}
        .links{text-align:center;font-size:0.88rem;color:var(--muted);}
        .links a{color:var(--primary);text-decoration:none;font-weight:600;}
        .links a:hover{text-decoration:underline;}
        .driver-btn{display:flex;align-items:center;justify-content:center;gap:8px;width:100%;margin-top:12px;padding:12px;border:1.5px solid var(--border);border-radius:10px;color:var(--muted);text-decoration:none;font-size:0.88rem;font-weight:500;transition:all .2s;}
        .driver-btn:hover{border-color:var(--primary);color:var(--primary);background:var(--primary-light);}
        @media(max-width:900px){.left-panel{display:none;}.right-panel{width:100%;padding:40px 24px;}}
    </style>
</head>
<body>
<div class="left-panel">
    <div class="brand">
        <div class="brand-icon"><i class="fa-solid fa-taxi"></i></div>
        <div class="brand-name">Cab<span>Go</span></div>
    </div>
    <div class="panel-title">Your Ride,<br>Your Way</div>
    <p class="panel-sub">Book affordable, safe and reliable cab rides in just a few taps. Available 24/7 across the city.</p>
    <div class="feature-list">
        <div class="feature-item"><div class="feature-icon"><i class="fa-solid fa-shield-halved"></i></div> Verified & background-checked drivers</div>
        <div class="feature-item"><div class="feature-icon"><i class="fa-solid fa-bolt"></i></div> Instant booking confirmation</div>
        <div class="feature-item"><div class="feature-icon"><i class="fa-solid fa-tag"></i></div> Best prices with zero hidden charges</div>
        <div class="feature-item"><div class="feature-icon"><i class="fa-solid fa-clock"></i></div> 24/7 available across the city</div>
    </div>
    <div class="cab-illustration">
        <img src="https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=400&q=80&auto=format" alt="Cab" style="border-radius:16px;width:300px;height:180px;object-fit:cover;opacity:0.85;">
    </div>
</div>
<div class="right-panel">
    <div class="form-header">
        <h2>Welcome Back 👋</h2>
        <p>Sign in to your account to book your next ride</p>
    </div>
    <% if(request.getAttribute("error") != null) { %>
    <div class="alert alert-error"><i class="fa-solid fa-circle-exclamation"></i> <%=request.getAttribute("error")%></div>
    <% } %>
    <% if(request.getAttribute("success") != null) { %>
    <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> <%=request.getAttribute("success")%></div>
    <% } %>
    <form action="<%=request.getContextPath()%>/user/login" method="post">
        <div class="form-group">
            <label>Email Address</label>
            <div class="input-wrap">
                <i class="fa-solid fa-envelope"></i>
                <input type="email" name="email" placeholder="you@example.com" required>
            </div>
        </div>
        <div class="form-group">
            <label>Password</label>
            <div class="input-wrap">
                <i class="fa-solid fa-lock"></i>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>
        </div>
        <button type="submit" class="btn-primary"><i class="fa-solid fa-arrow-right-to-bracket"></i> Sign In</button>
    </form>
    <div class="divider">or</div>
    <div class="links">Don't have an account? <a href="<%=request.getContextPath()%>/pages/register.jsp">Create Account</a></div>
    <a href="<%=request.getContextPath()%>/pages/driver-login.jsp" class="driver-btn"><i class="fa-solid fa-steering-wheel"></i> Login as Driver</a>
</div>
</body>
</html>
