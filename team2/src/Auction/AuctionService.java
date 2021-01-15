package Auction;

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

}
