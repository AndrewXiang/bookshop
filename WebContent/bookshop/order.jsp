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
		mesg = "你要查看的订单清单不存在！";
	} else {
		try {
			Id = Long.parseLong(request.getParameter("id"));
			if (!myIndentlist.getAllorder(indentNo)) {
				mesg = "你要查看的订单清单不存在！";
			}
		} catch (Exception e) {
			mesg = "你要查看的订单清单不存在！";
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
		<title>网上书店 查看订购清单资料</title>
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
				网上书店图书订单<%=indentNo%>&nbsp;清单:
			</p>
			<table width="95%" border="1" cellspacing="1" cellpadding="1"
				bordercolor="#CC9966">
				<tr align="center">
					<td>
						图书名称
					</td>
					<td>
						作者
					</td>
					<td>
						图书类别
					</td>
					<td>
						单价(元)
					</td>
					<td>
						数量
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
				<a href="javascript:window.close()">关闭窗口</a>
			</p>
			<%@include file="/bookshop/inc/authenticate.inc"%>
		</div>
	</body>
</html>
