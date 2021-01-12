package Living;

import java.util.ArrayList;
import java.util.List;

import CsCenter.NoticeVO;


public class ItemsService {
	
	//________  Living Service _________//
	
	ItemsDAO dao;
	ItemsVO vo;
	ItemsRepVO repVO;
	
	public ItemsService() {
		vo = new ItemsVO();
		dao = new ItemsDAO();
		repVO = new ItemsRepVO();
	}	
	
	 public List<ItemsVO> ContentList(int pageNO, int listSize, String ord) {
		  List<ItemsVO> contentList = new ArrayList<ItemsVO>();
		  contentList = dao.getAllContents(pageNO,listSize, ord);
		  return contentList;
	  }//end
	
	public ItemsVO  ContentDetail(int num){
		ItemsVO vo = dao.getContent(num);
		return vo;
	}//end
	
	public int totalCount() {
		int totalCount = dao.getTotalCount();
		return totalCount;
	}//end
	
	
	public int updateContent(ItemsVO vo) {
		return dao.updateContent(vo);
	}//end
	
	public int deleteContent(int num) {
		return dao.deleteContent(num);
	}//end
	
	public int insertContent(ItemsVO vo) {
		return dao.insertContent(vo);
	}//end
	

	public int addReply(ItemsRepVO repVO){
		return dao.insertNewReply(repVO);
	}//end

	public int totalCountRep() {
		int totalCount = dao.getTotalCountRep();
		return totalCount;
	}

	public List<ItemsRepVO> ReppagingList(int pageNO, int listSize, int num) {
		List<ItemsRepVO> ReppagingList = new ArrayList<ItemsRepVO>();
		ReppagingList = dao.getAllReply(pageNO,listSize,num);
		return ReppagingList;
	}
	
}