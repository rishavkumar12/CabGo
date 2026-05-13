<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cab.model.*,com.cab.dao.*,java.util.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/pages/login.jsp"); return; }
    String ctx = request.getContextPath();
    // Data loaded by BookingServlet (/booking/history) via request attribute
    @SuppressWarnings("unchecked")
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
    if (bookings == null) {
        // Redirect to servlet so data is loaded properly
        response.sendRedirect(ctx + "/booking/history"); return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ride History – CabGo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        :root{--night:#0a0a0f;--card:#15151f;--border:rgba(255,255,255,0.07);--gold:#f5c842;--text:#e8e8f0;--muted:#7878a0;--green:#22c55e;--red:#ef4444;--orange:#f97316}
        body{background:var(--night);color:var(--text);font-family:'DM Sans',sans-serif;min-height:100vh}
        nav{display:flex;align-items:center;justify-content:space-between;padding:18px 40px;background:rgba(10,10,15,.9);backdrop-filter:blur(16px);border-bottom:1px solid var(--border);position:sticky;top:0;z-index:100}
        .nav-logo{font-family:'Syne',sans-serif;font-size:1.6rem;font-weight:800;color:var(--gold);text-decoration:none}
        .nav-logo span{color:var(--text)}
        .nav-links{display:flex;gap:20px;align-items:center}
        .nav-link{color:var(--muted);text-decoration:none;font-size:.88rem;transition:color .2s}
        .nav-link:hover{color:var(--text)}
        .main{max-width:900px;margin:0 auto;padding:40px 24px}
        .page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:32px}
        h1{font-family:'Syne',sans-serif;font-size:1.8rem;font-weight:800}
        .btn-new{background:var(--gold);color:#0a0a0f;border:none;border-radius:50px;padding:10px 24px;font-family:'Syne',sans-serif;font-weight:700;font-size:.88rem;cursor:pointer;text-decoration:none;display:inline-flex;align-items:center;gap:8px;transition:transform .2s}
        .btn-new:hover{transform:translateY(-2px)}
        .empty-state{text-align:center;padding:80px 24px}
        .empty-icon{font-size:3rem;color:var(--muted);margin-bottom:16px}
        .empty-state h3{font-family:'Syne',sans-serif;margin-bottom:8px}
        .empty-state p{color:var(--muted);font-size:.9rem;margin-bottom:24px}
        .booking-card{background:var(--card);border:1px solid var(--border);border-radius:18px;padding:24px;margin-bottom:16px;transition:border-color .2s}
        .booking-card:hover{border-color:rgba(245,200,66,.15)}
        .card-top{display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:16px}
        .card-id{font-family:'Syne',sans-serif;font-weight:800;font-size:1rem;color:var(--gold)}
        .card-time{font-size:.78rem;color:var(--muted);margin-top:2px}
        .status{display:inline-flex;align-items:center;gap:5px;border-radius:50px;padding:4px 12px;font-size:.75rem;font-weight:700}
        .status.completed{background:rgba(34,197,94,.1);color:var(--green)}
        .status.pending{background:rgba(245,200,66,.1);color:var(--gold)}
        .status.accepted{background:rgba(59,130,246,.1);color:#60a5fa}
        .status.cancelled{background:rgba(239,68,68,.1);color:var(--red)}
        .status.in-progress{background:rgba(249,115,22,.1);color:var(--orange)}
        .route-mini{display:flex;flex-direction:column;gap:8px;padding:16px;background:rgba(255,255,255,.02);border-radius:12px;margin-bottom:16px}
        .route-mi-item{display:flex;align-items:center;gap:10px;font-size:.88rem}
        .dot{width:8px;height:8px;border-radius:50%;flex-shrink:0}
        .dot.g{background:var(--gold)}
        .dot.gr{background:var(--green)}
        .card-meta{display:flex;gap:20px;flex-wrap:wrap}
        .meta-chip{display:flex;align-items:center;gap:6px;font-size:.8rem;color:var(--muted)}
        .meta-chip i{color:var(--gold);font-size:.75rem}
        .fare-big{font-family:'Syne',sans-serif;font-weight:800;font-size:1.2rem;color:var(--gold);margin-left:auto}
        .cancel-btn{background:transparent;border:1px solid rgba(239,68,68,.3);border-radius:8px;padding:6px 14px;color:var(--red);font-size:.78rem;cursor:pointer;transition:background .2s}
        .cancel-btn:hover{background:rgba(239,68,68,.1)}
        .alert-success{background:rgba(34,197,94,.1);border:1px solid rgba(34,197,94,.2);border-radius:12px;padding:12px 16px;font-size:.88rem;color:var(--green);margin-bottom:20px}
    </style>
</head>
<body>
<nav>
    <a href="<%=ctx%>/index.jsp" class="nav-logo">Cab<span>Go</span></a>
    <div class="nav-links">
        <a href="<%=ctx%>/pages/book-cab.jsp" class="nav-link"><i class="fa-solid fa-car"></i> Book Ride</a>
        <a href="<%=ctx%>/user/logout" class="nav-link"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
    </div>
</nav>
<div class="main">
    <div class="page-header">
        <h1>Ride History</h1>
        <a href="<%=ctx%>/pages/book-cab.jsp" class="btn-new"><i class="fa-solid fa-plus"></i> New Ride</a>
    </div>
    <% String msg = request.getParameter("msg");
       if ("cancelled".equals(msg)) { %><div class="alert-success">&#10003; Booking cancelled successfully.</div><% } %>
    <% if (bookings == null || bookings.isEmpty()) { %>
    <div class="empty-state">
        <div class="empty-icon"><i class="fa-solid fa-car-side"></i></div>
        <h3>No rides yet</h3>
        <p>Your ride history will appear here once you book your first trip.</p>
        <a href="<%=ctx%>/pages/book-cab.jsp" class="btn-new"><i class="fa-solid fa-car"></i> Book Your First Ride</a>
    </div>
    <% } else { for (Booking b : bookings) {
        String st = b.getStatus() != null ? b.getStatus().toLowerCase().replace(" ","-") : "pending"; %>
    <div class="booking-card">
        <div class="card-top">
            <div>
                <div class="card-id">#CG-<%=b.getBookingId()%></div>
                <div class="card-time"><i class="fa-solid fa-clock"></i> <%=b.getBookingTime()!=null?b.getBookingTime().toString().substring(0,16):"-"%></div>
            </div>
            <span class="status <%=st%>"><%=b.getStatus()%></span>
        </div>
        <div class="route-mini">
            <div class="route-mi-item"><div class="dot g"></div><span><%=b.getPickupAddress()%></span></div>
            <div class="route-mi-item"><div class="dot gr"></div><span><%=b.getDropAddress()%></span></div>
        </div>
        <div class="card-meta">
            <div class="meta-chip"><i class="fa-solid fa-car"></i> <%=b.getCabType()%></div>
            <div class="meta-chip"><i class="fa-solid fa-route"></i> <%=b.getDistanceKm()%> km</div>
            <div class="meta-chip"><i class="fa-solid fa-credit-card"></i> <%=b.getPaymentMethod()%></div>
            <% if (b.getDriverName()!=null && !b.getDriverName().isEmpty()) { %>
            <div class="meta-chip"><i class="fa-solid fa-user-tie"></i> <%=b.getDriverName()%></div>
            <% } %>
            <div class="fare-big">&#8377;<%=String.format("%.2f",b.getFinalFare())%></div>
        </div>
        <% if ("Pending".equals(b.getStatus()) || "Accepted".equals(b.getStatus())) { %>
        <div style="margin-top:14px">
            <form action="<%=ctx%>/booking/cancel" method="post" style="display:inline">
                <input type="hidden" name="bookingId" value="<%=b.getBookingId()%>">
                <button type="submit" class="cancel-btn" onclick="return confirm('Cancel this booking?')">
                    <i class="fa-solid fa-xmark"></i> Cancel Booking
                </button>
            </form>
        </div>
        <% } %>
    </div>
    <% } } %>
</div>
</body>
</html>
