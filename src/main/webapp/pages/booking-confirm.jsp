<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cab.model.*,com.cab.dao.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/pages/login.jsp"); return; }
    String ctx = request.getContextPath();
    int bookingId = 0;
    try { bookingId = Integer.parseInt(request.getParameter("id")); } catch(Exception e) {}
    Booking booking = null;
    Driver driver = null;
    if (bookingId > 0) {
        BookingDAO bDao = new BookingDAO();
        booking = bDao.getBookingById(bookingId);
        if (booking != null && booking.getDriverId() > 0) {
            DriverDAO dDao = new DriverDAO();
            driver = dDao.getDriverById(booking.getDriverId());
        }
    }
    if (booking == null) { response.sendRedirect(ctx + "/pages/book-cab.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed – CabGo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        :root{--night:#0a0a0f;--card:#15151f;--border:rgba(255,255,255,0.07);--gold:#f5c842;--text:#e8e8f0;--muted:#7878a0;--green:#22c55e}
        body{background:var(--night);color:var(--text);font-family:'DM Sans',sans-serif;min-height:100vh;display:flex;align-items:center;justify-content:center;padding:40px 24px}
        .container{width:100%;max-width:520px}
        .success-icon{text-align:center;margin-bottom:28px;animation:popIn .5s cubic-bezier(.175,.885,.32,1.275) both}
        .check-circle{width:80px;height:80px;border-radius:50%;background:rgba(34,197,94,0.1);border:2px solid rgba(34,197,94,0.3);display:inline-flex;align-items:center;justify-content:center;font-size:2rem;color:var(--green)}
        h1{font-family:'Syne',sans-serif;font-size:1.8rem;font-weight:800;text-align:center;margin-bottom:6px;animation:fadeUp .5s .1s both}
        .sub{text-align:center;color:var(--muted);font-size:0.9rem;margin-bottom:28px;animation:fadeUp .5s .15s both}
        .card{background:var(--card);border:1px solid var(--border);border-radius:20px;padding:28px;animation:fadeUp .5s .2s both;margin-bottom:16px}
        .booking-id{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;padding-bottom:16px;border-bottom:1px solid var(--border)}
        .bid-label{font-size:.78rem;color:var(--muted)}
        .bid-value{font-family:'Syne',sans-serif;font-weight:800;color:var(--gold)}
        .status-badge{background:rgba(34,197,94,0.1);border:1px solid rgba(34,197,94,0.25);border-radius:50px;padding:5px 14px;font-size:.78rem;font-weight:700;color:var(--green)}
        .route-block{margin-bottom:20px}
        .route-item{display:flex;align-items:flex-start;gap:12px;margin-bottom:12px}
        .route-dot2{width:10px;height:10px;border-radius:50%;margin-top:5px;flex-shrink:0}
        .route-dot2.p{background:var(--gold)}
        .route-dot2.d{background:var(--green)}
        .route-lbl{font-size:.72rem;color:var(--muted)}
        .route-addr{font-size:.9rem;font-weight:500}
        .info-grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
        .info-item{background:rgba(255,255,255,0.03);border-radius:12px;padding:14px}
        .info-lbl{font-size:.72rem;color:var(--muted);margin-bottom:4px}
        .info-val{font-family:'Syne',sans-serif;font-weight:700;font-size:1.05rem}
        .info-val.gold{color:var(--gold)}
        .driver-card{display:flex;align-items:center;gap:16px;background:rgba(245,200,66,0.05);border:1px solid rgba(245,200,66,0.15);border-radius:14px;padding:16px;margin-top:16px}
        .driver-avatar{width:48px;height:48px;border-radius:50%;background:rgba(245,200,66,0.1);display:flex;align-items:center;justify-content:center;font-size:1.2rem;color:var(--gold);flex-shrink:0}
        .driver-name{font-family:'Syne',sans-serif;font-weight:700}
        .driver-meta{font-size:.8rem;color:var(--muted);margin-top:2px}
        .actions{display:flex;gap:12px;margin-top:4px;animation:fadeUp .5s .3s both}
        .btn-primary{flex:1;background:var(--gold);color:#0a0a0f;border:none;border-radius:12px;padding:14px;font-family:'Syne',sans-serif;font-weight:800;font-size:.9rem;cursor:pointer;text-decoration:none;display:block;text-align:center;transition:transform .2s}
        .btn-primary:hover{transform:translateY(-2px)}
        .btn-ghost{flex:1;background:transparent;color:var(--text);border:1px solid var(--border);border-radius:12px;padding:14px;font-family:'DM Sans',sans-serif;font-weight:600;font-size:.9rem;cursor:pointer;text-decoration:none;display:block;text-align:center;transition:border-color .2s}
        .btn-ghost:hover{border-color:rgba(255,255,255,.2)}
        @keyframes popIn{from{opacity:0;transform:scale(.5)}to{opacity:1;transform:scale(1)}}
        @keyframes fadeUp{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
    </style>
</head>
<body>
<div class="container">
    <div class="success-icon"><div class="check-circle"><i class="fa-solid fa-check"></i></div></div>
    <h1>Ride Confirmed!</h1>
    <p class="sub">Your booking is confirmed. Driver is on the way.</p>
    <div class="card">
        <div class="booking-id">
            <div><div class="bid-label">Booking ID</div><div class="bid-value">#CG-<%=booking.getBookingId()%></div></div>
            <div class="status-badge"><i class="fa-solid fa-circle" style="font-size:.5rem"></i> <%=booking.getStatus()%></div>
        </div>
        <div class="route-block">
            <div class="route-item">
                <div class="route-dot2 p"></div>
                <div><div class="route-lbl">PICKUP</div><div class="route-addr"><%=booking.getPickupAddress()%></div></div>
            </div>
            <div class="route-item">
                <div class="route-dot2 d"></div>
                <div><div class="route-lbl">DROP</div><div class="route-addr"><%=booking.getDropAddress()%></div></div>
            </div>
        </div>
        <div class="info-grid">
            <div class="info-item"><div class="info-lbl">Cab Type</div><div class="info-val"><%=booking.getCabType()%></div></div>
            <div class="info-item"><div class="info-lbl">Distance</div><div class="info-val"><%=booking.getDistanceKm()%> km</div></div>
            <div class="info-item"><div class="info-lbl">Payment</div><div class="info-val"><%=booking.getPaymentMethod()%></div></div>
            <div class="info-item"><div class="info-lbl">Total Fare</div><div class="info-val gold">&#8377;<%=String.format("%.2f",booking.getFinalFare())%></div></div>
        </div>
        <% if (driver != null) { %>
        <div class="driver-card">
            <div class="driver-avatar"><i class="fa-solid fa-user-tie"></i></div>
            <div>
                <div class="driver-name"><%=driver.getFullName()%></div>
                <div class="driver-meta">&#11088; <%=driver.getRating()%> &bull; <%=driver.getVehicleNo()%> &bull; <%=driver.getVehicleModel()%></div>
            </div>
            <div style="margin-left:auto;background:rgba(34,197,94,.1);border-radius:8px;padding:6px 12px;font-size:.78rem;color:#22c55e;font-weight:700">On the way</div>
        </div>
        <% } else { %>
        <div class="driver-card" style="justify-content:center;text-align:center">
            <div><i class="fa-solid fa-clock" style="color:var(--gold)"></i> &nbsp; Finding nearest driver...</div>
        </div>
        <% } %>
    </div>
    <div class="actions">
        <a href="<%=ctx%>/booking/history" class="btn-ghost"><i class="fa-solid fa-clock-rotate-left"></i> My Rides</a>
        <a href="<%=ctx%>/pages/book-cab.jsp" class="btn-primary"><i class="fa-solid fa-plus"></i> New Booking</a>
    </div>
</div>
</body>
</html>
