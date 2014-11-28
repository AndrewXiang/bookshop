<%@ page contentType="text/html; charset=gb2312"%>
<%@ page session="true"%>
<jsp:useBean id="login" scope="page"
	class="netshop.book.service.manage_login" />
<%@include file="/bookshop/inc/head.inc"%>
<script language="javascript">
 function checkform() {
	if (document.form1.username.value=="" || document.form1.passwd.value==""){
		alert("用户名或密码为空！");
		return false;
	}
	return true;
  }
</script>
<div align=center>
	用户登录
</div>
<br>

<form name="form1" method="post" action="login.jsp">
	<table width="400" border="0" cellspacing="1" cellpadding="1"
		align="center">
		<tr>
			<td width="147" align="right">
				用户名：
				<br>
			</td>
			<td width="246" valign="top">
				<input type="text" name="username" size="16" maxlength="25">
			</td>
		</tr>
		<tr>
			<td width="147" align="right">
				密&nbsp;&nbsp;&nbsp;&nbsp;码：
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
				<input type="submit" name="Submit" value="登录"
					onclick="javascript:return(checkform());">
				<a>&nbsp;&nbsp;&nbsp;</a>
				<input type="reset" name="Submit2" value="取消">
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
					如果你还不是本站用户，请在此
					<a href="bookshop/userreg.jsp">注册</a>
				</p>
			</td>
		</tr>
	</table>
</form>
<%@include file="/bookshop/inc/authenticate.inc"%>