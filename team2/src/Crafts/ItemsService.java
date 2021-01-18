package Crafts;

import java.util.ArrayList;
import java.util.List;


public class ItemsService {

	//________  Crafts Service _________//
	
	ItemsDAO dao;
	ItemsVO vo;
	
	public ItemsService() {
		vo = new ItemsVO();
		dao = new ItemsDAO();
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
	
	
}