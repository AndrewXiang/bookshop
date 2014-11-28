package netshop.book.bean;
/**
 * <p>购物车类</p>
 * @author longlyboyhe
 */
public class shopcart {

 private long bookId;		//图书ID编号
 private int quanlity;		//选购数量

 public shopcart(){
   bookId = 0;
   quanlity = 0;
  }
  public long getBookId() {
   return bookId;
  }
  public void setBookId(long newbookId) {
   bookId = newbookId;
  }
  public long getQuality() {
   return quanlity;
  }
  public void setQuanlity(int newquanlity) {
   quanlity = newquanlity;
  }
}