package netshop.book.service;

/**
 * <p>管理订单类</p>
 * <p>Description: </p>
 */

import java.sql.*;
import java.util.Vector;
import javax.servlet.http.*;

import netshop.book.bean.*;
import netshop.book.util.*;

import java.util.*;
public class manage_buybook extends DataBase {

    private javax.servlet.http.HttpServletRequest request; //建立页面请求
    private HttpSession session; //页面的session;
    private boolean sqlflag = true; //对接收到的数据是否正确
    private Vector allorder; //订购单列表
    private Vector order_list; //订单清单列表
    private int booknumber = 0; //购书总数量
    private float all_price = 0; //购书总价钱
    private String orderId = ""; //用户订单号
    private int page = 1; //显示的页码
    private int pageSize = 15; //每页显示的订单数
    private int pageCount = 0; //页面总数
    private long recordCount = 0; //查询的记录总数

    Calendar date = Calendar.getInstance();
    long time=date.getTimeInMillis();
   public manage_buybook() {
      super();
  }
  
    public Vector getOrder_list() {
      return order_list;
    }
    public Vector getAllorder() {
      return allorder;
    }
    public boolean getSqlflag() {
      return sqlflag;
    }
   
    public void setOrderId(String newId) {
      orderId = newId;
    }
    public String getOrderId() {
      return orderId;
    }
   
    public int getPage() { //显示的页码
      return page;
    }
    public void setPage(int newpage) {
      page = newpage;
    }
    public int getPageSize() { //每页显示的图书数
      return pageSize;
    }
    public void setPageSize(int newpsize) {
      pageSize = newpsize;
    }
    public int getPageCount() { //页面总数
      return pageCount;
    }
    public void setPageCount(int newpcount) {
      pageCount = newpcount;
    }
    public long getRecordCount() {
      return recordCount;
    }
    public void setRecordCount(long newrcount) {
      recordCount = newrcount;
    }
    public String getGbk(String str) {
      try {
        return new String(str.getBytes("ISO8859-1"));
      }
      catch (Exception e) {
        return str;
      }
    }

    public String getSql() {
      sqlStr = "select id,classname from book order by id";
      return sqlStr;
    }
   
