package netshop.book.bean;
/**
 * <p>图书分类类</p>
 * @author longlyboyhe
 */
public class bookclass {
        private int Id;			    //ID序列号
        private String ClassName;	//图书类别
        public bookclass() {
                Id = 0;
                ClassName = "";
              }
        public bookclass(int newId, String newname) {
                Id = newId;
                ClassName = newname;
              }
        public int getId() {
                return Id;
              }
        public void setId (int newId) {
                this.Id = newId;
              }
        public String getClassName() {
                return ClassName;
             }
        public void setClassName(String newname) {
                this.ClassName = newname;
            }
}
