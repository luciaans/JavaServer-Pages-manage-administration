<%-- 
    Document   : ProcessUpdateMakanan
    Created on : Jul 15, 2024, 6:45:41?PM
    Author     : kikig
--%>

<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");
String nama = request.getParameter("nama");
String varian = request.getParameter("varian");
String stock = request.getParameter("stock");
String harga = request.getParameter("harga");

if (id != null && !id.isEmpty() && nama != null && !nama.isEmpty() && varian != null && !varian.isEmpty() && stock != null && !stock.isEmpty() && harga != null && !harga.isEmpty()) {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    try {
        String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
        String userName = "root";
        String passWord = "";
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(connectionURL, userName, passWord);
        String updateQuery = "UPDATE makanan SET nama=?, varian=?, stock=?, harga=? WHERE id=?";
        preparedStatement = connection.prepareStatement(updateQuery);
        preparedStatement.setString(1, nama);
        preparedStatement.setString(2, varian);
        preparedStatement.setString(3, stock);
        preparedStatement.setString(4, harga);
        preparedStatement.setString(5, id);
        int updatedRows = preparedStatement.executeUpdate();

        response.sendRedirect("ReadMakanan.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ReadMakanan.jsp");
    } finally {
        if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
} else {
    response.sendRedirect("ReadMakanan.jsp");
}
%>
