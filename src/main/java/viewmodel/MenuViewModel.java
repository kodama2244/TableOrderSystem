package viewmodel;

public class MenuViewModel {
	String productName;
	int productPrice;
	String productImage;

	public MenuViewModel() {
	}

	public MenuViewModel(String productName, int productPrice, String productImage) {
		this.productName = productName;
		this.productPrice = productPrice;
		this.productImage = productImage;
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

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

}
