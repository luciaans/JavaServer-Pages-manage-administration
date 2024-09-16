<%-- 
    Document   : UpdateApp
    Created on : Jul 11, 2024, 2:13:13 PM
    Author     : kikig
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update App</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 50px;
        }
        .update-form {
            margin: auto;
            width: 50%; 
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
        }
        .update-form h1 {
            margin-bottom: 30px;
        }
        .btn-submit {
            background-color: #28a745;
            color: white;
            display: block;
            width: 100%;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="update-form">
            <h1 class="text-center">UPDATE USERS</h1>
            <%
            String id = request.getParameter("id");
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;
            try {
                String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
                String userName = "root";
                String passWord = "";
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(connectionURL, userName, passWord);
                statement = connection.createStatement();
                String query = "SELECT * FROM login_user WHERE id=" + id;
                resultSet = statement.executeQuery(query);

                if(resultSet.next()) {
            %>
                    <form action="ProcessUpdateApp.jsp" method="post">
                        <input type="hidden" name="id" value="<%= resultSet.getString("id") %>">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" class="form-control" value="<%= resultSet.getString("username") %>" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="text" id="password" name="password" class="form-control" value="<%= resultSet.getString("password") %>" required>
                        </div>
                        <button type="submit" class="btn btn-submit">Submit</button>
                    </form>
            <%
                }
            } catch (Exception e) {
                out.println(e.getMessage());
            } finally {
                if (resultSet != null) try { resultSet.close(); } catch (SQLException ignore) {}
                if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
                if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            }
            %>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

