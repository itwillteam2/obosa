package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardReplyDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null; 
	
	private Connection getConnection() throws Exception{
		
		Context init = new InitialContext();

		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		
		con = ds.getConnection();
		
		return con;
	}

	public void Resource(){
		try{
			if(pstmt != null){pstmt.close();}
			if(rs != null){rs.close();}
			if(con != null){con.close();}
		}catch(Exception exception){
			System.out.println("Resource Release 메소드 내부에서 오류 : " + exception);
		}
	}	
	
	public List<BoardReplyDTO> list(int no){
		
		List<BoardReplyDTO> list = null;
		
		try{
			con = getConnection();
			
			String sql = "select rno, content, writer, Date from board_rep where no = ? order by rno desc";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs != null){
				while(rs.next()){
					if(list == null)
						list = new ArrayList<BoardReplyDTO>();
						BoardReplyDTO dto = new BoardReplyDTO();
						dto.setRno(rs.getInt("rno"));
						dto.setContent(rs.getString("content"));
						dto.setWriter(rs.getString("writer"));
						dto.setDate(rs.getTimestamp("date"));
						
						list.add(dto);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			Resource();
		}
		return list;
	}
	
	public Integer write(BoardReplyDTO dto) throws Exception{
		
		int rno = 0;
		
		Integer result = 0;
		
		String sql = "";
		try{
		
			con = getConnection();
			
			sql = "select max(rno) from board_rep";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){		
				rno = rs.getInt(1) + 1;
				
			}else{
				
				rno = 1;
				
			}	
			
			sql = "insert into board_rep(rno, no, content, writer, pw)" +
						"values(rno, ?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getNo());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getWriter());
			pstmt.setString(4, dto.getPw());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println("write 메소드 내부에서 오류 : " + e);
		}finally{
			Resource();
		}
		
		return result;
	}
	
public Integer update(BoardReplyDTO dto) throws Exception{
				
		Integer result = 0;
		
		String sql = "";
		try{
		
			con = getConnection();
			
			sql = "update board_rep set content = ?, writer = ? where rno = ? and pw = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getWriter());
			pstmt.setInt(3, dto.getRno());
			pstmt.setString(4, dto.getPw());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println("update 메소드 내부에서 오류 : " + e);
		}finally{
			Resource();
		}
		
		return result;
	}
	
public Integer delete(BoardReplyDTO dto) throws Exception{
	
	Integer result = 0;
	
	String sql = "";
	try{
	
		con = getConnection();
		
		sql = "delete from board_rep where rno = ? and pw = ?";
		
		pstmt = con.prepareStatement(sql);
		
		pstmt.setInt(1, dto.getRno());
		pstmt.setString(2, dto.getPw());
		
		result = pstmt.executeUpdate();
		
	}catch(Exception e){
		System.out.println("delete 메소드 내부에서 오류 : " + e);
	}finally{
		Resource();
	}
	
	return result;
}

}
