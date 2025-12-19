package viewmodel;

import java.util.List;

import model.dto.TableListDTO;

public class TableListViewModel {
    private List<TableListDTO> tableList;

    public List<TableListDTO> getTableList() {
        return tableList;
    }

    public void setTableList(List<TableListDTO> tableList) {
        this.tableList = tableList;
    }
}
