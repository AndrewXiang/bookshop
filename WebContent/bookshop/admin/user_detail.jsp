<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="netshop.book.bean.*" %>
<jsp:useBean id="user" scope="page" class="netshop.book.service.manage_user" />
<%
long userid=0;
String mesg = "";

if (request.getParameter("userid")!=null && !request.getParameter("userid").equals("")) {
	try {
		userid = Long.parseLong(request.getParameter("userid"));
		//out.print(userid);
				if (!user.getUserinfo(userid)) {
			mesg = "Ҫ��ѯ���û���Ϣ������";
		}
	} catch(Exception e) {
		mesg = "���û��Ų�����!";
	}
}

if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try{
		long id = Long.parseLong(request.getParameter("userid"));
		if (user.delete(id)) {
			mesg = "ɾ�������ɹ�";
		} else {
			mesg = "ɾ����������";
		}
	} catch (Exception e) {
		mesg = "��Ҫɾ�����û��Ŵ���";
	}
}

%>

<html>
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style><head>
<title>���������ϵͳ--�鿴�û���ϸ����</title>

<link rel="stylesheet" href="books.css" type="text/css">
</head>

<body text="#000000" onLoad="javascript:window.focus();">
<div align="center">

       
        <p>�鿴�û���ϸ���:</p>
		<% if (!mesg.equals("")){
			out.println("<font color=red>"+ mesg +"</font><br><br>"); 
		} else {
			user userinfo = (user)user.getUserlist().elementAt(0);
		%>
	<table width="95%" border="1" cellspacing="1" cellpadding="1" bordercolor="#2DAE2D">
	  <tr><td align=right width=100>�û���</td><td><%= userinfo.getUserName() %></td></tr> 
	  <tr><td align=right width=100>�û�����</td><td><%= userinfo.getNames() %></td></tr> 
	  <tr><td align=right width=100>�Ա�</td><td><%= userinfo.getSex() %></td></tr> 
	  <tr><td align=right width=100>��ϵ��ַ</td><td><%= userinfo.getAddress() %></td></tr> 
	  <tr><td align=right width=100>��ϵ�绰</td><td><%= userinfo.getPhone() %></td></tr> 
	  <tr><td align=right width=100>�ʱ�</td><td><%= userinfo.getPost() %></td></tr> 
	  <tr><td align=right width=100>�����ʼ�</td><td><%= userinfo.getEmail() %></td></tr> 
	  <tr><td align=right width=100>ע����Դ</td><td><%= userinfo.getRegIpAddress() %></td></tr> 
	  <tr><td align=right width=100>ע��ʱ��</td><td><%= userinfo.getRegTime() %></td></tr>
  </table>
  <br>
  <a href="user_modify.jsp?userid=<%= userinfo.getId()%>">�޸�</a>&nbsp;&nbsp;
  <a href="user_detail.jsp?action=del&userid=<%=userinfo.getId() %>" onClick="return(confirm('�����Ҫɾ������û�?'))">ɾ��</a><br><br>
<%}%>
  <br><p><a href="javascript:window.close()">�رմ���</a></p>
  <%@include file="/bookshop/inc/adm_authenticate.inc"%>
  
</div>
</body>
</html>
