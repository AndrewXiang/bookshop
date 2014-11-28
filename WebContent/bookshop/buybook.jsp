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
		mesg = "��Ҫ��ͼ���Ѿ�������Ĺ��ﳵ�У�лл";
	} else if (shop.getIsEmpty()){
		mesg = "���ͼ���������㣡ֻʣ"+shop.getLeaveBook()+"��";
	} else {
		mesg = "��ʱ���ܹ���";
	}
}else {
	if (request.getParameter("bookid")==null || request.getParameter("bookid").equals("")) {
			mesg = "��Ҫ�����ͼ�鲻���ڣ�";
	} else {
		try {
			Id = Integer.parseInt(request.getParameter("bookid"));
			if (!book.getOnebook(Id)){
				mesg = "��Ҫ�����ͼ�鲻���ڣ�";
			}
		} catch (Exception e){
			mesg = "��Ҫ�����ͼ�鲻���ڣ�";
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
<title>����������ϵͳ������ͼ��</title>

<script language="javascript">

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
function check()
{
	if (document.form1.amount.value<1){
		alert("��Ĺ�������������");
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
  <p>������껶ӭ��<font color="#CC0066">ѡ��ͼ��</font>��</p>
   <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
		book bk = (book) book.getBooklist().elementAt(0);			  
	%>
  <table  width="90%" border="0" cellspacing="2" cellpadding="1">
    <form name="form1" method="post" action="buybook.jsp">
      <tr> 
        <td align="center" style="padding-top: 20px;">ͼ������<%= bk.getBookName() %></td>
      </tr>
      <tr align="center"> 
        <td>����Ҫ�������� 
          <input type="text" name="amount" maxlength="4" size="3" value="1"> ��</td>
      </tr>
      <tr align="center"> 
        <td>
		  <input type="hidden" name="bookid" value="<%=Id %>">
          <input type="submit" name="Submit" value="�� ��" onClick="return(check());">
          <input type="reset" name="Reset" value="ȡ ��">
        </td>
      </tr>
	   <tr align="center"> 
        <td><a href="#" onClick="openScript('bookdetail.jsp?bookid=<%= Id %>','show',400,450)" >�鿴��ϸ����</a> </td>
      </tr>
    </form>
  </table>
<% } %>
  <br>
  <p align="center"><a href="javascript:window.close()">�رմ���</a></p>
  <%@include file="/bookshop/inc/authenticate.inc"%> 
</div>
</body>
</html>
