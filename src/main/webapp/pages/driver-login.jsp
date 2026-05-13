<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Login – CabGo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        :root{--night:#0a0a0f;--card:#15151f;--border:rgba(255,255,255,0.07);--gold:#f5c842;--text:#e8e8f0;--muted:#7878a0;--green:#22c55e;--red:#ef4444}
        body{background:var(--night);color:var(--text);font-family:'DM Sans',sans-serif;min-height:100vh;display:flex;align-items:center;justify-content:center}
        .bg{position:fixed;inset:0;background:radial-gradient(ellipse 50% 60% at 50% 50%,rgba(34,197,94,0.06),transparent 70%);pointer-events:none}
        .container{width:100%;max-width:440px;padding:24px}
        .logo{text-align:center;margin-bottom:32px}
        .logo a{font-family:'Syne',sans-serif;font-size:2rem;font-weight:800;color:var(--gold);text-decoration:none}
        .logo a span{color:var(--text)}
        .card{background:var(--card);border:1px solid var(--border);border-radius:24px;padding:40px}
        .driver-badge{display:flex;align-items:center;justify-content:center;gap:10px;background:rgba(34,197,94,.08);border:1px solid rgba(34,197,94,.2);border-radius:12px;padding:12px;margin-bottom:24px;font-size:.88rem;color:var(--green)}
        h2{font-family:'Syne',sans-serif;font-size:1.6rem;font-weight:800;margin-bottom:6px}
        .sub{color:var(--muted);font-size:.88rem;margin-bottom:28px}
        .alert{padding:12px 16px;border-radius:12px;font-size:.88rem;margin-bottom:20px}
        .alert-error{background:rgba(239,68,68,.1);border:1px solid rgba(239,68,68,.2);color:var(--red)}
        .alert-success{background:rgba(34,197,94,.1);border:1px solid rgba(34,197,94,.2);color:var(--green)}
        .form-group{margin-bottom:20px}
        label{display:block;font-size:.82rem;font-weight:600;margin-bottom:6px;color:var(--muted)}
        .input-wrap{position:relative}
        .input-wrap i{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:.9rem}
        input{width:100%;background:rgba(255,255,255,.04);border:1px solid var(--border);border-radius:12px;padding:13px 14px 13px 42px;color:var(--text);font-family:'DM Sans',sans-serif;font-size:.92rem;outline:none;transition:border-color .2s}
        input:focus{border-color:rgba(34,197,94,.4)}
        input::placeholder{color:var(--muted)}
        .btn{width:100%;background:var(--green);color:#fff;border:none;border-radius:12px;padding:14px;font-family:'Syne',sans-serif;font-weight:800;font-size:.95rem;cursor:pointer;transition:transform .2s,box-shadow .2s;margin-top:8px}
        .btn:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(34,197,94,.3)}
        .links{text-align:center;font-size:.88rem;color:var(--muted);margin-top:20px}
        .links a{color:var(--green);text-decoration:none;font-weight:600}
        .divider{text-align:center;margin:20px 0;font-size:.82rem;color:var(--muted)}
        .user-link a{color:var(--muted);text-decoration:none;border:1px solid var(--border);border-radius:8px;padding:8px 16px;display:inline-block;font-size:.82rem;transition:all .2s}
        .user-link a:hover{border-color:rgba(245,200,66,.3);color:var(--gold)}
    </style>
</head>
<body>
<div class="bg"></div>
<div class="container">
    <div class="logo"><a href="<%=request.getContextPath()%>/index.jsp">Cab<span>Go</span></a></div>
    <div class="card">
        <div class="driver-badge"><i class="fa-solid fa-steering-wheel"></i> Driver Portal</div>
        <h2>Driver Login</h2>
        <p class="sub">Sign in to manage rides and earnings</p>
        <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-error"><i class="fa-solid fa-circle-exclamation"></i> <%=request.getAttribute("error")%></div>
        <% } %>
        <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> <%=request.getAttribute("success")%></div>
        <% } %>
        <form action="<%=request.getContextPath()%>/driver/login" method="post">
            <div class="form-group">
                <label>Email Address</label>
                <div class="input-wrap">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" name="email" placeholder="driver@example.com" required>
                </div>
            </div>
            <div class="form-group">
                <label>Password</label>
                <div class="input-wrap">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="password" placeholder="Your password" required>
                </div>
            </div>
            <button type="submit" class="btn"><i class="fa-solid fa-steering-wheel"></i> Sign In as Driver</button>
        </form>
        <div class="links" style="margin-top:20px">New driver? <a href="<%=request.getContextPath()%>/pages/driver-register.jsp">Register Here &rarr;</a></div>
        <div class="divider">Are you a rider?</div>
        <div style="text-align:center" class="user-link"><a href="<%=request.getContextPath()%>/pages/login.jsp"><i class="fa-solid fa-user"></i> Rider Login</a></div>
    </div>
</div>
</body>
</html>
