<%-- 
    Document   : CreateMinuman
    Created on : Jul 4, 2024, 12:00 PM
    Author     : kikig
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Burger Nusantara</title>
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
        }
        .sidebar {
            height: 100vh;
            width: 250px;
            background-color: #2f2f2f;
            display: flex;
            flex-direction: column;
            padding-top: 20px;
            position: fixed;
        }
        .sidebar a {
            padding: 15px 20px;
            text-align: left;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
        }
        .sidebar a:hover {
            background-color: #BE5B00;
            color: black;
        }
        .sidebar a i {
            margin-right: 15px;
        }
        .main-content {
            display: flex;
            justify-content: center;
            align-items: center;
            width: calc(100% - 250px);
            margin-left: 250px;
            padding: 20px;
        }
        .container {
            background-color: #BE5B00;
            padding: 20px 40px 40px 40px;
            border-radius: 8px;
            width: 80%;
        }
        .create-form {
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        h1 {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 30px;
            font-weight: bold;
        }
        .btn-submit {
            background-color: #2a9d8f;
            color: white;
            display: block;
            width: 100%;
            margin-top: 20px;
        }
        .btn-submit:hover {
            color: white;
            background-color: #28a745;
        }
        .btn-update {
            background-color: #2a9d8f;
            color: white;
        }
        .btn-update:hover {
            color: white;
            background-color: #28a745;
        }
         .logout {
            margin-top: auto;
            margin-bottom: 0.1%;
            padding-bottom: 0px;
        }
        .sidebar a.logout {
            position: absolute;
            bottom: 5px;
            width: 100%;
        }
        .sidebar img {
            width: 200px;
            justify-content: center;
            margin-left : 25px;
            padding-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <img src="https://cdn.discordapp.com/attachments/1178668534251933698/1263168683459481782/LOGOPUTH2_1.png?ex=66994102&is=6697ef82&hm=4fcd01a45197a9c0f7cb24749b8ae098c1c7705b64f78ca9a145369625aa8b0b "alt="Logo">
        <a href="HomeWeb.jsp"><i class="fas fa-home"></i> Beranda</a>
        <a href="ReadMakanan.jsp"><i class="fas fa-hamburger"></i> Menu Makanan</a>
        <a href="ReadMinuman.jsp"><i class="fas fa-coffee"></i> Menu Minuman</a>
        <a href="ReadKaryawan.jsp"><i class="fas fa-users"></i> Karyawan</a>
        <a href="Transaksi.jsp"><i class="fas fa-receipt"></i> Transaksi</a>
        <a href="ReadTransaksi.jsp"><i class="fas fa-book"></i> Riwayat Transaksi</a>
       <a href="http://127.0.0.1:5500/index.html" method="post" class="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
    <div class="main-content">
        <div class="container">
            <h1>INPUT MENU MINUMAN</h1>
            <div>
                <a href="ReadMinuman.jsp" class="btn btn-update btn-sm"><i class="fas fa-chevron-left"></i> Kembali</a>
            </div>
            <br>
            <div class="create-form">
                <form action="" method="post">
                    <div class="form-group">
                        <label for="nama">Nama</label>
                        <input type="text" class="form-control" id="nama" name="nama" required>
                    </div>
                    <div class="form-group">
                        <label for="merek">Merek</label>
                        <input type="text" class="form-control" id="merek" name="merek" required>
                    </div>
                    <div class="form-group">
                        <label for="stock">Stock</label>
                        <input type="text" class="form-control" id="stock" name="stock" required>
                    </div>
                    <div class="form-group">
                        <label for="harga">Harga</label>
                        <input type="text" class="form-control" id="harga" name="harga" required>
                    </div>
                    <button type="submit" class="btn btn-submit" name="createminuman">Tambahkan</button>
                </form>
            </div>
        </div>
    </div>
    
    <%@page import="java.sql.*" %>
    <% 
        String nama = request.getParameter("nama");
        String merek = request.getParameter("merek");
        String stock = request.getParameter("stock");
        String harga = request.getParameter("harga");

        if (nama != null && merek != null && stock != null && harga != null) {
            String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
            Connection connection = null;
            PreparedStatement statement = null;
            int updatedQuery = 0;

            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                connection = DriverManager.getConnection(connectionURL, "root", "");
                String query = "INSERT INTO minuman VALUES (?, ?, ?, ?, ?)";
                statement = connection.prepareStatement(query);
                int randomNum = (int) (Math.random() * (99 - 1 + 1)) + 1;
                statement.setInt(1, randomNum);
                statement.setString(2, nama);
                statement.setString(3, merek);
                statement.setString(4, stock);
                statement.setString(5, harga);
                updatedQuery = statement.executeUpdate();

                if (updatedQuery != 0) {
                    response.sendRedirect("ReadMinuman.jsp");
                }
            } catch (Exception e) {
                response.sendRedirect("ReadMinuman.jsp");
            } finally {
                if (statement != null) {
                    try {
                        statement.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    %>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

