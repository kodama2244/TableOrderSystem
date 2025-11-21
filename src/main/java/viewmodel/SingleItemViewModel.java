package viewmodel;

import java.io.Serializable;
import java.util.List;

import model.dto.ProductOptionDTO;

public class SingleItemViewModel implements Serializable {
    private List<ProductOptionDTO> products;

    public SingleItemViewModel() {}

    public List<ProductOptionDTO> getProducts() {
        return products;
    }

    public void setProducts(List<ProductOptionDTO> products) {
        this.products = products;
    }

}
