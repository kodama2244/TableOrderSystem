package database;

import java.util.ArrayList;
import java.util.List;

import model.dto.OrderDTO;

public class OrderDAO {

    // ★ 仮データ（本番はDB接続）
    public List<OrderDTO> findByTableNumber(int tableNumber) {

      List<OrderDTO> list = new ArrayList<>();

      // --- 仮データ1 ---
      OrderDTO o1 = new OrderDTO();
      o1.setOrderName("きつねうどん");
      o1.setStock(2);
      o1.setPrice(800);
      o1.setOrderStatus("提供済み");
      list.add(o1);

      // --- 仮データ2 ---
      OrderDTO o2 = new OrderDTO();
      o2.setOrderName("コーラ");
      o2.setStock(1);
      o2.setPrice(300);
      o2.setOrderStatus("提供前");
      list.add(o2);

      // --- 仮データ3 ---
      OrderDTO o3 = new OrderDTO();
      o3.setOrderName("生ビール");
      o3.setStock(1);
      o3.setPrice(500);
      o3.setOrderStatus("提供済み");
      list.add(o3);
      
      // --- 仮データ4 ---
      OrderDTO o4 = new OrderDTO();
      o4.setOrderName("漬物");
      o4.setStock(1);
      o4.setPrice(100);
      o4.setOrderStatus("提供中");
      list.add(o4);

      return list;
  }

    // ★ 会計済にするメソッド
    public void updateStatusToPaid(int tableNumber) {
        List<OrderDTO> list = findByTableNumber(tableNumber);

        if (list == null) {
        	return;
        }

        for (OrderDTO o : list) {
            o.setOrderStatus("会計済");
        }
    }
}
