package Common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DBUtil.DBConnection;
import Living.ItemsVO;

public class NewArrivalDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public void freeResource() {
		try {
			if(conn != null) conn.close();
			if(pstmt != null) pstmt.close();
			if(rs != null) rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<NewArrrivalVO> NewArrivalList() {
		List<NewArrrivalVO> NewArrivalList = new ArrayList<NewArrrivalVO>();
		try {
			conn = DBConnection.getConnection();

			String query = "select num, productImageName1, productName, productPrice, regdate, category"
					+ " from living union all"			
					+ " select num, productImageName1, productName, productPrice, regdate, category"
					+ " from crafts union all"
					+ " select num, productImageName1, productName, productPrice, regdate, category"
					+ " from fancy order by regdate desc limit 0,10";
			
			pstmt = conn.prepareStatement(query);	
			rs = pstmt.executeQuery();
			while(rs.next()) {
				NewArrrivalVO vo = new NewArrrivalVO();
				vo.setNum(rs.getInt("num"));
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getString("productPrice"));
				vo.setRegdate(rs.getTimestamp("regdate"));
				vo.setCategory(rs.getString("category"));
				NewArrivalList.add(vo);

			}
						
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return NewArrivalList;
	}
}
