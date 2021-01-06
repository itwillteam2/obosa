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
import Living.LivingVO;

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

			System.out.println(id);
			System.out.println(pw);
			System.out.println(title);
			System.out.println(email);
			System.out.println(content);
			System.out.println(category);

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
}
