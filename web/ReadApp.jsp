<%-- 
    Document   : ReadApp
    Created on : Jul 4, 2024, 1:35:37 PM
    Author     : kikig
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Burger Nusantara - Daftar User</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .user-table {
            margin: auto;
            width: 80%; 
        }
        .table thead th {
            text-align: center;
            background-color: #4CAF50; 
            color: #ffffff; 
        }
        .table tbody tr:nth-of-type(odd) {
            background-color: #f8f9fa; 
        }
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn-update {
            background-color: #28a745;
            color: white;
        }
        .heading {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center heading">Read User</h1>
        <div class="user-table">
            <table class="table table-bordered table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
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

                        String query = "SELECT * FROM login_user";
                        resultSet = statement.executeQuery(query);

                        while(resultSet.next()) {
                    %>
                            <tr>
                                <td><%= resultSet.getString("username") %></td>
                                <td><%= resultSet.getString("password") %></td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="UpdateApp.jsp?id=<%= resultSet.getString("id") %>" class="btn btn-update btn-sm">Update</a>
                                        <a href="DeleteApp.jsp?id=<%= resultSet.getString("id") %>" class="btn btn-danger btn-sm">Delete</a>
                                    </div>
                                </td>
                            </tr>
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
                </tbody>
            </table>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
