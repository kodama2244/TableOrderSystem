package model.service;

import java.util.List;

import database.TableDAO;
import model.dto.TableListDTO;
import viewmodel.TableListViewModel;

public class TableListService {

    private TableDAO dao = new TableDAO();

    public TableListViewModel getTableList() {

        // ================================
        // データベースからリストを取得
        // ================================
        List<TableListDTO> list = dao.getAllTables();
        
        // 確認用ログ
        System.out.println("DBから取得した件数: " + list.size());
        for(TableListDTO dto : list) {
            System.out.println(dto.getTableNumber() + "卓: " + (dto.isHasCustomer() ? "利用中" : "空き"));
        }

        // ViewModel にセット
        TableListViewModel vm = new TableListViewModel();
        vm.setTableList(list);

        return vm;
    }
}