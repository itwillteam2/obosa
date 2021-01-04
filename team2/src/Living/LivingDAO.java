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
	}//end of freeResource
	
	//get list of one page.
	public List<Map<String,Object>> getLivingList(Map<String,Object> LivingListMap){
		
		List<Map<String, Object>> productList = new ArrayList<Map<String,Object>>();
		
		int numberPerPage = 10; // 
		int pageNo = (int)LivingListMap.get("num");
		int offset = (pageNo - 1) * 10;
		String kwd = (String)LivingListMap.get("kwd");
		
		
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT * FROM living ORDER BY num LIMIT ?,?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, offset);
			pstmt.setInt(2, numberPerPage);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				Map<String,Object> livingMap = new HashMap<String, Object>();
				int num = rs.getInt("num");
				String productName = rs.getString("productName");
				String productContent = rs.getString("productContent");
				String sellerName = rs.getString("sellerName");
				int productPrice = rs.getInt("productPrice");
				String productImageName1 = rs.getString("productImageName1");
				String productImageName2 = rs.getString("productImageName2");
				String productImageName3 = rs.getString("productImageName3");
				int productQuantity = rs.getInt("productQuantity");
				int shipping_fee = rs.getInt("shipping_fee");
				int point = rs.getInt("point");
				Timestamp reg_date = rs.getTimestamp("regDate");
				
				
				LivingVO livingVO = new LivingVO();
				livingVO.setNum(num);
				livingVO.setPoint(point);
				livingVO.setProductContent(productContent);
				livingVO.setProductImageName1(productImageName1);
				livingVO.setProductImageName2(productImageName2);
				livingVO.setProductImageName3(productImageName3);
				livingVO.setProductName(productName);
				livingVO.setProductPrice(productPrice);
				livingVO.setProductQuantity(productQuantity);
				livingVO.setReg_date(reg_date);
				livingVO.setSellerName(sellerName);
				livingVO.setShipping_fee(shipping_fee);
				
				livingMap.put("livingVO", livingVO);
				productList.add(livingMap);
				
				
			}		
			
		} catch (Exception e) {
			System.out.println("getProductList error " + e.toString());
		}finally {
			freeResource();
		}
		
		return productList;
		
	}//end of getProductList

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
	
	public int addLiving(LivingVO livingVO) {
		int num = 0;

		String sql ="";
		
		try {
			conn = DBConnection.getConnection();
			sql = "select max(num) from living";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}else{
				num = 1;
			}

			String query = "INSERT INTO living"
					+ "(num, productName,productContent,sellerName,productPrice,productImageName1,productImageName2,productImageName3,productQuantity,shipping_fee,point) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, livingVO.getNum());
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
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				freeResource();
			}	
		}

		return num;
	}
	
	
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

	public LivingVO selectContent(int num) {
		LivingVO content = new LivingVO();
		try {
			conn = DBConnection.getConnection();
			String query = "select * from living where num=?";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, num);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			int _num = rs.getInt("num");
			String productName = rs.getString("productName");
			String productContent = rs.getString("productContent");
			String sellerName = rs.getString("SellerName");
			int productPrice = rs.getInt("productPrice");
			String productImageName1 = rs.getString("ProductImageName1");
			String productImageName2 = rs.getString("ProductImageName2");
			String productImageName3 = rs.getString("ProductImageName3");
			int productQuantity = rs.getInt("ProductQuantity");
			int shipping_fee = rs.getInt("Shipping_fee");
			int point = rs.getInt("Point");
			Timestamp regdate = rs.getTimestamp("regdate");

			content.setNum(_num);
			content.setProductName(productName);
			content.setProductContent(productContent);
			content.setSellerName(sellerName);
			content.setProductPrice(productPrice);
			content.setProductImageName1(productImageName1);
			content.setProductImageName2(productImageName2);
			content.setProductImageName3(productImageName3);
			content.setProductQuantity(productQuantity);
			content.setShipping_fee(shipping_fee);
			content.setPoint(point);
			content.setReg_date(regdate);

			
		} catch (Exception e) {
			System.out.println("selectContent error : " + e.toString());
		}finally {
			freeResource();
		}
		return content;
	}

	public int insertNewReply(LivingRepVO livingRepVO) {

		int rnum = 0;

		String sql ="";
		
		try {
			conn = DBConnection.getConnection();
			sql = "select max(num) from living_rep";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				rnum = rs.getInt(1) + 1;
			}else{
				rnum = 1;
			}
			
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
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return rnum;

	}

	
	
	
}//end DAO