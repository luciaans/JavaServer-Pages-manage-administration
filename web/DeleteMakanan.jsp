<%-- 
    Document   : DeleteMakanan
    Created on : Jul 15, 2024, 6:43:59?PM
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
        int deletedRows = statement.executeUpdate("DELETE FROM makanan WHERE id=" + id);

        statement.close();
        connection.close();

        response.sendRedirect("ReadMakanan.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ReadMakanan.jsp");
    }
} else {
    response.sendRedirect("ReadMakanan.jsp");
}
%>
