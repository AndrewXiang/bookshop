<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="netshop.book.bean.*"%>
<jsp:useBean id="book_list" scope="page"
	class="netshop.book.service.manage_book" />
<jsp:useBean id="classlist" scope="page"
	class="netshop.book.service.manage_bookclass" />
<%String classid = request.getParameter("classid");
String classname ="";
String keyword = request.getParameter("keyword");
if (classid==null) classid="";
if (keyword==null) keyword="";
keyword = book_list.to_String(keyword);
%>
<table width="140" border="0" cellspacing="1" cellpadding="1">
	<tr></tr>
	<tr>
		<td bgcolor = "#00eeeeee" align="center">
			<b>����ͼ����ࣺ</b>
		</td>
	</tr>
	<% if (classlist.seachBookClass()){
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); 
					if ( classid.equals(Integer.toString(bc.getId())) ) classname=bc.getClassName();
					%>
	<tr>
        <td style="padding-top: 10px" align="center" bgcolor="#00aaCC">
			<a href="booklist.jsp?classid=<%= bc.getId()%>"><%= bc.getClassName()%></a>
		</td>
	</tr>
	<%		}			
		} %>
	<FORM name=form1 METHOD=POST ACTION="booklist.jsp">
		<tr>
			<td align="center" style="padding-top: 20px">
				<b>ͼ���ѯ��</b>
			</td>
		</tr>
</table>
<table>
	<tr>
		<td lign="right">
			�ؼ��֣�
		</td>
		<td>
			<INPUT TYPE="text" NAME="keyword" size=8 maxlength=40
				value="<%= keyword %>">
		</td>
	</tr>
	<tr>
		<td lign="right">
			��&nbsp;&nbsp;&nbsp;&nbsp;��:
		</td>
		<td>
			<SELECT NAME="classid">
				<option value="">
					�������
				</option>
				<%
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>
				<option value="<%= bc.getId()%>"><%= bc.getClassName() %></option>
				<%		}			
%>
			</SELECT>
		</td>
	</tr>
	<tr>
		<td>
			&nbsp;
		</td>
		<td align="center">
			<INPUT TYPE="submit" name="submit" value="��ѯ">
		</td>
	</tr>
	</FORM>
</table>