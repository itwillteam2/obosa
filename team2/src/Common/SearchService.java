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

	public int craftsCount(String search) {
		int craftsCount = searchDAO.craftsCount(search);
		return craftsCount;
	}

	public List<SearchVO> searchCrafts(String search) {
		List<SearchVO> searchCrafts = new ArrayList<SearchVO>();
		searchCrafts = searchDAO.searchCrafts(search);
		return searchCrafts;
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

	public int shopCount(String kwd) {
		int searchCount = searchDAO.shopCount(kwd);
		return searchCount;
	}
	
	public List<SearchVO> shopList(String search) {
		  List<SearchVO> searchList = new ArrayList<SearchVO>();
		  searchList = searchDAO.shopArticles(search);
		  return searchList;
	  }
	
	public int shopLivingCount(String search) {
		int livingCount = searchDAO.shopLivingCount(search);
		return livingCount;
	}

	public List<SearchVO> shopLiving(String search) {
		List<SearchVO> searchLiving = new ArrayList<SearchVO>();
		searchLiving = searchDAO.shopLiving(search);
		return searchLiving;
	}
	
	public int shopCraftsCount(String search) {
		int craftsCount = searchDAO.shopCraftsCount(search);
		return craftsCount;
	}

	public List<SearchVO> shopCrafts(String search) {
		List<SearchVO> searchCrafts = new ArrayList<SearchVO>();
		searchCrafts = searchDAO.shopCrafts(search);
		return searchCrafts;
	}

	public int shopFancyCount(String search) {
		int fancyCount = searchDAO.shopFancyCount(search);
		return fancyCount;
	}

	public List<SearchVO> shopFancy(String search) {
		List<SearchVO> searchFancy = new ArrayList<SearchVO>();
		searchFancy = searchDAO.shopFancy(search);
		return searchFancy;
	}
}
