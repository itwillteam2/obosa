package ProductCategory;

import java.util.ArrayList;
import java.util.List;


public class ItemsService {
	
	ItemsDAO dao;
	ItemsVO vo;
	
	public ItemsService() {
		vo = new ItemsVO();
		dao = new ItemsDAO();
	}	
	
	 public List<ItemsVO> ContentList(int pageNO, int listSize, String ord, String setCategory) {
		  List<ItemsVO> contentList = new ArrayList<ItemsVO>();
		  contentList = dao.getAllContents(pageNO,listSize,ord,setCategory);
		  return contentList;
	  }//end
	
	public ItemsVO  ContentDetail(int num,String setCategory){
		ItemsVO vo = dao.getContent(num,setCategory);
		return vo;
	}//end
	
	public int totalCount(String setCategory) {
		int totalCount = dao.getTotalCount(setCategory);
		return totalCount;
	}//end
	
	
	public int updateContent(ItemsVO vo) {
		return dao.updateContent(vo);
	}//end
	
	public int deleteContent(int num,String setCategory) {
		return dao.deleteContent(num,setCategory);
	}//end
	
	public int insertContent(ItemsVO vo) {
		return dao.insertContent(vo);
	}//end
	

	public int addReply(ItemsRepVO  repVO,String setCategory){
		return dao.insertNewReply(repVO,setCategory);
	}//end
	
}