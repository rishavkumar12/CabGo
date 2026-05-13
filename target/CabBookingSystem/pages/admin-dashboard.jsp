<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cab.model.*,com.cab.dao.*,java.util.*" %>
<%
    if (!"admin".equals(session.getAttribute("userRole"))) {
        response.sendRedirect(request.getContextPath() + "/pages/admin-login.jsp"); return;
    }
    String ctx = request.getContextPath();
    Object totalUsersAttr = request.getAttribute("totalUsers");
    if (totalUsersAttr == null) { response.sendRedirect(ctx + "/admin/dashboard"); return; }
    int totalUsers    = (Integer) request.getAttribute("totalUsers");
    int totalDrivers  = (Integer) request.getAttribute("totalDrivers");
    int onlineDrivers = (Integer) request.getAttribute("onlineDrivers");
    int totalBookings = (Integer) request.getAttribute("totalBookings");
    double revenue    = (Double)  request.getAttribute("totalRevenue");
    @SuppressWarnings("unchecked")
    List<Booking> recentBookings = (List<Booking>) request.getAttribute("recentBookings");
    String adminName = (String) session.getAttribute("adminName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard – CabGo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        :root{--primary:#1a56db;--primary-dark:#1e429f;--primary-light:#ebf5ff;--accent:#f59e0b;--success:#057a55;--danger:#c81e1e;--bg:#f0f4f8;--white:#fff;--text:#111827;--muted:#6b7280;--border:#e5e7eb;--sidebar:#1e293b;}
        body{background:var(--bg);color:var(--text);font-family:'Inter',sans-serif;min-height:100vh;display:flex;}
        .sidebar{width:250px;background:var(--sidebar);min-height:100vh;position:fixed;top:0;left:0;display:flex;flex-direction:column;z-index:200;}
        .sidebar-brand{padding:24px 20px;border-bottom:1px solid rgba(255,255,255,0.08);}
        .brand-inner{display:flex;align-items:center;gap:10px;text-decoration:none;margin-bottom:8px;}
        .brand-icon{width:36px;height:36px;background:var(--primary);border-radius:9px;display:flex;align-items:center;justify-content:center;color:#fff;font-size:.9rem;}
        .brand-name{font-family:'Poppins',sans-serif;font-size:1.3rem;font-weight:800;color:#fff;}
        .brand-name span{color:var(--accent);}
        .admin-tag{display:inline-block;background:rgba(245,158,11,0.15);color:var(--accent);border-radius:6px;padding:3px 10px;font-size:.72rem;font-weight:700;letter-spacing:.5px;}
        .nav-section{padding:20px 12px;flex:1;}
        .nav-label{font-size:.68rem;font-weight:700;color:#64748b;letter-spacing:1px;text-transform:uppercase;padding:0 8px;margin-bottom:8px;margin-top:16px;}
        .nav-item{display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:10px;text-decoration:none;color:#94a3b8;font-size:.88rem;font-weight:500;transition:all .2s;margin-bottom:2px;}
        .nav-item:hover{background:rgba(255,255,255,0.07);color:#fff;}
        .nav-item.active{background:var(--primary);color:#fff;}
        .nav-item i{width:18px;text-align:center;font-size:.9rem;}
        .logout-btn{display:flex;align-items:center;gap:10px;padding:14px 20px;color:#94a3b8;text-decoration:none;font-size:.85rem;border-top:1px solid rgba(255,255,255,0.08);transition:color .2s;}
        .logout-btn:hover{color:#f87171;}
        .main{margin-left:250px;flex:1;padding:32px 36px;min-height:100vh;}
        .page-header{margin-bottom:28px;display:flex;align-items:center;justify-content:space-between;}
        .page-header h1{font-family:'Poppins',sans-serif;font-size:1.6rem;font-weight:800;color:var(--text);}
        .page-header p{color:var(--muted);font-size:.88rem;margin-top:3px;}
        .admin-chip{display:flex;align-items:center;gap:8px;background:var(--white);border:1px solid var(--border);border-radius:50px;padding:8px 16px;font-size:.85rem;font-weight:600;color:var(--text);}
        .admin-avatar{width:28px;height:28px;border-radius:50%;background:var(--primary);display:flex;align-items:center;justify-content:center;color:#fff;font-size:.75rem;font-weight:700;}
        .stats-grid{display:grid;grid-template-columns:repeat(5,1fr);gap:16px;margin-bottom:28px;}
        .stat-card{background:var(--white);border:1px solid var(--border);border-radius:14px;padding:20px;box-shadow:0 2px 8px rgba(0,0,0,0.04);}
        .stat-icon{width:42px;height:42px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1rem;margin-bottom:14px;}
        .si-blue{background:#eff6ff;color:var(--primary);}
        .si-orange{background:#fff7ed;color:#ea580c;}
        .si-green{background:#f0fdf4;color:var(--success);}
        .si-yellow{background:#fffbeb;color:var(--accent);}
        .si-purple{background:#faf5ff;color:#7c3aed;}
        .stat-val{font-family:'Poppins',sans-serif;font-size:1.7rem;font-weight:800;color:var(--text);margin-bottom:3px;}
        .stat-lbl{font-size:.75rem;color:var(--muted);font-weight:500;}
        .quick-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-bottom:28px;}
        .quick-card{background:var(--white);border:1.5px solid var(--border);border-radius:12px;padding:16px 18px;text-decoration:none;color:var(--text);display:flex;align-items:center;gap:12px;transition:all .2s;font-size:.88rem;font-weight:600;}
        .quick-card:hover{border-color:var(--primary);background:var(--primary-light);color:var(--primary);}
        .quick-card i{font-size:1.1rem;color:var(--primary);}
        .section-card{background:var(--white);border:1px solid var(--border);border-radius:16px;padding:24px;box-shadow:0 2px 8px rgba(0,0,0,0.04);}
        .sec-title{font-family:'Poppins',sans-serif;font-size:1rem;font-weight:700;color:var(--text);margin-bottom:20px;display:flex;align-items:center;gap:8px;}
        .sec-title i{color:var(--primary);}
        table{width:100%;border-collapse:collapse;font-size:.85rem;}
        th{text-align:left;padding:10px 14px;color:var(--muted);font-size:.72rem;font-weight:700;letter-spacing:.5px;text-transform:uppercase;border-bottom:1.5px solid var(--border);}
        td{padding:12px 14px;border-bottom:1px solid #f1f5f9;color:var(--text);}
        tr:last-child td{border-bottom:none;}
        tr:hover td{background:#f8fafc;}
        .badge{display:inline-flex;align-items:center;border-radius:20px;padding:3px 10px;font-size:.72rem;font-weight:700;}
        .b-green{background:#dcfce7;color:#166534;}
        .b-gold{background:#fef9c3;color:#854d0e;}
        .b-blue{background:#dbeafe;color:#1e40af;}
        .b-red{background:#fee2e2;color:#991b1b;}
        .b-orange{background:#ffedd5;color:#9a3412;}
        @media(max-width:1100px){.stats-grid{grid-template-columns:repeat(3,1fr);}}
        @media(max-width:768px){.sidebar{display:none;}.main{margin-left:0;padding:20px;}}
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-brand">
        <a href="<%=ctx%>/index.jsp" class="brand-inner">
            <div class="brand-icon"><i class="fa-solid fa-taxi"></i></div>
            <div class="brand-name">Cab<span>Go</span></div>
        </a>
        <span class="admin-tag">ADMIN PANEL</span>
    </div>
    <div class="nav-section">
        <div class="nav-label">Main</div>
        <a href="<%=ctx%>/admin/dashboard" class="nav-item active"><i class="fa-solid fa-chart-pie"></i> Dashboard</a>
        <a href="<%=ctx%>/admin/users" class="nav-item"><i class="fa-solid fa-users"></i> Users</a>
        <a href="<%=ctx%>/admin/drivers" class="nav-item"><i class="fa-solid fa-steering-wheel"></i> Drivers</a>
        <a href="<%=ctx%>/admin/bookings" class="nav-item"><i class="fa-solid fa-book"></i> Bookings</a>
        <div class="nav-label">Site</div>
        <a href="<%=ctx%>/index.jsp" class="nav-item"><i class="fa-solid fa-house"></i> View Site</a>
    </div>
    <a href="<%=ctx%>/admin/logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</aside>
<main class="main">
    <div class="page-header">
        <div>
            <h1>Dashboard Overview</h1>
            <p>Welcome back, <%=adminName!=null?adminName:"Admin"%>. Here's what's happening today.</p>
        </div>
        <div class="admin-chip">
            <div class="admin-avatar">A</div>
            <%=adminName!=null?adminName:"Admin"%>
        </div>
    </div>
    <div class="stats-grid">
        <div class="stat-card"><div class="stat-icon si-blue"><i class="fa-solid fa-users"></i></div><div class="stat-val"><%=totalUsers%></div><div class="stat-lbl">Total Users</div></div>
        <div class="stat-card"><div class="stat-icon si-orange"><i class="fa-solid fa-steering-wheel"></i></div><div class="stat-val"><%=totalDrivers%></div><div class="stat-lbl">Total Drivers</div></div>
        <div class="stat-card"><div class="stat-icon si-green"><i class="fa-solid fa-circle-dot"></i></div><div class="stat-val"><%=onlineDrivers%></div><div class="stat-lbl">Online Now</div></div>
        <div class="stat-card"><div class="stat-icon si-yellow"><i class="fa-solid fa-car"></i></div><div class="stat-val"><%=totalBookings%></div><div class="stat-lbl">Total Bookings</div></div>
        <div class="stat-card"><div class="stat-icon si-purple"><i class="fa-solid fa-indian-rupee-sign"></i></div><div class="stat-val">&#8377;<%=String.format("%.0f",revenue)%></div><div class="stat-lbl">Total Revenue</div></div>
    </div>
    <div class="quick-grid">
        <a href="<%=ctx%>/admin/users" class="quick-card"><i class="fa-solid fa-users"></i> Manage Users</a>
        <a href="<%=ctx%>/admin/drivers" class="quick-card"><i class="fa-solid fa-steering-wheel"></i> Manage Drivers</a>
        <a href="<%=ctx%>/admin/bookings" class="quick-card"><i class="fa-solid fa-book"></i> All Bookings</a>
        <a href="<%=ctx%>/index.jsp" class="quick-card"><i class="fa-solid fa-globe"></i> View Website</a>
    </div>
    <div class="section-card">
        <div class="sec-title"><i class="fa-solid fa-clock-rotate-left"></i> Recent Bookings</div>
        <table>
            <thead><tr><th>Booking ID</th><th>User</th><th>Pickup</th><th>Cab Type</th><th>Fare</th><th>Status</th><th>Date</th></tr></thead>
            <tbody>
            <% int count=0; for(Booking b:recentBookings){ if(count++>=15)break;
               String s=b.getStatus(); String cls="b-gold";
               if("Completed".equals(s))cls="b-green";
               else if("Cancelled".equals(s))cls="b-red";
               else if("Accepted".equals(s))cls="b-blue";
               else if("In-Progress".equals(s))cls="b-orange"; %>
            <tr>
                <td><strong style="color:var(--primary)">#CG-<%=b.getBookingId()%></strong></td>
                <td><%=b.getUserName()!=null?b.getUserName():"-"%></td>
                <td style="max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:var(--muted)"><%=b.getPickupAddress()!=null&&b.getPickupAddress().length()>28?b.getPickupAddress().substring(0,28)+"...":b.getPickupAddress()%></td>
                <td><span style="background:#f1f5f9;padding:3px 10px;border-radius:6px;font-size:.78rem;font-weight:600;"><%=b.getCabType()%></span></td>
                <td style="font-weight:700;color:var(--text)">&#8377;<%=String.format("%.2f",b.getFinalFare())%></td>
                <td><span class="badge <%=cls%>"><%=s%></span></td>
                <td style="color:var(--muted);font-size:.82rem"><%=b.getBookingTime()!=null?b.getBookingTime().toString().substring(0,10):"-"%></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
