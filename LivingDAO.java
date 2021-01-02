package Living;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import DBUtil.DBConnection;
//import Pagination.PagingVO;

public class LivingDAO {

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

	//select part for select all items list
	public List selectAllArticles(Map pagingMap) {
	
		List articlesList = new ArrayList();
		int section = (Integer)pagingMap.get("section");
		int pageNum = (Integer)pagingMap.get("pageNum");
		
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT * FROM living";
			pstmt = conn.prepareStatement(query);
			
		} catch (Exception e) {
			System.out.println("selectAllArticles error : " + e.toString());
		}finally {
			
		}
		return articlesList;
		
	}//end of selectAllArticles
	
/*	//get one page of list
	public List<Map<String, Integer>> selectOnePageLivingList(){
		
		PagingVO pagingVO = new PagingVO();
		List<Map<String, Integer>> LivingOneArticleList = new ArrayList<Map<String,Integer>>();
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT * FROM living ORDER BY NUM DESC LIMIT ?,?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pagingVO.getStartPageNo());
			pstmt.setInt(2, pagingVO.getPageSize());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//���⼭���ʹ� �����ѱ� DB���� ��������
				
			}
			
		} catch (Exception e) {
			System.out.println("selectOnePageLivingList error : " + e.toString());			
		}finally {
			freeResource();
		}
		
		return LivingOneArticleList;
		
		
	}//end of selectLivingOnePageListItem
*/	
	
	//get total record count
	public int selectTotalCount() {
		
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM living";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch (Exception e) {
			System.out.println("selectTotalCount error : " + e.toString());
		}finally {
			freeResource();
		}
		
		return 0;
		
	}//end of selectTotalCount	
	
	//Increase plus 1 Number for NUM column
	private int getNewLivingArticleNo() {
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT max(NUM) FROM living";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
		} catch (Exception e) {
			System.out.println("getNewLivingArticleNo error : " + e.toString());
		}
		return 0;
	}//end of getNewLivingArticleNo
	
	
	//insert part for living item list
	public int insertLivingNewArticle(LivingVO livingVO) {
		int num = getNewLivingArticleNo();
		
		try {
			conn = DBConnection.getConnection();
			String query = "INSERT INTO living"
					+ "(productName,productContent,sellerName,productPrice,productImageName1,productImageName2,productImageName3,productQuantity,shipping_fee,point) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, livingVO.getProductName());
			pstmt.setString(2, livingVO.getProductContent());
			pstmt.setString(3, livingVO.getSellerName());
			pstmt.setInt(4, livingVO.getProductPrice());
			pstmt.setString(5, livingVO.getProductImageName1());
			pstmt.setString(6, livingVO.getProductImageName2());
			pstmt.setString(7, livingVO.getProductImageName3());
			pstmt.setInt(8, livingVO.getProductQuantity());
			pstmt.setInt(9, livingVO.getShipping_fee());
			pstmt.setInt(10, livingVO.getPoint());		
			
			pstmt.executeUpdate();
					
		}catch (Exception e) {
			System.out.println("insertNewArticle error : " + e.toString());
		}finally {
			freeResource();
		}		
		return num;
	}//end of insertNewArticle
	
	/*
	//update method part for living list
	public void updateLivingArticle(LivingVO livingVO) {
		try {
			conn = DBConnection.getConnection();
			String query = "UPDATE living SET product_name = ?, seller=?,sellingprice=?,order_qty=?,shipping_fee=?,living_content=?";
						if(livingVO.getPhoto_name() != null && livingVO.getPhoto_name().length() != 0) {
							query += ",photo_name=?";
						}
			query += "WHERE num=?";
			
			System.out.println(query);
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, livingVO.getProduct_name());
			pstmt.setString(2, livingVO.getSeller());
			pstmt.setInt(3, livingVO.getSellingprice());
			pstmt.setInt(4, livingVO.getOrder_qty());
			pstmt.setInt(6, livingVO.getShipping_fee());
			pstmt.setString(7, livingVO.getLiving_content());
			pstmt.setString(9, livingVO.getPhoto_name());
			pstmt.setInt(10, livingVO.getNum());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateLivingArticle error : " + e.toString());
		}finally {
			freeResource();
		}
	}//end of updateLivingArticle
	*/
	
	//delete part for living one item.
	public void deleteArticle(int NUM) {
		try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM living where NUM = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, NUM);
			pstmt.executeUpdate();					
					
		} catch (Exception e) {
			System.out.println("deleteArticle error : " + e.toString());
		}finally {
			freeResource();
		}
	}//end of deleteArticle
	
	
}//end DAO
