<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="netshop.book.bean.*" %>
<%@ page import="netshop.book.util.*" %>
<jsp:useBean id="myIndentlist" scope="page" class="netshop.book.service.manage_buybook" />
<jsp:useBean id="mybook" scope="page" class="netshop.book.service.manage_book" />
<jsp:useBean id="user" scope="page" class="netshop.book.service.manage_user" />

<%
String mesg = "";
long Id=0;
String submit= request.getParameter("submit");
if (submit!=null && !submit.equals("")){
	if (myIndentlist.update(request))
		mesg = "更新订单状态成功！";
	else 
		mesg = "更新订单状态出错!";
}
String order_id=request.getParameter("indentid");
//out.print(order_id);
if (order_id==null || order_id.equals("")) {
		mesg = "你要查看的订单清单不存在！";
} else {
	try {
		if (!myIndentlist.getSinggleOrder(order_id) || !myIndentlist.getAllorder(order_id)){
			mesg = "你要查看的订单清单不存在！";
		}
	} catch (Exception e){
		mesg = "你要查看的订单清单不存在！";
	}
}



%>
<script language="javascript">

  function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
</script>
<html>
<head>
<title>网上书店管理系统　查看订单详细</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"><style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style><body text="#000000" >
 <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
	         //out.print(order_id);
		order Ident = (order) myIndentlist.getAllorder().elementAt(0);
		//out.print(Ident.size());
		out.println(mesg);
	%>
		<p>零度书店图书订单<%= Ident.getOrderId() %>&nbsp;清单:</p>
          <table width="95%" border="1" cellspacing="1" cellpadding="1" bordercolor="#2DAE2D">
          <tr align="center"> 
            <td>图书名称</td>
            <td>作者</td>
            <td>图书类别</td>
            <td>单价(元)</td>
            <td>数量</td>
          </tr>
	<%
	
	float totalprice =0;
	int totalamount = 0;
	for (int i=0; i<myIndentlist.getOrder_list().size();i++){
	out.println(mesg);
		allorder idList = (allorder) myIndentlist.getOrder_list().elementAt(i);		
		if (mybook.getOnebook((int)idList.getBookNo()) ){
			book bk = (book) mybook.getBooklist().elementAt(0);		
	%>	  
	      <tr align="center"> 
            <td><%= bk.getBookName() %></td>
            <td><%= bk.getAuthor() %></td>
            <td><%= bk.getClassname() %></td>
            <td><%= bk.getPrince() %></td>
            <td><%= idList.getAmount() %></td>
          </tr>
	<%	totalprice = totalprice + bk.getPrince() * idList.getAmount();
		totalamount = totalamount + idList.getAmount();
		} %>
	
<%   }%><tr align="center"> 
            <td colspan=5 >购买的总金额是：<%= totalprice %>元,总数量是<%= totalamount%>本</td> </tr>
		</table>
  <br>
  <table width="95%" border="1" cellspacing="2" cellpadding="1" bordercolor="#2DAE2D">
    <tr> 
      <td width="40%" align="right">下单用户：</td>
      <td width="60%"><%
				if (user.getUserinfo(Ident.getUserId()) ) {
					user userinfo = (user)user.getUserlist().elementAt(0); %>
				<a href="#" onClick="openScript('user_detail.jsp?userid=<%= Ident.getUserId() %>','showuser',450,500)"><%= userinfo.getUserName() %></a>
			<%} else {
					out.println("该用户已被删除");
				}			
			%></td>
    </tr>
    <tr> 
      <td width="40%" align="right">下单时间：</td>
      <td width="60%"><%= Ident.getSubmitTime() %></td>
    </tr>
    <tr> 
      <td width="40%" align="right">交货时间：</td>
      <td width="60%"><%= Ident.getConsignmentTime() %>&nbsp;</td>
    </tr>
    <tr> 
      <td width="40%" align="right">总金额：</td>
      <td width="60%"><%= Ident.getTotalPrice() %>&nbsp;</td>
    </tr>
    <tr> 
      <td width="40%" align="right">下单时IP：</td>
      <td width="60%"><%= Ident.getIPAddress() %>&nbsp;</td>
    </tr>
    <tr> 
      <td width="40%" align="right">用户备注：</td>
      <td width="60%"><%= dataFormat.toHtml(Ident.getContent()) %>&nbsp;</td>
    </tr>
	<form name="form1" method="post" action="order_detail.jsp" >
    <tr> 
      <td width="40%" align="right">是否付款：</td>
      <td width="60%"> 
        <input type="radio" name="payoff" value="1" <%if (!Ident.getIsPayoff()) out.print("checked") ; %>>
        否<input type="radio" name="payoff" value="2" <%if (Ident.getIsPayoff()) out.print("checked") ; %>>
        是</td>
    </tr>
    <tr> 
      <td width="40%" align="right">是否交货：</td>
      <td width="60%"> 
        <input type="radio" name="sales" value="1" <%if (!Ident.getIsSales()) out.print("checked") ; %>>
        否<input type="radio" name="sales" value="2" <%if (Ident.getIsSales()) out.print("checked") ; %>>
        是</td>
    </tr>
    <tr>
      <td width="40%" align="right">&nbsp;</td>
      <td width="60%">
		<input type="hidden" name="indentid" value="<%= order_id %>">
        <input type="submit" name="submit" value="更新">
      </td>
    </tr>
	</form>
  </table>
   <% } %>     

 <br><p><a href="javascript:window.close()">关闭窗口</a></p>
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td align="center"><p>零度书店开发<br>
        CopyRight@2007 陕西理工学院<br>
      Email:<a href="mailto:shilei82@126.com">shilei82@126.com</a></p>
      </td>
    </tr>
  </table>
  
</div>
</body>
</html>