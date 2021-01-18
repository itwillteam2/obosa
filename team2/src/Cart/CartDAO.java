package Cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import DBUtil.DBConnection;

public class CartDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
		
	private Connection getConnection() throws Exception{
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/team2");
		conn = ds.getConnection();
		return conn;
	}//end
	
	public void freeResource(){
		try{
			if(pstmt != null) pstmt.close();
			if(rs != null) rs.close();
			if(conn != null) conn.close();
			System.out.println("해제");
		}catch(Exception exception){
			System.out.println("freeResource error : " + exception);
		}
	}//end

//  -------- 전체 장바구니 내용 조회 ------- //
	public List<CartVO> getAllCartContent(String customer_id) {
		List<CartVO> cartList = new ArrayList<CartVO>();
		
		try {
			conn = getConnection();
			String query = "SELECT * FROM cart WHERE customer_id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,customer_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				CartVO vo = new CartVO();
			
				vo.setPnum(rs.getInt("pnum"));
				vo.setCategory(rs.getString("category"));
				vo.setCustomer_id(rs.getString("customer_id"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setCartQuantity(rs.getInt("cartQuantity"));
				vo.setShipping_fee(rs.getInt("shipping_fee"));
				vo.setPoint(rs.getInt("point"));
				vo.setTotalPrice(rs.getInt("totalPrice"));
				vo.setCdate(rs.getTimestamp("cdate"));
				cartList.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("getAllCartContent error : " + e);
		}finally {
			freeResource();
		}
		return cartList;
	}//end
	
//  -------- 장바구니 내용 개수 조회 ------- //
	public int getTotalCount(String customer_id) {
		int num = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM cart "
							+"WHERE customer_id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,customer_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1);
			}
		}catch (Exception e) {
			System.out.println("getTotalCount error : " + e.toString());
		}finally {
			freeResource();
		}
		return num;
	}//end

//  -------- 특정 상품 조회 등록 - 장바구니 입력에 사용------- //	
	
	public CartVO getContent(int pnum, String category) {
		CartVO vo = new CartVO();
		
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT * FROM "+category+" WHERE num=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setProductName(rs.getString("productName"));
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setShipping_fee(rs.getInt("shipping_fee"));
				vo.setPoint(rs.getInt("point"));
			}
		} catch (Exception e) {
			System.out.println("getContent error : " + e.toString());
		}finally {
			freeResource();
		}
		return vo;
	}//end
	
//  -------- 장바구니 내용 개수 조회 ------- //
	
	public int getContentCount(int pnum, String category,String customer_id) {
		int num = 0;
		System.out.println(customer_id);
		
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM cart WHERE pnum=? and category=? and customer_id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1,pnum);
			pstmt.setString(2,category);
			pstmt.setString(3,customer_id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1);
				System.out.println("count:" +num);
				if(num==0) num=1;
			}
		}catch (Exception e) {
			System.out.println("getTotalCount error : " + e.toString());
		}finally {
			freeResource();
		}
		return num;
	}//end

//  -------- 장바구니 내용 및 중복 조회 ------- //
	public CartVO getCartContent(int pnum, String category,String customer_id) {
		
		System.out.println("gcc:"+pnum+","+category+","+customer_id);
		
		CartVO vo = new CartVO();
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT * FROM cart WHERE pnum = ? and category=? and customer_id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pnum);
			pstmt.setString(2, category);
			pstmt.setString(3, customer_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setCartQuantity(rs.getInt("cartQuantity"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setShipping_fee(rs.getInt("shipping_fee"));
				vo.setPoint(rs.getInt("point"));
				vo.setTotalPrice(rs.getInt("totalPrice"));
			}		
		} catch (Exception e) {
			System.out.println("getCartContent error : " + e.toString());
		}finally {
			freeResource();
		}
		return vo;
	}//end
	
	
//  -------- 장바구니 등록 ------- //	
	public int insertContent(int pnum, String category, String customer_id, int cartQuantity) {
		int num=0;
		int totalPrice = 0;
		String sql ="";
		try {
			CartVO vo = new CartVO();
			vo=getCartContent(pnum,category,customer_id);
			if(vo.getCartQuantity()==0) {
				vo=getContent(pnum, category);
				totalPrice = vo.getProductPrice()*cartQuantity+vo.getShipping_fee();
				conn = DBConnection.getConnection();
				pstmt = conn.prepareStatement(sql);
				String query = "INSERT INTO cart "
						+ "(pnum,category,customer_id,productName,sellerName,productPrice,productImageName1,cartQuantity,shipping_fee,point,totalPrice,cDate) "
						+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,now())";
	
				pstmt = conn.prepareStatement(query);
				pstmt.setInt(1,pnum);		
				pstmt.setString(2, category);
				pstmt.setString(3, customer_id);
				pstmt.setString(4, vo.getProductName());
				pstmt.setString(5, vo.getSellerName());
				pstmt.setInt(6, vo.getProductPrice());
				pstmt.setString(7, vo.getProductImageName1());
				pstmt.setInt(8, cartQuantity);
				pstmt.setInt(9, vo.getShipping_fee());
				pstmt.setInt(10, vo.getPoint());		
				pstmt.setInt(11, totalPrice);
	
				pstmt.executeUpdate();
	
				num=getContentCount(pnum,category,customer_id);
			} else {
				cartQuantity +=vo.getCartQuantity();
				totalPrice= vo.getProductPrice()*cartQuantity+vo.getTotalPrice();
				updateContent(pnum,category,customer_id,cartQuantity,totalPrice);
				num=getContentCount(pnum,category,customer_id);
			}
		}catch (Exception e) {
			System.out.println("insertContent error : " + e.toString());
		}finally {
			freeResource();
		}		
		return num; // 장바구니 내용 개수 반환
	}//end 
	

//  -------- 장바구니 수정 ------- //		
	public int updateContent(int pnum, String category, String customer_id, int cartQuantity, int totalPrice) {
		int num=0;
		System.out.println("utc var:"+ cartQuantity+","+totalPrice );
		
		try {
			conn = DBConnection.getConnection();
			String query = "UPDATE cart SET cartQuantity=?,totalPrice=? "
					+ "WHERE pnum=? and category=? and customer_id=?";
				
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, cartQuantity);
			pstmt.setInt(2, totalPrice);	
			pstmt.setInt(3, pnum);
			pstmt.setString(4, category);
			pstmt.setString(5, customer_id);
			pstmt.executeUpdate();	
			num=1;	// 업데이트 성공시 1 반환	
		} catch (Exception e) {
			System.out.println("updateContent error : " + e.toString());
		}finally {
			freeResource();
		}
	return num;
	}//end 
	
	
//  -------- 상품 삭제 ------- //	
	public int deleteContent(int pnum, String category, String customer_id) {
		int num =0;
		try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM cart "
					+ "WHERE pnum=? and category=? and customer_id=?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, pnum);
			pstmt.setString(2, category);
			pstmt.setString(3, customer_id);
			pstmt.executeUpdate();						
			num=1; // 삭제 성공시 1 반환
		} catch (Exception e) {
			System.out.println("deleteContent error : " + e.toString());
		}finally {
			freeResource();
		}
		return num;
	}//end

}//end class
