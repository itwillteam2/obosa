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
	
	public Map<String,Object> detailLiving(int livingNum){
		
		Map<String, Object> livingMap = new HashMap<String, Object>();
		
		LivingVO livingVO = livingDAO.getLiving(livingNum);
		livingMap.put("livingVO", livingVO);
		
		return livingMap;
	}

	
	  public List<LivingVO> livingList() {
		  List<LivingVO> livingList = new ArrayList<LivingVO>();
		  livingList = livingDAO.selectAllArticles();
		  return livingList;
	  }
	 
	
	public int totalCountList() {
		int totalCountList = livingDAO.selectTotalCount();
		
		
		return totalCountList;
	}
	
	/*
	 * public List listArticles(Map<String, Integer> paingMap){ Map livingListMap =
	 * new HashMap(); List<LivingVO> livingList =
	 * livingDAO.selectAllArticles(paingMap);
	 * 
	 * livingListMap.put("livingList", livingList);
	 * 
	 * return livingListMap;
	 * 
	 * }
	 */
	public int addLiving(LivingVO livingVO) {
		return livingDAO.addLiving(livingVO);
	}
	
	public int insertLiving(LivingVO livingVO) {
		int num = livingDAO.addLiving(livingVO);
		return num;
	}
	
	public Map<String, Object> livingDetailProduct(int productNum){
		return null;
		
	}

	public LivingVO viewContent(int num) {
		LivingVO content = null;
		content = livingDAO.selectContent(num);
		System.out.println("hello"+content.getNum());
		return content;
	}

	public int addReply(LivingRepVO  livingRepVO){

		return livingDAO.insertNewReply(livingRepVO);
		 
	}
	
}