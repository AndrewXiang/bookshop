package netshop.book.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import netshop.book.service.manage_login;

public class login extends HttpServlet{
	/** 
     * @param request servlet request
     * @param response servlet response
	 * @throws Exception 
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws Exception{
        response.setContentType("text/html;charset=UTF-8");
        String mesg = "";
        if( request.getParameter("username")!=null && !request.getParameter("username").equals("")){
        	String username =request.getParameter("username");
        	String passwd = request.getParameter("passwd");
        	HttpSession session=request.getSession(true);
        	username = new String(username.getBytes("ISO8859-1"));
        	passwd = new String(passwd.getBytes("ISO8859-1"));
        	manage_login login = new manage_login();
        	login.setUsername(username);
        	login.setPasswd(passwd);
        	System.out.println(username+passwd);
        	if (login.excute()){
        		session.setAttribute("username",username);
        		String userid = Long.toString(login.getUserid());
        		session.setAttribute("userid",userid);
        		response.sendRedirect("bookshop/booklist.jsp");
        	}else {
        	mesg = "µÇÂ¼³ö´í£¡"	;
        	}
        }
        if (!mesg.equals("")){
			System.out.println("<p>" + mesg + "</p>");}
    }
    
    /** 
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
			processRequest(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /** 
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
			processRequest(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /**
     */
    public String getServletInfo(){
        return "Short description";
    }

}