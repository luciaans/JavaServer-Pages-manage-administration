<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, java.text.NumberFormat, java.text.SimpleDateFormat, java.util.Date, java.util.Locale"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Burger Nusantara - Struk Transaksi</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #212121;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            padding: 40px;
            border: 2px solid #333;
            border-radius: 8px;
            width: 60%;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            background-color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .receipt-header {
            text-align: center;
            margin-bottom: 10px;
        }
        .receipt-info {
            margin-bottom: 20px;
            text-align: center;
        }
        .receipt-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .receipt-table th, .receipt-table td {
            padding: 10px;
            border-bottom: 1px solid #333;
        }
        .receipt-table th {
            text-align: left;
            background-color: #f2f2f2;
            font-size: 16px;
            font-weight: normal;
        }
        .receipt-table td {
            font-size: 14px;
        }
        .total-amount {
            text-align: right;
            margin-top: 20px;
            font-size: 18px;
            font-weight: bold;
            width: 100%;
        }
        .button-container {
            display: flex;
            justify-content: space-between;
            width: 100%;
            margin-top: 20px;
        }
        .btn {
            width: 48%;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.6.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.15/jspdf.plugin.autotable.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="receipt-header">
            <br>
            <h2>Burger Nusantara</h2>
            <p>Jl. Nawawi Hasan No. 1023, Pontianak Barat</p>
            <p>Telp: 0812-5192-0769</p>
        </div>
        <p>============================================================================================================</p>
        <div class="receipt-info">
            <% 
                SimpleDateFormat dateFormatter = new SimpleDateFormat("dd MMMM yyyy", new Locale("id", "ID"));
                SimpleDateFormat timeFormatter = new SimpleDateFormat("HH:mm", new Locale("id", "ID"));
                Date now = new Date();
                String formattedDate = dateFormatter.format(now);
                String formattedTime = timeFormatter.format(now);
            %>
            <p>Tanggal : <%= formattedDate %></p>
            <p>Jam : <%= formattedTime %> WIB</p>
            <p>Nama Kasir : Roni Alviansyah</p> 
            <p>Nomor Transaksi : 00123</p> 
            <p>============================================================================================================</p>
        </div>
        <table class="receipt-table" id="receipt-table">
            <thead>
                <tr>
                    <th>Nama Pesanan</th>
                    <th>Jumlah</th>
                    <th>Harga</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <% 
                Connection connection = null;
                PreparedStatement preparedStatement = null;
                ResultSet resultSet = null;
                double total = 0.0;

                NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));

                try {
                    String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
                    String usernameDB = "root";
                    String passwordDB = "";
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);

                    String[] foodIds = request.getParameterValues("foodIds");
                    String[] foodQuantities = request.getParameterValues("foodQuantities");
                    if (foodIds != null && foodQuantities != null) {
                        for (int i = 0; i < foodIds.length; i++) {
                            String foodIdStr = foodIds[i];
                            String quantityStr = foodQuantities[i];
                            if (!foodIdStr.isEmpty() && !quantityStr.isEmpty()) {
                                try {
                                    int foodId = Integer.parseInt(foodIdStr);
                                    int quantity = Integer.parseInt(quantityStr);
                                    if (quantity > 0) {
                                        String query = "SELECT nama, harga FROM makanan WHERE id = ?";
                                        preparedStatement = connection.prepareStatement(query);
                                        preparedStatement.setInt(1, foodId);
                                        resultSet = preparedStatement.executeQuery();
                                        
                                        if (resultSet.next()) {
                                            String foodName = resultSet.getString("nama");
                                            double foodPrice = resultSet.getDouble("harga");
                                            double itemTotal = foodPrice * quantity;
                                            total += itemTotal;
                %>
                <tr>
                    <td><%= foodName %></td>
                    <td><%= quantity %></td>
                    <td><%= currencyFormat.format(foodPrice) %></td>
                    <td><%= currencyFormat.format(itemTotal) %></td>
                </tr>
                <% 
                                            // Insert transaction details into the database
                                            String insertTransactionQuery = "INSERT INTO transaksi (tanggal, waktu, nama_kasir, nomor_transaksi, nama_pesanan, jumlah, harga, total, total_pembayaran) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                                            PreparedStatement insertStatement = connection.prepareStatement(insertTransactionQuery);
                                            insertStatement.setDate(1, new java.sql.Date(now.getTime()));
                                            insertStatement.setTime(2, new java.sql.Time(now.getTime()));
                                            insertStatement.setString(3, "Roni Alviansyah");
                                            insertStatement.setString(4, "00123");
                                            insertStatement.setString(5, foodName);
                                            insertStatement.setInt(6, quantity);
                                            insertStatement.setDouble(7, foodPrice);
                                            insertStatement.setDouble(8, itemTotal);
                                            insertStatement.setDouble(9, total);
                                            insertStatement.executeUpdate();
                                        }
                                        if (resultSet != null) resultSet.close();
                                    }
                                } catch (NumberFormatException e) {
                                    out.println("<p>Error parsing quantity: " + quantityStr + "</p>");
                                }
                            }
                        }
                    }

                    String[] drinkIds = request.getParameterValues("drinkIds");
                    String[] drinkQuantities = request.getParameterValues("drinkQuantities");
                    if (drinkIds != null && drinkQuantities != null) {
                        for (int i = 0; i < drinkIds.length; i++) {
                            String drinkIdStr = drinkIds[i];
                            String quantityStr = drinkQuantities[i];
                            if (!drinkIdStr.isEmpty() && !quantityStr.isEmpty()) {
                                try {
                                    int drinkId = Integer.parseInt(drinkIdStr);
                                    int quantity = Integer.parseInt(quantityStr);
                                    if (quantity > 0) {
                                        String query = "SELECT nama, harga FROM minuman WHERE id = ?";
                                        preparedStatement = connection.prepareStatement(query);
                                        preparedStatement.setInt(1, drinkId);
                                        resultSet = preparedStatement.executeQuery();
                                        
                                        if (resultSet.next()) {
                                            String drinkName = resultSet.getString("nama");
                                            double drinkPrice = resultSet.getDouble("harga");
                                            double itemTotal = drinkPrice * quantity;
                                            total += itemTotal;
                %>
                <tr>
                    <td><%= drinkName %></td>
                    <td><%= quantity %></td>
                    <td><%= currencyFormat.format(drinkPrice) %></td>
                    <td><%= currencyFormat.format(itemTotal) %></td>
                </tr>
                <% 
                                            // Insert transaction details into the database
                                            String insertTransactionQuery = "INSERT INTO transaksi (tanggal, waktu, nama_kasir, nomor_transaksi, nama_pesanan, jumlah, harga, total, total_pembayaran) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                                            PreparedStatement insertStatement = connection.prepareStatement(insertTransactionQuery);
                                            insertStatement.setDate(1, new java.sql.Date(now.getTime()));
                                            insertStatement.setTime(2, new java.sql.Time(now.getTime()));
                                            insertStatement.setString(3, "Roni Alviansyah");
                                            insertStatement.setString(4, "00123");
                                            insertStatement.setString(5
, drinkName);
                                            insertStatement.setInt(6, quantity);
                                            insertStatement.setDouble(7, drinkPrice);
                                            insertStatement.setDouble(8, itemTotal);
                                            insertStatement.setDouble(9, total);
                                            insertStatement.executeUpdate();
                                        }
                                        if (resultSet != null) resultSet.close();
                                    }
                                } catch (NumberFormatException e) {
                                    out.println("<p>Error parsing quantity: " + quantityStr + "</p>");
                                }
                            }
                        }
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
        <div class="total-amount">
            Total Pembayaran : <%= currencyFormat.format(total) %>
        </div>
        <div class="button-container">
            <a href="javascript:window.print();" class="btn btn-primary btn-pdf">Print Transaksi</a>
            <a href="Transaksi.jsp" class="btn btn-secondary btn-back">Kembali ke Transaksi</a>
        </div>
    </div>
    <script>
        document.getElementById('pdf-button').addEventListener('click', function () {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            const autoTable = doc.autoTable;  

            doc.setFontSize(22);
            doc.text('Receipt', 14, 20);
           
            const table = document.querySelector('#receipt-table');
            const headers = Array.from(table.querySelectorAll('thead th')).map(th => th.innerText);
            const rows = Array.from(table.querySelectorAll('tbody tr')).map(tr => 
                Array.from(tr.querySelectorAll('td')).map(td => td.innerText)
            );

            autoTable.call(doc, {
                startY: 30,
                head: [headers],
                body: rows,
                didDrawPage: function (data) {
                
                    const total = document.querySelector('.total-amount').innerText;
                    doc.text(total, 14, data.cursor.y + 10);
                }
            });

            doc.save('receipt.pdf');
        });
    </script>
</body>
</html>
