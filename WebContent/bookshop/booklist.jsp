<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page import="netshop.book.bean.bookclass"%>
<%@ page session="true"%>
<%@ page import="netshop.book.bean.book"%>
<jsp:useBean id="book" scope="page" class="netshop.book.bean.book" />
<script language="javascript">
	function openScript(url, name, width, height) {
		var Win = window.open(url, name, 'width=' + width + ',height=' + height
				+ ',resizable=1,scrollbars=yes,menubar=no,status=yes');
	}
</script>
<%@include file="/bookshop/inc/head.inc"%>
<%@include file="/bookshop/inc/sub.inc"%>
<table width="778">
	<tr>
		<td width="150" valign="top" align="left">
			<%@include file="/bookshop/inc/left.inc"%>
		</td>
		<td width="600" valign="top">
			<p align="center">
				<b><font color="#0000FF">网上</font><font color="#0000FF">书店图书<%=classname%>列表</font>
				</b>
			</p>
			<%
				if (!keyword.equals(""))
					out.println("<p ><font color=#ff0000>你要查找关于&nbsp;" + keyword
							+ "&nbsp;的图书如下</font></p>");
			%>
			<table width="100%" border="1" cellspacing="1" cellpadding="1"
				bordercolor="white">
				<tr align="center" bgcolor="#DEF3CE">
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
						出版社
					</td>
					<td>
						单价
					</td>
					<td width=110>
						选择
					</td>
				</tr>
				<%
					if (book_list.book_search(request)) {
						if (book_list.getBooklist().size() > 0) {
							for (int i = 0; i < book_list.getBooklist().size(); i++) {
								book bk = (book) book_list.getBooklist().elementAt(i);
				%>
				<tr>
					<td><%=bk.getBookName()%></td>
					<td align="center"><%=bk.getAuthor()%></td>
					<td align="center"><%=bk.getClassname()%></td>
					<td align="center"><%=bk.getPublish()%></td>
					<td align="center"><%=bk.getPrince()%>元
					</td>
					<td align="center">
						<a href="#"
							onclick="openScript('buybook.jsp?bookid=<%=bk.getId()%>','pur',300,250)">购买</a>&nbsp;
						<a href="#"
							onclick="openScript('bookdetail.jsp?bookid=<%=bk.getId()%>','show',400,500)">详细资料</a>
					</td>
				</tr>
				<%
					}
						} else {
							if (keyword.equals("")) {
								out
										.println("<tr><td align='center' colspan=6>&nbsp;暂时没有此类图书资料</td></tr>");
							} else {
								out
										.println("<tr><td align='center' colspan=6>&nbsp;没有你要查找的&nbsp;"
												+ keyword + "&nbsp;相关图书</td></tr>");
							}
						}
					} else {
				%>
				<tr>
					<td align="center" colspan=6>
						&nbsp;此类图书不存在
					</td>

				</tr>
				<%
					}
				%>

			</table>
			<table width="90%" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<td align="right">
						总计结果为<%=book_list.getRecordCount()%>条，当前页第<%=book_list.getPage()%>页
						<a href="booklist.jsp?classid=<%=classid%>&keyword=<%=keyword%>">首页</a>&nbsp;
						<%
							if (book_list.getPage() > 1) {
						%>
						<a
							href="booklist.jsp?page=<%=book_list.getPage() - 1%>&classid=<%=classid%>&keyword=<%=keyword%>">上一页</a>&nbsp;
						<%
							}
						%>
						<%
							if (book_list.getPage() < book_list.getPageCount() - 1) {
						%>
						<a
							href="booklist.jsp?page=<%=book_list.getPage() + 1%>&classid=<%=classid%>&keyword=<%=keyword%>">下一页</a>&nbsp;
						<%
							}
						%>
						<a
							href="booklist.jsp?page=<%=book_list.getPageCount()%>&classid=<%=classid%>&keyword=<%=keyword%>">末页</a>&nbsp;
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%
	int pages = 1;
	String mesg = "";
	if (request.getParameter("page") != null
			&& !request.getParameter("page").equals("")) {
		String requestpage = request.getParameter("page");
		try {
			pages = Integer.parseInt(requestpage);
		} catch (Exception e) {
			mesg = "你要找的页码错误!";
		}
		book_list.setPage(pages);
	}
%>
<%@include file="/bookshop/inc/authenticate.inc"%>
