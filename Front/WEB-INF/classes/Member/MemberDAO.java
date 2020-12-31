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
	Connection con = null;		//DB와 미리 연결을 맺은 접속을 나타내는 객체를 저장할 조상 인터페이스 타입의 변수
	PreparedStatement pstmt = null;		//DB(jsbbeginner)에 SQL문을 전송해서 실행할 객체를 저장할 변수
	ResultSet rs = null;		//DB에 select 검색한 결과 데이터들을 임시로 저장해 놓을 수 있는 ResultSet객체를 저장할 변수
	
	//DataSource 커넥션풀을 얻고 커넥션풀 내부에 있는 Connection 객체를 얻는 메소드
	private Connection getConnection() throws Exception{
		
		//톰캣이 각 프로젝트에 접근할 수 있는 Context객체의 경로를 알고 있는  객체
		Context init = new InitialContext();
		
		//DataSource커넥션풀 얻기
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/team2");
		
		//DataSource커넥션풀 내부에 있는 Connection객체 얻기
		con = ds.getConnection();
		
		return con;		//DB와 미리 연결을 맺으 놓은 접속을 나타내는 Connection  객체 반환
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
	}
	
	public boolean overlappedID(String id){
	      
	      boolean result = false;
	      
	      try{
	         //커넥션풀(DataSource)공간에서 커넥션(Connection)객체를 빌려옴
	         //DB접속
	         con = getConnection();

	         //오라클 decode()함수를 이용하여 서블릿에서 전달된 입력한 ID에 해당하는 데이터를 검색하여
	         //true 또는 false를 반환하는데
	         //검색한 갯수가 1(검색한 레코드가 존재하면)이면 true를 반환
	         //존재하지 않으면 false를 문자열로 반환하여 조회하는 SQL문
	         String query = "select (case count(*) when 1 then 'true' else 'false' end) as result "
	         		+ "from (select id from customer where id=? union select id from seller where id = ?) a";
	               
	         pstmt = con.prepareStatement(query);
	         pstmt.setString(1, id);
	         pstmt.setString(2, id);
	         rs = pstmt.executeQuery();
	         rs.next();
	         
	         //문자열 "true" 또는 "false"를 Boolean클래스의 parseBoolean(String value)메소드를 호출해
	         //Boolean데이터로 변환해서 반환함
	         result = Boolean.parseBoolean(rs.getString("result"));
	         System.out.println(result);
	         
	         
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally {
	         release();
	      }
	      return result;//MemberServlet서블릿으로  true 또는 false반환
	   }
	
	public boolean overlappedEmail(String email){
	      
	      boolean result = false;
	      
	      try{
	         //커넥션풀(DataSource)공간에서 커넥션(Connection)객체를 빌려옴
	         //DB접속
	         con = getConnection();

	         //오라클 decode()함수를 이용하여 서블릿에서 전달된 입력한 ID에 해당하는 데이터를 검색하여
	         //true 또는 false를 반환하는데
	         //검색한 갯수가 1(검색한 레코드가 존재하면)이면 true를 반환
	         //존재하지 않으면 false를 문자열로 반환하여 조회하는 SQL문
	         String query = "select (case count(*) when 1 then 'true' else 'false' end) as result "
	         		+ "from (select email from customer where email=? union select email from seller where email = ?) a";
	               
	         pstmt = con.prepareStatement(query);
	         pstmt.setString(1, email);
	         pstmt.setString(2, email);
	         rs = pstmt.executeQuery();
	         rs.next();
	         
	         //문자열 "true" 또는 "false"를 Boolean클래스의 parseBoolean(String value)메소드를 호출해
	         //Boolean데이터로 변환해서 반환함
	         result = Boolean.parseBoolean(rs.getString("result"));
	         System.out.println(result);
	         
	         
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally {
	         release();
	      }
	      return result;//MemberServlet서블릿으로  true 또는 false반환
	   }
	
	public void addCustomer(MemberVO vo) {
		try{
			con = getConnection();
			
			int num=0;
			
			String query = "select max(num) from customer";
			
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()){//가장 최신 글번호가 검색된다면?
				//가장최신 글번호  + 1 데이터를 새로 추가할 글번호로 지정
				num = rs.getInt(1) + 1;
			}else{//가장 최신 글번호가 검색되지 않으면?(DB에 글이 없다면)
				num = 1; //새로추가할 글번호를 1로 설정 
			}
			
			//MemberVO객체의 getter메소드들을 호출하여 모두 얻기(이유 : insert문장에 ?값으로 설정하기 위해)
			String id = vo.getId();
			String pwd = vo.getPwd();
			String name = vo.getName();
			String cpnum = vo.getCpnum();
			String email = vo.getEmail();
			String postcode = vo.getPostcode();
			String addr1 = vo.getAddr1();
			String addr2 = vo.getAddr2();
			Timestamp timestamp = new Timestamp(System.currentTimeMillis());
			
			//insert문장 만들기
			query = "insert into customer(num, id, pwd, name, cpnum, email, postcode, addr1, addr2, joinDate) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			System.out.println(query);
			
			//insert 전체 문장중에서 ?기호에 대응되는 값을 제외한 전체 insert문장을 로딩한 preparedStatement<-- insert문장을 실행할 객체 얻기
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
	}
	
	public void addSeller(MemberVO vo) {
		try{
			con = getConnection();
			int num=0;
			
			String query = "select max(num) from seller";
			
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()){//가장 최신 글번호가 검색된다면?
				//가장최신 글번호  + 1 데이터를 새로 추가할 글번호로 지정
				num = rs.getInt(1) + 1;
			}else{//가장 최신 글번호가 검색되지 않으면?(DB에 글이 없다면)
				num = 1; //새로추가할 글번호를 1로 설정 
			}
			
			//MemberVO객체의 getter메소드들을 호출하여 모두 얻기(이유 : insert문장에 ?값으로 설정하기 위해)
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
			
			//insert문장 만들기
			query = "insert into seller(num, id, pwd, businessRegNum, shopName, pnum, cpnum, email, postcode, addr1, addr2, joinDate) "
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			System.out.println(query);
			
			//insert 전체 문장중에서 ?기호에 대응되는 값을 제외한 전체 insert문장을 로딩한 preparedStatement<-- insert문장을 실행할 객체 얻기
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
	}

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
			
			if(rs.next()){		//입력한 id가 DB에 존재
					check = true;
			}else{		//아이디 일치, 비밀번호 불일치
					check = false;
			}
			
		}catch(Exception e){
			System.out.println("login메소드 내부에서 오류 발생 : " + e);
		}finally{
			release();
		}
		
		return check;
	}
	
}
