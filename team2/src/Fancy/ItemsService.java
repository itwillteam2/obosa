package Fancy;

import java.util.ArrayList;
import java.util.List;

import CsCenter.InqRepVO;
import CsCenter.NoticeVO;


public class ItemsService {
	
	//________  fancy Service _________//
	
	ItemsDAO dao;
	ItemsVO vo;
	ItemsRepVO repVO;
	ItemsQnaVO qnaVO;
	FancyJoinVO joinVO;
	
	public ItemsService() {
		vo = new ItemsVO();
		dao = new ItemsDAO();
		repVO = new ItemsRepVO();
		qnaVO = new ItemsQnaVO();
		joinVO = new FancyJoinVO();
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

	public int addQna(ItemsQnaVO qnaVO) {
		return dao.insertNewQna(qnaVO);
	}

	public int totalCountQna() {
		int totalCount2 = dao.getTotalCountQna();
		return totalCount2;
	}

	public List<ItemsQnaVO> QnaPagingList(int pageNO, int listSize, int num) {
		List<ItemsQnaVO> QnaPagingList = new ArrayList<ItemsQnaVO>();
		QnaPagingList = dao.getAllQna(pageNO,listSize,num);
		return QnaPagingList;
	}

	public int addQnaRep(ItemsQnaRepVO qnarepVO) {
		return dao.insertNewQnaRep(qnarepVO);
		
	}

	public List<ItemsQnaRepVO> listQnaRep() {
		List<ItemsQnaRepVO> listQnaRep = dao.selectAllQnaRep();
		return listQnaRep;
	}

	public int totalCountQnaRep() {
		int totalCount3 = dao.getTotalCountQnaRep();
		return totalCount3;
	}

	public List<ItemsQnaRepVO> QnaRepPagingList(int pageNO, int listSize, int num) {
		List<ItemsQnaRepVO> QnaRepPagingList = new ArrayList<ItemsQnaRepVO>();
		QnaRepPagingList = dao.getAllQnaRep(pageNO,listSize,num);
		return QnaRepPagingList;
	}

	public List<FancyJoinVO> QnaPagingJoinList(int pageNO, int listSize, int num) {
		List<FancyJoinVO> QnaPagingJoinList = new ArrayList<FancyJoinVO>();
		QnaPagingJoinList = dao.JoinQna(pageNO,listSize,num);
		return QnaPagingJoinList;
	}

	public int QnaReplyDelete(int qrnum, String pw) {
		int check = dao.QnaReplyDelete(qrnum, pw);
		
		return check;
	}

	public int modifyReply(ItemsQnaRepVO qnarepVO) {
		int check = dao.modifyReply(qnarepVO);
		
		return check;
	}
	
	public ItemsVO getContent(int num){
		vo = dao.getContent(num);
		return vo;
	}
	
}