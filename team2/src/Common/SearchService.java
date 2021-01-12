package Common;

import java.util.ArrayList;
import java.util.List;

public class SearchService {
	SearchDAO searchDAO = new SearchDAO();
	
	public List<SearchVO> searchList(String search, String ord) {
		  List<SearchVO> searchList = new ArrayList<SearchVO>();
		  searchList = searchDAO.searchArticles(search, ord);
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

	public List<SearchVO> searchLiving(String search, String ord) {
		List<SearchVO> searchLiving = new ArrayList<SearchVO>();
		searchLiving = searchDAO.searchLiving(search, ord);
		return searchLiving;
	}

	public int craftsCount(String search) {
		int craftsCount = searchDAO.craftsCount(search);
		return craftsCount;
	}

	public List<SearchVO> searchCrafts(String search, String ord) {
		List<SearchVO> searchCrafts = new ArrayList<SearchVO>();
		searchCrafts = searchDAO.searchCrafts(search, ord);
		return searchCrafts;
	}

	public int fancyCount(String search) {
		int fancyCount = searchDAO.fancyCount(search);
		return fancyCount;
	}

	public List<SearchVO> searchFancy(String search, String ord) {
		List<SearchVO> searchFancy = new ArrayList<SearchVO>();
		searchFancy = searchDAO.searchFancy(search, ord);
		return searchFancy;
	}

	public int shopCount(String kwd) {
		int searchCount = searchDAO.shopCount(kwd);
		return searchCount;
	}
	
	public List<SearchVO> shopList(int pageNO, int listSize, String search, String ord) {
		  List<SearchVO> searchList = new ArrayList<SearchVO>();
		  searchList = searchDAO.shopArticles(pageNO, listSize, search, ord);
		  return searchList;
	  }
	
	public int shopLivingCount(String search) {
		int livingCount = searchDAO.shopLivingCount(search);
		return livingCount;
	}

	public List<SearchVO> shopLiving(int pageNO, int listSize, String search, String ord) {
		List<SearchVO> searchLiving = new ArrayList<SearchVO>();
		searchLiving = searchDAO.shopLiving(pageNO, listSize, search, ord);
		return searchLiving;
	}
	
	public int shopCraftsCount(String search) {
		int craftsCount = searchDAO.shopCraftsCount(search);
		return craftsCount;
	}

	public List<SearchVO> shopCrafts(int pageNO, int listSize, String search, String ord) {
		List<SearchVO> searchCrafts = new ArrayList<SearchVO>();
		searchCrafts = searchDAO.shopCrafts(pageNO, listSize, search, ord);
		return searchCrafts;
	}

	public int shopFancyCount(String search) {
		int fancyCount = searchDAO.shopFancyCount(search);
		return fancyCount;
	}

	public List<SearchVO> shopFancy(int pageNO, int listSize, String search, String ord) {
		List<SearchVO> searchFancy = new ArrayList<SearchVO>();
		searchFancy = searchDAO.shopFancy(pageNO, listSize, search, ord);
		return searchFancy;
	}

	public List<SearchVO> viewSearchList(int allPageNO, int listSize, String kwd, String ord) {
		List<SearchVO> viewSearchList = new ArrayList<SearchVO>();
		  viewSearchList = searchDAO.viewSearchArticles(allPageNO, listSize, kwd, ord);
		  return viewSearchList;
	}
	
	public List<SearchVO> viewSearchLiving(int livingPageNO, int listSize, String search, String ord) {
		List<SearchVO> searchLiving = new ArrayList<SearchVO>();
		searchLiving = searchDAO.viewSearchLiving(livingPageNO, listSize, search, ord);
		return searchLiving;
	}
	
	public List<SearchVO> viewSearchCrafts(int craftsPageNO, int listSize, String search, String ord) {
		List<SearchVO> searchCrafts = new ArrayList<SearchVO>();
		searchCrafts = searchDAO.viewSearchCrafts(craftsPageNO, listSize, search, ord);
		return searchCrafts;
	}
	
	public List<SearchVO> viewSearchFancy(int fancyPageNO, int listSize, String search, String ord) {
		List<SearchVO> searchFancy = new ArrayList<SearchVO>();
		searchFancy = searchDAO.viewSearchFancy(fancyPageNO, listSize, search, ord);
		return searchFancy;
	}
}
