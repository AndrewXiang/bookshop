<%@ page contentType="text/html; charset=gb2312"%>
<%@ page session="true"%>
<%
	String username = (String) session.getAttribute("username");
	if (username == null || username.equals("")) {
		response.sendRedirect("login.jsp?msg=nologin");
	}
%>
<%@ page import="netshop.book.bean.book"%>
<%@ page import="netshop.book.util.*"%>
<%@ page import="netshop.book.bean.allorder"%>
<%@ page import="netshop.book.service.manage_book"%>
<jsp:useBean id="myIndentlist" scope="page"
	class="netshop.book.service.manage_buybook" />
<jsp:useBean id="mybook" scope="page"
	class="netshop.book.service.manage_book" />
<%
	String mesg = "";
	long Id = 0;
	String indentNo = request.getParameter("orderno");
	if ((indentNo == null) || indentNo.equals("")) {
		mesg = "��Ҫ�鿴�Ķ����嵥�����ڣ�";
	} else {
		try {
			Id = Long.parseLong(request.getParameter("id"));
			if (!myIndentlist.getAllorder(indentNo)) {
				mesg = "��Ҫ�鿴�Ķ����嵥�����ڣ�";
			}
		} catch (Exception e) {
			mesg = "��Ҫ�鿴�Ķ����嵥�����ڣ�";
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
</style>
	<head>
		<title>������� �鿴�����嵥����</title>
		<link rel="stylesheet" href="books.css" type="text/css">
	</head>
	<body text="#000000" onLoad="javascript:window.focus();">
		<div align="center">
			<%
				if (!mesg.equals("")) {
					out.println(mesg);
				} else {
			%>
			<p>
				�������ͼ�鶩��<%=indentNo%>&nbsp;�嵥:
			</p>
			<table width="95%" border="1" cellspacing="1" cellpadding="1"
				bordercolor="#CC9966">
				<tr align="center">
					<td>
						ͼ������
					</td>
					<td>
						����
					</td>
					<td>
						ͼ�����
					</td>
					<td>
						����(Ԫ)
					</td>
					<td>
						����
					</td>
				</tr>
				<%
					for (int i = 0; i < myIndentlist.getOrder_list().size(); i++) {
							allorder idList = (allorder) myIndentlist.getOrder_list()
									.elementAt(i);
							//out.print(idList.getBookNo());
							if (mybook.getOnebook((int) idList.getBookNo())) {
								book bk = (book) mybook.getBooklist().elementAt(0);
				%>
				<tr align="center">
					<td><%=bk.getBookName()%></td>
					<td><%=bk.getAuthor()%></td>
					<td><%=bk.getClassname()%></td>
					<td><%=bk.getPrince()%></td>
					<td><%=idList.getAmount()%></td>
				</tr>
				<%
					}
						}
				%>
			</table>
			<%
				}
			%>
			<br>
			<p>
				<a href="javascript:window.close()">�رմ���</a>
			</p>
			<%@include file="/bookshop/inc/authenticate.inc"%>
		</div>
	</body>
</html>
