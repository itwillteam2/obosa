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
	
	public int insertLiving(LivingVO livingVO) {
		int NUM = livingDAO.insertLivingNewArticle(livingVO);
		return NUM;
	}

}
