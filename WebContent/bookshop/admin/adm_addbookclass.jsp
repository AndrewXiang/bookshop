<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="netshop.book.bean.*"%>
<jsp:useBean id="classlist" scope="page" class="netshop.book.service.manage_bookclass" />
<jsp:useBean id="book" scope="page" class="netshop.book.service.manage_book" />
<%
	String mesg = "";
	String submit = request.getParameter("Submit");
	if (submit!=null && !submit.equals("")){		
		if(classlist.getRequest(request)){
			if(classlist.insert()){
				mesg = "新图书资料提交成功！";
			} else {
				mesg = "数据库操作失败";
			}
		}else {
			mesg = "对不起，你提交的参数有错误";
		}
	}
	if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try {
		int delid = Integer.parseInt(request.getParameter("id"));
		if (classlist.delete(delid)){
			mesg = "删除成功！";
		} else {
			mesg = "删除出错！";
		}
	} catch (Exception e){
		mesg = "你要删除的对象错误!";
	}
}
%>

<script language="javascript">
  function checkform() {
	if (document.form1.bookclassname.value=="") {
		document.form1.bookname.focus();
		alert("图书名为空!");
		return false;
	}
	

	return true;

  }
</script>
<%@include file="/bookshop/inc/adm_head.inc"%>
<tr>
<tr><td align="center">现有图书分类:</td></tr>


		<% if (classlist.seachBookClass()){
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>
			    <tr align="left"> <td>&nbsp;&nbsp;&nbsp;&nbsp;分类名称：<%= bc.getClassName() %>&nbsp;<a href="adm_addbookclass.jsp?id=<%= bc.getId()%>&action=del">删除</a></td></tr>
		<%		}			
		}%>
			

<td align="center" width="100%"> 
        <p><br>
          <font size="3"><b>添加新的图书分类</b></font></p>
		  <% if(!mesg.equals("")){
			out.println(mesg);
		  }%>
        <form name="form1" method="post" action="adm_addbookclass.jsp">
          <table width="90%" border="0" cellspacing="1" cellpadding="1">
            <tr> 
              <td align="right" width="35%">图书分类名称：</td>
              <td width="65%"> 
                <input type="text" name="bookclassname" maxlength="40" size="30">
              </td>
            </tr>            
            <tr> 
              <td align="right" width="35%">&nbsp;</td>
              <td width="65%"> 
                <input type="submit" name="Submit" value="提交" onclick="return(checkform());">
                <input type="reset" name="reset" value="重置">
              </td>
            </tr>
          </table>
        </form>
        <p>&nbsp;</p>
      </td>

<%@include file="/bookshop/inc/adm_authenticate.inc"%>