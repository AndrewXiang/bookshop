<%@ page contentType="text/html; charset=gb2312"%>
<%@ page session="true"%>
<jsp:useBean id="login" scope="page"
	class="netshop.book.service.manage_login" />
<%@include file="/bookshop/inc/head.inc"%>
<script language="javascript">
 function checkform() {
	if (document.form1.username.value=="" || document.form1.passwd.value==""){
		alert("�û���������Ϊ�գ�");
		return false;
	}
	return true;
  }
</script>
<div align=center>
	�û���¼
</div>
<br>

<form name="form1" method="post" action="login.jsp">
	<table width="400" border="0" cellspacing="1" cellpadding="1"
		align="center">
		<tr>
			<td width="147" align="right">
				�û�����
				<br>
			</td>
			<td width="246" valign="top">
				<input type="text" name="username" size="16" maxlength="25">
			</td>
		</tr>
		<tr>
			<td width="147" align="right">
				��&nbsp;&nbsp;&nbsp;&nbsp;�룺
			</td>
			<td width="246" valign="top">
				<input type="password" name="passwd" maxlength="20" size="16">
			</td>
		</tr>
		<tr>
			<td width="147" align="right">
				&nbsp;
			</td>
			<td width="246" valign="top">
				<input type="submit" name="Submit" value="��¼"
					onclick="javascript:return(checkform());">
				<a>&nbsp;&nbsp;&nbsp;</a>
				<input type="reset" name="Submit2" value="ȡ��">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<p>
					&nbsp;
				</p>
				<p>
					����㻹���Ǳ�վ�û������ڴ�
					<a href="bookshop/userreg.jsp">ע��</a>
				</p>
			</td>
		</tr>
	</table>
</form>
<%@include file="/bookshop/inc/authenticate.inc"%>