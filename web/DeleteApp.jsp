<%-- 
    Document   : DeleteApp
    Created on : Jul 11, 2024, 2:11:41?PM
    Author     : kikig
--%>

<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");

if (id != null && !id.isEmpty()) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
        Connection connection = DriverManager.getConnection(connectionURL, "root", "");
        Statement statement = connection.createStatement();
        int i = statement.executeUpdate("DELETE FROM login_user WHERE id=" + id);

        statement.close();
        connection.close();

        response.sendRedirect("ReadApp.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ReadApp.jsp");
    }
} else {
    response.sendRedirect("ReadApp.jsp");
}
    
%>
