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
				<b><font color="#0000FF">����</font><font color="#0000FF">���ͼ��<%=classname%>�б�</font>
				</b>
			</p>
			<%
				if (!keyword.equals(""))
					out.println("<p ><font color=#ff0000>��Ҫ���ҹ���&nbsp;" + keyword
							+ "&nbsp;��ͼ������</font></p>");
			%>
			<table width="100%" border="1" cellspacing="1" cellpadding="1"
				bordercolor="white">
				<tr align="center" bgcolor="#DEF3CE">
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
						������
					</td>
					<td>
						����
					</td>
					<td width=110>
						ѡ��
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
					<td align="center"><%=bk.getPrince()%>Ԫ
					</td>
					<td align="center">
						<a href="#"
							onclick="openScript('buybook.jsp?bookid=<%=bk.getId()%>','pur',300,250)">����</a>&nbsp;
						<a href="#"
							onclick="openScript('bookdetail.jsp?bookid=<%=bk.getId()%>','show',400,500)">��ϸ����</a>
					</td>
				</tr>
				<%
					}
						} else {
							if (keyword.equals("")) {
								out
										.println("<tr><td align='center' colspan=6>&nbsp;��ʱû�д���ͼ������</td></tr>");
							} else {
								out
										.println("<tr><td align='center' colspan=6>&nbsp;û����Ҫ���ҵ�&nbsp;"
												+ keyword + "&nbsp;���ͼ��</td></tr>");
							}
						}
					} else {
				%>
				<tr>
					<td align="center" colspan=6>
						&nbsp;����ͼ�鲻����
					</td>

				</tr>
				<%
					}
				%>

			</table>
			<table width="90%" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<td align="right">
						�ܼƽ��Ϊ<%=book_list.getRecordCount()%>������ǰҳ��<%=book_list.getPage()%>ҳ
						<a href="booklist.jsp?classid=<%=classid%>&keyword=<%=keyword%>">��ҳ</a>&nbsp;
						<%
							if (book_list.getPage() > 1) {
						%>
						<a
							href="booklist.jsp?page=<%=book_list.getPage() - 1%>&classid=<%=classid%>&keyword=<%=keyword%>">��һҳ</a>&nbsp;
						<%
							}
						%>
						<%
							if (book_list.getPage() < book_list.getPageCount() - 1) {
						%>
						<a
							href="booklist.jsp?page=<%=book_list.getPage() + 1%>&classid=<%=classid%>&keyword=<%=keyword%>">��һҳ</a>&nbsp;
						<%
							}
						%>
						<a
							href="booklist.jsp?page=<%=book_list.getPageCount()%>&classid=<%=classid%>&keyword=<%=keyword%>">ĩҳ</a>&nbsp;
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
			mesg = "��Ҫ�ҵ�ҳ�����!";
		}
		book_list.setPage(pages);
	}
%>
<%@include file="/bookshop/inc/authenticate.inc"%>
