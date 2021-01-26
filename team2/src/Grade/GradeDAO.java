package Grade;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GradeDAO {
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
			System.out.println("release error : " + exception);
		}
	}//release메소드 끝
	
	public int getGradeAvg(int pnum, String category) {
		int result=0;
		try{
			con = getConnection();
			String query=null;
			
			query = "select avg(grade) from grade "
					+"where pnum=? and category=?";
			
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, pnum);
			pstmt.setString(2, category);
			rs = pstmt.executeQuery();
	        if(rs.next()) {
	        	result = rs.getInt("avg(grade)");
	        }
		}catch(Exception e){
			System.out.println("getGradeAvg메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
		return result;
	}//end

	public int getGrade(int pnum, String category, String id, int rNum) {
		int result=0;
		try{
			con = getConnection();
			String query=null;
			
			query = "select grade from grade "
					+"where pnum=? and category=? and id=? and repNum=?";
			
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, pnum);
			pstmt.setString(2, category);
			pstmt.setString(3, id);
			pstmt.setInt(4, rNum);
			
			rs = pstmt.executeQuery();
	    
			if(rs.next()) {
	        	result = rs.getInt("grade");
	        }
		}catch(Exception e){
			System.out.println("getGrade메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
		return result;
	}//end
	
	
	public int addGrade(String id, int pnum, String category, int rNum, int grade) {
		int result=0;
			try{
				con = getConnection();
				String query=null;
				
				query = "insert into grade(id,pnum,category,repNum,grade) "
						+ "values(?,?,?,?,?)";
				
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, id);
				pstmt.setInt(2, pnum);
				pstmt.setString(3, category);
				pstmt.setInt(4, rNum);
				pstmt.setInt(5, grade);
				
				pstmt.executeUpdate();
			}catch(Exception e){
				System.out.println("addGrade메소드 내부에서 오류 발생 : " + e);
			}finally{
				release();
			}
		  return result;
		
	}//addCustomer메소드 끝
}
