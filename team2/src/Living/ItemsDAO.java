package Living;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBUtil.DBConnection;

public class ItemsDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	final String CATEGORY = "living";
	
	public void freeResource() {
		try {
			if(conn != null) conn.close();
			if(pstmt != null) pstmt.close();
			if(rs != null) rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//end

	//select all articles list of crafts.
	public List<ItemsVO> getAllContents(int pageNO, int listSize, String ord) {
		List<ItemsVO> contentLIst = new ArrayList<ItemsVO>();
		try {
			conn = DBConnection.getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "SELECT * FROM "+CATEGORY+" order by regdate desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "SELECT * FROM "+CATEGORY+" order by productprice "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "SELECT * FROM "+CATEGORY+" order by productprice desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);
			}
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ItemsVO vo = new ItemsVO();
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
				contentLIst.add(vo);
			}
						
		} catch (Exception e) {
			System.out.println("getAllContents error : " + e.toString());
		}finally {
			freeResource();
		}
		return contentLIst;
	}//end of selectAllArticles
	
//  -------- 전체 상품 개수 조회 ------- //
	public int getTotalCount() {
		int num = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM "+CATEGORY;
			pstmt = conn.prepareStatement(query);
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
	}//end of selectTotalCount

//  -------- 상품 등록 ------- //	
	public int insertContent(ItemsVO vo) {
		int num = 0;
		String sql ="";
		
		try {
			conn = DBConnection.getConnection();
			sql = "select max(num) from "+CATEGORY;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){ num = rs.getInt(1) + 1;
			}else{ num = 1; }

			String query = "INSERT INTO "+CATEGORY
					+ "(num, productName,productContent,sellerName,productPrice,productImageName1,productImageName2,productImageName3,productQuantity,shipping_fee,point,category) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, num);		
			pstmt.setString(2, vo.getProductName());
			pstmt.setString(3, vo.getProductContent());
			pstmt.setString(4, vo.getSellerName());
			pstmt.setInt(5, vo.getProductPrice());
			pstmt.setString(6, vo.getProductImageName1());
			pstmt.setString(7, vo.getProductImageName2());
			pstmt.setString(8, vo.getProductImageName3());
			pstmt.setInt(9, vo.getProductQuantity());
			pstmt.setInt(10, vo.getShipping_fee());
			pstmt.setInt(11, vo.getPoint());		
			pstmt.setString(12, CATEGORY);
			
			pstmt.executeUpdate();
					
		}catch (Exception e) {
			System.out.println("insertContent error : " + e.toString());
		}finally {
			freeResource();
		}		
		return num;
	}//end 
	
//  -------- 특정 상품 조회 ------- //
	public ItemsVO getContent(int num) {
		ItemsVO vo = new ItemsVO();
		
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT * FROM "+CATEGORY+ " WHERE num = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
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
				vo.setCategory(rs.getString("category"));
			}
		} catch (Exception e) {
			System.out.println("getContent error : " + e.toString());
		}finally {
			freeResource();
		}
		return vo;
	}//end

//  -------- 상품 수정 ------- //		
	public int updateContent(ItemsVO vo) {
		int num = 0;
		
		try {
			conn = DBConnection.getConnection();
			String query = "UPDATE "+CATEGORY+" SET productName=?,productContent=?,sellerName=?,productPrice=?,"
					+"productImageName1=?,productImageName2=?,productImageName3=?,"
					+"productQuantity=?,shipping_fee=?,point=?"
			        +" WHERE num=?";
				
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, vo.getProductName());
			pstmt.setString(2, vo.getProductContent());
			pstmt.setString(3, vo.getSellerName());
			pstmt.setInt(4, vo.getProductPrice());
			pstmt.setString(5, vo.getProductImageName1());
			pstmt.setString(6, vo.getProductImageName2());
			pstmt.setString(7, vo.getProductImageName3());
			pstmt.setInt(8, vo.getProductQuantity());
			pstmt.setInt(9, vo.getShipping_fee());
			pstmt.setInt(10, vo.getPoint());	
			pstmt.setInt(11, vo.getNum());
			
			pstmt.executeUpdate();
	
			num = vo.getNum();

		} catch (Exception e) {
			System.out.println("updateContent error : " + e.toString());
		}finally {
			freeResource();
		}
	return num;
	}//end 
	
//  -------- 상품 삭제 ------- //	
	public int deleteContent(int NUM) {
		int num =0;
		try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM "+CATEGORY+" where NUM = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, NUM);
			pstmt.executeUpdate();					
			
			num=1;
		} catch (Exception e) {
			System.out.println("deleteContent error : " + e.toString());
		}finally {
			freeResource();
		}
		return num;
	}//end

	
	public int insertNewReply(ItemsRepVO repVO) {
		int rnum = 0;
		String sql ="";
		
		try {
			conn = DBConnection.getConnection();
			sql = "select max(num) from "
			+CATEGORY+"_rep";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){ 	rnum = rs.getInt(1) + 1;
			}else{	rnum = 1; }
			
			int num = repVO.getNum();
			System.out.println(num);
			String pw = repVO.getPw();
			String content = repVO.getContent();
			String writer = repVO.getWriter();

			String query = "INSERT INTO "+CATEGORY+"_rep(num, pw, content, writer)"
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

}
