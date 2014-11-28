<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<%@ page import="netshop.book.bean.*"%>
<%@ page import="netshop.book.service.manage_book" %>
<%@ page import="netshop.book.service.manage_buybook" %>
<jsp:useBean id="book_list" scope="page" class="netshop.book.service.manage_book" />
<jsp:useBean id="classlist" scope="page" class="netshop.book.service.manage_bookclass" />
<jsp:useBean id="shopcart" scope="page" class="netshop.book.service.manage_shopcart" />
<jsp:useBean id="shop" scope="page" class="netshop.book.service.manage_buybook" />
<% 
String userid = (String) session.getAttribute("userid");
if ( userid == null )
	userid = "";
String modi = request.getParameter("modi");
String del = request.getParameter("del");
String payoutCar = request.getParameter("payout");
String clearCar = request.getParameter("clear");
String mesg = "";
if (modi!=null && !modi.equals("")) {
	if ( !shopcart.modiShoper(request) ){
		if (shopcart.getIsEmpty())
			mesg = "你要的修改购买的图书数量不足你的购买数量!";
		else
			mesg = "修改购买数量出错！";
	} else {
		mesg = "修改成功";
	}

}else if ( del != null && !del.equals("") ) {
	if ( !shopcart.delShoper(request) ) {
		mesg = "删除清单中的图书时出错！" ;
	}
}else if (payoutCar != null && !payoutCar.equals("") ) {
	if (shopcart.payout(request) ) {
		mesg = "你的购物车中的物品已提交给本店，你的订单号为 "+ shop.getOrderId() + "<br>请及时付款，以便我们发货!";
		session.removeAttribute("shopcart");
	} else {
		if(!shopcart.getIsLogin())
			mesg = "你还没有登录，请先<a href=login.jsp>登录</a>后再提交";
		else
			mesg = "对不起，提交出错，请稍后重试"; 
	}	
} else if (clearCar != null && ! clearCar.equals("") ) {
	session.removeAttribute("shopcart");
	mesg = "购物车中的物品清单已清空";
}
%>
<script language="javascript">
function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
function checklogin() {
	if (document.payout.userid.value=="")
	{
		alert("你还没有登录，请登录后再提交购物清单。");
		return false;
	}
	return true;
}
function check()
{
	if (document.change.amount.value<1){
		alert("你的购买数量有问题");
		document.change.amount.focus();
		return false;
	}
	return true;
}

</script>
<%@include file="/bookshop/inc/head.inc"%>
<%@include file="/bookshop/inc/sub.inc"%>
<table width="778">
  <tr>
     <!--td width="150" align="center">
     <!--%@include file="/bookshop/inc/left.inc"%-->
     </td-->
     <td width="600">
         <p><b><font color="#0000FF">我的购物车物品清单</font></b></p>
<%
if (!mesg.equals("") )
	out.println("<p ><font color=#ff0000>" + mesg + "</font></p>");

Vector shoplist = (Vector) session.getAttribute("shopcart");
if (shoplist==null || shoplist.size()<0 ){
	if (mesg.equals(""))
		out.println("<p><font color=#ff0000>你还没有选择购买图书！请先购买</font></p>");
} else {
%>
       <table width="100%" border="1" cellspacing="1" cellpadding="1" bordercolor="white">
          <tr align="center" bgcolor="#DEF3CE"> 
            <td>图书名称</td>
            <td>作者</td>
            <td>图书类别</td>
            <td>单价(元)</td>
            <td>数量</td>
            <td colspan =2>选择</td>
          </tr>
	<% 
	float totalprice =0;
	int totalamount = 0;
	for (int i=0; i<shoplist.size();i++){
		allorder iList = (allorder) shoplist.elementAt(i);	
		if (book_list.getOnebook((int)iList.getBookNo())) {
			book bk = (book) book_list.getBooklist().elementAt(0);
			totalprice = totalprice + bk.getPrince() * iList.getAmount();
			totalamount = totalamount + iList.getAmount();
	%>
          <tr>
            <td><%= bk.getBookName() %></td>
            <td align="center"><%= bk.getAuthor() %></td>
            <td align="center"><%= bk.getClassname() %></td>
            <td align="center"><%= bk.getPrince() %></td>
		    <form name="change" method="post" action="shopcar.jsp">
            <td align="center">
              <input type="text" name="amount" maxlength="4" size="3" value="<%= iList.getAmount() %>" >			  
            </td>
            <td align="center" width=55 >
			<input type="hidden" name="bookid" value="<%= iList.getBookNo() %>" >
              <input type="submit" name="modi" value="修改" onclick="return(check());"></td>
			<form name="del" method="post" action="shoperlist.jsp">
			 <input type="hidden" name="bookid" value="<%= iList.getBookNo() %>" >
			 <td align=center width=55> <input type="submit" name="del" value="删除">
            </td></form>
          </tr>
		<% } 
	} %>  <tr><td colspan=7 align="right"><br>你选择的图书的总金额:<%= totalprice%>元&nbsp;&nbsp;总数量：<%= totalamount%>本&nbsp;</td></tr>
        </table>
       <p></p>
          <table width="90%" border="0" cellspacing="1" cellpadding="1">
            <tr> <form name="payout" method="post" action="shopcar.jsp">
              <td align="right" valign="bottom"> <a href="booklist.jsp">继续购书</a>&nbsp;&nbsp;&nbsp; 
                
				<input type="hidden" name="userid" value="<%= userid %>">
				<input type="hidden" name="totalprice" value="<%= totalprice %>">
				<TEXTAREA NAME="content" ROWS="3" COLS="20">附言：</TEXTAREA><br>
				<input type="submit" name="payout" value="提交我的购物车" onclick="javascript:return(checklogin());">&nbsp;</td></form>
				<form name="form1" method="post" action="shopcar.jsp">
			  <td valign="bottom">&nbsp;
                <input type="submit" name="clear" value="清空我的购物车">
              </td></form>
            </tr>
          </table>
        </form>
<% } %>
      </td>
    </tr>
  </table>
<%@include file="/bookshop/inc/authenticate.inc"%>   
 