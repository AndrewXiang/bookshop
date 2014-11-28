package netshop.book.service;

/**
 * <p>管理用户类 </p>
 * @version 1.0
 */
import java.sql.*;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;

import netshop.book.bean.*;
import netshop.book.util.*;

public class manage_user extends DataBase {
	private user user = new user(); // 新的用户对象
	private javax.servlet.http.HttpServletRequest request; // 建立页面请求
	private Vector userlist; // 显示用户列表向量数组
	private int page = 1; // 显示的页码
	private int pageSize = 8; // 每页显示的图书数
	private int pageCount = 0; // 页面总数
	private long recordCount = 0; // 查询的记录总数
	private String message = ""; // 出错信息提示
	private String username = ""; // 注册后返回的用户名
	private int userid = 0; // 注册后返回的用户ID

	public manage_user() {
	}

	// 添加新用户
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

	// 分析页面转递的参数
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
					message = message + "你要修改的用户号出错！";
				}
			}

			username = request.getParameter("username");
			if (username == null || username.equals("")) {
				username = "";
				message = message + "用户名为空!";
			}
			user.setUserName(getGbk(username));
			String password = request.getParameter("passwd");
			if (password == null || password.equals("")) {
				password = "";
				message = message + "密码为空!";
			}
			String pwdconfirm = request.getParameter("passconfirm");
			if (!password.equals(pwdconfirm)) {
				message = message + "确认密码不相同!";
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

	// 查询书店所有的用户
	public boolean get_alluser() throws Exception {
		sqlStr = "select count(*) from shop_user"; // 取出记录数
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
		// 设定有多少pageCount
		if (recordCount < 1)
			pageCount = 0;
		else
			pageCount = (int) (recordCount - 1) / pageSize + 1;
		// 检查查看的页面数是否在范围内
		if (page < 1)
			page = 1;
		else if (page > pageCount)
			page = pageCount;
		rscount = (int) recordCount % pageSize; // 最后一页记录数
		// sql为倒序取值
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

	// 修改用户
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

	// 删除用户
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

	// 查询指定id的用户，用于支持页面的查看详细资料请求
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

	public int getPage() { // 显示的页码
		return page;
	}

	public void setPage(int newpage) {
		page = newpage;
	}

	public int getPageSize() { // 每页显示的图书数
		return pageSize;
	}

	public void setPageSize(int newpsize) {
		pageSize = newpsize;
	}

	public int getPageCount() { // 页面总数
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
