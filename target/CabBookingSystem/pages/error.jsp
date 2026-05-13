<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error – CabGo</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        *{margin:0;padding:0;box-sizing:border-box}
        body{background:#0a0a0f;color:#e8e8f0;font-family:'DM Sans',sans-serif;min-height:100vh;display:flex;align-items:center;justify-content:center;text-align:center}
        h1{font-family:'Syne',sans-serif;font-size:5rem;font-weight:800;color:#f5c842;margin-bottom:12px}
        p{color:#7878a0;margin-bottom:28px}
        a{background:#f5c842;color:#0a0a0f;padding:12px 28px;border-radius:50px;text-decoration:none;font-weight:700;font-family:'Syne',sans-serif}
    </style>
</head>
<body>
<div>
    <div style="font-size:3rem;margin-bottom:20px">🚗</div>
    <h1>Oops!</h1>
    <p>Something went wrong. The page you're looking for doesn't exist.</p>
    <a href="${pageContext.request.contextPath}/index.jsp"><i class="fa-solid fa-house"></i> Back to Home</a>
</div>
</body>
</html>
