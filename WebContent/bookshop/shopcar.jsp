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
			mesg = "��Ҫ���޸Ĺ����ͼ������������Ĺ�������!";
		else
			mesg = "�޸Ĺ�����������";
	} else {
		mesg = "�޸ĳɹ�";
	}

}else if ( del != null && !del.equals("") ) {
	if ( !shopcart.delShoper(request) ) {
		mesg = "ɾ���嵥�е�ͼ��ʱ����" ;
	}
}else if (payoutCar != null && !payoutCar.equals("") ) {
	if (shopcart.payout(request) ) {
		mesg = "��Ĺ��ﳵ�е���Ʒ���ύ�����꣬��Ķ�����Ϊ "+ shop.getOrderId() + "<br>�뼰ʱ����Ա����Ƿ���!";
		session.removeAttribute("shopcart");
	} else {
		if(!shopcart.getIsLogin())
			mesg = "�㻹û�е�¼������<a href=login.jsp>��¼</a>�����ύ";
		else
			mesg = "�Բ����ύ�������Ժ�����"; 
	}	
} else if (clearCar != null && ! clearCar.equals("") ) {
	session.removeAttribute("shopcart");
	mesg = "���ﳵ�е���Ʒ�嵥�����";
}
%>
<script language="javascript">
function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
function checklogin() {
	if (document.payout.userid.value=="")
	{
		alert("�㻹û�е�¼�����¼�����ύ�����嵥��");
		return false;
	}
	return true;
}
function check()
{
	if (document.change.amount.value<1){
		alert("��Ĺ�������������");
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
         <p><b><font color="#0000FF">�ҵĹ��ﳵ��Ʒ�嵥</font></b></p>
<%
if (!mesg.equals("") )
	out.println("<p ><font color=#ff0000>" + mesg + "</font></p>");

Vector shoplist = (Vector) session.getAttribute("shopcart");
if (shoplist==null || shoplist.size()<0 ){
	if (mesg.equals(""))
		out.println("<p><font color=#ff0000>�㻹û��ѡ����ͼ�飡���ȹ���</font></p>");
} else {
%>
       <table width="100%" border="1" cellspacing="1" cellpadding="1" bordercolor="white">
          <tr align="center" bgcolor="#DEF3CE"> 
            <td>ͼ������</td>
            <td>����</td>
            <td>ͼ�����</td>
            <td>����(Ԫ)</td>
            <td>����</td>
            <td colspan =2>ѡ��</td>
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
              <input type="submit" name="modi" value="�޸�" onclick="return(check());"></td>
			<form name="del" method="post" action="shoperlist.jsp">
			 <input type="hidden" name="bookid" value="<%= iList.getBookNo() %>" >
			 <td align=center width=55> <input type="submit" name="del" value="ɾ��">
            </td></form>
          </tr>
		<% } 
	} %>  <tr><td colspan=7 align="right"><br>��ѡ���ͼ����ܽ��:<%= totalprice%>Ԫ&nbsp;&nbsp;��������<%= totalamount%>��&nbsp;</td></tr>
        </table>
       <p></p>
          <table width="90%" border="0" cellspacing="1" cellpadding="1">
            <tr> <form name="payout" method="post" action="shopcar.jsp">
              <td align="right" valign="bottom"> <a href="booklist.jsp">��������</a>&nbsp;&nbsp;&nbsp; 
                
				<input type="hidden" name="userid" value="<%= userid %>">
				<input type="hidden" name="totalprice" value="<%= totalprice %>">
				<TEXTAREA NAME="content" ROWS="3" COLS="20">���ԣ�</TEXTAREA><br>
				<input type="submit" name="payout" value="�ύ�ҵĹ��ﳵ" onclick="javascript:return(checklogin());">&nbsp;</td></form>
				<form name="form1" method="post" action="shopcar.jsp">
			  <td valign="bottom">&nbsp;
                <input type="submit" name="clear" value="����ҵĹ��ﳵ">
              </td></form>
            </tr>
          </table>
        </form>
<% } %>
      </td>
    </tr>
  </table>
<%@include file="/bookshop/inc/authenticate.inc"%>   
 