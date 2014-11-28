package netshop.book.bean;
/**
 * <p>订单类 </p>
 * @author longlyboyhe
 */
public class order {
        private long Id;			//ID序列号
        private String orderId;		        //订单编号
        private long UserId;			//用户序列号
        private String SubmitTime;		//提交订单时间
        private String ConsignmentTime;         //交货时间
        private float TotalPrice;		//总金额
        private String content;		        //用户备注
        private String IPAddress;		//下单时IP
        private boolean IsPayoff;		//用户是否已付款
        private boolean IsSales;		//是否已发货

        public order() {
                Id = 0;
                orderId = "";
                UserId = 0;
                SubmitTime = "";
                ConsignmentTime = "";
                TotalPrice = 0;
                content = "";
                IPAddress = "";
                IsPayoff = false;
                IsSales = false;
        }
        public long getId() {
                return Id;
        }
        public void setId(long newId){
                this.Id = newId;
        }
        public String getOrderId() {
                return orderId;
        }
        public void setOrderId(String neworderId) {
                this.orderId = neworderId;
        }
        public long getUserId() {
                return UserId;
        }
        public void setUserId(long newUserId){
                this.UserId = newUserId;
        }
        public String getSubmitTime() {
                return SubmitTime;
        }
        public void setSubmitTime(String newSubmitTime) {
                this.SubmitTime = newSubmitTime;
        }
        public String getConsignmentTime() {
                return ConsignmentTime;
        }
        public void setConsignmentTime(String con_time) {
                ConsignmentTime = con_time;
        }
        public float getTotalPrice() {
                return TotalPrice;
        }
        public void setTotalPrice(float newTotalPrice){
                this.TotalPrice = newTotalPrice;
        }
        public String getContent() {
                return content;
        }
        public void setContent(String newContent) {
                this.content = newContent;
        }
        public String getIPAddress() {
                return IPAddress;
        }
        public void setIPAddress(String newIPAddress) {
                this.IPAddress = newIPAddress;
        }
        public boolean getIsPayoff() {
                return IsPayoff;
        }
        public void setIsPayoff(boolean newIsPayoff){
                this.IsPayoff = newIsPayoff;
        }
        public boolean getIsSales() {
                return IsSales;
        }
        public void setIsSales(boolean newIsSales){
                this.IsSales = newIsSales;
        }
}

