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

		String sql ="";

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
			
			System.out.println(nnum);
			System.out.println(title);
			System.out.println(content);
			
			String query = "INSERT INTO Notice(nnum, title, content)"
					+ "VALUES(?, ?, ?)";

			pstmt = conn.prepareStatement(query);

			pstmt.setInt(1, nnum);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}

		return nnum;
	}

	public List selectAllNotice(){
		
		List NoticeList = new ArrayList();
		
		try{
			//커넥션풀로 부터 커넥션 얻기(DB접속)
			conn = DBConnection.getConnection();
			//계층형 구조로 전체 글을 조회하는 오라클의 SQL문 만들기
			String query = "select * from notice order by nnum desc";
			
			pstmt =conn.prepareStatement(query);
			
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
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			freeResource();
		}
		
		return NoticeList;//ArrayList배열을 BoardService클래스로 리턴	
	
	}

}
