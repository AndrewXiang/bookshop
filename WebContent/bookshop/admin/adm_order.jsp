<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
	if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
}
%>

<%@ page import="netshop.book.bean.*" %>
<%@ page import="netshop.book.service.manage_user" %>
<jsp:useBean id="shop" scope="page" class="netshop.book.service.manage_buybook" />
<jsp:useBean id="user" scope="page" class="netshop.book.service.manage_user" />

<%
int pages=1;
String mesg = "";
if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try {
		long id = Long.parseLong(request.getParameter("indentid"));
		if (shop.delete(id)) {
			mesg = "ɾ���������ϳɹ���";
		} else {
			mesg = "ɾ����������";
		}
	} catch (Exception e) {
		mesg ="��Ҫɾ�������ݲ�������";
	}
}

if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "��Ҫ�ҵ�ҳ�����!";
	}
	shop.setPage(pages);
}
%>
<script language="javascript">

  function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
</script>
<%@include file="/bookshop/inc/adm_head.inc"%>
<tr><td align="center">�������Ŀǰ���ж������</td></tr>
<tr></tr>
<tr>
<% if (!mesg.equals("")) out.println("<font color=red>" + mesg + "</font><br>");%>
        <table width="778" border="1" cellspacing="1" cellpadding="1" bgcolor="#E4EDFB"  bordercolor="white" align="center">
          <tr align="center" bgcolor="#DEF3CE"> 
            <td>�������</td>
            <td>�û���</td>
            <td>�µ�ʱ��</td>
			<td>����ʱ��</td>
            <td>�ܽ��</td>
			<td>����IP</td>
			<td>����</td>
            <td>����</td>
            <td>�鿴</td>
          </tr>
<%
  if (shop.getOrder()) {
		for(int i=0 ; i<shop.getAllorder().size(); i++){
			order Ident = (order) shop.getAllorder().elementAt(i);	%>
		  <tr>
            <td><%= Ident.getOrderId() %></td>
            <td align="center"><%
				if (user.getUserinfo(Ident.getUserId())&&user.getUserlist().size()>0) {
					user userinfo = (user)user.getUserlist().elementAt(0); %>
				<a href="#" onclick="openScript('user_detail.jsp?userid=<%= Ident.getUserId() %>','showuser',450,500)"><%= userinfo.getUserName() %></a>
			<%} else {
					out.println("���û��ѱ�ɾ��");
				}			
			%></td>
            <td align="center"><%= Ident.getSubmitTime() %></td>
			<td align="center"><%= Ident.getConsignmentTime() %></td>
            <td align="center"><%= Ident.getTotalPrice() %></td>
			<td align="center"><%= Ident.getIPAddress() %></td>
			<td align="center">
			<% if (Ident.getIsPayoff() )
					out.print("�Ѹ���");
				else
					out.print("δ��");
			%></td>
            <td align="center">
			<% if (Ident.getIsSales())
					out.print("�ѷ���");
				else 
					out.print("δ����");
			%></td>
            <td align="center"><a href="#"  onclick="openScript('order_detail.jsp?indentid=<%= Ident.getOrderId() %>','indent',500,500)" >��ϸ���</a>&nbsp;<a href="adm_order.jsp?action=del&indentid=<%= Ident.getId()%>&page=<%= shop.getPage() %>" onclick="return(confirm('�����Ҫɾ����'))">ɾ��</a></td>
          </tr>
<%		}
  }

%>

        </table>
		 <table width="778" border="0" cellspacing="1" cellpadding="1" bgcolor="#E4EDFB"  bordercolor=#CC0000 align="center">
          <tr>
            <td align="right">��ǰҳ��<%= shop.getPage() %>ҳ��<a href="adm_order.jsp">��ҳ</a>&nbsp; 
              <% if (shop.getPage()>1) {%>
              <a href="adm_order.jsp?page=<%= shop.getPage()-1 %>">��һҳ</a>&nbsp; 
              <% } %>
              <% if (shop.getPage()<shop.getPageCount()-1) {%>
              <a href="adm_order.jsp?page=<%= shop.getPage()+1 %>">��һҳ</a>&nbsp; 
              <% } %>
              <a href="adm_order.jsp?page=<%= shop.getPageCount() %>">δҳ</a>&nbsp;</td>
          </tr>
        </table>
</tr>
<%@include file="/bookshop/inc/adm_authenticate.inc"%>