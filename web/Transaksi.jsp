<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Burger Nusantara</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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
            overflow-y: auto; 
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
            margin-left: 250px;
            padding: 20px;
            width: calc(100% - 250px);
            display: flex;
            flex-direction: column;
            min-height: 100vh; 
            overflow-y: auto; 
            box-sizing: border-box;
        }
        .container {
            background-color: #BE5B00;
            padding: 20px 40px;
            border-radius: 8px;
            width: 70%;
            margin: 0 auto;
            box-sizing: border-box;
        }
        .form-group {
            margin-bottom: 1rem;
            font-weight: 600;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #dddddd;
            background-color: white;
            padding: 8px;
        }
        th {
            background-color: #363636;
            color: white;
        }
        h1 {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 30px;
            font-weight: bold;
        }
        h2 {
            font-weight: bold;
        }
        .btn-update {
            background-color: #2a9d8f;
            color: white;
        }
        .btn-update:hover {
            color: white;
            background-color: #28a745;
        }
        .btn-danger {
            background-color: #fa8072;
            color: white;
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
            margin-left: 25px;
            padding-bottom: 20px;
        }
        .form-container {
            display: flex;
            flex-wrap: wrap; 
            gap: 20px; 
        }
        .form-section {
            flex: 1;
            margin: 0 10px;
        }
        .text-center {
            text-align: center;
        }
        .btn-primary {
            background-color: #2a9d8f;
            color: white;
            border: none;
        }
        .btn-primary:hover {
            color: white;
            background-color: #28a745;
            border: none;
        }
    </style>
    <script>
        function validateForm() {
            let foodSelected = false;
            let drinkSelected = false;

        const foodQuantities = document.querySelectorAll('input[name="foodQuantities"]');
                foodQuantities.forEach(input => {
                    if (input.value && input.value > 0) {
                        foodSelected = true;
                    }
                });

        const drinkQuantities = document.querySelectorAll('input[name="drinkQuantities"]');
                drinkQuantities.forEach(input => {
                    if (input.value && input.value > 0) {
                        drinkSelected = true;
                        }
                    });

        if (!foodSelected && !drinkSelected) {
                alert('Please select at least one food item or drink item.');
                return false;
            }

            return true;
        }
</script>
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
            <h1>TRANSAKSI</h1>
            <br>
            <form action="PrintTransaksi.jsp" method="get" onsubmit="return validateForm()">
                <div class="form-container">
                    <div class="form-section">
                        <h2>Pilih Makanan</h2>
                        <% 
                            Connection connection = null;
                            Statement statement = null;
                            ResultSet resultSet = null;
                            try {
                                String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
                                String usernameDB = "root";
                                String passwordDB = "";
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);
                                statement = connection.createStatement();
                                
                                String query = "SELECT * FROM makanan";
                                resultSet = statement.executeQuery(query);
                                
                                while(resultSet.next()) {
                        %>
                        <div class="form-group">
                            <label><%= resultSet.getString("nama") %></label>
                            <input type="hidden" name="foodIds" value="<%= resultSet.getString("id") %>">
                            <input type="number" name="foodQuantities" min="1" class="form-control" placeholder="-" step="1">
                        </div>
                        <% 
                                }
                            } catch(Exception e) {
                                out.println(e.getMessage());
                            } finally {
                                if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                                if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
                                if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                            }
                        %>
                    </div>
                    <div class="form-section">
                        <h2>Pilih Minuman</h2>
                        <% 
                            try {
                                String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
                                String usernameDB = "root";
                                String passwordDB = "";
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);
                                statement = connection.createStatement();
                                
                                String query = "SELECT * FROM minuman";
                                resultSet = statement.executeQuery(query);
                                
                                while(resultSet.next()) {
                        %>
                        <div class="form-group">
                            <label><%= resultSet.getString("nama") %></label>
                            <input type="hidden" name="drinkIds" value="<%= resultSet.getString("id") %>">
                            <input type="number" name="drinkQuantities" min="1" class="form-control" placeholder="-" step="1">
                        </div>
                        <% 
                                }
                            } catch(Exception e) {
                                out.println(e.getMessage());
                            } finally {
                                if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                                if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
                                if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
                            }
                        %>
                    </div>
                </div>
                <br>
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-primary">Proses Transaksi</button>
                </div>
            </form>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
