<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login – CabGo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        :root{--primary:#1e429f;--accent:#f59e0b;--danger:#c81e1e;--bg:#0f172a;--card:#1e293b;--border:rgba(255,255,255,0.08);--text:#f1f5f9;--muted:#94a3b8;}
        body{background:var(--bg);color:var(--text);font-family:'Inter',sans-serif;min-height:100vh;display:flex;align-items:center;justify-content:center;position:relative;overflow:hidden;}
        .bg-grid{position:fixed;inset:0;background-image:linear-gradient(rgba(255,255,255,0.02) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,0.02) 1px,transparent 1px);background-size:60px 60px;pointer-events:none;}
        .bg-glow{position:fixed;top:20%;left:50%;transform:translateX(-50%);width:600px;height:400px;background:radial-gradient(ellipse,rgba(30,66,159,0.25) 0%,transparent 70%);pointer-events:none;}
        .container{width:100%;max-width:440px;padding:24px;position:relative;z-index:1;}
        .brand{display:flex;align-items:center;justify-content:center;gap:12px;margin-bottom:36px;}
        .brand-icon{width:46px;height:46px;background:var(--accent);border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:#fff;}
        .brand-name{font-family:'Poppins',sans-serif;font-size:1.8rem;font-weight:800;color:var(--text);}
        .brand-name span{color:var(--accent);}
        .card{background:var(--card);border:1px solid var(--border);border-radius:20px;padding:40px;box-shadow:0 24px 64px rgba(0,0,0,0.4);}
        .admin-badge{display:flex;align-items:center;justify-content:center;gap:10px;background:rgba(30,66,159,0.2);border:1px solid rgba(30,66,159,0.4);border-radius:50px;padding:10px 20px;margin-bottom:28px;font-size:.85rem;font-weight:600;color:#93c5fd;width:fit-content;margin-left:auto;margin-right:auto;}
        h2{font-family:'Poppins',sans-serif;font-size:1.6rem;font-weight:700;margin-bottom:6px;text-align:center;}
        .sub{color:var(--muted);font-size:.88rem;margin-bottom:28px;text-align:center;}
        .alert-error{background:rgba(200,30,30,.1);border:1px solid rgba(200,30,30,.3);border-radius:10px;padding:12px 16px;font-size:.88rem;color:#fca5a5;margin-bottom:20px;display:flex;align-items:center;gap:8px;}
        .form-group{margin-bottom:20px;}
        label{display:block;font-size:.8rem;font-weight:600;margin-bottom:7px;color:var(--muted);}
        .input-wrap{position:relative;}
        .input-wrap i{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:.9rem;}
        input{width:100%;background:rgba(255,255,255,0.05);border:1.5px solid var(--border);border-radius:10px;padding:13px 14px 13px 42px;color:var(--text);font-family:'Inter',sans-serif;font-size:.92rem;outline:none;transition:all .2s;}
        input:focus{border-color:rgba(30,66,159,0.6);background:rgba(30,66,159,0.08);box-shadow:0 0 0 3px rgba(30,66,159,0.15);}
        input::placeholder{color:var(--muted);}
        .btn{width:100%;background:linear-gradient(135deg,#1a56db,#1e429f);color:#fff;border:none;border-radius:10px;padding:14px;font-family:'Poppins',sans-serif;font-weight:700;font-size:.95rem;cursor:pointer;transition:all .2s;margin-top:8px;display:flex;align-items:center;justify-content:center;gap:8px;}
        .btn:hover{transform:translateY(-2px);box-shadow:0 8px 28px rgba(26,86,219,0.4);}
        .hint{margin-top:20px;padding:12px 16px;background:rgba(255,255,255,0.03);border:1px solid var(--border);border-radius:10px;font-size:.78rem;color:var(--muted);text-align:center;line-height:1.6;}
        .back-link{display:block;text-align:center;margin-top:20px;color:var(--muted);text-decoration:none;font-size:.85rem;transition:color .2s;}
        .back-link:hover{color:var(--text);}
    </style>
</head>
<body>
<div class="bg-grid"></div>
<div class="bg-glow"></div>
<div class="container">
    <div class="brand">
        <div class="brand-icon"><i class="fa-solid fa-taxi"></i></div>
        <div class="brand-name">Cab<span>Go</span></div>
    </div>
    <div class="card">
        <div class="admin-badge"><i class="fa-solid fa-shield-halved"></i> Admin Portal</div>
        <h2>Admin Sign In</h2>
        <p class="sub">Access the system administration panel</p>
        <% if(request.getAttribute("error") != null) { %>
        <div class="alert-error"><i class="fa-solid fa-circle-exclamation"></i> <%=request.getAttribute("error")%></div>
        <% } %>
        <form action="<%=request.getContextPath()%>/admin/login" method="post">
            <div class="form-group">
                <label>Username</label>
                <div class="input-wrap"><i class="fa-solid fa-user-shield"></i>
                    <input type="text" name="username" placeholder="Enter admin username" required>
                </div>
            </div>
            <div class="form-group">
                <label>Password</label>
                <div class="input-wrap"><i class="fa-solid fa-lock"></i>
                    <input type="password" name="password" placeholder="Enter admin password" required>
                </div>
            </div>
            <button type="submit" class="btn"><i class="fa-solid fa-right-to-bracket"></i> Access Dashboard</button>
        </form>
        <div class="hint">Default credentials: <strong style="color:var(--text);">admin</strong> / <strong style="color:var(--text);">Admin@123</strong></div>
    </div>
    <a href="<%=request.getContextPath()%>/index.jsp" class="back-link"><i class="fa-solid fa-arrow-left"></i> Back to Home</a>
</div>
</body>
</html>
