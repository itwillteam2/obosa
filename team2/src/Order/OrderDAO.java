package Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import DBUtil.DBConnection;

public class OrderDAO {
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

	public void addOrder(OrderVO vo){
		int num=0;
		try{
			con = getConnection();
			String query = "select max(num) from orderList";
			
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}else{
				num = 1;
			}
			
			String id = vo.getId();
			String name = vo.getName();
			String cpnum = vo.getCpnum();
			String email = vo.getEmail();
			String postcode = vo.getPostcode();
			String address = vo.getAddress();
			String category = vo.getCategory();
			int itemnum = vo.getItemnum();
			String productName = vo.getProductName();
			String sellerName = vo.getSellerName();
			int quantity = vo.getQuantity();
			int price = vo.getPrice();
			int shipping_fee = vo.getShipping_fee();
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			query = "insert into orderList(num, id, name, cpnum, email, postcode, address, category, "
					+ "itemnum, productName, sellerName, quantity, price, shipping_fee, orderdate) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
			pstmt.setString(3, name);
			pstmt.setString(4, cpnum);
			pstmt.setString(5, email);
			pstmt.setString(6, postcode);
			pstmt.setString(7, address);
			pstmt.setString(8, category);
			pstmt.setInt(9, itemnum);
			pstmt.setString(10, productName);
			pstmt.setString(11, sellerName);
			pstmt.setInt(12, quantity);
			pstmt.setInt(13, price);
			pstmt.setInt(14, shipping_fee);
			pstmt.setTimestamp(15, timestamp);
			
			pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println("addOrder메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
	}//addOrder메소드 끝
	
	public List<OrderVO> orderList(String id) {
		List<OrderVO> orderList = new ArrayList<OrderVO>();
		try{
			OrderVO vo = new OrderVO();
			con = getConnection();
			String query = "select * from orderList where id=? order by num desc";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				vo.setNum(rs.getInt("num"));
				vo.setName(rs.getString("name"));
				vo.setCpnum(rs.getString("cpnum"));
				vo.setEmail(rs.getString("email"));
				vo.setPostcode(rs.getString("postcode"));
				vo.setAddress(rs.getString("address"));
				vo.setCategory(rs.getString("category"));
				vo.setItemnum(rs.getInt("itemNum"));
				vo.setProductName(rs.getString("productName"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setQuantity(rs.getInt("quantity"));
				vo.setPrice(rs.getInt("price"));
				vo.setPoint(rs.getInt("point"));
				vo.setShipping_fee(rs.getInt("shipping_fee"));
				vo.setOrderDate(rs.getTimestamp("orderDate"));
				orderList.add(vo);
			}
		}catch(Exception e){
			System.out.println("orderList메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
		return orderList;
	}//orderList 메소드 끝

}
