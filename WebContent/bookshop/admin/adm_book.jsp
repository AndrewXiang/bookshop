<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="netshop.book.bean.*" %>
<jsp:useBean id="book_list" scope="page" class="netshop.book.service.manage_book" />
<%
int pages=1;
String mesg = "";

if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try {
		int delid = Integer.parseInt(request.getParameter("id"));
		if (book_list.delete(delid)){
			mesg = "删除成功！";
		} else {
			mesg = "删除出错！";
		}
	} catch (Exception e){
		mesg = "你要删除的对象错误!";
	}
}

if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "你要找的页码错误!";
	}
}


%>
<script language="javascript">
function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
</script>
<%@include file="/bookshop/inc/adm_head.inc"%>
<tr><td align="center">网上书店现有图书资料</td></tr>
<tr>
<table width="778" border="1" cellspacing="2" bgcolor="#E4EDFB"  bordercolor="white" align="center">
         
          <tr align="center" bgcolor="#DEF3CE"> 
            <td>编号</td>
            <td>图书名</td>
            <td>作者</td>
            <td>类别</td>
            <td>单价</td>
            <td>总数量</td>
            <td>剩余数</td>
            <td>动作</td>
          </tr>
<% if (book_list.book_search(request)) {
	for (int i=0;i<book_list.getBooklist().size();i++){
		book bk = (book) book_list.getBooklist().elementAt(i);
%>
          <tr> 
            <td align="center"><%=bk.getId() %></td>
            <td><a href="#" onclick="openScript('book_detail.jsp?bookid=<%= bk.getId() %>','sbook',450,500);"><%= bk.getBookName() %></a></td>
            <td align="center"><%= bk.getAuthor() %></td>
            <td align="center"><%= bk.getClassname() %></td>
            <td align="center"><%= bk.getPrince() %></td>
            <td align="center"><%= bk.getAmount() %></td>
            <td align="center"><%= bk.getLeav_number() %></td>
            <td align="center"><a href="book_modify.jsp?id=<%= bk.getId() %>">修改</a>&nbsp;&nbsp;<a href="adm_book.jsp?action=del&page=<%= pages %>&id=<%= bk.getId() %>" onclick="confirm('真的要删除吗');">删除</a></td>
          </tr>
<% }
} else {%>
          <tr> 
            <td align="center" colspan=8>&nbsp;网站正在维护中，请稍后......</td>
            
          </tr>
<% } %>
        </table>
        
        <table width="778" border="0" cellspacing="1" cellpadding="1" bgcolor="#E4EDFB" align="center">
          <tr>
            <td align="right">当前页第<%= book_list.getPage() %>页　<a href="adm_book.jsp">首页</a>&nbsp;
	<% if (book_list.getPage()>1) {%><a href="booklist.jsp?page=<%= book_list.getPage()-1 %>">上一页</a>&nbsp;<% } %>
	<% if (book_list.getPage()<book_list.getPageCount()-1) {%><a href="adm_book.jsp?page=<%= book_list.getPage()+1 %>">下一页</a>&nbsp;<% } %>
				<a href="adm_book.jsp?page=<%= book_list.getPageCount() %>">未页</a>&nbsp;</td>
          </tr>
        </table>
        
</tr>
<%@include file="/bookshop/inc/adm_authenticate.inc"%>