package viewmodel;

import java.io.Serializable;
import java.util.List;

import model.dto.categoryDTO;

public class CategoryViewModel implements Serializable {
    private List<categoryDTO> category;

    public CategoryViewModel() {}

    public List<categoryDTO> getCategory() {
        return category;
    }

    public void setCategory(List<categoryDTO> products) {
        this.category = products;
    }
}
