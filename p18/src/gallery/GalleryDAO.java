package gallery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class GalleryDAO {
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
			System.out.println("Resource Release 메소드 내부에서 오류 : " + exception);
		}
	}	
	
	public void insertGallery(GalleryBean gbean){		
		int num = 0;

		String sql ="";
		
		try {		
			con = getConnection();
			
			sql = "select max(num) from Gallery";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}else{
				num = 1;
			}
			
			sql = "insert into Gallery(num,name,passwd,subject,content,filename,realname," +
					"re_ref,re_lev,re_seq,readcount,date,ip)" + 
					"values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);	
			
			pstmt.setInt(1, num);
			pstmt.setString(2, gbean.getName());
			pstmt.setString(3, gbean.getPasswd());
			pstmt.setString(4, gbean.getSubject());
			pstmt.setString(5, gbean.getContent());
			pstmt.setString(6, gbean.getFilename());
			pstmt.setString(7, gbean.getRealname());
			pstmt.setInt(8, num);
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 0);
			pstmt.setInt(11, 0);
			pstmt.setTimestamp(12, gbean.getDate());
			pstmt.setString(13, gbean.getIp());

			pstmt.executeUpdate();
			
			
		
		}catch(Exception e) {
			System.out.println("InsertGallery메소드 내부에서 오류 : " + e);

		}finally{
			Resource();
		}
	}
	
	public int getGalleryCount(){
		
		int count = 0;
		
		String sql = "";
		
		try {
			con = getConnection();

			sql = "select count(*) from Gallery";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}			
		}catch(Exception e) {
			System.out.println("getGalleryCount 메소드 내부에서 오류 : " + e);
		}finally{
			Resource();
		}
		return count;	
	}
	
	public List<GalleryBean> getGalleryList(int startRow, int pageSize){
		
		String sql = "";
		
		List<GalleryBean> GalleryList = new ArrayList<GalleryBean>();
	
		try {
			con = getConnection();

			sql = "select * from Gallery order by re_ref desc, re_seq asc limit ?, ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){				
				GalleryBean gBean = new GalleryBean();
				gBean.setNum(rs.getInt("num"));
				gBean.setName(rs.getString("name"));
				gBean.setPasswd(rs.getString("passwd"));
				gBean.setSubject(rs.getString("subject"));
				gBean.setContent(rs.getString("content"));
				gBean.setFilename(rs.getString("filename"));
				gBean.setRealname(rs.getString("realname"));
				gBean.setRe_ref(rs.getInt("re_ref"));
				gBean.setRe_lev(rs.getInt("re_lev"));
				gBean.setRe_seq(rs.getInt("re_seq"));
				gBean.setReadcount(rs.getInt("readcount"));
				gBean.setDate(rs.getTimestamp("date"));
				gBean.setIp(rs.getString("ip"));

				GalleryList.add(gBean);
			}		
		}catch(Exception e) {
			System.out.println("getGalleryList 메소드 내부에서 오류  :" + e);
		}finally{
			Resource();
		}
		return GalleryList;
		
	}
	
	public void updateReadCount(int num){
			
			String sql = "";
			
			try {
	
				con = getConnection();
	
				sql = "update Gallery set readcount=readcount+1 where num = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
			
			}catch(Exception e) {
				System.out.println("updateReadCount 메소드 내부에서 오류  : " + e);
			}finally{
				Resource();
			}
		}
	
	public GalleryBean getGallery(int num){
		
		String sql = "";
		
		GalleryBean bean = new GalleryBean();
		try {

			con = getConnection();

			sql = "select * from Gallery where num = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setPasswd(rs.getString("passwd"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setFilename(rs.getString("filename"));
				bean.setRealname(rs.getString("realname"));
				bean.setRe_ref(rs.getInt("re_ref"));
				bean.setRe_lev(rs.getInt("re_lev"));
				bean.setRe_seq(rs.getInt("re_seq"));
				bean.setReadcount(rs.getInt("readcount"));
				bean.setDate(rs.getTimestamp("date"));
				bean.setIp(rs.getString("ip"));
			}
			
		}catch(Exception e) {
			System.out.println("getGallery 메소드 내부에서 오류 : " + e);
		}finally{
			Resource();
		}		
		return bean;
	
	}
	
	public int deleteGallery(int num, String passwd){
		
		int check = 0;
		
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "select passwd from Gallery where num = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd"))){

					check = 1;

					sql = "delete from Gallery where num=?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					pstmt.executeUpdate();
					
				}else{
					check = 0;
				}
			}		
		}catch(Exception e) {
			System.out.println("deleteGallery 메소드 내부에서 오류 : " + e);
		}finally{
			Resource();
		}
		
		return check;
	}
	
	public int updateGallery(GalleryBean dbean){
		int check = 0;
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "select passwd from Gallery where num = ?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, dbean.getNum());

			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(dbean.getPasswd().equals(rs.getString("passwd"))){
					check = 1;
					sql = "update Gallery set name=?, subject=?, filename=?, realname=?, content=? where num=?";
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, dbean.getName());
					pstmt.setString(2, dbean.getSubject());
					pstmt.setString(3, dbean.getFilename());
					pstmt.setString(4, dbean.getRealname());
					pstmt.setString(5, dbean.getContent());
					pstmt.setInt(6, dbean.getNum());
					pstmt.executeUpdate();
				}else{
					check = 0;
				}
			}			
		}catch(Exception e) {
			System.out.println("updateGallery 메소드내부에서 오류 : " + e);
		}finally{
			Resource();
		}
		return check;	
	}
	
	public void reInsertGallery(GalleryBean bBean){
		String sql = "";
		
		int num = 0;
		
		try {

			con = getConnection();

			sql = "select max(num) from Gallery";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1) +1;
			}else{ 
				num = 1;				
			}
			
			sql = "update Gallery set re_seq = re_seq +1 where re_ref = ? and re_seq > ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getRe_ref());
			pstmt.setInt(2, bBean.getRe_seq());
			pstmt.executeUpdate();

			sql = "insert into Gallery values(?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getPasswd());
			pstmt.setString(4, bBean.getSubject());
			pstmt.setString(5, bBean.getContent());
			pstmt.setInt(6, bBean.getRe_ref());
			pstmt.setInt(7, bBean.getRe_lev() + 1);
			pstmt.setInt(8, bBean.getRe_seq() + 1);
			pstmt.setInt(9, 0);
			pstmt.setTimestamp(10, bBean.getDate());
			pstmt.setString(11, bBean.getIp());
			
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			System.out.println("reInsertGallery 메소드 내부에서 오류 : " + e);			
		}finally{
			Resource();
		}
	}
}
