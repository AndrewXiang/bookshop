package netshop.book.service;

/**
 * <p>����ͼ�������ࣺ��������Ĳ�ѯ�����ӡ�ɾ�� </p>
 */
import java.util.*;
import java.sql.*;
import java.lang.String;
import javax.servlet.http.HttpServletRequest;

import netshop.book.bean.*;
import netshop.book.util.*;

public class manage_bookclass extends DataBase {
	public manage_bookclass() {
	}

	private bookclass bookclass = new bookclass(); // �µ�ͼ�����
	private javax.servlet.http.HttpServletRequest request; // ����ҳ������
	private Vector classlist; // ͼ�������������

	public Vector getClasslist() {
		return classlist;
	}

	public String getBookClassSql() {
		sqlStr = "select id,classname from bookclass order by id";
		return sqlStr;
	}

	// ��ѯͼ�����
	public boolean seachBookClass() throws Exception {
		int id = 0;
		String classname = "";
		int rscount = 0;
		try {
			DataBase db = new DataBase();
			Connection conn = db.connect();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(getBookClassSql());
			rscount = stmt.getMaxRows();
			classlist = new Vector(rscount + 1);
			classlist.clear();
			while (rs.next()) {
				id = rs.getInt("id");
				classname = rs.getString("classname");
				bookclass bc = new bookclass(id, classname);
				classlist.addElement(bc);
			}
			rs.close();
			return true;
		} catch (SQLException sqle) {
			System.out.println(sqle);
			return false;
		}
	}

	// �����ͼ�����ʱ���ҳ��ת�ݵķ�������
	public boolean getRequest(javax.servlet.http.HttpServletRequest newrequest) {
		boolean flag = false;
		try {
			request = newrequest;
			String bookclassname = request.getParameter("bookclassname");
			if (bookclassname == null || bookclassname.equals("")) {
				bookclassname = "";
				flag = false;
			}
			bookclass.setClassName(bookclassname);
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	// ����µ�ͼ�����
	public boolean insert() throws Exception {
		sqlStr = "insert into bookclass (classname) values ('";
		sqlStr = sqlStr + dataFormat.toSql(bookclass.getClassName()) + "')";
		try {
			System.out.print(sqlStr);
			DataBase db = new DataBase();
			Connection conn = db.connect();
			stmt = conn.createStatement();
			stmt.execute(sqlStr);
			return true;
		} catch (SQLException sqle) {
			System.out.print(sqle.getMessage());
			return false;
		}
	}

	// ɾ���µ�ͼ�����
	public boolean delete(int aid) throws Exception {
		sqlStr = "delete from bookclass where id = " + aid;
		try {
			DataBase db = new DataBase();
			Connection conn = db.connect();
			stmt = conn.createStatement();
			stmt.execute(sqlStr);
			return true;
		} catch (SQLException e) {
			System.out.println(e);
			return false;
		}
	}
};

