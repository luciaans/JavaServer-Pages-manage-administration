<%-- 
    Document   : ProcessUpdateMinuman
    Created on : Jul 4, 2024, 2:51:37?PM
    Author     : kikig
--%>

<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");
String nama = request.getParameter("nama");
String merek = request.getParameter("merek");
String stock = request.getParameter("stock");
String harga = request.getParameter("harga");

if (id != null && !id.isEmpty() && nama != null && !nama.isEmpty() && merek != null && !merek.isEmpty() && stock != null && !stock.isEmpty() && harga != null && !harga.isEmpty()) {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    try {
        String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
        String userName = "root";
        String passWord = "";
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(connectionURL, userName, passWord);
        String updateQuery = "UPDATE minuman SET nama=?, merek=?, stock=?, harga=? WHERE id=?";
        preparedStatement = connection.prepareStatement(updateQuery);
        preparedStatement.setString(1, nama);
        preparedStatement.setString(2, merek);
        preparedStatement.setString(3, stock);
        preparedStatement.setString(4, harga);
        preparedStatement.setString(5, id);
        int updatedRows = preparedStatement.executeUpdate();

        response.sendRedirect("ReadMinuman.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ReadMinuman.jsp");
    } finally {
        if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
} else {
    response.sendRedirect("ReadMinuman.jsp");
}
%>

