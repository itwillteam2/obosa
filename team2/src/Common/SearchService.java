package Common;

import java.util.ArrayList;
import java.util.List;

public class SearchService {
	SearchDAO searchDAO = new SearchDAO();
	
	public List<SearchVO> searchList(String search) {
		  List<SearchVO> searchList = new ArrayList<SearchVO>();
		  searchList = searchDAO.searchArticles(search);
		  return searchList;
	  }

	public int searchCount(String search) {
		int searchCount = searchDAO.searchCount(search);
		return searchCount;
	}
}
