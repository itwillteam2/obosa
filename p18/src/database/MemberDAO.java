package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;;

public class MemberDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null; 
	ResultSet rs = null;
	
	private Connection getConnection() throws Exception{

		Context init = new InitialContext();
		
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		
		con = ds.getConnection();
		
		return con;
	}
	
	public void Resource(){
		try{
			if(pstmt != null){pstmt.close();}
			if(rs != null){rs.close();}
			if(con != null){con.close();}
		}catch(Exception exception){
			System.out.println("Resource Release �떎�뙣 : " + exception);
		}
	}
	
	public void addMember(SignUp signup){
		
		try {
			con = getConnection();

			String id = signup.getId2();
			String pw = signup.getPw2();
			String name = signup.getName2();
			String address = signup.getAddress2();

			String query = "insert into KDH(id,pw,name,address)values(?,?,?,?)";
			
			pstmt = con.prepareStatement(query);

			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, address);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			
			System.out.println("addMember占쏙옙占쏙옙 占쏙옙占쏙옙 : " + e.toString());
		}finally{
			Resource();
		}		
	}
	
	public void ModifyUp(String id, String pw, String name, String address){		
		try {		
			con = getConnection();
			
			String query = "update KDH set pw=?, name=?, address=? where id=?" ;

			pstmt = con.prepareStatement(query);

			pstmt.setString(1, pw);
			pstmt.setString(2, name);
			pstmt.setString(3, address);
			pstmt.setString(4, id);
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			
			System.out.println("ModifyUp占쏙옙占쏙옙 占쏙옙占쏙옙 : " + e.toString());
		}finally{
			Resource();
		}		
	}
	public void Delete(String id){
		try {		
			con = getConnection();
			
			String query = "Delete From KDH where id=?" ;
			
			pstmt = con.prepareStatement(query);

			pstmt.setString(1, id);
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			
			System.out.println("DeleteUp占쏙옙占쏙옙 占쏙옙占쏙옙 : " + e.toString());
		}finally{
			Resource();
		}	
	}
	
	public void Select(String id){
		
		try {		
			con = getConnection();
			
			String pw = null;
			String name = null;
			String address = null;
			String query = "Select * from KDH where id = ? " ;
			
			pstmt = con.prepareStatement(query);

			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				id = rs.getString(id);
				pw = rs.getString(pw);
				name = rs.getString(name);
				address = rs.getString(address);
			}	
		} catch (Exception e) {
			
			System.out.println("select占쏙옙占쏙옙 占쏙옙占쏙옙 : " + e.toString());
		}finally{
			Resource();
		}	
	}
	public List listMembers(){
		List list = new ArrayList();
		
		try{
			con = getConnection();
			
			String query = "select * from KDH";
			
			pstmt = con.prepareStatement(query);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				String id = rs.getString("id");
				String pw = rs.getString("pw");
				String name = rs.getString("name");
				String address = rs.getString("address");
				
				SignUp signup = new SignUp();
				signup.setId2(id);
				signup.setPw2(pw);
				signup.setName2(name);
				signup.setAddress2(address);
				list.add(signup);
			}
			
		}catch (Exception e) {
			
			System.out.println("List占쏙옙占쏙옙 占쏙옙占쏙옙 : " + e.toString());
		}finally{
			Resource();
		}
		return list;	
	}
	
	public int userCheck(String id, String pw){
		
		int check = -1;
		
		try {
			con = getConnection();
			
			String query = "select * from KDH where id = ?";
			
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){			
					check = 1;
				}else{
					check = 0;
				}			
			}else{
				check = -1;
			}			
		}catch(Exception e) {
			System.out.println("userCheck �궡遺� 硫붿냼�뱶�뿉�꽌 �삤瑜� : " + e.toString());

		}finally{
			Resource();
		}
		return check;
	}
	
	public int idCheck(String id){
		
		String sql = "";
		
		int check = 0;
		try{
			con = getConnection();

			sql = "select * from kdh where id = ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			
			if(rs.next()){
				check = 1;			
			}else{
				check = 0;
			}
		}catch(Exception exception){
			System.out.println("idCheck 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + exception);
		}finally{
			Resource();
		}
		return check;	
	}
	
	public int getMemberCount(){
		
		int count = 0;
		
		String sql = "";
		
		try {
			con = getConnection();

			sql = "select count(*) from kdh";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}			
		}catch(Exception e) {
			System.out.println("getMemberCount 메소드 내부에서 오류 : " + e);
		}finally{
			Resource();
		}
		return count;	
		
	}
	
	public List<SignUp> getMemberList(int startRow, int pageSize){
		
		String sql = "";
		
		List<SignUp> memberList = new ArrayList<SignUp>();
	
		try {
			con = getConnection();

			sql = "select * from kdh order by name limit ?, ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){				
				SignUp su = new SignUp();
				su.setId2(rs.getString("id"));
				su.setPw2(rs.getString("pw"));
				su.setName2(rs.getString("name"));
				su.setAddress2(rs.getString("address"));
				
				memberList.add(su);
				
			}		
		}catch(Exception e) {
			System.out.println("getBoardList 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� :" + e);
		}finally{
			Resource();
		}
		return memberList;
		
	}
	
	public List<SignUp> getMemberSearch(String search, String searchText, int startRow, int pageSize){
		String sql = "";
		
		List<SignUp> memberList = new ArrayList<SignUp>();		
		try {
			con = getConnection();
			
			sql = "select * from kdh where " + search + " like '%" + searchText + "%' order by name limit ?, ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				SignUp bBean = new SignUp();
				bBean.setId2(rs.getString("id"));
				bBean.setPw2(rs.getString("pw"));
				bBean.setName2(rs.getString("name"));
				bBean.setAddress2(rs.getString("address"));
				memberList.add(bBean);
			}
		} catch (Exception e) {
			System.out.println("getMemberSearch 메소드 내부에서 오류 :" + e);
		}finally{
			Resource();
		}
		
		return memberList;
		
	}
}
