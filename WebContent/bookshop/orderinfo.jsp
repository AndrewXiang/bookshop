<%@ page contentType="text/html; charset=gb2312"%>
<%@ page session="true"%>
<%
	String username = (String)session.getAttribute("username");
if ( username == null || username.equals("") ){
	response.sendRedirect("login.jsp?msg=nologin");
}
%>
<%@ page import="netshop.book.service.manage_buybook"%>
<%@ page import="netshop.book.bean.order"%>
<jsp:useBean id="my_order" scope="page"
	class="netshop.book.service.manage_buybook" />

<%
String mesg = "";
String Uid = (String) session.getAttribute("userid");
long uid = 0;
try {
	uid = Long.parseLong(Uid);
} catch (Exception e) {
	uid =0;
	mesg = "出现不可预知错误!";
}
if (!my_order.getOrder(uid))
	mesg = "你在本站还没有购买过图书。"	;
%>
<script language="javascript">
function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
</script>
<%@include file="/bookshop/inc/head.inc"%>
<%@include file="/bookshop/inc/sub.inc"%>
<td align="center">
	<p>
		<br>
		<font color="#33FFCC"><b><font color="#0000FF">您的订单信息</font>
		</b>
		</font>
	</p>
	<%if (!mesg.equals("")) {
		out.println("<p><font color=red>" + mesg + "</font></p>");
} else {   %>
	<table width="80%" border="1" cellspacing="2" cellpadding="1"
		bordercolor="white">
		<tr align="center" bgcolor="#DEF3CE">
			<td>
				订单号
			</td>
			<td>
				提交时间
			</td>
			<td>
				总金额
			</td>
			<td>
				付款
			</td>
			<td>
				发货
			</td>
			<td>
				详情
			</td>
		</tr>
		<%for (int i = 0; i<my_order.getAllorder().size();i++){
		order order = (order) my_order.getAllorder().elementAt(i);
			%>
		<tr>
			<td>
				<font color=red><%=order.getOrderId() %></font>
			</td>
			<td align="center"><%= order.getSubmitTime() %></td>
			<td align="center"><%= order.getTotalPrice() %></td>
			<td align="center">
				<% if (order.getIsPayoff() )
					out.print("已付清");
				else
					out.print("未付");
			%>
			</td>
			<td align="center">
				<% if (order.getIsSales())
					out.print("已发货");
				else 
					out.print("未发货");
			%>
			</td>
			<td align="center">
				<a href="#"
					onclick="openScript('order.jsp?id=<%= order.getId() %>&orderno=<%=order.getOrderId() %>','indentlist',500,400);">查看</a>
			</td>
		</tr>
		<%}%>
	</table>
	<%} %>
	<p>&nbsp;</p>
</td>
<%@include file="/bookshop/inc/authenticate.inc"%>
