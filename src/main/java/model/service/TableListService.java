package model.service;

import java.util.ArrayList;
import java.util.List;

import model.dto.TableListDTO;
import viewmodel.TableListViewModel;

public class TableListService {

    public TableListViewModel getTableList() {

        // ================================
        // 元の仮データ（全席空き）
        // ================================
    		
        /*
        List<TableDTO> list = new ArrayList<>();
        for (int i = 1; i <= 16; i++) {
            TableDTO dto = new TableDTO();
            dto.setTableNumber(i);
            
            dto.setHasCustomer(false);  // とりあえず全席空き
            
            list.add(dto);
        }
        */

        // ================================
        // 元の仮データ（1,16卓使用例）
        // ================================
    		
        List<TableListDTO> list = new ArrayList<>();
        
        for (int i = 1; i <= 16; i++) {
            TableListDTO dto = new TableListDTO();
            dto.setTableNumber(i);

            if (i == 1 || i == 16) {
                dto.setHasCustomer(true);   // 使用中
            } else {
                dto.setHasCustomer(false);  // 空席
            }
            
            //確認用
            System.out.println("TableListDTO " + (i) + "卓 : " + dto.isHasCustomer());

            list.add(dto);
        }
        
        System.out.println("==============================");

        // ViewModel にセット
        TableListViewModel vm = new TableListViewModel();
        vm.setTableList(list);

        return vm;
    }
}
