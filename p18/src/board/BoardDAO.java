package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
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
			System.out.println("Resource Release �떎�뙣 : " + exception);
		}
	}	
	
	public void insertBoard(BoardBean bBean){
		int num = 0;

		String sql ="";
		
		try {
			con = getConnection();
			
			sql = "select max(num) from board";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}else{
				num = 1;
			}
			
			sql = "insert into board(num,name,passwd,subject,content," +
					"re_ref,re_lev,re_seq,readcount,date,ip)" + 
					"values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getPasswd());
			pstmt.setString(4, bBean.getSubject());
			pstmt.setString(5, bBean.getContent());
			pstmt.setInt(6, num);
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			pstmt.setTimestamp(10, bBean.getDate());
			pstmt.setString(11, bBean.getIp());

			pstmt.executeUpdate();
		
		}catch(Exception e) {
			System.out.println("insertBoard硫붿냼�뱶 �궡遺��뿉�꽌 �떎�뻾 �삤瑜� : " + e);

		}finally{
			Resource();
		}
	}
	
	public int getBoardCount(){
		
		int count = 0;
		
		String sql = "";
		
		try {
			con = getConnection();

			sql = "select count(*) from board";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}			
		}catch(Exception e) {
			System.out.println("getBoardCount 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
		}finally{
			Resource();
		}
		return count;	
	}
	
	public List<BoardBean> getBoardList(int startRow, int pageSize){
		
		String sql = "";
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
	
		try {
			con = getConnection();

			sql = "select * from board order by re_ref desc, re_seq asc limit ?, ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){				
				BoardBean bBean = new BoardBean();
				bBean.setNum(rs.getInt("num"));
				bBean.setName(rs.getString("name"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setSubject(rs.getString("subject"));
				bBean.setContent(rs.getString("content"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setIp(rs.getString("ip"));

				boardList.add(bBean);
			}		
		}catch(Exception e) {
			System.out.println("getBoardList 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� :" + e);
		}finally{
			Resource();
		}
		return boardList;
		
	}
	
	public void updateReadCount(int num){
			
			String sql = "";
			
			try {
	
				con = getConnection();
	
				sql = "update board set readcount=readcount+1 where num = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
			
			}catch(Exception e) {
				System.out.println("updateReadCount 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
			}finally{
				Resource();
			}
		}
	
	public BoardBean getBoard(int num){
		
		String sql = "";
		
		BoardBean bean = new BoardBean();
		try {

			con = getConnection();

			sql = "select * from board where num = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setPasswd(rs.getString("passwd"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setRe_ref(rs.getInt("re_ref"));
				bean.setRe_lev(rs.getInt("re_lev"));
				bean.setRe_seq(rs.getInt("re_seq"));
				bean.setReadcount(rs.getInt("readcount"));
				bean.setDate(rs.getTimestamp("date"));
				bean.setIp(rs.getString("ip"));
			}
			
		}catch(Exception e) {
			System.out.println("getBoard 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
		}finally{
			Resource();
		}		
		return bean;
	
	}
	
	public int deleteBoard(int num, String passwd){
		
		int check = 0;
		
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "select passwd from board where num = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd"))){

					check = 1;

					sql = "delete from board where num=?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					pstmt.executeUpdate();
				}else{
					check = 0;
				}
			}		
		}catch(Exception e) {
			System.out.println("deleteBoard 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
		}finally{
			Resource();
		}
		
		return check;
	}
	
	public int updateBoard(BoardBean bBean){
		int check = 0;
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "select passwd from board where num = ?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, bBean.getNum());

			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(bBean.getPasswd().equals(rs.getString("passwd"))){
					check = 1;
					sql = "update board set name=?, subject=?, content=? where num=?";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, bBean.getName());
					pstmt.setString(2, bBean.getSubject());
					pstmt.setString(3, bBean.getContent());
					pstmt.setInt(4, bBean.getNum());
					pstmt.executeUpdate();
				}else{
					check = 0;
				}
			}			
		}catch(Exception e) {
			System.out.println("updateBoard 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
		}finally{
			Resource();
		}
		return check;	
	}
	
	public void reInsertBoard(BoardBean bBean){
		String sql = "";
		
		int num = 0;
		
		try {

			con = getConnection();

			sql = "select max(num) from board";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1) +1;
			}else{ 
				num = 1;				
			}
			
			sql = "update board set re_seq = re_seq +1 where re_ref = ? and re_seq > ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getRe_ref());
			pstmt.setInt(2, bBean.getRe_seq());
			pstmt.executeUpdate();

			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getPasswd());
			pstmt.setString(4, bBean.getSubject());
			pstmt.setString(5, bBean.getContent());
			pstmt.setInt(6, bBean.getRe_ref());
			pstmt.setInt(7, bBean.getRe_lev() + 1);
			pstmt.setInt(8, bBean.getRe_seq() + 1);
			pstmt.setInt(9, 0);
			pstmt.setTimestamp(10, bBean.getDate());
			pstmt.setString(11, bBean.getIp());
			
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			System.out.println("reInsertBoard 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);			
		}finally{
			Resource();
		}
	}
	
	public List<BoardBean> getBoardSearch(String search, String searchText, int startRow, int pageSize){
		String sql = "";
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();		
		try {
			con = getConnection();
			
			sql = "select * from board where " + search + " like '%" + searchText + "%' order by num desc limit ?, ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				BoardBean bBean = new BoardBean();
				bBean.setNum(rs.getInt("num"));
				bBean.setName(rs.getString("name"));
				bBean.setSubject(rs.getString("subject"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setReadcount(rs.getInt("readcount"));
				boardList.add(bBean);
			}
		} catch (Exception e) {
			System.out.println("getBoardSearch 메소드 내부에서 오류 :" + e);
		}finally{
			Resource();
		}
		
		return boardList;
		
	}

}
