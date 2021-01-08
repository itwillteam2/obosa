package Living;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LivingService {
	
	LivingDAO livingDAO;
	LivingVO livingVO;
	
	public LivingService() {
		livingDAO = new LivingDAO();
		livingVO = new LivingVO();
	}	
	
	 public List<LivingVO> ContentList() {
		  List<LivingVO> livingList = new ArrayList<LivingVO>();
		  livingList = livingDAO.getAllContents();
		  return livingList;
	  }//end
	
	public LivingVO  ContentDetail(int livingNum){
		LivingVO livingVO = livingDAO.getContent(livingNum);
		return livingVO;
	}//end
	
	public int totalCount() {
		int totalCount = livingDAO.getTotalCount();
		return totalCount;
	}//end
	
	
	public int insertContent(LivingVO livingVO) {
		return livingDAO.insertContent(livingVO);
	}//end
	

	public int addReply(LivingRepVO  livingRepVO){
		return livingDAO.insertNewReply(livingRepVO);
	}//end
	
}