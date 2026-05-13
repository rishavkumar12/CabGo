<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cab.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) { response.sendRedirect(request.getContextPath() + "/pages/login.jsp"); return; }
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Ride – CabGo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        :root{--primary:#1a56db;--primary-dark:#1e429f;--primary-light:#ebf5ff;--accent:#f59e0b;--success:#057a55;--danger:#c81e1e;--bg:#f0f4f8;--white:#fff;--text:#111827;--muted:#6b7280;--border:#e5e7eb;--card:#fff;}
        body{background:var(--bg);color:var(--text);font-family:'Inter',sans-serif;min-height:100vh;}
        nav{background:var(--white);border-bottom:1px solid var(--border);padding:0 40px;display:flex;align-items:center;justify-content:space-between;height:64px;position:sticky;top:0;z-index:100;box-shadow:0 1px 8px rgba(0,0,0,0.06);}
        .nav-logo{display:flex;align-items:center;gap:10px;text-decoration:none;}
        .nav-logo-icon{width:36px;height:36px;background:var(--primary);border-radius:9px;display:flex;align-items:center;justify-content:center;color:#fff;font-size:.95rem;}
        .nav-logo-name{font-family:'Poppins',sans-serif;font-size:1.3rem;font-weight:800;color:var(--text);}
        .nav-logo-name span{color:var(--primary);}
        .nav-right{display:flex;align-items:center;gap:8px;}
        .nav-btn{display:flex;align-items:center;gap:7px;padding:8px 14px;border-radius:8px;text-decoration:none;font-size:.85rem;font-weight:500;color:var(--muted);transition:all .2s;}
        .nav-btn:hover{background:#f3f4f6;color:var(--text);}
        .nav-user-chip{display:flex;align-items:center;gap:8px;background:var(--primary-light);border-radius:50px;padding:6px 14px 6px 6px;}
        .avatar{width:30px;height:30px;border-radius:50%;background:var(--primary);display:flex;align-items:center;justify-content:center;color:#fff;font-size:.8rem;font-weight:700;}
        .user-name{font-size:.85rem;font-weight:600;color:var(--primary);}
        .main{max-width:1100px;margin:0 auto;padding:36px 24px;}
        .page-header{margin-bottom:28px;}
        .page-header h1{font-family:'Poppins',sans-serif;font-size:1.8rem;font-weight:800;color:var(--text);margin-bottom:4px;}
        .page-header p{color:var(--muted);font-size:.92rem;}
        .hero-banner{background:linear-gradient(135deg,#1a56db,#1e429f);border-radius:20px;padding:28px 32px;margin-bottom:28px;display:flex;align-items:center;justify-content:space-between;overflow:hidden;position:relative;}
        .hero-banner::after{content:'';position:absolute;right:-40px;top:-40px;width:200px;height:200px;border-radius:50%;background:rgba(255,255,255,0.06);}
        .hero-text h2{font-family:'Poppins',sans-serif;font-size:1.4rem;font-weight:700;color:#fff;margin-bottom:6px;}
        .hero-text p{color:rgba(255,255,255,0.75);font-size:.88rem;}
        .hero-badges{display:flex;gap:8px;margin-top:14px;flex-wrap:wrap;}
        .hero-badge{background:rgba(255,255,255,0.12);border-radius:20px;padding:5px 12px;font-size:.75rem;color:#fff;display:flex;align-items:center;gap:6px;}
        .hero-img{width:130px;height:90px;object-fit:cover;border-radius:12px;opacity:.85;position:relative;z-index:1;}
        .booking-layout{display:grid;grid-template-columns:1fr 360px;gap:24px;}
        .card{background:var(--card);border:1px solid var(--border);border-radius:16px;padding:24px;box-shadow:0 2px 12px rgba(0,0,0,0.05);}
        .card-title{font-family:'Poppins',sans-serif;font-size:1rem;font-weight:700;color:var(--text);margin-bottom:18px;display:flex;align-items:center;gap:8px;}
        .card-title i{color:var(--primary);width:32px;height:32px;background:var(--primary-light);border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:.85rem;}
        .form-group{margin-bottom:18px;}
        label{display:block;font-size:.8rem;font-weight:600;margin-bottom:6px;color:var(--text);}
        .input-wrap{position:relative;}
        .input-wrap i.icon{position:absolute;left:13px;top:50%;transform:translateY(-50%);color:var(--muted);font-size:.85rem;}
        input,select{width:100%;background:#f9fafb;border:1.5px solid var(--border);border-radius:10px;padding:11px 12px 11px 38px;color:var(--text);font-family:'Inter',sans-serif;font-size:.9rem;outline:none;transition:all .2s;-webkit-appearance:none;}
        input:focus,select:focus{border-color:var(--primary);background:#fff;box-shadow:0 0 0 3px rgba(26,86,219,0.1);}
        input::placeholder{color:#9ca3af;}
        .cab-types{display:grid;grid-template-columns:repeat(3,1fr);gap:12px;margin-bottom:8px;}
        .cab-option{display:none;}
        .cab-label{display:block;background:#f9fafb;border:1.5px solid var(--border);border-radius:12px;padding:16px 10px;text-align:center;cursor:pointer;transition:all .2s;}
        .cab-label:hover{border-color:var(--primary);background:var(--primary-light);}
        .cab-option:checked + .cab-label{border-color:var(--primary);background:var(--primary-light);box-shadow:0 0 0 3px rgba(26,86,219,0.1);}
        .cab-icon-big{font-size:1.7rem;color:var(--muted);margin-bottom:6px;transition:color .2s;}
        .cab-option:checked + .cab-label .cab-icon-big{color:var(--primary);}
        .cab-type-name{font-family:'Poppins',sans-serif;font-weight:700;font-size:.85rem;color:var(--text);}
        .cab-rate{font-size:.72rem;color:var(--muted);margin-top:2px;}
        .promo-row{display:flex;gap:10px;}
        .promo-row input{flex:1;}
        .promo-btn{background:var(--primary);border:none;color:#fff;border-radius:10px;padding:0 18px;font-family:'Inter',sans-serif;font-weight:600;font-size:.85rem;cursor:pointer;white-space:nowrap;transition:background .2s;}
        .promo-btn:hover{background:var(--primary-dark);}
        .fare-box{background:#f8fafc;border:1px solid var(--border);border-radius:12px;padding:18px;margin-bottom:18px;}
        .fare-row{display:flex;justify-content:space-between;align-items:center;font-size:.88rem;margin-bottom:10px;color:var(--muted);}
        .fare-row:last-child{margin-bottom:0;padding-top:10px;border-top:1.5px solid var(--border);font-family:'Poppins',sans-serif;font-weight:700;font-size:1rem;color:var(--text);}
        .fare-val{color:var(--text);font-weight:600;}
        .fare-val.discount{color:var(--success);}
        .fare-val.total{color:var(--primary);font-size:1.2rem;}
        .off-peak-badge{display:none;align-items:center;gap:6px;background:#f0fdf4;border:1px solid #bbf7d0;border-radius:8px;padding:8px 12px;font-size:.8rem;color:var(--success);margin-bottom:14px;}
        .btn-book{width:100%;background:linear-gradient(135deg,var(--primary),var(--primary-dark));color:#fff;border:none;border-radius:12px;padding:15px;font-family:'Poppins',sans-serif;font-weight:700;font-size:1rem;cursor:pointer;transition:all .2s;display:flex;align-items:center;justify-content:center;gap:8px;}
        .btn-book:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(26,86,219,0.35);}
        .btn-book:disabled{opacity:.5;cursor:not-allowed;transform:none;box-shadow:none;}
        .payment-opts{display:grid;grid-template-columns:repeat(3,1fr);gap:8px;margin-bottom:4px;}
        .pay-option{display:none;}
        .pay-label{display:block;background:#f9fafb;border:1.5px solid var(--border);border-radius:10px;padding:10px 6px;text-align:center;cursor:pointer;font-size:.76rem;font-weight:600;color:var(--muted);transition:all .2s;}
        .pay-option:checked + .pay-label{border-color:var(--primary);background:var(--primary-light);color:var(--primary);}
        .trust-items{display:flex;flex-direction:column;gap:6px;margin-top:14px;}
        .trust-item{display:flex;align-items:center;gap:8px;font-size:.78rem;color:var(--muted);}
        .trust-item i{color:var(--success);}
        @media(max-width:768px){.booking-layout{grid-template-columns:1fr;}.hero-img{display:none;}}
    </style>
</head>
<body>
<nav>
    <a href="<%=ctx%>/index.jsp" class="nav-logo">
        <div class="nav-logo-icon"><i class="fa-solid fa-taxi"></i></div>
        <div class="nav-logo-name">Cab<span>Go</span></div>
    </a>
    <div class="nav-right">
        <a href="<%=ctx%>/booking/history" class="nav-btn"><i class="fa-solid fa-clock-rotate-left"></i> My Rides</a>
        <div class="nav-user-chip">
            <div class="avatar"><%=user.getFullName().substring(0,1).toUpperCase()%></div>
            <span class="user-name"><%=user.getFullName().split(" ")[0]%></span>
        </div>
        <a href="<%=ctx%>/user/logout" class="nav-btn" title="Logout"><i class="fa-solid fa-right-from-bracket"></i></a>
    </div>
</nav>
<div class="main">
    <div class="hero-banner">
        <div class="hero-text">
            <h2>Where are you headed today? 🚀</h2>
            <p>Get instant fare estimates — no surprises, just great rides.</p>
            <div class="hero-badges">
                <div class="hero-badge"><i class="fa-solid fa-shield-halved"></i> Safe & Verified</div>
                <div class="hero-badge"><i class="fa-solid fa-bolt"></i> Instant Booking</div>
                <div class="hero-badge"><i class="fa-solid fa-tag"></i> Best Prices</div>
            </div>
        </div>
        <img src="https://images.unsplash.com/photo-1522199755839-a2bacb67c546?w=300&q=80&auto=format" class="hero-img" alt="Ride">
    </div>
    <% if(request.getAttribute("error") != null) { %>
    <div style="background:#fef2f2;border:1px solid #fecaca;border-radius:10px;padding:12px 16px;font-size:.88rem;color:#c81e1e;margin-bottom:18px;display:flex;align-items:center;gap:8px;">
        <i class="fa-solid fa-circle-exclamation"></i> <%=request.getAttribute("error")%>
    </div>
    <% } %>
    <form id="bookingForm" action="<%=ctx%>/booking/create" method="post">
        <div class="booking-layout">
            <div>
                <div class="card" style="margin-bottom:20px">
                    <div class="card-title"><i class="fa-solid fa-map-marker-alt"></i> Your Route</div>
                    <div class="form-group">
                        <label>Pickup Location</label>
                        <div class="input-wrap">
                            <i class="icon fa-solid fa-circle" style="color:var(--primary);font-size:.55rem;"></i>
                            <input type="text" id="pickupAddress" name="pickupAddress" placeholder="Enter pickup address" required>
                        </div>
                    </div>
                    <div class="form-group" style="margin-bottom:0">
                        <label>Drop Location</label>
                        <div class="input-wrap">
                            <i class="icon fa-solid fa-location-dot" style="color:var(--success)"></i>
                            <input type="text" id="dropAddress" name="dropAddress" placeholder="Enter destination" required>
                        </div>
                    </div>
                    <input type="hidden" id="distanceKm" name="distanceKm" value="0">
                    <input type="hidden" id="estimatedFare" name="estimatedFare" value="0">
                    <input type="hidden" id="finalFareHidden" name="finalFare" value="0">
                    <input type="hidden" id="discountAmountHidden" name="discountAmount" value="0">
                </div>
                <div class="card" style="margin-bottom:20px">
                    <div class="card-title"><i class="fa-solid fa-car"></i> Choose Cab Type</div>
                    <div class="cab-types">
                        <div>
                            <input type="radio" class="cab-option" name="cabType" id="bike" value="Bike">
                            <label class="cab-label" for="bike">
                                <div class="cab-icon-big"><i class="fa-solid fa-motorcycle"></i></div>
                                <div class="cab-type-name">Bike</div>
                                <div class="cab-rate">&#8377;6/km</div>
                            </label>
                        </div>
                        <div>
                            <input type="radio" class="cab-option" name="cabType" id="mini" value="Mini" checked>
                            <label class="cab-label" for="mini">
                                <div class="cab-icon-big"><i class="fa-solid fa-car"></i></div>
                                <div class="cab-type-name">Mini</div>
                                <div class="cab-rate">&#8377;9/km</div>
                            </label>
                        </div>
                        <div>
                            <input type="radio" class="cab-option" name="cabType" id="sedan" value="Sedan">
                            <label class="cab-label" for="sedan">
                                <div class="cab-icon-big"><i class="fa-solid fa-car-side"></i></div>
                                <div class="cab-type-name">Sedan</div>
                                <div class="cab-rate">&#8377;13/km</div>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-title"><i class="fa-solid fa-tag"></i> Promo Code</div>
                    <div class="promo-row">
                        <input type="text" id="promoCode" placeholder="Try: FIRSTRIDE / CABGO10" style="padding-left:12px;">
                        <button type="button" class="promo-btn" onclick="applyPromo()">Apply</button>
                    </div>
                    <div id="promoMsg" style="font-size:.8rem;margin-top:8px;display:none;"></div>
                </div>
            </div>
            <div>
                <div class="card">
                    <div class="card-title"><i class="fa-solid fa-receipt"></i> Fare Summary</div>
                    <div class="off-peak-badge" id="offPeakBadge"><i class="fa-solid fa-moon"></i> Off-peak discount applied!</div>
                    <div class="fare-box">
                        <div class="fare-row"><span>Distance</span><span class="fare-val" id="distDisplay">—</span></div>
                        <div class="fare-row"><span>Base Fare</span><span class="fare-val" id="baseFareDisplay">—</span></div>
                        <div class="fare-row" id="discountRow" style="display:none"><span>Discount</span><span class="fare-val discount" id="discountDisplay">—</span></div>
                        <div class="fare-row"><span>Total</span><span class="fare-val total" id="totalDisplay">Enter route</span></div>
                    </div>
                    <div class="form-group">
                        <label>Payment Method</label>
                        <div class="payment-opts">
                            <div><input type="radio" class="pay-option" name="paymentMethod" id="payCash" value="Cash" checked><label class="pay-label" for="payCash"><i class="fa-solid fa-money-bill"></i><br>Cash</label></div>
                            <div><input type="radio" class="pay-option" name="paymentMethod" id="payUPI" value="UPI"><label class="pay-label" for="payUPI"><i class="fa-solid fa-mobile-screen"></i><br>UPI</label></div>
                            <div><input type="radio" class="pay-option" name="paymentMethod" id="payWallet" value="Wallet"><label class="pay-label" for="payWallet"><i class="fa-solid fa-wallet"></i><br>Wallet</label></div>
                        </div>
                    </div>
                    <button type="submit" class="btn-book" id="bookBtn" disabled><i class="fa-solid fa-car"></i> Confirm Booking</button>
                    <div class="trust-items">
                        <div class="trust-item"><i class="fa-solid fa-shield-halved"></i> Safe, verified drivers only</div>
                        <div class="trust-item"><i class="fa-solid fa-check-circle"></i> No hidden charges</div>
                        <div class="trust-item"><i class="fa-solid fa-headset"></i> 24/7 customer support</div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<script>
var currentFare=0,promoDiscount=0;
function simulateDistance(p,d){if(!p||!d)return 0;var h=function(s){return s.split('').reduce(function(a,c){return a+c.charCodeAt(0);},0);};return Math.round((Math.abs(h(p)-h(d))%25+3)*10)/10;}
function estimateFare(){
    var pickup=document.getElementById('pickupAddress').value.trim();
    var drop=document.getElementById('dropAddress').value.trim();
    var cabType=document.querySelector('input[name="cabType"]:checked').value;
    if(!pickup||!drop){document.getElementById('bookBtn').disabled=true;return;}
    var dist=simulateDistance(pickup,drop);
    document.getElementById('distanceKm').value=dist;
    var rates={Bike:{base:15,km:6},Mini:{base:25,km:9},Sedan:{base:40,km:13}};
    var r=rates[cabType];var fare=r.base+r.km*dist;
    var hr=new Date().getHours();var offPeak=(hr>=22||hr<6);
    if(offPeak){fare*=0.90;document.getElementById('offPeakBadge').style.display='flex';}
    else{document.getElementById('offPeakBadge').style.display='none';}
    fare=Math.round(fare*10)/10;currentFare=fare;
    var finalFare=Math.max(0,fare-promoDiscount);
    document.getElementById('estimatedFare').value=fare;
    document.getElementById('finalFareHidden').value=finalFare;
    document.getElementById('discountAmountHidden').value=promoDiscount;
    document.getElementById('distDisplay').textContent=dist+' km';
    document.getElementById('baseFareDisplay').textContent='₹'+fare.toFixed(2);
    document.getElementById('totalDisplay').textContent='₹'+finalFare.toFixed(2);
    if(promoDiscount>0){document.getElementById('discountRow').style.display='flex';document.getElementById('discountDisplay').textContent='- ₹'+promoDiscount.toFixed(2);}
    document.getElementById('bookBtn').disabled=false;
}
var promos={FIRSTRIDE:30,OFFPEAK20:20,CABGO10:10};
function applyPromo(){
    var code=document.getElementById('promoCode').value.trim().toUpperCase();
    var msg=document.getElementById('promoMsg');
    if(promos[code]){var pct=promos[code];promoDiscount=Math.min(currentFare*pct/100,80);msg.style.display='block';msg.style.color='#057a55';msg.textContent='✓ Promo applied! '+pct+'% off';estimateFare();}
    else{promoDiscount=0;msg.style.display='block';msg.style.color='#c81e1e';msg.textContent='✗ Invalid promo code';estimateFare();}
}
document.querySelectorAll('input[name="cabType"]').forEach(function(r){r.addEventListener('change',estimateFare);});
document.getElementById('pickupAddress').addEventListener('input',estimateFare);
document.getElementById('dropAddress').addEventListener('input',estimateFare);
</script>
</body>
</html>
