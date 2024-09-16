<%-- 
    Document   : DeleteKaryawan
    Created on : Jul 17, 2024, 3:07:27?PM
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
        int deletedRows = statement.executeUpdate("DELETE FROM karyawan WHERE id=" + id);

        statement.close();
        connection.close();

        response.sendRedirect("ReadKaryawan.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ReadKaryawan.jsp");
    }
} else {
    response.sendRedirect("ReadKaryawan.jsp");
}
%>