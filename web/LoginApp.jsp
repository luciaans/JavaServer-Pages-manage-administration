<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Burger Nusantara - Login App</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Montserrat', sans-serif;
        background-color: #212121;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .container {
        background-color: #BE5B00;
        padding: 30px 50px 50px 50px;
        border-radius: 8px;
        width: 100%;
        max-width: 400px;
    }
    .login-form {
        background-color: #ffffff;
        padding: 20px;
        box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
        border-radius: 10px;
        position: relative;
    }
    h1 {
        text-align: center;
        margin-top: 10px;
        margin-bottom: 20px;
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
    .error-message, .success-message {
        text-align: center;
        display: none;
        margin-top: 20px;
    }
    .error-message {
        color: red;
    }
    .success-message {
        color: green;
 
    }
    
</style>
</head>
<body>
<div class="container">
    <h1>LOGIN</h1>
    <br>
    <div class="login-form">
        <form action="" method="post">
            <div class="form-group">
                <label for="userName">Username</label>
                <input type="text" class="form-control" id="userName" name="userName" required>
            </div>
            <div class="form-group">
                <label for="passWord">Password</label>
                <input type="password" class="form-control" id="passWord" name="passWord" required>
            </div>
            <button type="submit" class="btn btn-submit" name="createUser">Login</button>
        </form>
        <div id="successMessage" class="success-message">
            <p>Login Berhasil! Redirecting...</p>
        </div>
        <div id="errorMessage" class="error-message">
            <p>Username atau password salah. Silakan coba lagi.</p>
        </div>
        <%
            String userName = request.getParameter("userName");
            String passWord = request.getParameter("passWord");
            boolean isValidUser = false;

            if (userName != null && passWord != null) {
                String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
                Connection connection = null;
                PreparedStatement statement = null;
                ResultSet resultSet = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection(connectionURL, "root", "");
                    String query = "SELECT * FROM login_user WHERE username = ? AND password = ?";
                    statement = connection.prepareStatement(query);
                    statement.setString(1, userName);
                    statement.setString(2, passWord);
                    resultSet = statement.executeQuery();

                    if (resultSet.next()) {
                        isValidUser = true;
                        out.println("<script>document.getElementById('successMessage').style.display = 'block';</script>");
                        response.setHeader("Refresh", "2; URL=HomeWeb.jsp");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (resultSet != null) {
                        try {
                            resultSet.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
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
        <%
            if (userName != null && passWord != null && !isValidUser) {
        %>
            <script>document.getElementById('errorMessage').style.display = 'block';</script>
        <%
            }
        %>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
