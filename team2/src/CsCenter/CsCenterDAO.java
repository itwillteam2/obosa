package CsCenter;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import DBUtil.DBConnection;
import Living.ItemsVO;

public class CsCenterDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public void freeResource() {
		try {
			if (conn != null)
				conn.close();
			if (pstmt != null)
				pstmt.close();
			if (rs != null)
				rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public int insertNewNotice(NoticeVO noticeVO) {

		int nnum = 0;

		String sql = "";

		try {
			conn = DBConnection.getConnection();
			sql = "select max(nnum) from notice";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				nnum = rs.getInt(1) + 1;
			} else {
				nnum = 1;
			}

			String title = noticeVO.getTitle();
			String content = noticeVO.getContent();
			String pw = noticeVO.getPw();
			String query = "INSERT INTO Notice(nnum, pw, title, content)" + "VALUES(?, ?, ?, ?)";

			pstmt = conn.prepareStatement(query);

			pstmt.setInt(1, nnum);
			pstmt.setString(2, pw);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}

		return nnum;
	}

	public List selectAllNotice() {

		List NoticeList = new ArrayList();

		try {
			// 커넥션풀로 부터 커넥션 얻기(DB접속)
			conn = DBConnection.getConnection();
			// 계층형 구조로 전체 글을 조회하는 오라클의 SQL문 만들기
			String query = "select * from notice order by nnum desc";

			pstmt = conn.prepareStatement(query);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int nnum = rs.getInt("nnum");
				String title = rs.getString("title");
				String content = rs.getString("content");
				Timestamp date = rs.getTimestamp("date");

				NoticeVO notice = new NoticeVO();
				notice.setNnum(nnum);
				notice.setTitle(title);
				notice.setContent(content);
				notice.setDate(date);

				NoticeList.add(notice);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}

		return NoticeList;

	}

	public int insertNewInquiry(InquiryVO inquiryVO) {

		int inqnum = 0;

		String sql = "";

		try {
			conn = DBConnection.getConnection();
			sql = "select max(inqnum) from inquiry";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				inqnum = rs.getInt(1) + 1;
			} else {
				inqnum = 1;
			}

			String id = inquiryVO.getId();
			String pw = inquiryVO.getPw();
			String title = inquiryVO.getTitle();
			String email = inquiryVO.getEmail();
			String content = inquiryVO.getContent();
			String category = inquiryVO.getCategory();

			String query = "INSERT INTO inquiry(inqnum, id, pw, title, email, content, category)"
					+ "VALUES(?, ?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(query);

			pstmt.setInt(1, inqnum);
			pstmt.setString(2, id);
			pstmt.setString(3, pw);
			pstmt.setString(4, title);
			pstmt.setString(5, email);
			pstmt.setString(6, content);
			pstmt.setString(7, category);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}

