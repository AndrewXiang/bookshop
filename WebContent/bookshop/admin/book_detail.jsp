<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%@ page import="netshop.book.bean.book" %>
<%@ page import="netshop.book.util.dataFormat" %>
<jsp:useBean id="book" scope="page" class="netshop.book.service.manage_book" />
<%
String mesg = "";
int Id=0;
if (request.getParameter("bookid")==null || request.getParameter("bookid").equals("")) {
		mesg = "你要查看的图书不存在！";
} else {
	try {
		Id = Integer.parseInt(request.getParameter("bookid"));
		if (!book.getOnebook(Id)){
			mesg = "你要查看的图书不存在！";
		}
	} catch (Exception e){
		mesg = "你要查看的图书不存在！";
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
<title>网上书店　查看图书资料</title>

<script language="javascript">
function check()
{
	if (document.form1.amount.value<1){
		alert("你的购买数量有问题");
		document.form1.amount.focus();
		return false;
	}
	return true;
}


</script>
<link rel="stylesheet" href="books.css" type="text/css">
</head>

<body text="#000000" >
<div align="center">
  <p>网上书店<font color="#CC0066">图书资料</font>！</p>
  <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
		book bk = (book) book.getBooklist().elementAt(0);			  
	%>
  <table width="90%" border="0" cellspacing="2" cellpadding="1">
      <tr> 
        <td align="right" width="120">图书名：</td>
        <td><%= bk.getBookName() %></td>
      </tr>
      <tr> 
        <td align="right" width="120">作者：</td>
        <td><%= bk.getAuthor() %></td>
      </tr>
      <tr> 
        <td align="right" width="120">所属类别：</td>
        <td><%= bk.getClassname() %></td>
      </tr>
      <tr> 
        <td align="right" width="120">出版社：</td>
        <td><%= bk.getPublish() %></td>
      </tr>
      <tr> 
        <td align="right" width="120">书号：</td>
        <td><%= bk.getBookNo() %></td>
      </tr>
      <tr> 
        <td align="right" width="120">书价：</td>
        <td><%= bk.getPrince() %></td>
      </tr>
      <tr> 
        <td align="right" width="120" valign="top">内容介绍：</td>
        <td><%= dataFormat.toHtml(bk.getContent()) %></td>
      </tr>
      <tr> 
        <td align="right" width="120" valign="top">总数量</td>
        <td><%= bk.getAmount() %></td>
      </tr> 
	  <tr> 
        <td align="right" width="120" valign="top">剩余数量</td>
        <td><%= bk.getLeav_number() %></td>
      </tr> 
	  <tr> 
        <td align="right" width="120" valign="top">登录时间</td>
        <td><%= bk.getRegTime() %></td>
      </tr>
      
  </table>
<% } %>
  <br><p><a href="javascript:window.close()">关闭窗口</a></p>
  <%@include file="/bookshop/inc/adm_authenticate.inc"%>
  
</div>
</body>
</html>
