<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<jsp:useBean id="alogin" scope="page" class="netshop.book.service.manage_login" />
<%
String mesg = "";
if( request.getParameter("username")!=null && !request.getParameter("username").equals("")){
	String username =request.getParameter("username");
	String passwd = request.getParameter("passwd");
	username = new String(username.getBytes("ISO8859-1"));
	passwd = new String(passwd.getBytes("ISO8859-1"));
	alogin.setUsername(username);
	alogin.setPasswd(passwd);
	alogin.setIsadmin(true);
	if (alogin.excute()){
		session.setAttribute("admin","admin"); 
		response.sendRedirect("adm_user.jsp");			
	}else {
	mesg = "��¼����"	;
	}
}
%>
<script language="javascript">
  function checkform() {
	if (document.form1.username.value=="" || document.form1.passwd.value==""){
		alert("�û���������Ϊ�գ�");
		return false;
	}
	return true;
  }
</script>
<%@include file="/bookshop/inc/adm_head.inc"%>
<tr>
<td>&nbsp;</td>
</tr>
<tr>
<div align="center" bgcolor="#E4EDFB">
  <table width="778" border="0"  cellspacing="0" cellpadding="0" bgcolor="#E4EDFB" align="center">
    <tr> 
      <td align="center"> 
        <form name="form1" method="post" action="adm_login.jsp">
          <table width="360" border="0" cellspacing="2" cellpadding="2" bgcolor="#E4EDFB" bordercolor="#66CCFF" style="font-size:9pt">
            <tr align="center"> 
              <td colspan="2"> 
                <h3><br>
                  <font color="#FF0000">����������ϵͳ</font></h3>
                <p>&nbsp;<% if (!mesg.equals("")){
						out.println(mesg);}%></p>
              </td>
            </tr>
            <tr> 
              <td align="right" width="150">����Ա��</td>
              <td> 
                <input type="text" name="username" size="12" maxlength="20">
              </td>
            </tr>
            <tr> 
              <td align="right" width="150">����Ա���룺</td>
               <td>
                <input type="password" name="passwd" size="12" maxlength="20">
              </td>
            </tr>
            <tr align="center"> 
              <td colspan="2"> 
                <input type="submit" name="Submit" value="��¼" onclick="javascript:return(checkform());">
			    <a>&nbsp;&nbsp;&nbsp;&nbsp;</a>
                <input type="reset" name="Submit2" value="ȡ��">
              </td>
            </tr>
            <tr align="center">
              <td colspan="2"></td>
            </tr>
            <tr align="center">
              <td colspan="2"><A HREF="../index.jsp">������ҳ</A></td>
            </tr>
          </table>
		 </form>
        <p>&nbsp;</p>  
      </td>
    </tr>
  </table>
</div>
</tr>

<%@include file="/bookshop/inc/adm_authenticate.inc"%>