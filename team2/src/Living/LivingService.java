package Living;

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
	
	public Map listArticles(Map<String, Integer> paingMap){
		Map livingListMap = new HashMap();
		List<LivingVO> livingList = livingDAO.selectAllArticles(paingMap);
		
		livingListMap.put("livingList", livingList);		
		
		return livingListMap;
		
	}
	
	public int addLiving(LivingVO livingVO) {
		return livingDAO.addLiving(livingVO);
	}
	
	public int insertLiving(LivingVO livingVO) {
		int num = livingDAO.insertLivingNewArticle(livingVO);
		return num;
	}
	
	public Map<String, Object> livingDetailProduct(int productNum){
		return null;
		
	}

	public LivingVO viewContent(int num) {
		LivingVO content = null;
		content = livingDAO.selectContent(num);
		return content;
	}

	public int addReply(LivingRepVO  livingRepVO){

		return livingDAO.insertNewReply(livingRepVO);
		 
	}
	
}