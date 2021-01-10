package Living;

import java.util.ArrayList;
import java.util.List;


public class ItemsService {
	
	//________  Living Service _________//
	
	ItemsDAO dao;
	ItemsVO vo;
	
	public ItemsService() {
		vo = new ItemsVO();
		dao = new ItemsDAO();
	}	
	
	 public List<ItemsVO> ContentList() {
		  List<ItemsVO> contentList = new ArrayList<ItemsVO>();
		  contentList = dao.getAllContents();
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
	
	
	public int insertContent(ItemsVO vo) {
		return dao.insertContent(vo);
	}//end
	

	public int addReply(ItemsRepVO  repVO){
		return dao.insertNewReply(repVO);
	}//end
	
}