package netshop.book.bean;
/**
 * <p>���ﳵ��</p>
 * @author longlyboyhe
 */
public class shopcart {

 private long bookId;		//ͼ��ID���
 private int quanlity;		//ѡ������

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