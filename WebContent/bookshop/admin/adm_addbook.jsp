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
				mesg = "��ͼ�������ύ�ɹ���";
			} else {
				mesg = "���ݿ����ʧ��";
			}
		}else {
			mesg = "�Բ������ύ�Ĳ����д���";
		}
	}
%>
<script language="javascript">
  function checkform() {
	if (document.form1.bookname.value=="") {
		document.form1.bookname.focus();
		alert("ͼ����Ϊ��!");
		return false;
	}
	if (document.form1.author.value=="") {
		alert("������Ϊ��!");
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
          <font size="3"><b>����µ�ͼ������</b></font></p>
		  <% if(!mesg.equals("")){
			out.println(mesg);
		  }%>
        <form name="form1" method="post" action="adm_addbook.jsp">
          <table width="90%" border="0" cellspacing="1" cellpadding="1">
            <tr> 
              <td align="right" width="35%">ͼ�����ƣ�</td>
              <td width="65%"> 
                <input type="text" name="bookname" maxlength="40" size="30">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">���ߣ�</td>
              <td width="65%"> 
                <input type="text" name="author" maxlength="25" size="20">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">�����磺</td>
              <td width="65%"> 
                <input type="text" name="publish" size="40" maxlength="150">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">�������</td>
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
              <td align="right" width="35%">��ţ�</td>
              <td width="65%"> 
                <input type="text" name="bookno" size="20" maxlength="30">
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">���ۣ�</td>
              <td width="65%"> 
                <input type="text" name="price" size="8" maxlength="10">
                Ԫ</td>
            </tr>
            <tr> 
              <td align="right" width="35%">��������</td>
              <td width="65%"> 
                <input type="text" name="amount" size="8" maxlength="10">
                ��</td>
            </tr>
            <tr> 
              <td align="right" width="35%">ͼ����棺</td>
              <td width="65%"> 
                <input type="File" name="picture" class=box>
                </td>
            </tr>
            <tr> 
              <td align="right" width="35%" valign="top">ͼ���飺</td>
              <td width="65%"> 
                <textarea name="content" cols="40" rows="6"></textarea>
              </td>
            </tr>
            <tr> 
              <td align="right" width="35%">&nbsp;</td>
              <td width="65%"> 
                <input type="submit" name="Submit" value="�ύ" onclick="return(checkform());">
                <input type="reset" name="reset" value="����">
              </td>
            </tr>
          </table>
        </form>
        <p>&nbsp;</p>
      </td>
</tr>
<%@include file="/bookshop/inc/adm_authenticate.inc"%>