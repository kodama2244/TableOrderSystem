package viewmodel;

import java.io.Serializable;
import java.util.List;

import model.dto.ProductOptionDTO;

public class MenuViewModel implements Serializable {
    private List<ProductOptionDTO> products;

    public MenuViewModel() {}

    public List<ProductOptionDTO> getProducts() {
        return products;
    }

    public void setProducts(List<ProductOptionDTO> products) {
        this.products = products;
    }
}