    /**
     * 查询指定用户id的所有订单
     * @param userid
     * @return
     */
    public boolean getOrder(long userid) {
      sqlStr = "select * from orders where userid = '" + userid +
          "' order by id desc";
      try {
        DataBase db = new DataBase();
                  Connection conn=db.connect();
                  stmt = conn.createStatement ();

        rs = stmt.executeQuery(sqlStr);
        allorder = new Vector();
        while (rs.next()) {
          order ind = new order();
          ind.setId(rs.getLong("id"));
          ind.setOrderId(rs.getString("orderId"));
          ind.setUserId(rs.getLong("userid"));
          ind.setSubmitTime(rs.getString("submitTime"));
          ind.setConsignmentTime(rs.getString("ConsignmentTime"));
          ind.setTotalPrice(rs.getFloat("TotalPrice"));
          ind.setContent(rs.getString("content"));
          ind.setIPAddress(rs.getString("IpAddress"));
          if (rs.getInt("IsPayoff") == 1)
            ind.setIsPayoff(false);
          else
            ind.setIsPayoff(true);
          if (rs.getInt("IsSales") == 1)
            ind.setIsSales(false);
          else
            ind.setIsSales(true);
          allorder.addElement(ind);
        }
        rs.close();
        return true;
      }
      catch (SQLException e) {
        return false;
      }
    }
    /**
     * 查询指定订单编号的订单
     * @param iid
     * @return
     */
    public boolean getSinggleOrder(String order_id) {
      sqlStr = "select * from orders where orderId = '" + order_id +
          "' ";
      try {
        DataBase db = new DataBase();
                  Connection conn=db.connect();
                  stmt = conn.createStatement ();

        rs = stmt.executeQuery(sqlStr);
        allorder = new Vector();
        while (rs.next()) {
          order ind = new order();
          ind.setId(rs.getLong("id"));
          ind.setOrderId(rs.getString("orderId"));
          ind.setUserId(rs.getLong("userid"));
          ind.setSubmitTime(rs.getString("submitTime"));
          ind.setConsignmentTime(rs.getString("ConsignmentTime"));
          ind.setTotalPrice(rs.getFloat("TotalPrice"));
          ind.setContent(rs.getString("content"));
          ind.setIPAddress(rs.getString("IpAddress"));
          if (rs.getInt("IsPayoff") == 1)
            ind.setIsPayoff(false);
          else
            ind.setIsPayoff(true);
          if (rs.getInt("IsSales") == 1)
            ind.setIsSales(false);
          else
            ind.setIsSales(true);
          allorder.addElement(ind);
          System.out.print("allorder:"+allorder.size());
        }
        rs.close();
        return true;
      }
      catch (SQLException e) {
        System.out.print(e.getMessage());
        return false;
      }
    }
    /**
     * 查询书店的所有订单数据
     * @return
     */
    public boolean getOrder() {
      sqlStr = "select count(*) from orders"; //取出记录数
      int rscount = pageSize;
      try {
        DataBase db = new DataBase();
                  Connection conn=db.connect();
                  stmt = conn.createStatement ();

        ResultSet rs1 = stmt.executeQuery(sqlStr);
        if (rs1.next())
          recordCount = rs1.getInt(1);
        rs1.close();
      }
      catch (SQLException e) {
        return false;
      }
      //设定有多少pageCount
      if (recordCount < 1)
        pageCount = 0;
      else
        pageCount = (int) (recordCount - 1) / pageSize + 1;
        //检查查看的页面数是否在范围内
      if (page < 1)
        page = 1;
      else if (page > pageCount)
        page = pageCount;

      rscount = (int) recordCount % pageSize; // 最后一页记录数

      //sql为倒序取值
      sqlStr = "select  * from orders ";
      if (page == 1) {
        sqlStr = sqlStr + " order by Id desc";
      }
      else {
        sqlStr = sqlStr + " order by Id desc  limit "+(recordCount - pageSize * page) +","+ (recordCount - pageSize * (page - 1));

      }

      try {
        DataBase db = new DataBase();
                  Connection conn=db.connect();
                  stmt = conn.createStatement ();

        rs = stmt.executeQuery(sqlStr);
        allorder = new Vector();
        while (rs.next()) {
          order ind = new order();
          ind.setId(rs.getLong("id"));
          ind.setOrderId(rs.getString("orderid"));
          ind.setUserId(rs.getLong("userid"));
          ind.setSubmitTime(rs.getString("submitTime"));
          ind.setConsignmentTime(rs.getString("ConsignmentTime"));
          ind.setTotalPrice(rs.getFloat("TotalPrice"));
          ind.setContent(rs.getString("content"));
          ind.setIPAddress(rs.getString("IpAddress"));
          if (rs.getInt("IsPayoff") == 1)
            ind.setIsPayoff(false);
          else
            ind.setIsPayoff(true);
          if (rs.getInt("IsSales") == 1)
            ind.setIsSales(false);
          else
            ind.setIsSales(true);
          allorder.addElement(ind);
        }
        rs.close();
        return true;
      }
      catch (SQLException e) {
        System.out.println(e);
        return false;
      }
    }
    /**
     * 获得订单列表
     * @param nid
     * @return
     */
    public boolean getAllorder(String order_id) {
      sqlStr = "select * from allorder where orderId = '" + order_id + "'";
      try {
        DataBase db = new DataBase();
                  Connection conn=db.connect();
                  stmt = conn.createStatement ();

        rs = stmt.executeQuery(sqlStr);
        order_list = new Vector();
        while (rs.next()) {
          allorder identlist = new allorder();
          identlist.setId(rs.getLong("id"));
          identlist.setOrderId(rs.getLong("orderId"));
          identlist.setBookNo(rs.getLong("BookNo"));
          identlist.setAmount(rs.getInt("Amount"));
          order_list.addElement(identlist);
        }
        rs.close();
        return true;
      }
      catch (SQLException e) {
        System.out.print(e.getMessage());
        return false;
      }
    }
    /**
     * 修改订单，修改付款标志
     * @param res
     * @return
     */
    public boolean update(HttpServletRequest res) {
      request = res;
      int payoff = 1;
      int sales = 1;
      //long orderId = 0;
      try {
        System.out.println("payoff:"+request.getParameter("payoff"));
        payoff = Integer.parseInt(request.getParameter("payoff"));
        sales = Integer.parseInt(request.getParameter("sales"));
        orderId =request.getParameter("indentid");
        sqlStr = "update orders set IsPayoff = '" + payoff + "',IsSales='" +
            sales + "' where orderId =" + orderId;
        DataBase db = new DataBase();
                  Connection conn=db.connect();
                  stmt = conn.createStatement ();
                  System.out.print(sqlStr);
        stmt.execute(sqlStr);
        return true;
      }
      catch (Exception e) {
        System.out.print(e.getMessage());
        return false;
      }
    }
    /**
     * 删除订单
     * @param id
     * @return
     */
    public boolean delete(long id) {
      try {
        DataBase db = new DataBase();
                  Connection conn=db.connect();
                  stmt = conn.createStatement ();
        sqlStr = "delete from allorder where id =" + id;
        stmt.execute(sqlStr);
        sqlStr = "delete from orders where id= " + id;
        stmt.execute(sqlStr);
        return true;
      }
      catch (SQLException e) {
        return false;
      }
    }

  }
