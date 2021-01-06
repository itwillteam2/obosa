package CsCenter;

import java.util.List;

import Living.LivingVO;

public class CsCenterService {
	
	CsCenterDAO CsCenterDAO;
	NoticeVO noticeVO;
	InquiryVO inquiryVO;
	
	public CsCenterService() {
		CsCenterDAO = new CsCenterDAO();
		noticeVO = new NoticeVO();
		inquiryVO = new InquiryVO();
	}
	
	public int addNotice(NoticeVO noticeVO) {
		
		return CsCenterDAO.insertNewNotice(noticeVO);
		
		
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

}