		return inqnum;
	}
	
	public int insertNewInqRep(InqRepVO inqRepVO) {

		int repnum = 0;

		String sql = "";

		try {
			conn = DBConnection.getConnection();
			sql = "select max(repnum) from inq_rep";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				repnum = rs.getInt(1) + 1;
			} else {
				repnum = 1;
			}
			
			int inqnum = inqRepVO.getInqnum();
			String content = inqRepVO.getContent();
			String pw = inqRepVO.getPw();

			System.out.println(inqnum);
			System.out.println(pw);
			System.out.println(content);

			String query = "INSERT INTO inq_rep(repnum, pw, content, inqnum)"
					+ "VALUES(?, ?, ?, ?)";

			pstmt = conn.prepareStatement(query);

			pstmt.setInt(1, repnum);
			pstmt.setString(2, pw);
			pstmt.setString(3, content);
			pstmt.setInt(4, inqnum);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}

		return repnum;
	}
	
	public List selectAllInquiry() {

		List InquiryList = new ArrayList();

		try {
			conn = DBConnection.getConnection();

			String query = "select * from inquiry order by inqnum desc";

			pstmt = conn.prepareStatement(query);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int inqnum = rs.getInt("inqnum");
				String id = rs.getString("id");
				String pw = rs.getString("pw");
				String title = rs.getString("title");
				String email = rs.getString("email");
				String content = rs.getString("content");
				String category = rs.getString("category");
				Timestamp date = rs.getTimestamp("date");

				InquiryVO inq = new InquiryVO();
				inq.setInqnum(inqnum);
				inq.setId(id);
				inq.setPw(pw);
				inq.setTitle(title);
				inq.setEmail(email);
				inq.setContent(content);
				inq.setCategory(category);
				inq.setDate(date);

				InquiryList.add(inq);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}

		return InquiryList;

	}
	
	public List selectAllInqRep() {

		List InqRepList = new ArrayList();

		try {
			conn = DBConnection.getConnection();

			String query = "select * from inq_rep order by repnum desc";

			pstmt = conn.prepareStatement(query);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int repnum = rs.getInt("repnum");
				String content = rs.getString("content");
				String pw = rs.getString("pw");		
				int inqnum = rs.getInt("inqnum");

				InqRepVO inqrep = new InqRepVO();
				inqrep.setRepnum(repnum);
				inqrep.setContent(content);
				inqrep.setPw(pw);
				inqrep.setInqnum(inqnum);
				
				InqRepList.add(inqrep);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}

		return InqRepList;

	}

	public int deleteInquiry(int inqnum, String pw){
		
		int check = 0;
		
		String sql = "";
		
		try {
			conn = DBConnection.getConnection();
			
			sql = "select pw from inquiry where inqnum = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, inqnum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){

					check = 1;

					sql = "delete from inquiry where inqnum=?";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, inqnum);
					
					pstmt.executeUpdate();
				}else{
					check = 0;
				}
			}		
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			freeResource();
		}
		
		return check;
	}

	public int deleteNotice(int nnum, String pw){
		
		int check = 0;
		
		String sql = "";
		
		try {
			conn = DBConnection.getConnection();
			
			sql = "select pw from notice where nnum = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nnum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){

					check = 1;

					sql = "delete from notice where nnum=?";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, nnum);
					
					pstmt.executeUpdate();
				}else{
					check = 0;
				}
			}		
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			freeResource();
		}
		
		return check;
	}

	public NoticeVO selectNotice(int nnum) {
		NoticeVO notice = new NoticeVO();
		try {
			conn = DBConnection.getConnection();
			String query = "select * from notice where nnum=?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, nnum);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				int _nnum = rs.getInt("nnum");
				String pw = rs.getString("pw");
				String title = rs.getString("title");
				String content = rs.getString("content");
				Timestamp date = rs.getTimestamp("date");
				
				notice.setNnum(_nnum);
				notice.setPw(pw);
				notice.setTitle(title);
				notice.setContent(content);
				notice.setDate(date);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return notice;
	}

	public InquiryVO selectInquiry(int inqnum) {
		InquiryVO inquiry = new InquiryVO();
		try {
			conn = DBConnection.getConnection();
			String query = "select * from inquiry where inqnum=?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, inqnum);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				int _inqnum = rs.getInt("inqnum");
				String id = rs.getString("id");
				String pw = rs.getString("pw");
				String title = rs.getString("title");
				String email = rs.getString("email");
				String content = rs.getString("content");
				String category = rs.getString("category");
				Timestamp date = rs.getTimestamp("date");
				
				inquiry.setInqnum(_inqnum);
				inquiry.setId(id);
				inquiry.setPw(pw);
				inquiry.setTitle(title);
				inquiry.setEmail(email);
				inquiry.setContent(content);
				inquiry.setCategory(category);
				inquiry.setDate(date);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return inquiry;
	}

	public int modifyNotice(NoticeVO noticeVO){
		int check = 0;
		String sql = "";
		
		try {
			conn = DBConnection.getConnection();
			
			sql = "select pw from notice where nnum = ?";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, noticeVO.getNnum());

			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(noticeVO.getPw().equals(rs.getString("pw"))){
					check = 1;
					sql = "update notice set title=?, content=? where nnum=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, noticeVO.getTitle());
					pstmt.setString(2, noticeVO.getContent());
					pstmt.setInt(3, noticeVO.getNnum());

					pstmt.executeUpdate();
				}else{
					check = 0;
				}
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			freeResource();
		}
		return check;	
	}

	public int modifyInquiry(InquiryVO inquiryVO){
		int check = 0;
		String sql = "";
		
		try {
			conn = DBConnection.getConnection();
			
			sql = "select pw from Inquiry where inqnum = ?";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, inquiryVO.getInqnum());

			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(inquiryVO.getPw().equals(rs.getString("pw"))){
					check = 1;
					sql = "update inquiry set id=?, title=?, email=?, content=?, category=? where inqnum=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, inquiryVO.getId());
					pstmt.setString(2, inquiryVO.getTitle());
					pstmt.setString(3, inquiryVO.getEmail());
					pstmt.setString(4, inquiryVO.getContent());
					pstmt.setString(5, inquiryVO.getCategory());
					pstmt.setInt(6, inquiryVO.getInqnum());

					pstmt.executeUpdate();
				}else{
					check = 0;
				}
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			freeResource();
		}
		return check;	
	}

	public int deleteReply(int inqnum, String pw){
		
		int check = 0;
		
		String sql = "";
		
		try {
			conn = DBConnection.getConnection();
			
			sql = "select pw from inq_rep where inqnum = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, inqnum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){

					check = 1;

					sql = "delete from inq_rep where inqnum=?";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, inqnum);

					
					pstmt.executeUpdate();
				}else{
					check = 0;
				}
			}		
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			freeResource();
		}
		
		return check;
	}

	public int modifyReply(InqRepVO inqRepVO){
		int check = 0;
		String sql = "";
		
		try {
			conn = DBConnection.getConnection();
			
			sql = "select pw from Inq_rep where inqnum = ?";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, inqRepVO.getInqnum());

			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(inqRepVO.getPw().equals(rs.getString("pw"))){
					check = 1;
					sql = "update inq_rep set content=? where inqnum=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, inqRepVO.getContent());
					pstmt.setInt(2, inqRepVO.getInqnum());

					pstmt.executeUpdate();
				}else{
					check = 0;
				}
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			freeResource();
		}
		return check;	
	}

	public int getTotalCount() {
		int num = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM NOTICE";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1);
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}

		return num;
	}

	public List<NoticeVO> getAllNotices(int pageNO, int listSize) {
		List<NoticeVO> pagingList = new ArrayList<NoticeVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			conn = DBConnection.getConnection();
			
				String query = "SELECT * FROM notice order by nnum desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				NoticeVO vo = new NoticeVO();
				vo.setNnum(rs.getInt("nnum"));
				vo.setPw(rs.getString("pw"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setDate(rs.getTimestamp("date"));
				pagingList.add(vo);
			}
						
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return pagingList;
	}

	public List<NoticeVO> getselectNotices(int pageNO, int listSize, String category, String searchText) {
		List<NoticeVO> NoticeSearchList = new ArrayList<NoticeVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			conn = DBConnection.getConnection();
			
				String query = "SELECT * FROM notice where " + category + " like '%" + searchText + "%' order by nnum desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				NoticeVO vo = new NoticeVO();
				vo.setNnum(rs.getInt("nnum"));
				vo.setPw(rs.getString("pw"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setDate(rs.getTimestamp("date"));
				NoticeSearchList.add(vo);
			}
						
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return NoticeSearchList;
	}

	public int getTotalCount2() {
		int num = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM Inquiry";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1);
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}

		return num;
	}

	public List<InquiryVO> getAllInquiry(int pageNO, int listSize) {
		List<InquiryVO> pagingList = new ArrayList<InquiryVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			conn = DBConnection.getConnection();
			
				String query = "SELECT * FROM Inquiry order by inqnum desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				InquiryVO vo = new InquiryVO();
				vo.setInqnum(rs.getInt("inqnum"));
				vo.setId(rs.getString("id"));
				vo.setPw(rs.getString("pw"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setContent(rs.getString("content"));
				vo.setDate(rs.getTimestamp("date"));
				vo.setCategory(rs.getString("category"));
				pagingList.add(vo);
			}
						
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return pagingList;
	}

	public List<InquiryVO> getselectInquiry(int pageNO, int listSize, String category, String searchText) {
		List<InquiryVO> InquirySearchList = new ArrayList<InquiryVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			conn = DBConnection.getConnection();
			
				String query = "SELECT * FROM inquiry where " + category + " like '%" + searchText + "%' order by inqnum desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				InquiryVO vo = new InquiryVO();
				vo.setInqnum(rs.getInt("inqnum"));
				vo.setId(rs.getString("id"));
				vo.setPw(rs.getString("pw"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setContent(rs.getString("content"));
				vo.setDate(rs.getTimestamp("date"));
				vo.setCategory(rs.getString("category"));
				InquirySearchList.add(vo);
			}
						
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return InquirySearchList;
	}

	public List<InquiryJoinVO> JoinList(int pageNO, int listSize) {
		List<InquiryJoinVO> JoinList = new ArrayList<InquiryJoinVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			conn = DBConnection.getConnection();
				String query = "SELECT i.id, i.inqnum, i.title, i.content, i.date, ifnull(r.repnum,0) repnum,  ifnull(r.content,0) rcontent "
						+ "from inquiry i left outer join inq_rep r on i.inqnum = r.inqnum "
						+ " order by inqnum desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				InquiryJoinVO vo = new InquiryJoinVO();
				vo.setId(rs.getString("id"));
				vo.setInqnum(rs.getInt("inqnum"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setDate(rs.getTimestamp("date"));
				vo.setRepnum(rs.getInt("repnum"));
				vo.setRcontent(rs.getString("rcontent"));
				JoinList.add(vo);
			}
						
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return JoinList;
	}
}
