package Common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import DBUtil.DBConnection;

public class SearchDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	private Connection getConnection() throws Exception{
		
		Context init = new InitialContext();
		
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/team2");
		
		con = ds.getConnection();
		
		return con;
	}//getConnection메소드 끝
	
	public void release(){
		try{
			if(pstmt != null){
				pstmt.close();
			}
			if(rs != null){
				rs.close();
			}
			if(con != null){
				con.close();
			}
		}catch(Exception exception){
			System.out.println("자원 해제 실패 : " + exception);
		}
	}//release메소드 끝

	public List<SearchVO> searchArticles(String search) {
		List<SearchVO> searchList = new ArrayList<SearchVO>();
		try {
			
			con = getConnection();
			String query = "SELECT * FROM living where productname like ?";
			//select * from (select * from living where productname like ? 
			//union select * from fancy where productname like ?) a;
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,"%"+search+"%");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				searchList.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("searchArticles 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchList;
		
	}//searchArticles 메소드 끝

	public int searchCount(String search) {
		int searchCount = 0;
		try{
			con = getConnection();
			String query = "SELECT count(*) FROM living where productname like ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+search+"%");
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				searchCount = rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("searchCount메소드 내부에서 오류 : " + e);
		}finally{
			release();
		}
		return searchCount;
	}
	
}
