<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="netshop.book.bean.*" %>
<jsp:useBean id="user" scope="page" class="netshop.book.service.manage_user" />
<%
int pages=1;
String mesg = "";

if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "��Ҫ�ҵ�ҳ�����!";
	}
	user.setPage(pages);
}

if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try{
		long id = Long.parseLong(request.getParameter("userid"));
		if (user.delete(id)) {
			mesg = "ɾ�������ɹ�";
		} else {
			mesg = "ɾ����������";
		}
	} catch (Exception e) {
		mesg = "��Ҫɾ�����û��Ŵ���";
	}
}

%>
<script language="javascript">
<!--
  function checkform() {
	if (document.form1.username.value=="" || document.form1.passwd.value==""){
		alert("�û���������Ϊ�գ�");
		return false;
	}
	return true;

  }

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
-->
</script>
<%@include file="/bookshop/inc/adm_head.inc"%>
  <tr> 
     <td align="center">������������û����</td>          
  </tr>
  
    
    <tr>    
     <table width="778" style="font-size:9pt" border="1" cellpadding="2" cellspacing="1"  bgcolor="#E4EDFB" bordercolor="white" align="center">
          <tr align="center" bgcolor="#DEF3CE"> 
            <td>�û�ID��</td>
            <td>�û���</td>
            <td>��ʵ����</td>
            <td>��ϵ��ַ</td>
            <td>��ϵ�绰</td>
			<td>Email</td>
			<td>�鿴</td>
          </tr>
<% 
if (user.get_alluser()){
	for(int i=0; i<user.getUserlist().size(); i++){
		user userinfo = (user) user.getUserlist().elementAt(i);
%>
          <tr>
            <td align=center><%= userinfo.getId()%></td>
            <td><%= userinfo.getUserName()%></td>
            <td><%= userinfo.getNames()%></td>
            <td><%= userinfo.getAddress()%></td>
            <td><%= userinfo.getPhone()%></td>
			<td><%= userinfo.getEmail()%></td>
            <td align=center><a href="#" onclick="openScript('user_detail.jsp?userid=<%= userinfo.getId() %>','showuser',450,500)">��ϸ����</a>&nbsp;<a href="#" onclick="openScript('user_modify.jsp?userid=<%= userinfo.getId() %>','modis',450,500)">�޸�</a>&nbsp;<a href="adm_user.jsp?userid=<%= userinfo.getId()%>&page=<%= user.getPage()%>&action=del" onclick="return(confirm('�����Ҫɾ������û�?'))">ɾ��</a></td>
          </tr>
<%	}
}%>

        </table>
		<table align="center" width="778" border="0" cellspacing="1" cellpadding="1"  bgcolor="#E4EDFB">
          <tr>
            <td align="right">��ǰҳ��<%= user.getPage() %>ҳ��<a href="adm_user.jsp">��ҳ</a>&nbsp; 
              <% if (user.getPage()>1) {%>
              <a href="adm_user.jsp?page=<%= user.getPage()-1 %>">��һҳ</a>&nbsp; 
              <% } %>
              <% if (user.getPage()<user.getPageCount()-1) {%>
              <a href="adm_user.jsp?page=<%= user.getPage()+1 %>">��һҳ</a>&nbsp; 
              <% } %>
              <a href="adm_user.jsp?page=<%= user.getPageCount() %>">δҳ</a>&nbsp;</td>
          </tr>
        </table>
       
        </tr>
<%@include file="/bookshop/inc/adm_authenticate.inc"%>