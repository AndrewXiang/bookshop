package netshop.book.service;

/**
 * <p>�����û��� </p>
 * @version 1.0
 */
import java.sql.*;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;

import netshop.book.bean.*;
import netshop.book.util.*;

public class manage_user extends DataBase {
	private user user = new user(); // �µ��û�����
	private javax.servlet.http.HttpServletRequest request; // ����ҳ������
	private Vector userlist; // ��ʾ�û��б���������
	private int page = 1; // ��ʾ��ҳ��
	private int pageSize = 8; // ÿҳ��ʾ��ͼ����
	private int pageCount = 0; // ҳ������
	private long recordCount = 0; // ��ѯ�ļ�¼����
	private String message = ""; // ������Ϣ��ʾ
	private String username = ""; // ע��󷵻ص��û���
	private int userid = 0; // ע��󷵻ص��û�ID

	public manage_user() {
	}

	// ������û�
	public boolean add(HttpServletRequest req) throws Exception {
		if (getRequest(req)) {
			DataBase db = new DataBase();
			db.connect();
			stmt = db.conn.createStatement();
			sqlStr = "select * from shop_user where username = '"
					+ user.getUserName() + "'";
			sqlStr = "insert into shop_user (username,password,Names,sex,"
					+ "Address,Phone,Post,Email,RegTime,RegIpaddress) values ('";
			sqlStr = sqlStr + dataFormat.toSql(user.getUserName()) + "','";
			sqlStr = sqlStr + dataFormat.toSql(user.getPassWord()) + "','";
			sqlStr = sqlStr + dataFormat.toSql(user.getNames()) + "','";
			sqlStr = sqlStr + dataFormat.toSql(user.getSex()) + "','";
			sqlStr = sqlStr + dataFormat.toSql(user.getAddress()) + "','";
			sqlStr = sqlStr + dataFormat.toSql(user.getPhone()) + "','";
			sqlStr = sqlStr + dataFormat.toSql(user.getPost()) + "','";
			sqlStr = sqlStr + dataFormat.toSql(user.getEmail()) + "',now(),'";
			sqlStr = sqlStr + user.getRegIpAddress() + "')";
			try {
				stmt.executeUpdate(sqlStr);
				sqlStr = "select max(id) from shop_user where username = '"
						+ user.getUserName() + "'";
				rs = stmt.executeQuery(sqlStr);
				while (rs.next()) {
					userid = rs.getInt(1);
				}
				rs.close();
				return true;
			} catch (Exception sqle) {
				System.out.print(sqle.getMessage());
				return false;
			}
		} else {
			return false;
		}

	}

	// ����ҳ��ת�ݵĲ���
	public boolean getRequest(javax.servlet.http.HttpServletRequest newrequest) {
		boolean flag = false;
		try {
			request = newrequest;
			String ID = request.getParameter("userid");
			if (ID != null) {
				userid = 0;
				try {
					userid = Integer.parseInt(ID);
					user.setId(userid);
				} catch (Exception e) {
					message = message + "��Ҫ�޸ĵ��û��ų���";
				}
			}

			username = request.getParameter("username");
			if (username == null || username.equals("")) {
				username = "";
				message = message + "�û���Ϊ��!";
			}
			user.setUserName(getGbk(username));
			String password = request.getParameter("passwd");
			if (password == null || password.equals("")) {
				password = "";
				message = message + "����Ϊ��!";
			}
			String pwdconfirm = request.getParameter("passconfirm");
			if (!password.equals(pwdconfirm)) {
				message = message + "ȷ�����벻��ͬ!";
			}
			user.setPassWord(getGbk(password));
			String names = request.getParameter("names");
			;
			if (names == null) {
				names = "";
			}
			user.setNames(getGbk(names));
			String sex = request.getParameter("sex");
			user.setSex(getGbk(sex));
			String address = request.getParameter("address");
			if (address == null) {
				address = "";
			}
			user.setAddress(getGbk(address));
			String post = request.getParameter("post");
			if (post == null) {
				post = "";
			}
			user.setPost(getGbk(post));
			String phone = request.getParameter("phone");
			if (phone == null) {
				phone = "";
			}
			user.setPhone(phone);
			String email = request.getParameter("email");
			if (email == null) {
				email = "";
			}
			user.setEmail(getGbk(email));
			String IP = request.getRemoteAddr();
			user.setRegIpAddress(IP);
			if (message.equals("")) {
				flag = true;
			}
			return flag;
		} catch (Exception e) {
			return flag;
		}
	}

