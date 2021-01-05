package CsCenter;

import java.util.List;

public class CsCenterService {
	
	CsCenterDAO CsCenterDAO;
	NoticeVO noticeVO;
	
	public CsCenterService() {
		CsCenterDAO = new CsCenterDAO();
		noticeVO = new NoticeVO();
	}
	
	public int addNotice(NoticeVO noticeVO) {
		
		return CsCenterDAO.insertNewNotice(noticeVO);
		
		
	}

	public List<NoticeVO> listNotice() { 
		List<NoticeVO> NoticeList = CsCenterDAO.selectAllNotice();
		return NoticeList;
	}

}
