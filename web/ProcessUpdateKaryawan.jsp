<%-- 
    Document   : ProcessUpdateKaryawan
    Created on : Jul 17, 2024, 3:07:46?PM
    Author     : kikig
--%>

<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");
String nama = request.getParameter("nama");
String jenis_kelamin = request.getParameter("jenis_kelamin");
String umur = request.getParameter("umur");
String tempat_tinggal = request.getParameter("tempat_tinggal");

if (id != null && !id.isEmpty() && nama != null && !nama.isEmpty() && jenis_kelamin != null && !jenis_kelamin.isEmpty() && umur != null && !umur.isEmpty() && tempat_tinggal != null && !tempat_tinggal.isEmpty()) {
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    try {
        String connectionURL = "jdbc:mysql://localhost/burger_nusantara";
        String userName = "root";
        String passWord = "";
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(connectionURL, userName, passWord);
        String updateQuery = "UPDATE karyawan SET nama=?, jenis_kelamin=?, umur=?, tempat_tinggal=? WHERE id=?";
        preparedStatement = connection.prepareStatement(updateQuery);
        preparedStatement.setString(1, nama);
        preparedStatement.setString(2, jenis_kelamin);
        preparedStatement.setString(3, umur);
        preparedStatement.setString(4, tempat_tinggal);
        preparedStatement.setString(5, id);
        int updatedRows = preparedStatement.executeUpdate();

        response.sendRedirect("ReadKaryawan.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ReadKaryawan.jsp");
    } finally {
        if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
        if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
    }
} else {
    response.sendRedirect("ReadKaryawan.jsp");
}
%>
