<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cab.model.*,com.cab.dao.*,java.util.*" %>
<%
    Driver driver = (Driver) session.getAttribute("driver");
    if (driver == null) { response.sendRedirect(request.getContextPath() + "/pages/driver-login.jsp"); return; }
    String ctx = request.getContextPath();
    @SuppressWarnings("unchecked")
    List<Booking> myRides = (List<Booking>) request.getAttribute("rides");
    @SuppressWarnings("unchecked")
    List<Booking> pending = (List<Booking>) request.getAttribute("pendingRides");
    if (myRides == null || pending == null) { response.sendRedirect(ctx + "/driver/dashboard"); return; }
    long completed = myRides.stream().filter(b -> "Completed".equals(b.getStatus())).count();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Dashboard – CabGo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        :root{--primary:#1a56db;--primary-dark:#1e429f;--primary-light:#ebf5ff;--accent:#f59e0b;--success:#057a55;--success-bg:#f0fdf4;--danger:#c81e1e;--bg:#f0f4f8;--white:#fff;--text:#111827;--muted:#6b7280;--border:#e5e7eb;}
        body{background:var(--bg);color:var(--text);font-family:'Inter',sans-serif;min-height:100vh;}
        nav{background:var(--white);border-bottom:1px solid var(--border);padding:0 40px;display:flex;align-items:center;justify-content:space-between;height:64px;position:sticky;top:0;z-index:100;box-shadow:0 1px 8px rgba(0,0,0,0.06);}
        .nav-logo{display:flex;align-items:center;gap:10px;text-decoration:none;}
        .nav-logo-icon{width:36px;height:36px;background:var(--primary);border-radius:9px;display:flex;align-items:center;justify-content:center;color:#fff;font-size:.95rem;}
        .nav-logo-name{font-family:'Poppins',sans-serif;font-size:1.3rem;font-weight:800;color:var(--text);}
        .nav-logo-name span{color:var(--primary);}
        .nav-right{display:flex;align-items:center;gap:10px;}
        .toggle-btn{display:flex;align-items:center;gap:8px;padding:8px 18px;border-radius:50px;font-weight:600;font-size:.85rem;cursor:pointer;border:2px solid;transition:all .2s;}
        .toggle-btn.online{background:#f0fdf4;border-color:#bbf7d0;color:var(--success);}
        .toggle-btn.offline{background:#f9fafb;border-color:var(--border);color:var(--muted);}
        .toggle-dot{width:8px;height:8px;border-radius:50%;}
        .toggle-dot.on{background:var(--success);animation:pulse 2s infinite;}
        .toggle-dot.off{background:var(--muted);}
        .nav-btn{display:flex;align-items:center;gap:7px;padding:8px 14px;border-radius:8px;text-decoration:none;font-size:.85rem;font-weight:500;color:var(--muted);transition:all .2s;}
        .nav-btn:hover{background:#f3f4f6;color:var(--text);}
        .main{max-width:1100px;margin:0 auto;padding:32px 24px;}
        .driver-header{background:linear-gradient(135deg,#1a56db,#1e429f);border-radius:20px;padding:28px 32px;margin-bottom:28px;display:flex;align-items:center;justify-content:space-between;overflow:hidden;position:relative;}
        .driver-header::after{content:'';position:absolute;right:-60px;top:-60px;width:250px;height:250px;border-radius:50%;background:rgba(255,255,255,0.06);}
        .driver-info h1{font-family:'Poppins',sans-serif;font-size:1.5rem;font-weight:800;color:#fff;margin-bottom:6px;}
        .driver-meta{color:rgba(255,255,255,0.75);font-size:.88rem;display:flex;flex-wrap:wrap;gap:16px;margin-top:8px;}
        .driver-meta span{display:flex;align-items:center;gap:6px;}
        .driver-img{width:120px;height:90px;object-fit:cover;border-radius:12px;opacity:.85;position:relative;z-index:1;}
        .stats-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:28px;}
        .stat-card{background:var(--white);border:1px solid var(--border);border-radius:14px;padding:20px;box-shadow:0 2px 8px rgba(0,0,0,0.04);}
        .stat-icon{width:42px;height:42px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1rem;margin-bottom:12px;}
        .stat-icon.blue{background:#eff6ff;color:var(--primary);}
        .stat-icon.yellow{background:#fffbeb;color:var(--accent);}
        .stat-icon.green{background:#f0fdf4;color:var(--success);}
        .stat-icon.orange{background:#fff7ed;color:#ea580c;}
        .stat-val{font-family:'Poppins',sans-serif;font-size:1.6rem;font-weight:800;color:var(--text);margin-bottom:2px;}
        .stat-lbl{font-size:.75rem;color:var(--muted);font-weight:500;}
        .section-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;}
        .section-title{font-family:'Poppins',sans-serif;font-size:1rem;font-weight:700;color:var(--text);display:flex;align-items:center;gap:8px;}
        .section-title i{color:var(--primary);}
        .badge-count{background:var(--primary);color:#fff;border-radius:50px;padding:2px 10px;font-size:.75rem;font-weight:700;}
        .card{background:var(--white);border:1px solid var(--border);border-radius:16px;padding:24px;margin-bottom:24px;box-shadow:0 2px 8px rgba(0,0,0,0.04);}
        .ride-request{border:1.5px solid #bfdbfe;border-radius:12px;padding:18px;margin-bottom:12px;background:#eff6ff;}
        .rr-top{display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:8px;}
        .rr-id{font-weight:700;font-size:.88rem;color:var(--primary);}
        .rr-fare{font-family:'Poppins',sans-serif;font-weight:800;font-size:1.1rem;color:var(--text);}
        .rr-route{font-size:.84rem;color:var(--muted);margin-bottom:10px;display:flex;align-items:center;gap:6px;}
        .rr-meta{display:flex;gap:14px;font-size:.78rem;color:var(--muted);margin-bottom:14px;flex-wrap:wrap;}
        .rr-meta span{display:flex;align-items:center;gap:5px;}
        .btn-accept{background:linear-gradient(135deg,#057a55,#065f46);color:#fff;border:none;border-radius:8px;padding:9px 20px;font-family:'Poppins',sans-serif;font-weight:700;font-size:.85rem;cursor:pointer;transition:all .2s;display:flex;align-items:center;gap:6px;}
        .btn-accept:hover{transform:translateY(-1px);box-shadow:0 4px 12px rgba(5,122,85,0.3);}
        .btn-complete{background:linear-gradient(135deg,var(--accent),#d97706);color:#fff;border:none;border-radius:8px;padding:6px 14px;font-weight:700;font-size:.78rem;cursor:pointer;display:flex;align-items:center;gap:5px;}
        .history-item{display:flex;justify-content:space-between;align-items:center;padding:14px 0;border-bottom:1px solid var(--border);}
        .history-item:last-child{border-bottom:none;}
        .hi-route{font-weight:600;font-size:.88rem;margin-bottom:3px;}
        .hi-meta{font-size:.76rem;color:var(--muted);}
        .hi-right{text-align:right;}
        .hi-fare{font-family:'Poppins',sans-serif;font-weight:700;font-size:.95rem;color:var(--primary);}
        .status-badge{font-size:.7rem;padding:3px 10px;border-radius:20px;font-weight:700;display:inline-block;margin-top:3px;}
        .status-badge.completed{background:#dcfce7;color:#166534;}
        .status-badge.pending{background:#fef9c3;color:#854d0e;}
        .status-badge.accepted{background:#dbeafe;color:#1e40af;}
        .empty-msg{text-align:center;padding:36px;color:var(--muted);font-size:.88rem;}
        .empty-msg i{font-size:2rem;display:block;margin-bottom:12px;color:#d1d5db;}
        @keyframes pulse{0%,100%{opacity:1}50%{opacity:.4}}
        @media(max-width:768px){.stats-grid{grid-template-columns:1fr 1fr;}.driver-img{display:none;}}
    </style>
</head>
<body>
<nav>
    <a href="<%=ctx%>/index.jsp" class="nav-logo">
        <div class="nav-logo-icon"><i class="fa-solid fa-taxi"></i></div>
        <div class="nav-logo-name">Cab<span>Go</span></div>
    </a>
    <div class="nav-right">
        <form action="<%=ctx%>/driver/toggle-status" method="post" style="display:inline">
            <button type="submit" class="toggle-btn <%=driver.getIsOnline()==1?"online":"offline"%>">
                <span class="toggle-dot <%=driver.getIsOnline()==1?"on":"off"%>"></span>
                <%=driver.getIsOnline()==1 ? "Online" : "Go Online"%>
            </button>
        </form>
        <a href="<%=ctx%>/driver/logout" class="nav-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
    </div>
</nav>
<div class="main">
    <div class="driver-header">
        <div class="driver-info">
            <h1>Hello, <%=driver.getFullName().split(" ")[0]%>! <% if(driver.getIsOnline()==1){ %><span style="font-size:1rem;color:#86efac;">&#9679; Online</span><% } %></h1>
            <div class="driver-meta">
                <span><i class="fa-solid fa-car"></i> <%=driver.getCabType()%></span>
                <span><i class="fa-solid fa-id-card"></i> <%=driver.getVehicleNo()%></span>
                <span><i class="fa-solid fa-car-side"></i> <%=driver.getVehicleModel()%></span>
                <span><i class="fa-solid fa-star"></i> <%=driver.getRating()%> Rating</span>
            </div>
        </div>
        <img src="https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=300&q=80&auto=format" class="driver-img" alt="Car">
    </div>
    <div class="stats-grid">
        <div class="stat-card"><div class="stat-icon blue"><i class="fa-solid fa-car"></i></div><div class="stat-val"><%=driver.getTotalRides()%></div><div class="stat-lbl">Total Rides</div></div>
        <div class="stat-card"><div class="stat-icon yellow"><i class="fa-solid fa-indian-rupee-sign"></i></div><div class="stat-val">&#8377;<%=String.format("%.0f",driver.getTotalEarnings())%></div><div class="stat-lbl">Total Earnings</div></div>
        <div class="stat-card"><div class="stat-icon green"><i class="fa-solid fa-star"></i></div><div class="stat-val"><%=driver.getRating()%></div><div class="stat-lbl">Rating</div></div>
        <div class="stat-card"><div class="stat-icon orange"><i class="fa-solid fa-check-circle"></i></div><div class="stat-val"><%=completed%></div><div class="stat-lbl">Completed</div></div>
    </div>
    <div class="card">
        <div class="section-header">
            <div class="section-title"><i class="fa-solid fa-bell"></i> Pending Requests</div>
            <span class="badge-count"><%=pending.size()%></span>
        </div>
        <% if (pending.isEmpty()) { %>
        <div class="empty-msg"><i class="fa-solid fa-hourglass"></i> No pending requests right now. Stay online to receive rides.</div>
        <% } else { for (Booking b : pending) { %>
        <div class="ride-request">
            <div class="rr-top">
                <div class="rr-id"><i class="fa-solid fa-hashtag"></i> CG-<%=b.getBookingId()%></div>
                <div class="rr-fare">&#8377;<%=String.format("%.2f",b.getFinalFare())%></div>
            </div>
            <div class="rr-route"><i class="fa-solid fa-map-marker-alt" style="color:var(--primary)"></i><%=b.getPickupAddress()%> <i class="fa-solid fa-arrow-right"></i> <%=b.getDropAddress()%></div>
            <div class="rr-meta">
                <span><i class="fa-solid fa-car"></i><%=b.getCabType()%></span>
                <span><i class="fa-solid fa-route"></i><%=b.getDistanceKm()%> km</span>
                <span><i class="fa-solid fa-user"></i><%=b.getUserName()!=null?b.getUserName():"Rider"%></span>
            </div>
            <form action="<%=ctx%>/driver/accept" method="post">
                <input type="hidden" name="bookingId" value="<%=b.getBookingId()%>">
                <button type="submit" class="btn-accept"><i class="fa-solid fa-check"></i> Accept Ride</button>
            </form>
        </div>
        <% } } %>
    </div>
    <div class="card">
        <div class="section-title" style="margin-bottom:16px"><i class="fa-solid fa-clock-rotate-left"></i> Ride History</div>
        <% if (myRides.isEmpty()) { %>
        <div class="empty-msg"><i class="fa-solid fa-road"></i> No rides yet. Accept requests to start earning!</div>
        <% } else { for (Booking b : myRides) { %>
        <div class="history-item">
            <div>
                <div class="hi-route"><%=b.getPickupAddress()!=null&&b.getPickupAddress().length()>40?b.getPickupAddress().substring(0,40)+"...":b.getPickupAddress()%> &rarr; <%=b.getDropAddress()!=null&&b.getDropAddress().length()>30?b.getDropAddress().substring(0,30)+"...":b.getDropAddress()%></div>
                <div class="hi-meta"><%=b.getCabType()%> &bull; <%=b.getDistanceKm()%> km &bull; <%=b.getBookingTime()!=null?b.getBookingTime().toString().substring(0,10):""%></div>
            </div>
            <div class="hi-right">
                <div class="hi-fare">&#8377;<%=String.format("%.2f",b.getFinalFare())%></div>
                <span class="status-badge <%=b.getStatus()!=null?b.getStatus().toLowerCase():""%>"><%=b.getStatus()%></span>
                <% if ("Accepted".equals(b.getStatus()) || "In-Progress".equals(b.getStatus())) { %>
                <form action="<%=ctx%>/driver/complete" method="post" style="margin-top:6px">
                    <input type="hidden" name="bookingId" value="<%=b.getBookingId()%>">
                    <button type="submit" class="btn-complete"><i class="fa-solid fa-flag-checkered"></i> Complete</button>
                </form>
                <% } %>
            </div>
        </div>
        <% } } %>
    </div>
</div>
</body>
</html>
