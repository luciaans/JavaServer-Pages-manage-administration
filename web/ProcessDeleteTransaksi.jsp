<%-- 
    Document   : ProcessDeleteTransaksi
    Created on : Jul 25, 2024, 3:22:25?PM
    Author     : kikig
--%>

<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");

if (id != null && !id.isEmpty()) {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    try {
        String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
        String userName = "root";
        String passWord = "";
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(connectionURL, userName, passWord);
        String deleteQuery = "DELETE FROM transaksi WHERE id=?";
        preparedStatement = connection.prepareStatement(deleteQuery);
        preparedStatement.setString(1, id);
        int deletedRows = preparedStatement.executeUpdate();

        if (deletedRows > 0) {
            response.sendRedirect("ReadTransaksi.jsp");
        } else {
            response.sendRedirect("ReadTransaksi.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ReadTransaksi.jsp");
    } finally {
        if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
} else {
    response.sendRedirect("ReadTransaksi.jsp");
}
%>
