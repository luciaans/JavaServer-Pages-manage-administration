<%-- 
    Document   : ProcessUpdateApp
    Created on : Jul 11, 2024, 2:14:29?PM
    Author     : kikig
--%>

<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");
String username = request.getParameter("username");
String password = request.getParameter("password");

if (id != null && !id.isEmpty() && username != null && !username.isEmpty() && password != null && !password.isEmpty()) {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    try {
        String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
        String userName = "root";
        String passWord = "";
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(connectionURL, userName, passWord);
        String updateQuery = "UPDATE login_user SET username=?, password=? WHERE id=?";
        preparedStatement = connection.prepareStatement(updateQuery);
        preparedStatement.setString(1, username);
        preparedStatement.setString(2, password);
        preparedStatement.setString(3, id);
        int updatedRows = preparedStatement.executeUpdate();

        response.sendRedirect("ReadApp.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ReadApp.jsp");
    } finally {
        if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
} else {
    response.sendRedirect("ReadApp.jsp");
}
%>
