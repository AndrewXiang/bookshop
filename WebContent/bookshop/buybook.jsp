<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%@ page import="netshop.book.bean.book" %>
<jsp:useBean id="book" scope="page" class="netshop.book.service.manage_book" />
<jsp:useBean id="shop" scope="page" class="netshop.book.service.manage_shopcart" />
<%
String mesg = "";
String submits = request.getParameter("Submit");
int Id=0;
if (submits!=null && !submits.equals("")){
	if (shop.addnew(request)){
		mesg = "你要的图书已经放入你的购物车中！谢谢";
	} else if (shop.getIsEmpty()){
		mesg = "库存图书数量不足！只剩"+shop.getLeaveBook()+"本";
	} else {
		mesg = "暂时不能购买！";
	}
}else {
	if (request.getParameter("bookid")==null || request.getParameter("bookid").equals("")) {
			mesg = "你要购买的图书不存在！";
	} else {
		try {
			Id = Integer.parseInt(request.getParameter("bookid"));
			if (!book.getOnebook(Id)){
				mesg = "你要购买的图书不存在！";
			}
		} catch (Exception e){
			mesg = "你要购买的图书不存在！";
		}
	}
}
%>
<html>
<style type="text/css">
<!--
body {
	background-color: #99CCFF;
}
-->
</style><head>
<title>网上书店管理系统　购买图书</title>

<script language="javascript">

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
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
<body text="#000000" onLoad="javascript:window.focus();">
<%@include file="/bookshop/inc/head.inc"%>
<div style="padding-top: 20px;" align="center">
  <p>网上书店欢迎你<font color="#CC0066">选购图书</font>！</p>
   <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
		book bk = (book) book.getBooklist().elementAt(0);			  
	%>
  <table  width="90%" border="0" cellspacing="2" cellpadding="1">
    <form name="form1" method="post" action="buybook.jsp">
      <tr> 
        <td align="center" style="padding-top: 20px;">图书名：<%= bk.getBookName() %></td>
      </tr>
      <tr align="center"> 
        <td>你想要的数量： 
          <input type="text" name="amount" maxlength="4" size="3" value="1"> 本</td>
      </tr>
      <tr align="center"> 
        <td>
		  <input type="hidden" name="bookid" value="<%=Id %>">
          <input type="submit" name="Submit" value="购 买" onClick="return(check());">
          <input type="reset" name="Reset" value="取 消">
        </td>
      </tr>
	   <tr align="center"> 
        <td><a href="#" onClick="openScript('bookdetail.jsp?bookid=<%= Id %>','show',400,450)" >查看详细资料</a> </td>
      </tr>
    </form>
  </table>
<% } %>
  <br>
  <p align="center"><a href="javascript:window.close()">关闭窗口</a></p>
  <%@include file="/bookshop/inc/authenticate.inc"%> 
</div>
</body>
</html>
