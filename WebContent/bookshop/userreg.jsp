<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="netshop.book.util.*" %>
<%@ page session="true" %>
<jsp:useBean id="user" scope="page" class="netshop.book.service.manage_user" />
<script language="javascript">
function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
function checkform() {
	if (document.form1.username.value==""){
		alert("�û�������Ϊ��");
		document.form1.username.focus();
		return false;
	}
	if (document.form1.passwd.value==""){
		alert("�û����벻��Ϊ��");
		document.form1.passwd.focus();
		return false;
	}
	if (document.form1.passwd.value!=document.form1.passconfirm.value){
		alert("ȷ�����벻�����");
		document.form1.passconfirm.focus();
		return false;
	}
	return true;
}
</script>
<%@include file="/bookshop/inc/head.inc"%>
<form name="form1" method="post" action="<%=request.getContextPath ()%>/userreg">
    <table width="450" border="0" cellspacing="1" cellpadding="1" align=center>
 <tr></tr>
      <tr> 
        <td colspan="2" align="center"><b><font color="#0000FF">�û�ע��</font></b></td>
      </tr>
     <tr></tr>
      <tr> 
        <td width="171" align="right">�û�����</td>
        <td width="272"> 
          <input type="text" name="username" maxlength="20" size="14" >
        </td>
      </tr>
      <tr> 
        <td width="171" align="right">���룺</td>
        <td width="272">
          <input type="password" name="passwd" maxlength="20" size="14">
        </td>
      </tr>
      <tr> 
        <td width="171" align="right">ȷ�����룺</td>
        <td width="272">
          <input type="password" name="passconfirm" maxlength="20" size="14">
        </td>
      </tr>
      <tr> 
        <td width="171" align="right">��ʵ������</td>
        <td width="272">
          <input type="text" name="names" maxlength="20" size="14">
        </td>
      </tr>
      <tr> 
        <td width="171" align="right">�Ա�</td>
        <td width="272">
          <select name="sex">
            <option>��</option>
            <option>Ů</option>
          </select>
        </td>
      </tr>
      <tr> 
        <td width="171" align="right">��ϵ��ַ��</td>
        <td width="272">
          <input type="text" name="address" maxlength="150" size="40">
        </td>
      </tr>
	  <tr> 
        <td width="171" align="right">��ϵ�ʱࣺ</td>
        <td width="272">
          <input type="text" name="post" maxlength="8" size="8">
        </td>
      </tr>
      <tr> 
        <td width="171" align="right">��ϵ�绰��</td>
        <td width="272">
          <input type="text" name="phone" maxlength="25" size="16">
        </td>
      </tr>
      <tr> 
        <td width="171" align="right">�����ʼ���</td>
        <td width="272">
          <input type="text" name="email" maxlength="50" size="25">
        </td>
      </tr>
      <tr>
        <td width="171" align="right">&nbsp; </td>
        <td width="272">
          <input type="submit" name="Submit" value="ע��" onclick="javascript:return(checkform());">
          <input type="reset" name="reset" value="ȡ��">
        </td>
      </tr>
    </table>  
  </form>
<%@include file="/bookshop/inc/authenticate.inc"%> 
  