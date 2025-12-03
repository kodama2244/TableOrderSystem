package model.dto;

public class OrderHistoryDTO {
	private int productQuantity;
	private String priductName;
	private String statusName;
	private String optionName;
	private int tableNumber;
	public int getProductQuantity() {
		return productQuantity;
	}
	public void setProductQuantity(int productQuantity) {
		this.productQuantity = productQuantity;
	}
	public String getPriductName() {
		return priductName;
	}
	public void setPriductName(String priductName) {
		this.priductName = priductName;
	}
	public String getStatusName() {
		return statusName;
	}
	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
	public String getOptionName() {
		return optionName;
	}
	public void setOptionName(String optionName) {
		this.optionName = optionName;
	}
	public int getTableNumber() {
		return tableNumber;
	}
	public void setTableNumber(int tableNumber) {
		this.tableNumber = tableNumber;
	}
	
}
