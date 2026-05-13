<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Registration – CabGo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        :root{--night:#0a0a0f;--card:#15151f;--border:rgba(255,255,255,0.07);--gold:#f5c842;--text:#e8e8f0;--muted:#7878a0;--green:#22c55e;--red:#ef4444}
        body{background:var(--night);color:var(--text);font-family:'DM Sans',sans-serif;min-height:100vh;display:flex;align-items:center;justify-content:center;padding:40px 24px}
        .bg{position:fixed;inset:0;background:radial-gradient(ellipse 50% 60% at 50% 50%,rgba(34,197,94,.06),transparent 70%);pointer-events:none}
        .container{width:100%;max-width:520px}
        .logo{text-align:center;margin-bottom:28px}
        .logo a{font-family:'Syne',sans-serif;font-size:2rem;font-weight:800;color:var(--gold);text-decoration:none}
        .logo a span{color:var(--text)}
        .card{background:var(--card);border:1px solid var(--border);border-radius:24px;padding:40px}
        .driver-badge{display:flex;align-items:center;justify-content:center;gap:10px;background:rgba(34,197,94,.08);border:1px solid rgba(34,197,94,.2);border-radius:12px;padding:12px;margin-bottom:24px;font-size:.88rem;color:var(--green)}
        h2{font-family:'Syne',sans-serif;font-size:1.6rem;font-weight:800;margin-bottom:6px}
        .sub{color:var(--muted);font-size:.88rem;margin-bottom:28px}
        .alert-error{background:rgba(239,68,68,.1);border:1px solid rgba(239,68,68,.2);border-radius:12px;padding:12px 16px;font-size:.88rem;color:var(--red);margin-bottom:16px}
        .row{display:grid;grid-template-columns:1fr 1fr;gap:16px}
        .form-group{margin-bottom:18px}
        label{display:block;font-size:.82rem;font-weight:600;margin-bottom:6px;color:var(--muted)}
        .input-wrap{position:relative}
        .input-wrap i{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:.85rem}
        input,select{width:100%;background:rgba(255,255,255,.04);border:1px solid var(--border);border-radius:12px;padding:12px 14px 12px 40px;color:var(--text);font-family:'DM Sans',sans-serif;font-size:.9rem;outline:none;transition:border-color .2s;-webkit-appearance:none}
        input:focus,select:focus{border-color:rgba(34,197,94,.4)}
        input::placeholder{color:var(--muted)}
        select option{background:#15151f}
        .btn{width:100%;background:var(--green);color:#fff;border:none;border-radius:12px;padding:14px;font-family:'Syne',sans-serif;font-weight:800;font-size:.95rem;cursor:pointer;transition:transform .2s,box-shadow .2s;margin-top:4px}
        .btn:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(34,197,94,.3)}
        .links{text-align:center;font-size:.88rem;color:var(--muted);margin-top:20px}
        .links a{color:var(--green);text-decoration:none;font-weight:600}
    </style>
</head>
<body>
<div class="bg"></div>
<div class="container">
    <div class="logo"><a href="<%=request.getContextPath()%>/index.jsp">Cab<span>Go</span></a></div>
    <div class="card">
        <div class="driver-badge"><i class="fa-solid fa-steering-wheel"></i> Become a CabGo Driver</div>
        <h2>Driver Registration</h2>
        <p class="sub">Join our fleet and start earning today</p>
        <% if(request.getAttribute("error") != null) { %>
        <div class="alert-error"><i class="fa-solid fa-circle-exclamation"></i> <%=request.getAttribute("error")%></div>
        <% } %>
        <form action="<%=request.getContextPath()%>/driver/register" method="post">
            <div class="row">
                <div class="form-group">
                    <label>Full Name</label>
                    <div class="input-wrap">
                        <i class="fa-solid fa-user"></i>
                        <input type="text" name="fullName" placeholder="Your full name" required>
                    </div>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <div class="input-wrap">
                        <i class="fa-solid fa-phone"></i>
                        <input type="tel" name="phone" placeholder="10-digit mobile" maxlength="10" required>
                    </div>
                </div>
            </div>
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
                    <input type="password" name="password" placeholder="Minimum 6 characters" minlength="6" required>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label>License Number</label>
                    <div class="input-wrap">
                        <i class="fa-solid fa-id-card"></i>
                        <input type="text" name="licenseNo" placeholder="DL1234567" required>
                    </div>
                </div>
                <div class="form-group">
                    <label>Cab Type</label>
                    <div class="input-wrap">
                        <i class="fa-solid fa-car"></i>
                        <select name="cabType" required>
                            <option value="">Select type</option>
                            <option value="Bike">Bike</option>
                            <option value="Mini">Mini</option>
                            <option value="Sedan">Sedan</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="form-group">
                    <label>Vehicle Number</label>
                    <div class="input-wrap">
                        <i class="fa-solid fa-hashtag"></i>
                        <input type="text" name="vehicleNo" placeholder="DL3C AB1234" required>
                    </div>
                </div>
                <div class="form-group">
                    <label>Vehicle Model</label>
                    <div class="input-wrap">
                        <i class="fa-solid fa-car-side"></i>
                        <input type="text" name="vehicleModel" placeholder="Maruti Swift" required>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn"><i class="fa-solid fa-steering-wheel"></i> Register as Driver</button>
        </form>
        <div class="links">Already a driver? <a href="<%=request.getContextPath()%>/pages/driver-login.jsp">Sign In &rarr;</a></div>
    </div>
</div>
</body>
</html>
