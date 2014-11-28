package netshop.book.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import netshop.book.bean.allorder;
import netshop.book.util.DataBase;
import netshop.book.util.dataFormat;


public class manage_shopcart extends DataBase{
	 private javax.servlet.http.HttpServletRequest request; //����ҳ������
	 private HttpSession session; //ҳ���session;
	 private Vector purchaselist; //��ʾͼ���б���������
	 private boolean isEmpty = false; //���е��������Ƿ񹻹������
	 private int leaveBook = 0; //�������
	 private boolean isLogin = true; //�û��Ƿ��¼��
	 private String orderId = ""; //�û�������
	  public Vector getPurchaselist() {
	      return purchaselist;
	    }
	  public void setIsEmpty(boolean flag) {
	      isEmpty = flag;
	    }
	    public boolean getIsEmpty() {
	      return isEmpty;
	    }
	    public void setLeaveBook(int bknum) {
	      leaveBook = bknum;
	    }
	    public int getLeaveBook() {
	      return leaveBook;
	    }
	    public void setIsLogin(boolean flag) {
	        isLogin = flag;
	      }
	      public boolean getIsLogin() {
	        return isLogin;
	      }
	 public String getGbk(String str) {
	      try {
	        return new String(str.getBytes("ISO8859-1"));
	      }
	      catch (Exception e) {
	        return str;
	      }
	    }
	 /**
     * �����ﳵ�����ѡ����ͼ��
     * @param newrequest
     * @return
     */
    public boolean addnew(HttpServletRequest newrequest) {
      request = newrequest;
      String ID = request.getParameter("bookid");
      String Amount = request.getParameter("amount");
      long bookid = 0;
      int amount = 0;
      try {
        bookid = Long.parseLong(ID);
        amount = Integer.parseInt(Amount);
      }
      catch (Exception e) {
        return false;
      }
      if (amount < 1)
        return false;
      session = request.getSession(false);
      if (session == null) {
        return false;
      }
      purchaselist = (Vector) session.getAttribute("shopcart");
      sqlStr = "select leav_number from book where id=" + bookid;
      try {
        DataBase db = new DataBase();
                  Connection conn=db.connect();
                  stmt = conn.createStatement ();

        rs = stmt.executeQuery(sqlStr);
        if (rs.next()) {
          if (amount > rs.getInt(1)) {
            leaveBook = rs.getInt(1);
            isEmpty = true;
            return false;
          }
        }
        rs.close();
      }
      catch (SQLException e) {
        return false;
      }

      allorder iList = new allorder();
      iList.setBookNo(bookid);
      iList.setAmount(amount);
      boolean match = false; //�Ƿ������ͼ��
      if (purchaselist == null) { //��һ�ι���
        purchaselist = new Vector();
        purchaselist.addElement(iList);
      }

      else { // ���ǵ�һ�ι���
        for (int i = 0; i < purchaselist.size(); i++) {
          allorder itList = (allorder) purchaselist.elementAt(i);
          if (iList.getBookNo() == itList.getBookNo()) {
            itList.setAmount(itList.getAmount() + iList.getAmount());
            purchaselist.setElementAt(itList, i);
            match = true;
            break;
          } //if name matches����
        } // forѭ������
        if (!match)
          purchaselist.addElement(iList);
      }
      session.setAttribute("shopcart", purchaselist);
      return true;
    }
    /**
     * �޸��Ѿ��Ž����ﳵ������
     * @param newrequest
     * @return
     */
    public boolean modiShoper(HttpServletRequest newrequest) {
      request = newrequest;
      String ID = request.getParameter("bookid");
      String Amount = request.getParameter("amount");
      long bookid = 0;
      int amount = 0;
      try {
        bookid = Long.parseLong(ID);
        amount = Integer.parseInt(Amount);
      }
      catch (Exception e) {
        return false;
      }
      if (amount < 1)
        return false;
      session = request.getSession(false);
      if (session == null) {
        return false;
      }
      purchaselist = (Vector) session.getAttribute("shopcart");
      if (purchaselist == null) {
        return false;
      }
      sqlStr = "select leav_number from book where id=" + bookid;
      try {
        DataBase db = new DataBase();
                  Connection conn=db.connect();
                  stmt = conn.createStatement ();

        rs = stmt.executeQuery(sqlStr);
        if (rs.next()) {
          if (amount > rs.getInt(1)) {
            leaveBook = rs.getInt(1);
            isEmpty = true;
            return false;
          }
        }
        rs.close();
      }
      catch (SQLException e) {
        return false;
      }
      for (int i = 0; i < purchaselist.size(); i++) {
        allorder itList = (allorder) purchaselist.elementAt(i);
        if (bookid == itList.getBookNo()) {
          itList.setAmount(amount);
          purchaselist.setElementAt(itList, i);
          break;
        } //if name matches����
      } // forѭ������
      return true;
    }
    /**
     *ɾ�����ﳵ������
     * @param newrequest
     * @return
     */
    public boolean delShoper(HttpServletRequest newrequest) {
      request = newrequest;
      String ID = request.getParameter("bookid");
      long bookid = 0;
      try {
        bookid = Long.parseLong(ID);
      }
      catch (Exception e) {
        return false;
      }
      session = request.getSession(false);
      if (session == null) {
        return false;
      }
      purchaselist = (Vector) session.getAttribute("shopcart");
      if (purchaselist == null) {
        return false;
      }

      for (int i = 0; i < purchaselist.size(); i++) {
        allorder itList = (allorder) purchaselist.elementAt(i);
        if (bookid == itList.getBookNo()) {
          purchaselist.removeElementAt(i);
          break;
        } //if name matches����
      } // forѭ������
      return true;
    }
    /**
     * �ύ���ﳵ
     * @param newrequest
     * @return
     * @throws java.lang.Exception
     */
    public boolean payout(HttpServletRequest newrequest) throws Exception {
      request = newrequest;
      session = request.getSession(false);
      if (session == null) {
        return false;
      }
      String Userid = (String) session.getAttribute("userid"); //ȡ���û�ID��
      long userid = 0;
      if (Userid == null || Userid.equals("")) {
        isLogin = false;
        return false;
      }
      else {
        try {
          userid = Long.parseLong(Userid);
        }
        catch (NumberFormatException e) {
        //  System.out.print(e.getMessage());
          return false;
        }
      }
      purchaselist = (Vector) session.getAttribute("shopcar");
      if (purchaselist == null || purchaselist.size() < 0) {
        return false;
      }
      String Content = request.getParameter("content");
      if (Content == null) {
        Content = "";
      }
      Content = getGbk(Content);
      String IP = request.getRemoteAddr();
      String TotalPrice = request.getParameter("totalprice");
      long timeInMillis = System.currentTimeMillis();
      sqlStr = "insert into order (orderId,UserId,SubmitTime,ConsignmentTime,TotalPrice,content,IPAddress,IsPayoff,IsSales) values (";
      orderId=""+timeInMillis;//��ϵͳʱ�����λ�ƵĶ������
      sqlStr = sqlStr  + orderId + ",'";
      sqlStr = sqlStr + userid + "',now(),now()+7,'";
      sqlStr = sqlStr + TotalPrice + "','";
      sqlStr = sqlStr + dataFormat.toSql(Content) + "','";
      sqlStr = sqlStr + IP + "',1,1)";
      try {
    	DataBase db = new DataBase();
          Connection conn=db.connect();
          stmt = conn.createStatement ();
        stmt.execute(sqlStr);
        for (int i = 0; i < purchaselist.size(); i++) {
          allorder iList = (allorder) purchaselist.elementAt(i);
          sqlStr =
              "insert into allorder (orderId,BookNo,Amount) values (";
          sqlStr = sqlStr + orderId + ",'";
          sqlStr = sqlStr + iList.getBookNo() + "','";
          sqlStr = sqlStr + iList.getAmount() + "')";
          stmt.execute(sqlStr);
          sqlStr = "update book set leav_number=leav_number - " +
              iList.getAmount() + " where id = " + iList.getBookNo();
          stmt.execute(sqlStr);
        }
        return true;
      }
      catch (SQLException e) {
        System.out.print(e.getMessage());
        return false;
      }

    }
}
