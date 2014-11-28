<%@ page contentType="text/html; charset=gb2312"%>
<HTML>
	<HEAD>
		<TITLE>网上书店管理系统 Template</TITLE>
		<!--设置编码方式-->
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
		<link rel="stylesheet" href="images/CSS.CSS" type="text/css">
		<style type="text/css">
<!--
设置加载CSS样式--
>
</style>
		<!-- 设置加载JavaScript-->
		<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
function window_onload() {
<!--Page.OnLoad-->
}
//-->
</SCRIPT>
	</HEAD>
	<!-- 设置页面显示背景颜色、边距和加载方式-->
	<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
		onload="return window_onload()">
		<!-- 设置表格属性，包括宽、高，居中显示和表格边线-->
		<table width="778" border="0" cellspacing="0" cellpadding="0"
			align="center" height="135">
			<tr>
				<td height="110" width="540" background="images/index_top1.gif"
					valign="top">
					<table border="0" cellspacing="0" cellpadding="0" width="540"
						align="center">
						<tr>
							<td height="25" width="340">
								<font color="#FFFFFF"></font>
								<div align="center"></div>
							</td>
							<td height="25" width="200">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td height="30" width="500">
								<div align="center">
									<font color="#FFFFFF"> <b><font size="5"> <!--设置书店名称-->
												网上书店管理系统 </font> </b> </font>
								</div>
							</td>
							<td height="30" width="200">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td height="30" width="500">
								<div align="center">
									<font size="4" color="#FFFFFF"> <!--设置书店英文名称--> NetShop
										Online </font>
								</div>
							</td>
						</tr>
					</table>
				</td>
				<td height="110" width="238" background="images/book01.png">
					<img src="images/index_pic.gif" width="238" height="110">
				</td>
			</tr>
			<tr>
				<td colspan="2" height="25">
					<img src="images/index_top2.gif" width="778" height="25">
				</td>
			</tr>
		</table>
		<table width="778" border="0" cellspacing="0" cellpadding="0"
			align="center" background="images/nv.png" height="20">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						align="center" height="28">
						<tr>
							<!-- 设置首页按钮的显示方式，点击跳转到index.jsp-->
							<td width="14%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									height="28" background="images/index_lm.gif">
									<tr>
										<td width="100%">
											<div align="center">
												<b> <a href="index.jsp"><font color="#FFFFFF">首页</font>
												</a> </b>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<!--设置书店简介的按钮开始-->
							<td width="14%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									height="28" background="images/index_lm.gif">
									<tr>
										<td width="100%">
											<div align="center">
												<b> <!--该链接还没完成--> <a href="#"><font color="#FFFFFF">
															<!--Button1--> 书店简介 </font> </a> </b>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<!--设置书店简介的按钮结束-->

							<!--设置新书介绍按钮开始-->
							<td width="14%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									height="28" background="images/index_lm.gif">
									<tr>
										<td width="100%">
											<div align="center">
												<b> <!--设置新书介绍按钮跳转--> <a href="#"><font
														color="#FFFFFF"> 新书介绍 </font> </a> </b>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<!--设置新书介绍按钮结束-->

							<!--设置在线服务按钮开始-->
							<td width="14%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									height="28" background="images/index_lm.gif">
									<tr>
										<td width="100%">
											<div align="center">
												<b> <!--在线服务按钮链接--> <a href="#"><font
														color="#FFFFFF"> 在线服务 </font> </a> </b>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<!--设置在线服务按钮结束-->

							<!--设置本店公告按钮开始-->
							<td width="14%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									height="28" background="images/index_lm.gif">
									<tr>
										<td width="100%">
											<div align="center">
												<b> <!--本店公告按钮链接--> <a href="#"><font
														color="#FFFFFF"> 本店公告 </font> </a> </b>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<!--设置本店公告按钮结束-->

							<!--设置店长答疑按钮开始-->
							<td width="14%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									height="28" background="images/index_lm.gif">
									<tr>
										<td width="100%">
											<div align="center">
												<b> <!--店长答疑按钮链接--> <a href="#"><font
														color="#FFFFFF"> 店长答疑 </font> </a> </b>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<!--设置店长答疑按钮结束-->

							<!--设置管理员入口按钮开始-->
							<td width="16%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									height="28" background="images/index_lm.gif">
									<tr>
										<td width="100%">
											<div align="center">
												<b> <!--点击管理员入口跳转链接--> <a href="admin/adm_login.jsp">
														<font color="#FFFFFF"> 管理员入口 </font> </a> </b>
											</div>
										</td>
									</tr>
								</table>
							</td>
							<!--设置管理员入口按钮结束-->
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<table width="778" height="90%" border="0" cellspacing="0"
			cellpadding="0" align="center" bgcolor="#E4EDFB">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<!--设置页面显示内容属性-->
								<table width="90%" border="0" cellspacing="0" cellpadding="0"
									align="center">
									<tr>
										<td bgcolor="#000000">
											<img src="images/Spacer.gif" width="1" height="1">
										</td>
									</tr>
									<tr>