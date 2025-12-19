package model.dto;

public class OrderDTO {
	 private int orderId;
   private String orderName;
   private int price;
   private int stock;
   private String orderStatus;

   public int getOrderId() {  
  	 return orderId; 
   }
   
   public void setOrderId(int orderId) {
  	 this.orderId = orderId; 
   }

   public String getOrderName() {
  	 return orderName;
   }
   public void setOrderName(String orderName) {
  	 this.orderName = orderName;
   }

   public int getPrice() {
  	 return price;
   }
   
   public void setPrice(int price) {
  	 this.price = price;
   }

   public int getStock() {
  	 return stock;
   }
   
   public void setStock(int stock) {
  	 this.stock = stock;
   }

   public String getOrderStatus() {
  	 return orderStatus;
   }
   
   public void setOrderStatus(String orderStatus) {
  	 this.orderStatus = orderStatus;
   }
}
