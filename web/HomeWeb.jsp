<%-- 
    Document   : HomeWeb
    Created on : Jul 15, 2024, 6:44:44 PM
    Author     : kikig
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Burger Nusantara - Beranda</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #212121;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background-color: #BE5B00;
            padding: 40px;
            border-radius: 8px;
            width: 50%;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            font-weight: bold;
            color: white;
        }
        p {
            font-size: 18px;
            color: white;
        }
        .btn {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 18px;
            border-radius: 5px;
            border: none;
        }
        .btn-primary {
            background-color: #2a9d8f;
            color: white;
            margin-right: 20px;
        }
        .btn-primary:hover {
            background-color: #28a745;
        }
        i {
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Selamat Datang di Burger Nusantara</h1>
        <p>Selamat datang di sistem manajemen Burger Nusantara. Silakan pilih salah satu menu di bawah untuk mengelola data.</p>
        <a href="ReadMakanan.jsp" class="btn btn-primary"><i class="fas fa-hamburger"></i>Daftar Menu Makanan</a>
        <a href="ReadMinuman.jsp" class="btn btn-primary"><i class="fas fa-coffee"></i>Daftar Menu Minuman</a>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

