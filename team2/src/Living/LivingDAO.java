package Living;

import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import DBUtil.DBConnection;

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
	}//end
	
	
//  -------- 전체 상품 조회 ------- //
	public List<LivingVO> getAllContents() {
	
		List<LivingVO> livingList = new ArrayList<LivingVO>();
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT * FROM living";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			while(rs.next()){
				LivingVO vo = new LivingVO();
				vo.setNum(rs.getInt("num"));
				vo.setPoint(rs.getInt("point"));
				vo.setProductContent(rs.getString("productContent"));
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductImageName2(rs.getString("productImageName2"));
				vo.setProductImageName3(rs.getString("productImageName3"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setProductQuantity(rs.getInt("productQuantity"));
				vo.setReg_date(rs.getTimestamp("regDate"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setShipping_fee(rs.getInt("shipping_fee"));
				livingList.add(vo);
			}
			
		} catch (Exception e) {
			System.out.println("getAllContents error : " + e.toString());
		}finally {
			freeResource();
		}
		return livingList;
		
	}//end
	
	
//  -------- 특정 상품 조회 ------- //
	public LivingVO getContent(int livingNum) {
		LivingVO livingVO = new LivingVO();
		
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT * FROM living WHERE NUM = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, livingNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				livingVO.setNum(rs.getInt("num"));
				livingVO.setPoint(rs.getInt("point"));
				livingVO.setProductContent(rs.getString("productContent"));
				livingVO.setProductImageName1(rs.getString("productImageName1"));
				livingVO.setProductImageName2(rs.getString("productImageName2"));
				livingVO.setProductImageName3(rs.getString("productImageName3"));
				livingVO.setProductName(rs.getString("productName"));
				livingVO.setProductPrice(rs.getInt("productPrice"));
				livingVO.setProductQuantity(rs.getInt("productQuantity"));
				livingVO.setReg_date(rs.getTimestamp("regDate"));
				livingVO.setSellerName(rs.getString("sellerName"));
				livingVO.setShipping_fee(rs.getInt("shipping_fee"));
			}
		} catch (Exception e) {
			System.out.println("getContent error : " + e.toString());
		}finally {
			freeResource();
		}
		return livingVO;
	}//end
	
//  -------- 전체 상품 개수 조회 ------- //
	public int getTotalCount() {
		int num = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM living";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				 rs.getInt(1);
			}
			return num;
		}catch (Exception e) {
			System.out.println("getTotalCount error : " + e.toString());
		}finally {
			freeResource();
		}
		return num;
	}//end
	
//  -------- 상품 등록 ------- //	
	public int insertContent(LivingVO livingVO) {
		int num = 0;
		String sql ="";
		
		try {
			conn = DBConnection.getConnection();
			sql = "select max(num) from living";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){ num = rs.getInt(1) + 1;
			}else{ num = 1; }

			String query = "INSERT INTO living"
<<<<<<< Updated upstream
					+ "(num, productName,productContent,sellerName,productPrice,productImageName1,productImageName2,productImageName3,productQuantity,shipping_fee,point,category) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
=======
					+ "(num,productName,productContent,sellerName,productPrice,productImageName1,productImageName2,productImageName3,productQuantity,shipping_fee,point) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?)";
>>>>>>> Stashed changes
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, num);		
			pstmt.setString(2, livingVO.getProductName());
			pstmt.setString(3, livingVO.getProductContent());
			pstmt.setString(4, livingVO.getSellerName());
			pstmt.setInt(5, livingVO.getProductPrice());
			pstmt.setString(6, livingVO.getProductImageName1());
			pstmt.setString(7, livingVO.getProductImageName2());
			pstmt.setString(8, livingVO.getProductImageName3());
			pstmt.setInt(9, livingVO.getProductQuantity());
			pstmt.setInt(10, livingVO.getShipping_fee());
			pstmt.setInt(11, livingVO.getPoint());		
			pstmt.setString(12, "living");
			
			pstmt.executeUpdate();
					
		}catch (Exception e) {
			System.out.println("insertContent error : " + e.toString());
		}finally {
			freeResource();
		}		
		return num;
	}//end 
	
<<<<<<< Updated upstream
	
	//insert part for living item list
//	public int insertLivingNewArticle(LivingVO livingVO) {
//		int num = getNewLivingArticleNo();
//		
//		try {
//			conn = DBConnection.getConnection();
//			String query = "INSERT INTO living"
//					+ "(productName,productContent,sellerName,productPrice,productImageName1,productImageName2,productImageName3,productQuantity,shipping_fee,point,num) "
//					+ "VALUES(?,?,?,?,?,?,?,?,?,?,5)";
//			pstmt = conn.prepareStatement(query);
//			
//			pstmt.setString(1, livingVO.getProductName());
//			pstmt.setString(2, livingVO.getProductContent());
//			pstmt.setString(3, livingVO.getSellerName());
//			pstmt.setInt(4, livingVO.getProductPrice());
//			pstmt.setString(5, livingVO.getProductImageName1());
//			pstmt.setString(6, livingVO.getProductImageName2());
//			pstmt.setString(7, livingVO.getProductImageName3());
//			pstmt.setInt(8, livingVO.getProductQuantity());
//			pstmt.setInt(9, livingVO.getShipping_fee());
//			pstmt.setInt(10, livingVO.getPoint());		
//			
//			pstmt.executeUpdate();
//					
//		}catch (Exception e) {
//			System.out.println("insertNewArticle error : " + e.toString());
//		}finally {
//			freeResource();
//		}		
//		return num;
//	}//end of insertNewArticle
	
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
=======
//  -------- 상품 수정 ------- //		
	public void updateContent(LivingVO livingVO) {
		try {
			conn = DBConnection.getConnection();
			String query = "UPDATE living SET productName=?,productContent=?,sellerName=?,productPrice=?,"
					+"productImageName1=?,productImageName2=?,productImageName3=?,"
					+"productQuantity=?,shipping_fee,point=?"
			        +" WHERE num=?";
				
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
			pstmt.setInt(10, livingVO.getNum());	
>>>>>>> Stashed changes
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateContent error : " + e.toString());
		}finally {
			freeResource();
		}
	}//end 
	
//  -------- 상품 삭제 ------- //	
	public void deleteContent(int NUM) {
		try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM living where NUM = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, NUM);
			pstmt.executeUpdate();					
					
		} catch (Exception e) {
			System.out.println("deleteContent error : " + e.toString());
		}finally {
			freeResource();
		}
	}//end

	
	public int insertNewReply(LivingRepVO livingRepVO) {
		int rnum = 0;
		String sql ="";
		
		try {
			conn = DBConnection.getConnection();
			sql = "select max(num) from living_rep";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){ 	rnum = rs.getInt(1) + 1;
			}else{	rnum = 1; }
			
			int num = livingRepVO.getNum();
			System.out.println(num);
			String pw = livingRepVO.getPw();
			String content = livingRepVO.getContent();
			String writer = livingRepVO.getWriter();

			String query = "INSERT INTO living_rep(num, pw, content, writer)"
					+ "VALUES(?, ?, ?, ?)";

			pstmt = conn.prepareStatement(query);

			pstmt.setInt(1, num);
			pstmt.setString(2, pw);
			pstmt.setString(3, content);
			pstmt.setString(4, writer);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}
		return rnum;
	}//end

		
	
}//end DAO