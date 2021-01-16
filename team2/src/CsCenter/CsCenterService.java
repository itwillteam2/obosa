package CsCenter;

import java.util.ArrayList;
import java.util.List;

import Living.ItemsVO;

public class CsCenterService {
	
	CsCenterDAO CsCenterDAO;
	NoticeVO noticeVO;
	InquiryVO inquiryVO;
	InqRepVO InqRepVO;
	
	public CsCenterService() {
		CsCenterDAO = new CsCenterDAO();
		noticeVO = new NoticeVO();
		inquiryVO = new InquiryVO();
		InqRepVO = new InqRepVO();
	}
	
	public int addNotice(NoticeVO noticeVO) {
		
		return CsCenterDAO.insertNewNotice(noticeVO);
		
		
	}
	
	public int addInqRep(InqRepVO inqRepVO) {
		
		return CsCenterDAO.insertNewInqRep(inqRepVO);
		
	}

	public List<NoticeVO> listNotice() { 
		List<NoticeVO> NoticeList = CsCenterDAO.selectAllNotice();
		return NoticeList;
	}

	public int addInquiry(InquiryVO inquiryVO) {

		return CsCenterDAO.insertNewInquiry(inquiryVO);
	}

	public List<InquiryVO> listInquiry() { 
		List<InquiryVO> InquiryList = CsCenterDAO.selectAllInquiry();
		return InquiryList;
	}
	
	public List<InqRepVO> listInqRep() { 
		List<InqRepVO> InqRepList = CsCenterDAO.selectAllInqRep();
		return InqRepList;
	}

	public int delteInquiry(int inqnum, String pw) {
		
		int check = CsCenterDAO.deleteInquiry(inqnum, pw);
		
		return check;
	}

	public int delteNotice(int nnum, String pw) {
		
		int check = CsCenterDAO.deleteNotice(nnum, pw);
		
		return check;
	}
	
	public NoticeVO viewNotice(int nnum) {
		NoticeVO notice = null;
		notice = CsCenterDAO.selectNotice(nnum);
		return notice;
	}

	public InquiryVO viewInquiry(int inqnum) {
		InquiryVO inquiry = null;
		inquiry = CsCenterDAO.selectInquiry(inqnum);
		return inquiry;
	}

	public int modifyNotice(NoticeVO noticeVO) {
		
		int check = CsCenterDAO.modifyNotice(noticeVO);
		
		return check;
	}

	public int modifyInquiry(InquiryVO inquiryVO) {
		
		int check = CsCenterDAO.modifyInquiry(inquiryVO);
		
		return check;
	}

	public int delteReply(int inqnum, String pw) {
		
		int check = CsCenterDAO.deleteReply(inqnum, pw);
		
		return check;
	}

	public int modifyReply(InqRepVO inqRepVO) {
		int check = CsCenterDAO.modifyReply(inqRepVO);
		
		return check;
	}

	public int totalCount() {
		int totalCount = CsCenterDAO.getTotalCount();
		return totalCount;
	}

	public List<NoticeVO> pagingList(int pageNO, int listSize) {
		  List<NoticeVO> pagingList = new ArrayList<NoticeVO>();
		  pagingList = CsCenterDAO.getAllNotices(pageNO,listSize);
		  return pagingList;
	  }
	
	public List<NoticeVO> NoticeSearchList(int pageNO, int listSize, String category, String searchText) {
		  List<NoticeVO> NoticeSearchList = new ArrayList<NoticeVO>();
		  NoticeSearchList = CsCenterDAO.getselectNotices(pageNO,listSize,category,searchText);
		  return NoticeSearchList;
	  }

	public int totalCount2() {
		int totalCount = CsCenterDAO.getTotalCount2();
		return totalCount;
	}

	public List<InquiryVO> pagingList2(int pageNO, int listSize) {
		List<InquiryVO> pagingList = new ArrayList<InquiryVO>();
		  pagingList = CsCenterDAO.getAllInquiry(pageNO,listSize);
		  return pagingList;
	}

	public List<InquiryVO> InquirySearchList(int pageNO, int listSize, String category, String searchText) {
		List<InquiryVO> InquirySearchList = new ArrayList<InquiryVO>();
		InquirySearchList = CsCenterDAO.getselectInquiry(pageNO,listSize,category,searchText);
		  return InquirySearchList;
	}

	public List<InquiryJoinVO> JoinList(int pageNO, int listSize) {
		List<InquiryJoinVO> JoinList = new ArrayList<InquiryJoinVO>();
		JoinList = CsCenterDAO.JoinList(pageNO,listSize);
		  return JoinList;
	}





}
