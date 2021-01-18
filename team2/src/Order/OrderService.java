package Order;

import java.util.ArrayList;
import java.util.List;

public class OrderService {
	OrderDAO dao = new OrderDAO();
	OrderVO vo = new OrderVO();
	
	public void addOrder(OrderVO vo){
		dao.addOrder(vo);
	}
}
