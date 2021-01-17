package Auction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import DBUtil.DBConnection;

public class AuctionDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private void freeResource() {
		try {
			if(conn != null) conn.close();
			if(pstmt !=null) pstmt.close();
			if(rs != null) rs.close();
		} catch (Exception e) {
			System.out.println("freeResource error : " +e.toString());
		}
	}//end of freeResource
	
	//plus 1
	public int getAuctionMaxNum() {
		int maxNum = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT MAX(num) FROM auction";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				maxNum = rs.getInt(1) + 1;
			}else {
				maxNum = 1;
			}
			
			
		} catch (Exception e) {
			System.out.println("getAuctionMaxNum error " + e.toString());
			e.printStackTrace();
		}finally {
			freeResource();
		}		
		return maxNum;		
	}//end of getAuctionMaxNum
	
	
	//get all boardlist count
	public int selectListCount() {
		int listCount = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM auction";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (Exception e) {
			System.out.println("selectListCount error : "+ e.toString());
		}finally {
			freeResource();
		}
		
		return listCount;
	}//end of selectListCount
	
	//select all article list of auction
	public List<AuctionVO> selectArticle(int pageNo, int listSize){
		  List<AuctionVO> articleList = new ArrayList<AuctionVO>();
		  
		  try {
			  conn = DBConnection.getConnection();
			  String query = "SELECT * FROM auction LIMIT ORDER BY num DESC ?,?";
			  pstmt = conn.prepareStatement(query);
			  pstmt.setInt(1, pageNo);
			  pstmt.setInt(2, listSize);
			  rs = pstmt.executeQuery();
			  
			  if(rs.next()) {
				  AuctionVO auctionVO = new AuctionVO();
				  auctionVO.setAuction_date(rs.getTimestamp("auction_date"));
				  auctionVO.setNum(rs.getInt("num"));
				  auctionVO.setProductContent(rs.getString("productContent"));
				  auctionVO.setProductImageName1(rs.getString("productImage1"));
				  auctionVO.setProductImageName1(rs.getString("productImage2"));
				  auctionVO.setProductImageName1(rs.getString("productImage3"));
				  auctionVO.setProductName(rs.getString("productName"));
				  auctionVO.setProductQuantity(rs.getInt("productQuantity"));
				  auctionVO.setSellerName(rs.getString("sellerName"));
				  auctionVO.setShipping_fee(rs.getInt("shipping_fee"));
				  auctionVO.setStartPrice(rs.getInt("startPrice"));
				  
			  }
			  
			 
			
		} catch (Exception e) {
			System.out.println("selectArticle error : " + e.toString());
		}finally {
			freeResource();
		}
		  return articleList;
	  
	}//end of selectArticle
 

	public void insertItem(AuctionVO auctionVO, int maxNum) {
		try {
			conn = DBConnection.getConnection();
			String query = "INSERT INTO auction (num,productName,productContent,sellerName,startPrice,"
					+ "productImageName1,productImageName2,productImageName3,productQuantity,shipping_fee,auction_date)"
					+ "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, maxNum);
			pstmt.setString(2, auctionVO.getProductName());
			pstmt.setString(3, auctionVO.getProductContent());
			pstmt.setString(4, auctionVO.getSellerName());
			pstmt.setInt(5, auctionVO.getStartPrice());
			pstmt.setString(6, auctionVO.getProductImageName1());
			pstmt.setString(7, auctionVO.getProductImageName2());
			pstmt.setString(8, auctionVO.getProductImageName3());
			pstmt.setInt(9, auctionVO.getProductQuantity());
			pstmt.setInt(10, auctionVO.getShipping_fee());			
			pstmt.setTimestamp(11, auctionVO.getAuction_date());
			
			pstmt.executeUpdate();		
					
					
				
		}catch (Exception e) {
			System.out.println("insertItem error : " + e.toString());
		}finally {
			freeResource();
			
		}
		
	}//end of insertItem
}
