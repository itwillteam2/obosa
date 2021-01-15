package Auction;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
