<%@ page contentType="text/html; charset=gb2312"%>
<%@ page import="java.util.*"%>
<%@ page session="true"%>
<%@ page import="netshop.book.util.*"%>
<%@include file="/bookshop/inc/head.inc"%>
<form name="form1" method="post" action="<%=request.getContextPath ()%>/login">
	<div align=center>
		用户登录
	</div>
	<br>
	<table width="300" border="0" cellspacing="1" cellpadding="1"
		align="center">
		<br>
		<tr>
			<td align="right">
				用户名：
			</td>
			<td>
				<input type="text" name="username" size="15" maxlength="25">
			</td>
		</tr>
		<tr>
			<td align="right">
				密&nbsp;&nbsp;&nbsp;码：
			</td>
			<td>
				<input type="password" name="passwd" size="15" maxlength="20">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" name="Submit" value="登录">
				<a>&nbsp; &nbsp;</a>
				<input type="reset" name="Submit2" value="取消">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<p>
					&nbsp;
				</p>
			</td>
		</tr>
		<tr>
			<td colspan="2" align=center>
				如果不是本站会员，请在此
				<a href="bookshop/userreg.jsp">注册</a>。
			</td>
		</tr>
	</table>
</form>
<%@include file="/bookshop/inc/authenticate.inc"%>