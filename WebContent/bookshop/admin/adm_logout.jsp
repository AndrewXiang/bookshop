<%@ page contentType="text/html; charset=gb2312" %>
<%
session.removeAttribute("admin");
response.sendRedirect("../login.jsp?msg=logout");
%>