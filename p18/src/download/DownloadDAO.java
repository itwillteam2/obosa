package download;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import download.DownloadBean;
import guest.GuestBean;

public class DownloadDAO {
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
			System.out.println("Resource Release 占쎈뼄占쎈솭 : " + exception);
		}
	}	
	
	public void insertDownload(DownloadBean dbean){		
		int num = 0;

		String sql ="";
		
		try {		
			con = getConnection();
			
			sql = "select max(num) from download";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}else{
				num = 1;
			}
			
			sql = "insert into download(num,name,passwd,subject,content,filename,realname," +
					"re_ref,re_lev,re_seq,readcount,date,ip)" + 
					"values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);	
			
			pstmt.setInt(1, num);
			pstmt.setString(2, dbean.getName());
			pstmt.setString(3, dbean.getPasswd());
			pstmt.setString(4, dbean.getSubject());
			pstmt.setString(5, dbean.getContent());
			pstmt.setString(6, dbean.getFilename());
			pstmt.setString(7, dbean.getRealname());
			pstmt.setInt(8, num);
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 0);
			pstmt.setInt(11, 0);
			pstmt.setTimestamp(12, dbean.getDate());
			pstmt.setString(13, dbean.getIp());

			pstmt.executeUpdate();
			
			
		
		}catch(Exception e) {
			System.out.println("InsertDownload硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);

		}finally{
			Resource();
		}
	}
	
	public int getdownloadCount(){
		
		int count = 0;
		
		String sql = "";
		
		try {
			con = getConnection();

			sql = "select count(*) from download";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}			
		}catch(Exception e) {
			System.out.println("getdownloadCount 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
		}finally{
			Resource();
		}
		return count;	
	}
	
	public List<DownloadBean> getdownloadList(int startRow, int pageSize){
		
		String sql = "";
		
		List<DownloadBean> downloadList = new ArrayList<DownloadBean>();
	
		try {
			con = getConnection();

			sql = "select * from Download order by re_ref desc, re_seq asc limit ?, ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){				
				DownloadBean bBean = new DownloadBean();
				bBean.setNum(rs.getInt("num"));
				bBean.setName(rs.getString("name"));
				bBean.setPasswd(rs.getString("passwd"));
				bBean.setSubject(rs.getString("subject"));
				bBean.setContent(rs.getString("content"));
				bBean.setRe_ref(rs.getInt("re_ref"));
				bBean.setRe_lev(rs.getInt("re_lev"));
				bBean.setRe_seq(rs.getInt("re_seq"));
				bBean.setReadcount(rs.getInt("readcount"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setIp(rs.getString("ip"));

				downloadList.add(bBean);
			}		
		}catch(Exception e) {
			System.out.println("getdownloadList 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜�  :" + e);
		}finally{
			Resource();
		}
		return downloadList;
		
	}
	
	public void updateReadCount(int num){
			
			String sql = "";
			
			try {
	
				con = getConnection();
	
				sql = "update download set readcount=readcount+1 where num = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
			
			}catch(Exception e) {
				System.out.println("updateReadCount 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜�  : " + e);
			}finally{
				Resource();
			}
		}
	
	public DownloadBean getDownload(int num){
		
		String sql = "";
		
		DownloadBean bean = new DownloadBean();
		try {

			con = getConnection();

			sql = "select * from Download where num = ?";
			
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
			System.out.println("getDownload 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
		}finally{
			Resource();
		}		
		return bean;
	
	}
	
	public int deleteDownload(int num, String passwd){
		
		int check = 0;
		
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "select passwd from Download where num = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(passwd.equals(rs.getString("passwd"))){

					check = 1;

					sql = "delete from Download where num=?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					pstmt.executeUpdate();
					
				}else{
					check = 0;
				}
			}		
		}catch(Exception e) {
			System.out.println("deleteDownload 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);
		}finally{
			Resource();
		}
		
		return check;
	}
	
	public int updateDownload(DownloadBean dbean){
		int check = 0;
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "select passwd from Download where num = ?";
			
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, dbean.getNum());

			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(dbean.getPasswd().equals(rs.getString("passwd"))){
					check = 1;
					sql = "update Download set name=?, subject=?, filename=?, realname=?, content=? where num=?";
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
			System.out.println("updateDownload 硫붿냼�뱶�궡遺��뿉�꽌 �삤瑜� : " + e);
		}finally{
			Resource();
		}
		return check;	
	}
	
	public void reInsertDownload(DownloadBean bBean){
		String sql = "";
		
		int num = 0;
		
		try {

			con = getConnection();

			sql = "select max(num) from Download";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1) +1;
			}else{ 
				num = 1;				
			}
			
			sql = "update Download set re_seq = re_seq +1 where re_ref = ? and re_seq > ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bBean.getRe_ref());
			pstmt.setInt(2, bBean.getRe_seq());
			pstmt.executeUpdate();

			sql = "insert into Download values(?,?,?,?,?,?,?,?,?,?,?)";
			
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
			System.out.println("reInsertDownload 硫붿냼�뱶 �궡遺��뿉�꽌 �삤瑜� : " + e);			
		}finally{
			Resource();
		}
	}
	
	public List<DownloadBean> getDownloadSearch(String search, String searchText, int startRow, int pageSize){
		String sql = "";
		
		List<DownloadBean> boardList = new ArrayList<DownloadBean>();		
		try {
			con = getConnection();
			
			sql = "select * from download where " + search + " like '%" + searchText + "%' order by num desc limit ?, ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				DownloadBean bBean = new DownloadBean();
				bBean.setNum(rs.getInt("num"));
				bBean.setName(rs.getString("name"));
				bBean.setSubject(rs.getString("subject"));
				bBean.setDate(rs.getTimestamp("date"));
				bBean.setReadcount(rs.getInt("readcount"));
				boardList.add(bBean);
			}
		} catch (Exception e) {
			System.out.println("getDownloadSearch 메소드 내부에서 오류 :" + e);
		}finally{
			Resource();
		}
		
		return boardList;
		
	}
}
