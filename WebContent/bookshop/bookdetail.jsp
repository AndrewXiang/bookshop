<%@ page contentType="text/html; charset=gb2312"%>
<%@ page session="true"%>
<%@ page import="netshop.book.bean.book"%>
<%@ page import="netshop.book.util.dataFormat"%>
<jsp:useBean id="book" scope="page"
	class="netshop.book.service.manage_book" />
<%
	String mesg = "";
	int Id = 0;
	if (request.getParameter("bookid") == null
			|| request.getParameter("bookid").equals("")) {
		mesg = "��Ҫ�鿴��ͼ�鲻���ڣ�";
	} else {
		try {
			Id = Integer.parseInt(request.getParameter("bookid"));
			if (!book.getOnebook(Id)) {
				mesg = "��Ҫ�鿴��ͼ�鲻���ڣ�";
			}
		} catch (Exception e) {
			mesg = "��Ҫ�鿴��ͼ�鲻���ڣ�";
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
		<title>���������� �鿴ͼ������</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script language="javascript">
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
	<body text="#000000">
		<%@include file="/bookshop/inc/head.inc"%>
		<div style="padding-top: 20px" align="center">
			<p>
				������껶ӭ��
				<font color="#CC0066">ѡ��ͼ��</font>��
			</p>
			<%
				if (!mesg.equals("")) {
					out.println(mesg);
				} else {
					book bk = (book) book.getBooklist().elementAt(0);
			%>
			<table width="90%" border="0" cellspacing="2" cellpadding="1">
				<form name="form1" method="post" action="buybook.jsp">
					<tr>
						<td align="right" width="120">
							ͼ������
						</td>
						<td><%=bk.getBookName()%></td>
					</tr>
					<tr>
						<td align="right" width="120">
							���ߣ�
						</td>
						<td><%=bk.getAuthor()%></td>
					</tr>
					<tr>
						<td align="right" width="120">
							�������
						</td>
						<td><%=bk.getClassname()%></td>
					</tr>
					<tr>
						<td align="right" width="120">
							�����磺
						</td>
						<td><%=bk.getPublish()%></td>
					</tr>
					<tr>
						<td align="right" width="120">
							��ţ�
						</td>
						<td><%=bk.getBookNo()%></td>
					</tr>
					<tr>
						<td align="right" width="120">
							��ۣ�
						</td>
						<td><%=bk.getPrince()%></td>
					</tr>
					<tr>
						<td align="right" width="120">
							���棺
						</td>
						<td>
							<img src="<%=bk.getPicture()%>" width="80" height="112">
						</td>
					</tr>
					<tr>
						<td align="right" width="120" valign="top">
							���ݽ��ܣ�
						</td>
						<td><%=dataFormat.toHtml(bk.getContent())%></td>
					</tr>
					<tr>
						<td align="right" width="120" valign="top">
							&nbsp;
						</td>
						<td>
							&nbsp;
						</td>
					</tr>
					<tr>
						<td align="right" width="120" valign="top">
							����
						</td>
						<td>
							<input type="text" name="amount" maxlength="5" size="3" value="1">
							��
						</td>
					</tr>
					<tr>
						<td align="right" width="120" valign="top">
							&nbsp;
						</td>
						<td>
							<input type="hidden" name="bookid" value="<%=Id%>">
							<input type="submit" name="Submit" value="����"
								onClick="return(check());">
							<input type="reset" name="reset" value="ȡ��">
						</td>
					</tr>
				</form>
			</table>
			<%
				}
			%>
			<br>
			<p align="center">
				<a href="javascript:window.close()">�رմ���</a>
			</p>
			<%@include file="/bookshop/inc/authenticate.inc"%>
		</div>
	</body>
</html>
