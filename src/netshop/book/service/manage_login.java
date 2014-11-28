package netshop.book.service;
/**
 * <p>管理用户登录的类 </p>
 * @author longlyboyhe
 */

import java.sql.Connection;
import java.sql.Statement;

import netshop.book.util.*;
public class manage_login extends DataBase {
        private String username;	//登录用户名
        private String passwd;		//登录密码
        private boolean isadmin;	//是否管理员登录
        private long userid=0;		//用户ID号
        public manage_login() throws Exception{
            super();
            username = "";
            passwd = "";
            isadmin = false;
         }
         public String getUsername() {
                 return username;
         }
         public void setUsername(String newusername) {
                 username = newusername;
         }
         public String getPasswd() {
                 return passwd;
         }
         public void setPasswd(String newpasswd) {
                 passwd = newpasswd;
         }
         public boolean getIsadmin() {
                 return isadmin;
         }
         public void setIsadmin(boolean newIsadmin) {
                 isadmin = newIsadmin;
         }
         public long getUserid() {
                 return userid;
         }
         public void setUserid (long uid) {
                 userid = uid;
         }
        /**
         * 获得查询用户信息的sql语句
         * @return
         */
        public String getSql() {
            if (isadmin) {
                    sqlStr = "select * from bookadmin where adminuser = '" +
                    dataFormat.toSql(username) + "' and adminpass = '" +
                    dataFormat.toSql(passwd) + "'";
            }else {
                    sqlStr = "select * from shop_user where username = '" +
                        username + "' and password = '" + passwd + "'";
            }
            return sqlStr;
        }
        /**
         * 执行查询
         * @return
         * @throws java.lang.Exception
         */
        public boolean excute() throws Exception 
		{
		      
                boolean flag = false;
                DataBase db = new DataBase();
                Connection conn=db.connect();
                Statement stmt = conn.createStatement();
                rs = stmt.executeQuery(getSql());
                if (rs.next()){
                        if (!isadmin)
                        {
                          userid = rs.getLong("id");
                        }
                        flag = true;
                }
                rs.close();
                return flag;
				
		        }
}

