package Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
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
	
	public boolean overlappedID(String id){
	      
	      boolean result = false;
	      
	      try{
	         con = getConnection();

	         String query = "select (case count(*) when 1 then 'true' else 'false' end) as result "
	         		+ "from (select id from customer where id=? union select id from seller where id = ?) a";
	               
	         pstmt = con.prepareStatement(query);
	         pstmt.setString(1, id);
	         pstmt.setString(2, id);
	         rs = pstmt.executeQuery();
	         rs.next();
	         
	         result = Boolean.parseBoolean(rs.getString("result"));
	         System.out.println(result);
	         
	         
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally {
	         release();
	      }
	      return result;
	   }//overlappedID메소드 끝
	
	public boolean overlappedEmail(String email){
	      
	      boolean result = false;
	      
	      try{
	         con = getConnection();

	         String query = "select (case count(*) when 1 then 'true' else 'false' end) as result "
	         		+ "from (select email from customer where email=? union select email from seller where email = ?) a";
	               
	         pstmt = con.prepareStatement(query);
	         pstmt.setString(1, email);
	         pstmt.setString(2, email);
	         rs = pstmt.executeQuery();
	         rs.next();
	         
	         result = Boolean.parseBoolean(rs.getString("result"));
	         System.out.println(result);
	         
	         
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally {
	         release();
	      }
	      return result;
	   }//overlappedEmail메소드 끝
	
	public void addCustomer(MemberVO vo) {
		try{
			con = getConnection();
			
			int num=0;
			
			String query = "select max(num) from customer";
			
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}else{
				num = 1;
			}
			
			String id = vo.getId();
			String pwd = vo.getPwd();
			String name = vo.getName();
			String cpnum = vo.getCpnum();
			String email = vo.getEmail();
			String postcode = vo.getPostcode();
			String addr1 = vo.getAddr1();
			String addr2 = vo.getAddr2();
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			query = "insert into customer(num, id, pwd, name, cpnum, email, postcode, addr1, addr2, joinDate) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			System.out.println(query);
			
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
			pstmt.setString(3, pwd);
			pstmt.setString(4, name);
			pstmt.setString(5, cpnum);
			pstmt.setString(6, email);
			pstmt.setString(7, postcode);
			pstmt.setString(8, addr1);
			pstmt.setString(9, addr2);
			pstmt.setTimestamp(10, timestamp);
			
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("addCustomer메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
	}//addCustomer메소드 끝
	
	public void addSeller(MemberVO vo) {
		try{
			con = getConnection();
			int num=0;
			
			String query = "select max(num) from seller";
			
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}else{
				num = 1;
			}
			
			String id = vo.getId();
			String pwd = vo.getPwd();
			String businessRegNum = vo.getBusinessRegNum();
			String shopName = vo.getShopName();
			String pnum = vo.getPnum();
			String cpnum = vo.getCpnum();
			String email = vo.getEmail();
			String postcode = vo.getPostcode();
			String addr1 = vo.getAddr1();
			String addr2 = vo.getAddr2();
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			query = "insert into seller(num, id, pwd, businessRegNum, shopName, pnum, cpnum, email, postcode, addr1, addr2, joinDate) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			System.out.println(query);
			
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
			pstmt.setString(3, pwd);
			pstmt.setString(4, businessRegNum);
			pstmt.setString(5, shopName);
			pstmt.setString(6, pnum);
			pstmt.setString(7, cpnum);
			pstmt.setString(8, email);
			pstmt.setString(9, postcode);
			pstmt.setString(10, addr1);
			pstmt.setString(11, addr2);
			pstmt.setTimestamp(12, timestamp);
			
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("addSeller메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
	}//addSeller메소드 끝

	public Boolean login(MemberVO vo) {
		Boolean check = false;
		try{
			con = getConnection();
			
			String id = vo.getId();
			String pwd = vo.getPwd();
			
			String query = "select * from (select id, pwd from customer where id=? and pwd=?"
					+ " union select id, pwd from seller where id=? and pwd=?) a";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, id);
			pstmt.setString(4, pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
					check = true;
			}else{
					check = false;
			}
			
		}catch(Exception e){
			System.out.println("login메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
		
		return check;
	}//login메소드 끝

	public MemberVO searchUser(String id) {
		MemberVO vo = new MemberVO();
		
		try{
			con = getConnection();
			String query = "select * from customer where id=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				vo.setPwd(rs.getString("pwd"));
				vo.setName(rs.getString("name"));
				vo.setCpnum(rs.getString("cpnum"));
				vo.setEmail(rs.getString("email"));
				vo.setPostcode(rs.getString("postcode"));
				vo.setAddr1(rs.getString("addr1"));
				vo.setAddr2(rs.getString("addr2"));
			}else{
				query = "select * from seller where id=?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()){
					vo.setPwd(rs.getString("pwd"));
					vo.setBusinessRegNum(rs.getString("businessRegNum"));
					vo.setShopName(rs.getString("shopName"));
					vo.setPnum(rs.getString("pnum"));
					vo.setCpnum(rs.getString("cpnum"));
					vo.setEmail(rs.getString("email"));
					vo.setPostcode(rs.getString("postcode"));
					vo.setAddr1(rs.getString("addr1"));
					vo.setAddr2(rs.getString("addr2"));
				}
			}
		}catch(Exception e){
			System.out.println("searchUser메소드 내부에서 오류 : " + e);
		}finally{
			release();
		}//searchUser메소드 끝
		
		return vo;
	}
	
	public void modCustomer(MemberVO vo) {
		try{
			con = getConnection();
			
			String id = vo.getId();
			String pwd = vo.getPwd();
			String name = vo.getName();
			String cpnum = vo.getCpnum();
			String email = vo.getEmail();
			String postcode = vo.getPostcode();
			String addr1 = vo.getAddr1();
			String addr2 = vo.getAddr2();
			
			String query = "update customer set pwd=?, name=?, cpnum=?, email=?, postcode=?, "
					+ "addr1=?, addr2=? where id=?";
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, pwd);
			pstmt.setString(2, name);
			pstmt.setString(3, cpnum);
			pstmt.setString(4, email);
			pstmt.setString(5, postcode);
			pstmt.setString(6, addr1);
			pstmt.setString(7, addr2);
			pstmt.setString(8, id);
			
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("modCustomer메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
	}//modCustomer메소드 끝
	
	public void modSeller(MemberVO vo) {
		try{
			con = getConnection();
			
			String id = vo.getId();
			String pwd = vo.getPwd();
			String businessRegNum = vo.getBusinessRegNum();
			String shopName = vo.getShopName();
			String pnum = vo.getPnum();
			String cpnum = vo.getCpnum();
			String email = vo.getEmail();
			String postcode = vo.getPostcode();
			String addr1 = vo.getAddr1();
			String addr2 = vo.getAddr2();
			
			String query = "update seller set pwd=?, businessRegNum=?, shopName=?, pnum=?, "
					+ "cpnum=?, email=?, postcode=?, addr1=?, addr2=? where id=?";
			System.out.println(query);
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, pwd);
			pstmt.setString(2, businessRegNum);
			pstmt.setString(3, shopName);
			pstmt.setString(4, pnum);
			pstmt.setString(5, cpnum);
			pstmt.setString(6, email);
			pstmt.setString(7, postcode);
			pstmt.setString(8, addr1);
			pstmt.setString(9, addr2);
			pstmt.setString(10, id);
			
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("modSeller메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
	}//modSeller메소드 끝

	public String findIdByCpnum(String name, String cpnum) {
		String id = null;
		try{
			con = getConnection();
			String query = "select id from (select id from customer where name=? and cpnum =? "
					+ "union select id from seller where shopname=? and cpnum =?) a";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, name);
			pstmt.setString(2, cpnum);
			pstmt.setString(3, name);
			pstmt.setString(4, cpnum);
			rs = pstmt.executeQuery();
			if(rs.next()){
				id = rs.getString("id");
			}
		}catch(Exception e){
			System.out.println("findIdByCpnum메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
		return id;
	}

	public String findIdByEmail(String email, String cpnum) {
		String id = null;
		try{
			con = getConnection();
			String query = "select id from (select id from customer where name=? and email =? "
					+ "union select id from seller where shopname=? and email =?) a";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, cpnum);
			pstmt.setString(3, email);
			pstmt.setString(4, cpnum);
			rs = pstmt.executeQuery();
			if(rs.next()){
				id = rs.getString("id");
			}
		}catch(Exception e){
			System.out.println("findIdByEmail메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
		return id;
	}

	public Boolean findPwd(String id, String name, String email) {
		Boolean check = false;
		try{
			con = getConnection();
			String query = "select pwd from (select pwd from customer where id=? and name=? and email =? "
					+ "union select pwd from seller where id=? and shopname=? and email =?) a";
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			pstmt.setString(4, id);
			pstmt.setString(5, name);
			pstmt.setString(6, email);
			rs = pstmt.executeQuery();
			if(rs.next()){
				check = true;
			}
		}catch(Exception e){
			System.out.println("findPwd메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
		return check;
	}

	public void modPwd(String id, String pwd) {
		try{
			con = getConnection();
			String query = "select * from customer where id=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				query = "update customer set pwd=? where id=?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, pwd);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
			}else{
				query = "update seller set pwd=? where id=?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, pwd);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
			}
		}catch(Exception e){
			System.out.println("modPwd메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
	}

	public void delete(String id) {
		try{
			con = getConnection();
			String query = "select * from customer where id=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				query = "delete from customer where id=?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
			}else{
				query = "delete from seller where id=?";
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
			}
		}catch(Exception e){
			System.out.println("delete메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
	}
	
}
