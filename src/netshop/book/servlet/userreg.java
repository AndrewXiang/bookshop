package netshop.book.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import netshop.book.service.manage_login;
import netshop.book.service.manage_user;

public class userreg extends HttpServlet{
	/** 
     * @param request servlet request
     * @param response servlet response
	 * @throws Exception 
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws Exception{
        response.setContentType("text/html;charset=UTF-8");
        String mesg = "";
        String submit = request.getParameter("Submit");
        manage_user user = new manage_user();
        HttpSession session=request.getSession(true);
        if (submit!=null && !submit.equals("")) {
        	if(user.add(request)){
        		session.setAttribute("username",user.getUserName());
        		session.setAttribute( "userid", Integer.toString( user.getUserid() ) ); 
        		response.sendRedirect("bookshop/orderinfo.jsp?action=regok");
        	} else if (!user.getMessage().equals("")) {
        		mesg = user.getMessage();
        	} else
        		mesg = "注册时出现错误，请稍后再试";
          if (!mesg.equals("")) 
        	  System.out.println("<p><font color=#ff0000>"+ mesg + "</font></p>");
        }
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
