<%-- 
    Document   : ReadTransaksi.jsp
    Created on : Jul 25, 2024, 2:47:42 PM
    Author     : kikig
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.text.NumberFormat, java.util.Locale"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Burger Nusantara - Daftar Transaksi</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.2/xlsx.full.min.js"></script>
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
        .sidebar a.logout {
            position: absolute;
            bottom: 5px;
            width: 100%;
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
            padding: 20px 40px;
            border-radius: 8px;
            width: 100%; 
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #dddddd;
            background-color: white;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #363636;
            color: white;
            font-weight: bold;
        }
        h1 {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 30px;
            font-weight: bold;
            color: #212529; 
        }
        .action-buttons {
            display: flex;
            justify-content: flex-start; 
            gap: 10px;
            margin-bottom: 20px;
        }
       
        .btn-danger {
            background-color: #fa8072;
            color: white;
        }
        .btn-danger:hover {
            color: white;
            background-color: #e74c3c;
        }
        .logout {
            margin-top: auto;
            margin-bottom: 0.1%;
            padding-bottom: 0px;
        }
        .sidebar img {
            width: 200px;
            justify-content: center;
            margin-left: 25px;
            padding-bottom: 20px;
        }
        .btn-excel {
            background-color: #2A9D8F;
            color: white;
        }
       .btn-excel:hover {
            background-color: #21867a;
            color: white;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <img src="https://cdn.discordapp.com/attachments/1178668534251933698/1263168683459481782/LOGOPUTH2_1.png?ex=66994102&is=6697ef82&hm=4fcd01a45197a9c0f7cb24749b8ae098c1c7705b64f78ca9a145369625aa8b0b" alt="Logo">
        <a href="HomeWeb.jsp"><i class="fas fa-home"></i> Beranda</a>
        <a href="ReadMakanan.jsp"><i class="fas fa-hamburger"></i> Menu Makanan</a>
        <a href="ReadMinuman.jsp"><i class="fas fa-coffee"></i> Menu Minuman</a>
        <a href="ReadKaryawan.jsp"><i class="fas fa-users"></i> Karyawan</a>
        <a href="Transaksi.jsp"><i class="fas fa-receipt"></i> Transaksi</a>
        <a href="ReadTransaksi.jsp"><i class="fas fa-book"></i> Riwayat Transaksi</a>
        <a href="http://127.0.0.1:5500/index.html" method="post" class="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
    <div class="main-content">
        <div class="container">
            <h1>DAFTAR TRANSAKSI</h1>
            <div class="action-buttons">
                <button onclick="downloadTableAsExcel('transactionTable')" class="btn btn-excel">
                    <i class="fas fa-file-excel"></i> Unduh sebagai Excel
                </button>
            </div>
            <table id="transactionTable" class="table table-striped">
                <thead>
                    <tr>
                        <th>Tanggal</th>
                        <th>Waktu</th>
                        <th>Nama Kasir</th>
                        <th>Nomor Transaksi</th>
                        <th>Nama Pesanan</th>
                        <th>Jumlah</th>
                        <th>Harga</th>
                        <th>Total Pembayaran</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection connection = null;
                        PreparedStatement preparedStatement = null;
                        ResultSet resultSet = null;
                        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));

                        try {
                            String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
                            String usernameDB = "root";
                            String passwordDB = "";
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);

                            String query = "SELECT * FROM transaksi";
                            preparedStatement = connection.prepareStatement(query);
                            resultSet = preparedStatement.executeQuery();

                            while (resultSet.next()) {
                                int id = resultSet.getInt("id");
                                String tanggal = resultSet.getString("tanggal");
                                String waktu = resultSet.getString("waktu");
                                String namaKasir = resultSet.getString("nama_kasir");
                                String nomorTransaksi = resultSet.getString("nomor_transaksi");
                                String namaPesanan = resultSet.getString("nama_pesanan");
                                int jumlah = resultSet.getInt("jumlah");
                                double harga = resultSet.getDouble("harga");
                                String formattedHarga = currencyFormat.format(harga);
                                double total = resultSet.getDouble("total");
                                String formattedTotal = currencyFormat.format(total);
                    %>
                    <tr>
                        <td><%= tanggal %></td>
                        <td><%= waktu %></td>
                        <td><%= namaKasir %></td>
                        <td><%= nomorTransaksi %></td>
                        <td><%= namaPesanan %></td>
                        <td><%= jumlah %></td>
                        <td><%= formattedHarga %></td>
                        <td><%= formattedTotal %></td>
                        <td>
                            <div class="action-buttons">
                                <a href="ProcessDeleteTransaksi.jsp?id=<%= id %>" class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i> Hapus</a>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (ClassNotFoundException | SQLException e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (resultSet != null) resultSet.close();
                                if (preparedStatement != null) preparedStatement.close();
                                if (connection != null) connection.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <script>
      function downloadTableAsExcel(tableId, filename = 'data_transaksi.xlsx') {
        var wb = XLSX.utils.book_new();
        var ws = XLSX.utils.table_to_sheet(document.getElementById(tableId));
        XLSX.utils.book_append_sheet(wb, ws, "Sheet1");
        XLSX.writeFile(wb, filename);
      }
    </script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
