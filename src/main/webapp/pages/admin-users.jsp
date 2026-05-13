<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cab.model.*,com.cab.dao.*,java.util.*" %>
<%
    if (!"admin".equals(session.getAttribute("userRole"))) {
        response.sendRedirect(request.getContextPath() + "/pages/admin-login.jsp"); return;
    }
    String ctx = request.getContextPath();
    UserDAO uDao = new UserDAO();
    @SuppressWarnings("unchecked")
    List<User> users = (List<User>) request.getAttribute("users");
    if (users == null) users = uDao.getAllUsers();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users – CabGo Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        :root{--night:#0a0a0f;--deep:#10101a;--card:#15151f;--border:rgba(255,255,255,0.07);--gold:#f5c842;--text:#e8e8f0;--muted:#7878a0;--green:#22c55e;--red:#ef4444;--blue:#60a5fa}
        body{background:var(--night);color:var(--text);font-family:'DM Sans',sans-serif;min-height:100vh;display:flex}
        .sidebar{width:240px;background:var(--deep);border-right:1px solid var(--border);min-height:100vh;position:fixed;top:0;left:0;display:flex;flex-direction:column}
        .sidebar-logo{padding:28px 24px;border-bottom:1px solid var(--border)}
        .sidebar-logo a{font-family:'Syne',sans-serif;font-size:1.5rem;font-weight:800;color:var(--gold);text-decoration:none}
        .sidebar-logo a span{color:var(--text)}
        .admin-tag{display:block;font-size:9px;font-weight:700;letter-spacing:2px;color:var(--muted);text-transform:uppercase;margin-top:2px}
        .nav-items{padding:20px 12px;flex:1}
        .nav-item{display:flex;align-items:center;gap:12px;padding:11px 16px;border-radius:12px;color:var(--muted);text-decoration:none;font-size:.88rem;font-weight:500;margin-bottom:4px;transition:all .2s}
        .nav-item:hover,.nav-item.active{background:rgba(245,200,66,.07);color:var(--gold)}
        .nav-item i{width:16px;text-align:center}
        .logout-btn{margin:20px 12px;display:flex;align-items:center;gap:10px;padding:11px 16px;border-radius:12px;color:var(--muted);text-decoration:none;font-size:.88rem;border:1px solid var(--border);transition:all .2s}
        .logout-btn:hover{color:var(--red);border-color:rgba(239,68,68,.3)}
        .main{margin-left:240px;flex:1;padding:36px}
        h1{font-family:'Syne',sans-serif;font-size:1.8rem;font-weight:800;margin-bottom:28px}
        .section-card{background:var(--card);border:1px solid var(--border);border-radius:18px;padding:24px}
        table{width:100%;border-collapse:collapse;font-size:.85rem}
        th{text-align:left;padding:10px 14px;color:var(--muted);font-size:.75rem;font-weight:700;letter-spacing:.5px;text-transform:uppercase;border-bottom:1px solid var(--border)}
        td{padding:12px 14px;border-bottom:1px solid rgba(255,255,255,.04)}
        tr:last-child td{border-bottom:none}
        tr:hover td{background:rgba(255,255,255,.02)}
        .badge{display:inline-flex;align-items:center;border-radius:50px;padding:3px 10px;font-size:.72rem;font-weight:700}
        .b-green{background:rgba(34,197,94,.1);color:var(--green)}
        .b-red{background:rgba(239,68,68,.1);color:var(--red)}
        .action-btn{border:none;border-radius:8px;padding:5px 12px;font-size:.75rem;font-weight:700;cursor:pointer;transition:all .2s}
        .btn-disable{background:rgba(239,68,68,.1);color:var(--red)}
        .btn-enable{background:rgba(34,197,94,.1);color:var(--green)}
    </style>
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-logo"><a href="<%=ctx%>/index.jsp">Cab<span>Go</span></a><span class="admin-tag">Admin Panel</span></div>
    <nav class="nav-items">
        <a href="<%=ctx%>/admin/dashboard" class="nav-item"><i class="fa-solid fa-chart-pie"></i> Dashboard</a>
        <a href="<%=ctx%>/admin/users" class="nav-item active"><i class="fa-solid fa-users"></i> Users</a>
        <a href="<%=ctx%>/admin/drivers" class="nav-item"><i class="fa-solid fa-steering-wheel"></i> Drivers</a>
        <a href="<%=ctx%>/admin/bookings" class="nav-item"><i class="fa-solid fa-book"></i> Bookings</a>
    </nav>
    <a href="<%=ctx%>/admin/logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
</aside>
<main class="main">
    <h1>Manage Users (<%=users.size()%>)</h1>
    <div class="section-card">
        <table>
            <thead><tr><th>#</th><th>Name</th><th>Email</th><th>Phone</th><th>Status</th><th>Joined</th><th>Action</th></tr></thead>
            <tbody>
            <% for(User u:users){ %>
            <tr>
                <td><%=u.getUserId()%></td>
                <td><strong><%=u.getFullName()%></strong></td>
                <td><%=u.getEmail()%></td>
                <td><%=u.getPhone()%></td>
                <td><span class="badge <%=u.getIsActive()==1?"b-green":"b-red"%>"><%=u.getIsActive()==1?"Active":"Inactive"%></span></td>
                <td style="color:var(--muted)"><%=u.getCreatedAt()!=null?u.getCreatedAt().toString().substring(0,10):"-"%></td>
                <td>
                    <form action="<%=ctx%>/admin/toggle-user" method="post" style="display:inline">
                        <input type="hidden" name="userId" value="<%=u.getUserId()%>">
                        <input type="hidden" name="status" value="<%=u.getIsActive()==1?0:1%>">
                        <button type="submit" class="action-btn <%=u.getIsActive()==1?"btn-disable":"btn-enable"%>"><%=u.getIsActive()==1?"Disable":"Enable"%></button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>
