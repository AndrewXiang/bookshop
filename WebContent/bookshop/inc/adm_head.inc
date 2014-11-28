<%@ page contentType="text/html; charset=gb2312" %>
<HTML>
<HEAD>
<TITLE>
网上书店管理系统
Template
</TITLE>
<!--设置字符显示方式-->
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<link rel="stylesheet" href="images/CSS.CSS" type="text/css">
<style type="text/css">
<!-- 设置CSS样式 -->
</style>
<!--加载JavaScript -->
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
function window_onload() {
<!--Page.OnLoad-->
}

//-->
</SCRIPT>
</HEAD>
<!--设置页面背景颜色、页边距和加载方式-->
<BODY BGCOLOR=#3E79A6 leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="return window_onload()">
<!--设置导航栏表格显示属性-->
<table width="778" border="0" cellspacing="0" cellpadding="0" align="center" height="135">
  <tr> 
    <td height="110" width="540" background="images/index_top1.gif" valign="top"> 
      <table border="0" cellspacing="0" cellpadding="0" width="540" align="center">
        <tr> 
          <td height="25" width="340"> <font color="#FFFFFF"><b></b></font> 
            <div align="center"></div>
          </td>
          <td height="25" width="200">&nbsp;</td>
        </tr>
        <!--设置系统中文显示名称-->
        <tr> 
          <td height="30" width="500"> 
            <div align="center"><font color="#FFFFFF"><b><font size="5">
                                网上书店内部管理 
              </font></b></font></div>
          </td>
          <td height="30" width="200">&nbsp;</td>
        </tr>
        <!--设置系统英文显示名称 -->
        <tr> 
          <td height="30" width="500"> 
            <div align="center"><font size="4" color="#FFFFFF">
             Admin NetBook Shop
            </font> </div>
          </td>
          <td height="25" width="200">&nbsp;</td>
        </tr>
      </table>
    </td>
    <td height="110" width="238" background="images/book01.png"><img src="images/index_pic.gif" width="238" height="110"></td>
  </tr>
  <tr> 
    <td colspan="2" height="25"><img src="images/index_top2.gif" width="778" height="25"></td>
  </tr>
</table>
<!-- 用表格设置管理员导航栏-->
<table width="778" border="0" cellspacing="0" cellpadding="0" align="center" background="images/nv.png" height="10">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="28">
        <tr>
          <!--设置首页按钮-->
          <td width="10%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="28" background="images/index_lm.gif">
              <tr> 
                <td width="100%"> 
                  <div align="center"><b><a href="#"><font color="#FFFFFF">首页</font></a></b> 
                  </div>
                </td>
              </tr>
            </table>
          </td>
         <!--设置现有图书管理按钮-->
          <td width="16%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="28" background="images/index_lm.gif">
              <tr> 
                <td width="100%"> 
                  <div align="center">
                  <b> <!--跳转链接-->
                  <a href="adm_book.jsp">
                 <font color="#FFFFFF">现有图书管理</font>
                 </a></b> 
                  </div>
                </td>
              </tr>
            </table>
          </td>
         <!--设置 添加新图书管理按钮-->
          <td width="14%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="28" background="images/index_lm.gif">
              <tr> 
                <td width="100%"> 
                  <div align="center"><b>
                  <!-- 添加新图书按钮链接-->
                  <a href="adm_addbook.jsp">
                  <font color="#FFFFFF">
                                                  添加新图书
                   </font>
                   </a></b></div>
                </td>
              </tr>
            </table>
          </td>
          <!--设置  添加图书分类管理按钮-->
          <td width="16%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="28" background="images/index_lm.gif">
              <tr> 
                <td width="100%"> 
                  <div align="center"><b>
                  <!-- 添加图书分类链接-->
                  <a href="adm_addbookclass.jsp">
                  <font color="#FFFFFF">
                                                添加图书分类 
                  </font></a></b></div>
                </td>
              </tr>
            </table>
          </td>
          <!--设置 订单管理按钮-->
          <td width="12%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="28" background="images/index_lm.gif">
              <tr> 
                <td width="100%"> 
                  <div align="center"><b>
                  <!--订单管理链接-->
                  <a href="adm_order.jsp">
                  <font color="#FFFFFF">
                                                订单管理 
                  </font></a></b></div>
                </td>
              </tr>
            </table>
          </td>
        <!--设置用户管理 按钮-->
          <td width="12%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="28" background="images/index_lm.gif">
              <tr> 
                <td width="100%"> 
                  <div align="center"><b>
                  <!--用户管理链接-->
                  <a href="adm_user.jsp">
                  <font color="#FFFFFF">
                                              用户管理 
                  </font></a></b></div>
                </td>
              </tr>
            </table>
          </td>
         <!--设置管理员管理按钮-->
          <td width="10%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="28" background="images/index_lm.gif">
              <tr> 
                <td width="100%"> 
                  <div align="center"><b>
                  <!--登录按钮链接-->
                  <a href="adm_login.jsp">
                  <font color="#FFFFFF">
                                                登录 
                  </font></a></b></div>
                </td>
              </tr>
            </table>
          </td>
         <!--设置管理员退出按钮-->
          <td width="10%"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="28" background="images/index_lm.gif">
              <tr> 
                <td width="100%"> 
                  <div align="center"><b>
                  <!--管理员退出按钮链接-->
                  <a href="adm_logout.jsp">
                  <font color="#FFFFFF">
                                                退出 
                  </font></a></b></div>
                </td>
              </tr>
            </table>
          </td>
      </tr>
      </table>
    </td>
  </tr>
</table>
<table width="778"  cellspacing="1"  align="center" bgcolor="#E4EDFB">

          
              
             