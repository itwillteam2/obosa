package Cart;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



public class CartService {
	CartDAO dao = new CartDAO();
	
	public List<CartVO> getCart(String customer_id) {
		List<CartVO> cartList = new ArrayList<CartVO>();
		cartList = dao.getAllCartContent(customer_id);
		return cartList;
	}//end
		
	public int totalCount(String customer_id) {
		int totalCount = dao.getTotalCount(customer_id);
		return totalCount;
	}//end
	
	public int insertContent(int pnum, String category, String customer_id, int cartQuantity) {
		return dao.insertContent(pnum,category,customer_id,cartQuantity);
	}//end
	
	public int updateContent(int pnum, String category, String customer_id, int cartQuantity, int totalPrice) {
		return dao.updateContent(pnum,category,customer_id,cartQuantity,totalPrice);
	}//end
	
	public int deleteContent(int pnum, String category, String customer_id) {
		return dao.deleteContent(pnum,category,customer_id);
	}//end
	

	
	


}
