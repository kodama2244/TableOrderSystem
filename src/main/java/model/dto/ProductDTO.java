package model.dto;

public class ProductDTO {
	private int productId;
	private String productName;
	private int productPrice;
	private int category;
	private String productImage;
	private String productDescription;
	private String productAllergy;
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public String getProductImage() {
		return productImage;
	}
	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}
	public String getProductDescription() {
		return productDescription;
	}
	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}
	public String getProductAllergy() {
		return productAllergy;
	}
	public void setProductAllergy(String productAllergy) {
		this.productAllergy = productAllergy;
	}
	
}