	// ��ѯ������е��û�
	public boolean get_alluser() throws Exception {
		sqlStr = "select count(*) from shop_user"; // ȡ����¼��
		int rscount = pageSize;
		try {
			DataBase db = new DataBase();
			db.connect();
			stmt = db.conn.createStatement();
			ResultSet rs1 = stmt.executeQuery(sqlStr);
			if (rs1.next())
				recordCount = rs1.getInt(1);
			rs1.close();
		} catch (SQLException e) {
			System.out.print("count:" + e.getMessage());
			return false;
		}
		// �趨�ж���pageCount
		if (recordCount < 1)
			pageCount = 0;
		else
			pageCount = (int) (recordCount - 1) / pageSize + 1;
		// ���鿴��ҳ�����Ƿ��ڷ�Χ��
		if (page < 1)
			page = 1;
		else if (page > pageCount)
			page = pageCount;
		rscount = (int) recordCount % pageSize; // ���һҳ��¼��
		// sqlΪ����ȡֵ
		sqlStr = "select  * from shop_user ";
		if (page == 1) {
			sqlStr = sqlStr + " order by Id desc limit 0," + pageSize;
		} else {
			sqlStr = sqlStr + " order by Id desc limit "
					+ (recordCount - pageSize * page) + ","
					+ (recordCount - pageSize * (page - 1));
		}
		try {
			DataBase db = new DataBase();
			db.connect();
			stmt = db.conn.createStatement();
			rs = stmt.executeQuery(sqlStr);
			userlist = new Vector();
			while (rs.next()) {
				user user = new user();
				user.setId(rs.getLong("id"));
				user.setUserName(rs.getString("username"));
				user.setPassWord(rs.getString("password"));
				user.setNames(rs.getString("names"));
				user.setSex(rs.getString("sex"));
				user.setAddress(rs.getString("address"));
				user.setPhone(rs.getString("Phone"));
				user.setPost(rs.getString("post"));
				user.setEmail(rs.getString("email"));
				user.setRegTime(rs.getString("regtime"));
				user.setRegIpAddress(rs.getString("RegIpaddress"));
				userlist.addElement(user);
			}
			rs.close();
			return true;
		} catch (SQLException e) {
			System.out.print(e.getMessage());
			return false;
		}

	}

	// �޸��û�
	public boolean update(HttpServletRequest req) throws Exception {
		if (getRequest(req)) {
			sqlStr = "update shop_user set ";
			sqlStr = sqlStr + "username = '"
					+ dataFormat.toSql(user.getUserName()) + "',";
			sqlStr = sqlStr + "password = '"
					+ dataFormat.toSql(user.getPassWord()) + "',";
			sqlStr = sqlStr + "Names = '" + dataFormat.toSql(user.getNames())
					+ "',";
			sqlStr = sqlStr + "sex = '" + dataFormat.toSql(user.getSex())
					+ "',";
			sqlStr = sqlStr + "address = '"
					+ dataFormat.toSql(user.getAddress()) + "',";
			sqlStr = sqlStr + "phone = '" + dataFormat.toSql(user.getPhone())
					+ "',";
			sqlStr = sqlStr + "post = '" + dataFormat.toSql(user.getPost())
					+ "',";
			sqlStr = sqlStr + "Email = '" + dataFormat.toSql(user.getEmail())
					+ "' ";
			sqlStr = sqlStr + " where id = '" + user.getId() + "'";
			try {
				DataBase db = new DataBase();
				db.connect();
				stmt = db.conn.createStatement();
				stmt.execute(sqlStr);
				return true;
			} catch (SQLException e) {
				return false;
			}
		} else {
			return false;
		}

	}

	// ɾ���û�
	public boolean delete(long aid) throws Exception {
		sqlStr = "delete from shop_user where id = " + aid;
		try {
			DataBase db = new DataBase();
			db.connect();
			stmt = db.conn.createStatement();
			stmt.execute(sqlStr);
			return true;
		} catch (SQLException e) {
			System.out.println(e);
			return false;
		}
	}

	// ��ѯָ��id���û�������֧��ҳ��Ĳ鿴��ϸ��������
	public boolean getUserinfo(long newid) throws Exception {
		try {
			sqlStr = "select  * from shop_user where Id = " + newid;
			DataBase db = new DataBase();
			db.connect();
			stmt = db.conn.createStatement();
			rs = stmt.executeQuery(sqlStr);
			userlist = new Vector();
			while (rs.next()) {
				user.setId(rs.getLong("id"));
				System.out.print(rs.getLong("id"));
				user.setUserName(rs.getString("username"));
				user.setPassWord(rs.getString("password"));
				user.setNames(rs.getString("names"));
				user.setSex(rs.getString("sex"));
				user.setAddress(rs.getString("address"));
				user.setPhone(rs.getString("Phone"));
				user.setPost(rs.getString("post"));
				user.setEmail(rs.getString("email"));
				user.setRegTime(rs.getString("regtime"));
				user.setRegIpAddress(rs.getString("RegIpaddress"));
				userlist.addElement(user);
			}
			rs.close();
			return true;
		} catch (Exception e) {
			System.out.print(e.getMessage());
			return false;
		}
	}

	public String getGbk(String str) {
		try {
			return new String(str.getBytes("ISO8859-1"));
		} catch (Exception e) {
			return str;
		}
	}

	public int getPage() { // ��ʾ��ҳ��
		return page;
	}

	public void setPage(int newpage) {
		page = newpage;
	}

	public int getPageSize() { // ÿҳ��ʾ��ͼ����
		return pageSize;
	}

	public void setPageSize(int newpsize) {
		pageSize = newpsize;
	}

	public int getPageCount() { // ҳ������
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

	public String getMessage() {
		return message;
	}

	public void setMessage(String msg) {
		message = msg;
	}

	public void setUserid(int uid) {
		userid = uid;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserName(String uName) {
		username = uName;
	}

	public String getUserName() {
		return username;
	}

	public Vector getUserlist() {
		return userlist;
	}

};
