package netshop.book.service;

/**
 * <p>����ͼ����࣬����ͼ����޸ġ���ѯ��ɾ������� </p>
 * @author longlyboyhe
 */
import java.sql.*;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;

import netshop.book.bean.*;
import netshop.book.util.*;

public class manage_book extends DataBase {
	private book abooks = new book(); // �µ�ͼ����
	private javax.servlet.http.HttpServletRequest request; // ����ҳ������
	private boolean sqlflag = true; // �Խ��յ��������Ƿ���ȷ
	private Vector booklist; // ��ʾͼ���б���������
	private int page = 1; // ��ʾ��ҳ��
	private int pageSize = 10; // ÿҳ��ʾ��ͼ����
	private int pageCount = 0; // ҳ������
	private long recordCount = 0; // ��ѯ�ļ�¼����
	public String sqlStr = "";

	public Vector getBooklist() {
		return booklist;
	}

	public boolean getSqlflag() {
		return sqlflag;
	}

	public String to_String(String str) {
		try {
			return new String(str.getBytes("ISO8859-1"));
		} catch (Exception e) {
			return str;
		}
	}

	/**
	 * ��ҳ������������Ϸֽ�
	 */
	public boolean getRequest(javax.servlet.http.HttpServletRequest newrequest) {
		boolean flag = false;
		try {
			request = newrequest;
			String ID = request.getParameter("id");
			long bookid = 0;
			try {
				bookid = Long.parseLong(ID);
			} catch (Exception e) {
			}
			abooks.setId(bookid);
			String bookname = request.getParameter("bookname");
			if (bookname == null || bookname.equals("")) {
				bookname = "";
				sqlflag = false;
			}
			abooks.setBookName(to_String(bookname));
			String author = request.getParameter("author");
			if (author == null || author.equals("")) {
				author = "";
				sqlflag = false;
			}
			abooks.setAuthor(to_String(author));
			String publish = request.getParameter("publish");
			;
			if (publish == null) {
				publish = "";
			}
			abooks.setPublish(to_String(publish));
			String bookclass = request.getParameter("bookclass");
			int bc = Integer.parseInt(bookclass);
			abooks.setBookClass(bc);
			String bookno = request.getParameter("bookno");
			if (bookno == null) {
				bookno = "";
			}
			abooks.setBookNo(to_String(bookno));
			String picture = request.getParameter("picture");
			if (picture == null) {
				picture = "images/01.gif";
			}
			abooks.setPicture(to_String(picture));
			float price;
			try {
				price = new Float(request.getParameter("price")).floatValue();
			} catch (Exception e) {
				price = 0;
				sqlflag = false;
			}
			abooks.setPrince(price);
			int amount;
			try {
				amount = new Integer(request.getParameter("amount")).intValue();
			} catch (Exception e) {
				sqlflag = false;
				amount = 0;
			}
			abooks.setAmount(amount);
			String content = request.getParameter("content");
			if (content == null) {
				content = "";
			}
			abooks.setContent(to_String(content));
			if (sqlflag) {
				flag = true;
			}
			return flag;
		} catch (Exception e) {
			return flag;
		}
	}

	/**
	 * ��ò�ѯͼ������sql���
	 * 
	 * @return
	 */
	public String getSql() {
		sqlStr = "select id,classname from book order by id";
		return sqlStr;
	}

