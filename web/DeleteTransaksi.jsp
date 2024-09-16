<%-- 
    Document   : DeleteTransaksi
    Created on : Jul 17, 2024, 10:10:01 PM
    Author     : kikig
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    int index = Integer.parseInt(request.getParameter("index"));
    List<Map<String, String>> transaksi = (List<Map<String, String>>) session.getAttribute("transaksi");
    if (transaksi != null && index >= 0 && index < transaksi.size()) {
        transaksi.remove(index);
        session.setAttribute("transaksi", transaksi);
    }
    response.sendRedirect("Transaksi.jsp");
%>
