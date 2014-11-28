package netshop.book.service;

/**
 * <p>��������</p>
 * <p>Description: </p>
 */

import java.sql.*;
import java.util.Vector;
import javax.servlet.http.*;

import netshop.book.bean.*;
import netshop.book.util.*;

import java.util.*;
public class manage_buybook extends DataBase {

    private javax.servlet.http.HttpServletRequest request; //����ҳ������
    private HttpSession session; //ҳ���session;
    private boolean sqlflag = true; //�Խ��յ��������Ƿ���ȷ
    private Vector allorder; //�������б�
    private Vector order_list; //�����嵥�б�
    private int booknumber = 0; //����������
    private float all_price = 0; //�����ܼ�Ǯ
    private String orderId = ""; //�û�������
    private int page = 1; //��ʾ��ҳ��
    private int pageSize = 15; //ÿҳ��ʾ�Ķ�����
    private int pageCount = 0; //ҳ������
    private long recordCount = 0; //��ѯ�ļ�¼����

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
   
    public int getPage() { //��ʾ��ҳ��
      return page;
    }
    public void setPage(int newpage) {
      page = newpage;
    }
    public int getPageSize() { //ÿҳ��ʾ��ͼ����
      return pageSize;
    }
    public void setPageSize(int newpsize) {
      pageSize = newpsize;
    }
    public int getPageCount() { //ҳ������
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
     * ��ѯָ���û�id�����ж���
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
     * ��ѯָ��������ŵĶ���
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
     * ��ѯ�������ж�������
     * @return
     */
    public boolean getOrder() {
      sqlStr = "select count(*) from orders"; //ȡ����¼��
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
      //�趨�ж���pageCount
      if (recordCount < 1)
        pageCount = 0;
      else
        pageCount = (int) (recordCount - 1) / pageSize + 1;
        //���鿴��ҳ�����Ƿ��ڷ�Χ��
      if (page < 1)
        page = 1;
      else if (page > pageCount)
        page = pageCount;

      rscount = (int) recordCount % pageSize; // ���һҳ��¼��

      //sqlΪ����ȡֵ
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
     * ��ö����б�
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
     * �޸Ķ������޸ĸ����־
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
     * ɾ������
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
