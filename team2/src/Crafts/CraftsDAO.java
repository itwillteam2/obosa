package Crafts;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBUtil.DBConnection;

public class CraftsDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public void freeResource() {
		try {
			if(conn != null) conn.close();
			if(pstmt != null) pstmt.close();
			if(rs != null) rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}//end of freeResource

	//select all articles list of crafts.
	public List<CraftsVO> selectAllArticles() {
		List<CraftsVO> craftsList = new ArrayList<CraftsVO>();
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT * FROM crafts";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				CraftsVO craftsVO = new CraftsVO();
				craftsVO.setNum(rs.getInt("num"));
				craftsVO.setPoint(rs.getInt("point"));
				craftsVO.setProductContent(rs.getString("productContent"));
				craftsVO.setProductImageName1(rs.getString("productImageName1"));
				craftsVO.setProductImageName2(rs.getString("productImageName2"));
				craftsVO.setProductImageName3(rs.getString("productImageName3"));
				craftsVO.setProductName(rs.getString("productName"));
				craftsVO.setProductPrice(rs.getInt("productPrice"));
				craftsVO.setProductQuantity(rs.getInt("productQuantity"));
				craftsVO.setReg_date(rs.getTimestamp("regDate"));
				craftsVO.setSellerName(rs.getString("sellerName"));
				craftsVO.setShipping_fee(rs.getInt("shipping_fee"));
				craftsList.add(craftsVO);
			}
					
					
		} catch (Exception e) {
			System.out.println("selectAllArticles error : " + e.toString());
		}finally {
			freeResource();
		}
		return craftsList;
	}//end of selectAllArticles
	
	public int selectTotalCount() {
		
		int num = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM Living";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rs.getInt(1);				
			}
			return num;	
					
		} catch (Exception e) {
			System.out.println("selectTotalCount error : " + e.toString());
		}finally {
			freeResource();
		}
		return num;
	}//end of selectTotalCount
	
	//auto num+1
	private int autoNum() {
			int num = 1;
			String query="";
		try {
			conn = DBConnection.getConnection();
			query = "SELECT MAX(num) FROM crafts";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(num) + 1;				
			}			
			return num;
		} catch (Exception e) {
			System.out.println("autoNum error : " + e.toString());
		}finally {
			freeResource();
		}
		return 0;
	}//end of autoNum

	
	//insert new articles into crafts table;
	public int insertCraftsNewArticle(CraftsVO craftsVO) {
		int craftsNum = autoNum();
		System.out.println(craftsNum);
		
		int num = 1;
		
		try {
			conn = DBConnection.getConnection();
			String query = "INSERT INTO crafts"
					+ "(productName,productContent,sellerName,productPrice,productImageName1,productImageName2,productImageName3,productQuantity,shipping_fee,point)"
					+ "VALUES(?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.executeUpdate();
			
					
			
		} catch (Exception e) {
			System.out.println("insertCraftsNewArticle : " + e.toString());
		}finally {
			freeResource();
		}
		
		return num;
		
		
	}//end of insertCraftsNewArticle

}