	/**
	 * ���ͼ���ѯ���������࣬��ҳ��ѯ
	 * 
	 * @param res
	 * @return
	 * @throws java.lang.Exception
	 */
	public boolean book_search(HttpServletRequest res) throws Exception {
		DataBase db = new DataBase();
		Connection conn = db.connect();
		Statement stmt = conn.createStatement();
		request = res;
		String PAGE = request.getParameter("page"); // ҳ��
		String classid = request.getParameter("classid"); // ����ID��
		String keyword = request.getParameter("keyword"); // ��ѯ�ؼ���
		if (classid == null)
			classid = "";
		if (keyword == null)
			keyword = "";
		keyword = to_String(keyword).toUpperCase();
		try {
			page = Integer.parseInt(PAGE);
		} catch (NumberFormatException e) {
			page = 1;
		}
		// ȡ����¼��
		if (!classid.equals("") && keyword.equals("")) {
			sqlStr = "select count(*) from book where bookclass='" + classid
					+ "'";
		} else if (!keyword.equals("")) {
			if (classid.equals("")) {
				sqlStr = "select count(*) from book where upper(bookname) like '%"
						+ keyword
						+ "%' or upper(content) like '%"
						+ keyword
						+ "%'";
			} else {
				sqlStr = "select count(*) from book where bookclass='"
						+ classid + "'" + " and  (upper(bookname) like '%"
						+ keyword + "%' or " + "upper(content) like '%"
						+ keyword + "%')";
			}
		} else {
			sqlStr = "select count(*) from book";
		}
		int rscount = pageSize;
		try {
			ResultSet rs1 = stmt.executeQuery(sqlStr);
			if (rs1.next())
				recordCount = rs1.getInt(1);
			rs1.close();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
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
		sqlStr = "select   a.id,a.bookname,a.bookclass,b.classname,"
				+ "a.author,a.publish,a.bookno,a.content,a.prince,a.amount,"
				+ "a.Leav_number,a.regtime,a.picture from book a,bookclass b"
				+ " where a.Bookclass = b.Id ";
		if (!classid.equals("") && keyword.equals("")) { // ������Ϊ�գ��ǲ�ѯ
			if (page == 1) {
				sqlStr = sqlStr + " and a.bookclass='" + classid + "' "
						+ "order by a.Id desc";
			} else {
				sqlStr = sqlStr + " and a.bookclass='" + classid + "'";
			}
		} else if (!keyword.equals("")) { // ����ǲ�ѯ����
			if (page == 1) {
				if (!classid.equals("")) {// ��ѯĳһ��
					sqlStr = sqlStr + "and a.Bookclass='" + classid
							+ "' and (upper(a.bookname) like '%" + keyword
							+ "%' or upper(a.content) like '%" + keyword
							+ "%')  order by a.Id desc";
				} else { // ��ѯ������
					sqlStr = sqlStr + " and (upper(a.bookname) like '%"
							+ keyword + "%' or upper(a.content) like '%"
							+ keyword + "%') order by a.Id desc";
				}
			} else {
				if (!classid.equals("")) {
					sqlStr = sqlStr + " and a.Bookclass='" + classid + "'"
							+ " and (upper(a.bookname) like '%" + keyword
							+ "%'" + " or upper(a.content) like '%" + keyword
							+ "%')";
				} else {
					sqlStr = sqlStr + " and (upper(a.bookname) like '%"
							+ keyword + "%'" + " or upper(a.content) like '%"
							+ keyword + "%')";
				}
			}
		} else {// �ǲ�ѯ��Ҳ�Ƿ������
			if (page == 1) {
				sqlStr = sqlStr + "  order by a.Id desc";
			} else {
				sqlStr = sqlStr;
			}
		}
		try {
			rs = stmt.executeQuery(sqlStr);
			booklist = new Vector(rscount);
			while (rs.next()) {
				book book = new book();
				book.setId(rs.getLong("id"));
				book.setBookName(rs.getString("bookname"));
				book.setBookClass(rs.getInt("bookclass"));
				book.setClassname(rs.getString("classname"));
				book.setAuthor(rs.getString("author"));
				book.setPublish(rs.getString("publish"));
				book.setBookNo(rs.getString("Bookno"));
				book.setContent(rs.getString("content"));
				book.setPrince(rs.getFloat("prince"));
				book.setAmount(rs.getInt("amount"));
				book.setLeav_number(rs.getInt("leav_number"));
				book.setRegTime(rs.getString("regtime"));
				book.setPicture(rs.getString("picture"));
				booklist.addElement(book);
			}
			rs.close();
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
	}

	/**
	 * ���ͼ�����
	 * 
	 * @return
	 * @throws java.lang.Exception
	 */
	public boolean insert() throws Exception {
		sqlStr = "insert into book (Bookname,Bookclass,Author,Publish,Bookno,"
				+ "Content,Prince,Amount,Leav_number,Regtime,picture) values ('";
		sqlStr = sqlStr + dataFormat.toSql(abooks.getBookName()) + "','";
		sqlStr = sqlStr + abooks.getBookClass() + "','";
		sqlStr = sqlStr + dataFormat.toSql(abooks.getAuthor()) + "','";
		sqlStr = sqlStr + dataFormat.toSql(abooks.getPublish()) + "','";
		sqlStr = sqlStr + dataFormat.toSql(abooks.getBookNo()) + "','";
		sqlStr = sqlStr + dataFormat.toSql(abooks.getContent()) + "','";
		sqlStr = sqlStr + abooks.getPrince() + "','";
		sqlStr = sqlStr + abooks.getAmount() + "','";
		sqlStr = sqlStr + abooks.getAmount() + "',";
		sqlStr = sqlStr + "now()" + ",'";
		sqlStr = sqlStr + abooks.getPicture() + "')";
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

	/**
	 * ���ͼ���޸�
	 * 
	 * @return
	 * @throws java.lang.Exception
	 */
	public boolean update() throws Exception {
		sqlStr = "update book set ";
		sqlStr = sqlStr + "bookname = '"
				+ dataFormat.toSql(abooks.getBookName()) + "',";
		sqlStr = sqlStr + "bookclass = '" + abooks.getBookClass() + "',";
		sqlStr = sqlStr + "Author = '" + dataFormat.toSql(abooks.getAuthor())
				+ "',";
		sqlStr = sqlStr + "publish = '" + dataFormat.toSql(abooks.getPublish())
				+ "',";
		sqlStr = sqlStr + "bookno = '" + dataFormat.toSql(abooks.getBookNo())
				+ "',";
		sqlStr = sqlStr + "content = '" + dataFormat.toSql(abooks.getContent())
				+ "',";
		sqlStr = sqlStr + "prince = '" + abooks.getPrince() + "',";
		sqlStr = sqlStr + "Amount = '" + abooks.getAmount() + "',";
		sqlStr = sqlStr + "leav_number = '" + abooks.getLeav_number() + "' ,";
		sqlStr = sqlStr + "picture = '" + abooks.getPicture() + "' ";
		sqlStr = sqlStr + "where id = " + abooks.getId();
		try {
			DataBase db = new DataBase();
			db.connect();
			stmt = db.conn.createStatement();
			stmt.execute(sqlStr);
			return true;
		} catch (SQLException e) {
			System.out.print(e.getMessage());
			return false;
		}

	}

	/**
	 * ���ͼ��ɾ��
	 * 
	 * @param aid
	 * @return
	 * @throws java.lang.Exception
	 */
	public boolean delete(int aid) throws Exception {
		sqlStr = "delete from book where id = " + aid;
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

	/**
	 * ���ͼ�鵥����ѯ������֧��ҳ��Ĳ鿴ͼ����ϸ����
	 * 
	 * @param newid
	 * @return
	 * @throws java.lang.Exception
	 */
	public boolean getOnebook(int newid) throws Exception {
		DataBase db = new DataBase();
		Connection conn = db.connect();
		stmt = conn.createStatement();
		try {
			sqlStr = "select  a.id,a.bookname,a.bookclass,b.classname,a.author,"
					+ "a.publish,a.bookno,a.content,a.prince,a.amount,a.Leav_number,"
					+ "a.regtime,a.picture from book a,bookclass b where a.Bookclass="
					+ "b.Id and a.Id = " + newid;
			rs = stmt.executeQuery(sqlStr);
			if (rs.next()) {
				booklist = new Vector(1);
				book book = new book();
				book.setId(rs.getLong("id"));
				book.setBookName(rs.getString("bookname"));
				book.setBookClass(rs.getInt("bookclass"));
				book.setClassname(rs.getString("classname"));
				book.setAuthor(rs.getString("author"));
				book.setPublish(rs.getString("publish"));
				book.setBookNo(rs.getString("Bookno"));
				book.setContent(rs.getString("content"));
				book.setPrince(rs.getFloat("prince"));
				book.setAmount(rs.getInt("amount"));
				book.setLeav_number(rs.getInt("leav_number"));
				book.setRegTime(rs.getString("regtime"));
				book.setPicture(rs.getString("picture"));
				booklist.addElement(book);
			} else {
				rs.close();
				return false;
			}
			rs.close();
			return true;
		} catch (SQLException e) {
			return false;
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

	public manage_book() {}
}