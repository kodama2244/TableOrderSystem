package viewmodel;

import java.io.Serializable;
import java.util.List;

import model.dto.categoryDTO;

public class categoryViewModel implements Serializable {
    private List<categoryDTO> category;

    public categoryViewModel() {}

    public List<categoryDTO> getCategory() {
        return category;
    }

    public void setCategory(List<categoryDTO> products) {
        this.category = products;
    }
}
