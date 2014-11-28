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
		if(book.getRequest(request)){
			if(book.insert()){
				mesg = "新图书资料提交成功！";
			} else {
				mesg = "数据库操作失败";
			}
		}else {
			mesg = "对不起，你提交的参数有错误";
		}
	}
%>
<script language="javascript">
  function checkform() {
	if (document.form1.bookname.value=="") {
		document.form1.bookname.focus();
		alert("图书名为空!");
		return false;
	}
	if (document.form1.author.value=="") {
		alert("作者名为空!");
		document.form1.author.focus();
		return false;
	}

	return true;

  }
</script>
<%@include file="/bookshop/inc/adm_head.inc"%>
<tr>
<td align="center" width="77%"> 
        <p><br>
          <font size="3"><b>添加新的图书资料</b></font></p>
		  <% if(!mesg.equals("")){
			out.println(mesg);
		  }%>
        <form name="form1" method="post" action="adm_addbook.jsp">
          <table width="90%" border="0" cellspacing="1" cellpadding="1">
            <tr> 
              <td align="right" width="35%">图书名称：</td>
              <td width="65%"> 
                <input type="text" name="bookname" maxlength="40" size="30">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">作者：</td>
              <td width="65%"> 
                <input type="text" name="author" maxlength="25" size="20">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">出版社：</td>
              <td width="65%"> 
                <input type="text" name="publish" size="40" maxlength="150">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">所属类别：</td>
              <td width="65%"> 
                <select name="bookclass">
		<% if (classlist.seachBookClass()){
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>
			      <option value="<%= bc.getId()%>"><%= bc.getClassName() %></option>
		<%		}			
		}%>	
					
                </select>
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">书号：</td>
              <td width="65%"> 
                <input type="text" name="bookno" size="20" maxlength="30">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">定价：</td>
              <td width="65%"> 
                <input type="text" name="price" size="8" maxlength="10">
                元</td>
            </tr>
            <tr> 
              <td align="right" width="35%">总数量：</td>
              <td width="65%"> 
                <input type="text" name="amount" size="8" maxlength="10">
                本</td>
            </tr>
            <tr> 
              <td align="right" width="35%">图书封面：</td>
              <td width="65%"> 
                <input type="File" name="picture" class=box>
                </td>
            </tr>
            <tr> 
              <td align="right" width="35%" valign="top">图书简介：</td>
              <td width="65%"> 
                <textarea name="content" cols="40" rows="6"></textarea>
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
</tr>
<%@include file="/bookshop/inc/adm_authenticate.inc"%>