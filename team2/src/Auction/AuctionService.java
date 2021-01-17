package Auction;

import java.util.ArrayList;
import java.util.List;

public class AuctionService {
	
	AuctionDAO auctionDAO;
	
	public AuctionService() {
		auctionDAO = new AuctionDAO();
	}
	
	public int insertAuctionItem(AuctionVO auctionVO) {
		int maxNum = auctionDAO.getAuctionMaxNum();
		auctionDAO.insertItem(auctionVO,maxNum);
		
		return maxNum;
	}
	
	public List<AuctionVO> getArticleList(int pageNo, int listSize){
		
		List<AuctionVO> articleList = new ArrayList<AuctionVO>();
		
		articleList = auctionDAO.selectArticle(pageNo, listSize);
		
		return articleList;
		
	}
	
	public int totalCount() {
		int totalCount = auctionDAO.selectListCount();
		return totalCount;
	}

}
