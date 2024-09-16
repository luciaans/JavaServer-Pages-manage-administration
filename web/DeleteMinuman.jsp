<%-- 
    Document   : DeleteMinuman
    Created on : Jul 4, 2024, 2:51:49?PM
    Author     : kikig
--%>

<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");

if (id != null && !id.isEmpty()) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
        Connection connection = DriverManager.getConnection(connectionURL, "root", "");
        Statement statement = connection.createStatement();
        int deletedRows = statement.executeUpdate("DELETE FROM minuman WHERE id=" + id);

        statement.close();
        connection.close();

        response.sendRedirect("ReadMinuman.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ReadMinuman.jsp");
    }
} else {
    response.sendRedirect("ReadMinuman.jsp");
}
%>


