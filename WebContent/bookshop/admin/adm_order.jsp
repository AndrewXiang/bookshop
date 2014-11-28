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
			mesg = "删除订单资料成功！";
		} else {
			mesg = "删除订单出错！";
		}
	} catch (Exception e) {
		mesg ="你要删除的数据参数出错！";
	}
}

if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "你要找的页码错误!";
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
<tr><td align="center">网上书店目前所有订单情况</td></tr>
<tr></tr>
<tr>
<% if (!mesg.equals("")) out.println("<font color=red>" + mesg + "</font><br>");%>
        <table width="778" border="1" cellspacing="1" cellpadding="1" bgcolor="#E4EDFB"  bordercolor="white" align="center">
          <tr align="center" bgcolor="#DEF3CE"> 
            <td>订单编号</td>
            <td>用户名</td>
            <td>下单时间</td>
			<td>交货时间</td>
            <td>总金额</td>
			<td>订货IP</td>
			<td>付款</td>
            <td>发货</td>
            <td>查看</td>
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
					out.println("该用户已被删除");
				}			
			%></td>
            <td align="center"><%= Ident.getSubmitTime() %></td>
			<td align="center"><%= Ident.getConsignmentTime() %></td>
            <td align="center"><%= Ident.getTotalPrice() %></td>
			<td align="center"><%= Ident.getIPAddress() %></td>
			<td align="center">
			<% if (Ident.getIsPayoff() )
					out.print("已付清");
				else
					out.print("未付");
			%></td>
            <td align="center">
			<% if (Ident.getIsSales())
					out.print("已发货");
				else 
					out.print("未发货");
			%></td>
            <td align="center"><a href="#"  onclick="openScript('order_detail.jsp?indentid=<%= Ident.getOrderId() %>','indent',500,500)" >详细情况</a>&nbsp;<a href="adm_order.jsp?action=del&indentid=<%= Ident.getId()%>&page=<%= shop.getPage() %>" onclick="return(confirm('你真的要删除吗？'))">删除</a></td>
          </tr>
<%		}
  }

%>

        </table>
		 <table width="778" border="0" cellspacing="1" cellpadding="1" bgcolor="#E4EDFB"  bordercolor=#CC0000 align="center">
          <tr>
            <td align="right">当前页第<%= shop.getPage() %>页　<a href="adm_order.jsp">首页</a>&nbsp; 
              <% if (shop.getPage()>1) {%>
              <a href="adm_order.jsp?page=<%= shop.getPage()-1 %>">上一页</a>&nbsp; 
              <% } %>
              <% if (shop.getPage()<shop.getPageCount()-1) {%>
              <a href="adm_order.jsp?page=<%= shop.getPage()+1 %>">下一页</a>&nbsp; 
              <% } %>
              <a href="adm_order.jsp?page=<%= shop.getPageCount() %>">未页</a>&nbsp;</td>
          </tr>
        </table>
</tr>
<%@include file="/bookshop/inc/adm_authenticate.inc"%>