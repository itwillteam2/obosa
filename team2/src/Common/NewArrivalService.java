package Common;

import java.util.ArrayList;
import java.util.List;

public class NewArrivalService {
	
	NewArrivalDAO NewArrivalDAO;
	
	public NewArrivalService() {
		NewArrivalDAO = new NewArrivalDAO();
	}
	
	public List<NewArrrivalVO> NewArrivalList() {
		List<NewArrrivalVO> NewArrivalList = new ArrayList<NewArrrivalVO>();
		NewArrivalList = NewArrivalDAO.NewArrivalList();
		  return NewArrivalList;
	}

}
