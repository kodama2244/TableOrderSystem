package viewmodel;

import java.io.Serializable;
import java.util.List;

import model.dto.OrderHistoryDTO;

public class KitchenHallViewModel implements Serializable {
	private List<OrderHistoryDTO> orderHistorys;
	public KitchenHallViewModel() {}

	public List<OrderHistoryDTO> getOrderHistorys() {
		return orderHistorys;
	}

	public void setOrderHistorys(List<OrderHistoryDTO> orderHistorys) {
		this.orderHistorys = orderHistorys;
	}
}
