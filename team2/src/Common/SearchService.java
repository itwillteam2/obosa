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

	public int shopSearchCount(String search) {
		int shopSearchCount = searchDAO.shopSearchCount(search);
		return shopSearchCount;
	}

	public List<SearchVO> shopSearchList(String search) {
		List<SearchVO> shopSearchList = new ArrayList<SearchVO>();
		shopSearchList = searchDAO.shopSearch(search);
		return shopSearchList;
	}

	public int livingCount(String search) {
		int livingCount = searchDAO.livingCount(search);
		return livingCount;
	}

	public List<SearchVO> searchLiving(String search) {
		List<SearchVO> searchLiving = new ArrayList<SearchVO>();
		searchLiving = searchDAO.searchLiving(search);
		return searchLiving;
	}

	public int artCount(String search) {
		int artCount = searchDAO.artCount(search);
		return artCount;
	}

	public List<SearchVO> searchArt(String search) {
		List<SearchVO> searchArt = new ArrayList<SearchVO>();
		searchArt = searchDAO.searchArt(search);
		return searchArt;
	}

	public int fancyCount(String search) {
		int fancyCount = searchDAO.fancyCount(search);
		return fancyCount;
	}

	public List<SearchVO> searchFancy(String search) {
		List<SearchVO> searchFancy = new ArrayList<SearchVO>();
		searchFancy = searchDAO.searchFancy(search);
		return searchFancy;
	}
}
