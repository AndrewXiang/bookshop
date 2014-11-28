package netshop.book.bean;

/**
 * <p>图书类 </p>
 * @author longlyboyhe
 */

public class book {
        private long Id;		//ID序列号
        private String BookName;	//书名
        private int BookClass;		//图书类别
        private String classname ;  //图书类别名
        private String Author;		//作者
        private String Publish;		//出版社
        private String BookNo ;		//书号
        private String Content ;	//内容介绍
        private float Prince ;		//书价
        private int Amount ;		//总数量
        private int Leav_number ;	//剩余数量
        private String RegTime ;	//登记时间
        private String picture ;	//图书样图文件的名称
        /**
         * 图书的初始化
         */
        public book() {
                Id = 0;
                BookName = "";
                BookClass = 0;
                classname = "";
                Author = "";
                Publish = "";
                BookNo = "";
                Content = "";
                Prince = 0;
                Amount = 0;
                Leav_number = 0;
                RegTime = "";
        }
        public void setId(long newId){
                this.Id = newId;
        }
        public long getId(){
                return Id;
        }
        public void setBookName(String newBookName) {
                this.BookName = newBookName;
        }
        public String getBookName() {
                return BookName;
        }
        public void setBookClass(int newBookClass) {
                this.BookClass = newBookClass;
        }
        public int getBookClass() {
                return BookClass;
        }
        public void setClassname(String cname) {
                this.classname = cname;
        }
        public String getClassname() {
                return classname;
        }
        public void setAuthor(String newAuthor) {
                this.Author = newAuthor;
        }
        public String getAuthor() {
                return Author;
        }
        public void setBookNo(String newBookNo) {
                this.BookNo = newBookNo;
        }
        public String getBookNo() {
                return BookNo;
        }
        public void setPublish(String newPublish) {
                this.Publish = newPublish;
        }
        public String getPublish() {
                return Publish;
        }
        public void setContent(String newContent) {
                this.Content= newContent;
        }
        public String getContent() {
                return Content;
        }
        public void setPrince(float newPrince) {
                this.Prince = newPrince;
        }
        public float getPrince() {
                return Prince;
        }
        public void setAmount(int newAmount) {
                this.Amount = newAmount;
        }
        public long getAmount() {
                return Amount;
        }
        public void setLeav_number(int newLeav_number) {
                this.Leav_number = newLeav_number;
        }
        public int getLeav_number() {
                return Leav_number;
        }
        public void setRegTime(String newRegTime) {
                this.RegTime = newRegTime;
        }
        public String getRegTime() {
                return RegTime;
        }
        public void setPicture(String newPicture) {
               this.picture = newPicture;
       }
       public String getPicture() {
               return picture;
       }

};
