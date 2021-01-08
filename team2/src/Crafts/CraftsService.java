package Crafts;

import java.util.ArrayList;
import java.util.List;

public class CraftsService {

	CraftsVO craftsVO;	
	CraftsDAO craftsDAO;
	
	
	public CraftsService() {
	
		craftsVO = new CraftsVO();
		craftsDAO = new CraftsDAO();
	}
	
	public List<CraftsVO> craftsList(){
		
		List<CraftsVO> craftsList = new ArrayList<CraftsVO>();
		craftsList = craftsDAO.selectAllArticles();
		return craftsList;
	}

	public int totalCountList() {
		int totalCountList = craftsDAO.selectTotalCount();
		
		return totalCountList;
		
	}

	public int insertCrafts(CraftsVO craftsVO) {
		int num = craftsDAO.insertCraftsNewArticle(craftsVO);
		return num;
	}
	
	public int updateCrafts(CraftsVO craftsVO) {
		int num = craftsDAO.updateCraftsArticle(craftsVO);
		return num;
		
	}
}
