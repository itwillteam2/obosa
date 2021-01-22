package Common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import DBUtil.DBConnection;

public class SearchDAO {
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

	public List<SearchVO> searchArticles(String search, String ord) {
		List<SearchVO> searchList = new ArrayList<SearchVO>();
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "select * from (select * from living where productname like ? "
						+ "union select * from fancy where productname like ? "
						+ "union select * from crafts where productname like ?) a "
						+ "order by regdate desc";
				
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "select * from (select * from living where productname like ? "
						+ "union select * from fancy where productname like ? "
						+ "union select * from crafts where productname like ?) a "
						+ "order by productprice";
				
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "select * from (select * from living where productname like ? "
						+ "union select * from fancy where productname like ? "
						+ "union select * from crafts where productname like ?) a "
						+ "order by productprice desc";
				
				pstmt = con.prepareStatement(query);
			}
			
			pstmt.setString(1,"%"+search+"%");
			pstmt.setString(2,"%"+search+"%");
			pstmt.setString(3,"%"+search+"%");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setCategory(rs.getString("category"));
				vo.setNum(rs.getInt("num"));
				searchList.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("searchArticles 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchList;
		
	}//searchArticles 메소드 끝

	public int searchCount(String search) {
		int searchCount = 0;
		try{
			con = getConnection();
			String query = "select count(*) from (select * from living where productname like ? "
					+ "union select * from fancy where productname like ? "
					+ "union select * from crafts where productname like ?) a";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setString(2,"%"+search+"%");
			pstmt.setString(3,"%"+search+"%");
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				searchCount = rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("searchCount메소드 내부에서 오류 : " + e);
		}finally{
			release();
		}
		return searchCount;
	}//searchCount메소드 끝

	public int shopSearchCount(String search) {
		int shopSearchCount = 0;
		try{
			con = getConnection();
			String query = "SELECT count(shopname) from seller where shopname like ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+search+"%");
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				shopSearchCount = rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("shopSearchCount메소드 내부에서 오류 : " + e);
		}finally{
			release();
		}
		return shopSearchCount;
	}//shopSearchCount메소드 끝

	public List<SearchVO> shopSearch(String search) {
		List<SearchVO> shopSearchList = new ArrayList<SearchVO>();
		try {
			
			con = getConnection();
			String query = "select shopname from seller where shopname like ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,"%"+search+"%");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setSellerName(rs.getString("shopName"));
				shopSearchList.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("searchArticles 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return shopSearchList;
		
	}//shopSearchArticles메소드 끝

	public int livingCount(String search) {
		int livingCount = 0;
		try{
			con = getConnection();
			String query = "SELECT count(*) FROM living where productname like ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+search+"%");
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				livingCount = rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("livingCount메소드 내부에서 오류 : " + e);
		}finally{
			release();
		}
		return livingCount;
	}//livingCount메소드 끝
	
	public List<SearchVO> searchLiving(String search, String ord) {
		List<SearchVO> searchList = new ArrayList<SearchVO>();
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "SELECT * FROM living where productname like ? order by regdate desc";
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "SELECT * FROM living where productname like ? order by productprice";
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "SELECT * FROM living where productname like ? order by productprice desc";
				pstmt = con.prepareStatement(query);
			}
			
			pstmt.setString(1,"%"+search+"%");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setNum(rs.getInt("num"));
				searchList.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("searchLiving 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchList;
		
	}//searchLiving 메소드 끝

	public int craftsCount(String search) {
		int craftsCount = 0;
		try{
			con = getConnection();
			String query = "SELECT count(*) FROM crafts where productname like ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+search+"%");
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				craftsCount = rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("craftsCount메소드 내부에서 오류 : " + e);
		}finally{
			release();
		}
		return craftsCount;
	}//craftsCount메소드 끝

	public List<SearchVO> searchCrafts(String search, String ord) {
		List<SearchVO> searchCrafts = new ArrayList<SearchVO>();
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "SELECT * FROM crafts where productname like ? order by regdate desc";
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "SELECT * FROM crafts where productname like ? order by productprice";
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "SELECT * FROM crafts where productname like ? order by productprice desc";
				pstmt = con.prepareStatement(query);
			}
			
			
			pstmt.setString(1,"%"+search+"%");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setNum(rs.getInt("num"));
				searchCrafts.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("searchArt 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchCrafts;
	}//searchArt메소드 끝

	public int fancyCount(String search) {
		int fancyCount = 0;
		try{
			con = getConnection();
			String query = "SELECT count(*) FROM fancy where productname like ?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+search+"%");
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				fancyCount = rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("fancyCount메소드 내부에서 오류 : " + e);
		}finally{
			release();
		}
		return fancyCount;
	}//fancyCount메소드 끝

	public List<SearchVO> searchFancy(String search, String ord) {
		List<SearchVO> searchFancy = new ArrayList<SearchVO>();
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "SELECT * FROM fancy where productname like ? order by regdate desc";
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "SELECT * FROM fancy where productname like ? order by productprice";
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "SELECT * FROM fancy where productname like ? order by productprice desc";
				pstmt = con.prepareStatement(query);
			}
			
			pstmt.setString(1,"%"+search+"%");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				searchFancy.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("searchFancy 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchFancy;
	}//searchFancy메소드 끝
	
	public int shopCount(String search) {
		int searchCount = 0;
		try{
			con = getConnection();
			String query = "select count(*) from (select * from living where sellername=? "
					+ "union select * from fancy where sellername=? "
					+ "union select * from crafts where sellername=?) a";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, search);
			pstmt.setString(2, search);
			pstmt.setString(3, search);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				searchCount = rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("shopCount메소드 내부에서 오류 : " + e);
		}finally{
			release();
		}
		return searchCount;
	}//shopCount메소드 끝
	
	public List<SearchVO> shopArticles(int pageNO, int listSize, String search, String ord) {
		List<SearchVO> searchList = new ArrayList<SearchVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "select * from (select * from living where sellername=? "
						+ "union select * from fancy where sellername=? "
						+ "union select * from crafts where sellername=?) a "
						+ " order by regdate desc"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "select * from (select * from living where sellername=? "
						+ "union select * from fancy where sellername=? "
						+ "union select * from crafts where sellername=?) a "
						+ " order by productprice"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "select * from (select * from living where sellername=? "
						+ "union select * from fancy where sellername=? "
						+ "union select * from crafts where sellername=?) a "
						+ " order by productprice desc"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}
			
			pstmt.setString(1,search);
			pstmt.setString(2,search);
			pstmt.setString(3,search);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setCategory(rs.getString("category"));
				vo.setNum(rs.getInt("num"));
				searchList.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("shopArticles 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchList;
		
	}//shopArticles 메소드 끝
	
	public List<SearchVO> shopLiving(int pageNO, int listSize, String search, String ord) {
		List<SearchVO> searchList = new ArrayList<SearchVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "SELECT * FROM living where sellername=? order by regdate desc"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "SELECT * FROM living where sellername=? order by productprice"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "SELECT * FROM living where sellername=? order by productprice desc"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}
			
			pstmt.setString(1,search);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setNum(rs.getInt("num"));
				searchList.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("shopLiving 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchList;
		
	}//shopLiving 메소드 끝
	
	public int shopLivingCount(String search) {
		int livingCount = 0;
		try{
			con = getConnection();
			String query = "SELECT count(*) FROM living where sellername=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, search);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				livingCount = rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("shopLivingCount메소드 내부에서 오류 : " + e);
		}finally{
			release();
		}
		return livingCount;
	}//shopLivingCount메소드 끝
	
	public int shopCraftsCount(String search) {
		int craftsCount = 0;
		try{
			con = getConnection();
			String query = "SELECT count(*) FROM crafts where sellername=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, search);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				craftsCount = rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("shopCraftsCount메소드 내부에서 오류 : " + e);
		}finally{
			release();
		}
		return craftsCount;
	}//shopCraftsCount메소드 끝

	public List<SearchVO> shopCrafts(int pageNO, int listSize, String search, String ord) {
		List<SearchVO> searchCrafts = new ArrayList<SearchVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "SELECT * FROM crafts where sellername=? order by regdate desc"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "SELECT * FROM crafts where sellername=? order by productprice"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "SELECT * FROM crafts where sellername=? order by productprice desc"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}
			
			pstmt.setString(1,search);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setNum(rs.getInt("num"));
				searchCrafts.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("shopCrafts 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchCrafts;
	}//shopCrafts메소드 끝

	public int shopFancyCount(String search) {
		int fancyCount = 0;
		try{
			con = getConnection();
			String query = "SELECT count(*) FROM fancy where sellername=?";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, search);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				fancyCount = rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("shopFancyCount메소드 내부에서 오류 : " + e);
		}finally{
			release();
		}
		return fancyCount;
	}//shopFancyCount메소드 끝

	public List<SearchVO> shopFancy(int pageNO, int listSize, String search, String ord) {
		List<SearchVO> searchFancy = new ArrayList<SearchVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "SELECT * FROM fancy where sellername=? order by regdate desc"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "SELECT * FROM fancy where sellername=? order by productprice"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "SELECT * FROM fancy where sellername=? order by productprice desc"
						+ " LIMIT "+pageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}
			
			pstmt.setString(1,search);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				searchFancy.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("shopFancy 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchFancy;
	}//shopFancy메소드 끝
	
	public List<SearchVO> viewSearchArticles(int allPageNO, int listSize, String search, String ord) {
		List<SearchVO> searchList = new ArrayList<SearchVO>();
		allPageNO= (allPageNO-1)*listSize;
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "select * from (select * from living where productname like ? "
						+ "union select * from fancy where productname like ? "
						+ "union select * from crafts where productname like ?) a "
						+ "order by regdate desc"
						+ " LIMIT "+allPageNO+","+listSize;
				
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "select * from (select * from living where productname like ? "
						+ "union select * from fancy where productname like ? "
						+ "union select * from crafts where productname like ?) a "
						+ "order by productprice"
						+ " LIMIT "+allPageNO+","+listSize;
				
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "select * from (select * from living where productname like ? "
						+ "union select * from fancy where productname like ? "
						+ "union select * from crafts where productname like ?) a "
						+ "order by productprice desc"
						+ " LIMIT "+allPageNO+","+listSize;
				
				pstmt = con.prepareStatement(query);
			}
			
			pstmt.setString(1,"%"+search+"%");
			pstmt.setString(2,"%"+search+"%");
			pstmt.setString(3,"%"+search+"%");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setCategory(rs.getString("category"));
				vo.setNum(rs.getInt("num"));
				searchList.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("viewSearchArticles 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchList;
		
	}//viewSearchArticles 메소드 끝
	
	public List<SearchVO> viewSearchLiving(int livingPageNO, int listSize, String search, String ord) {
		List<SearchVO> searchList = new ArrayList<SearchVO>();
		livingPageNO= (livingPageNO-1)*listSize;
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "SELECT * FROM living where productname like ? order by regdate desc"
						+ " LIMIT "+livingPageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "SELECT * FROM living where productname like ? order by productprice"
						+ " LIMIT "+livingPageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "SELECT * FROM living where productname like ? order by productprice desc"
						+ " LIMIT "+livingPageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}
			
			pstmt.setString(1,"%"+search+"%");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setNum(rs.getInt("num"));
				searchList.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("viewSearchLiving 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchList;
		
	}//viewSearchLiving 메소드 끝
	
	public List<SearchVO> viewSearchCrafts(int craftsPageNO, int listSize, String search, String ord) {
		List<SearchVO> searchCrafts = new ArrayList<SearchVO>();
		craftsPageNO= (craftsPageNO-1)*listSize;
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "SELECT * FROM crafts where productname like ? order by regdate desc"
						+ " LIMIT "+craftsPageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "SELECT * FROM crafts where productname like ? order by productprice"
						+ " LIMIT "+craftsPageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "SELECT * FROM crafts where productname like ? order by productprice desc"
						+ " LIMIT "+craftsPageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}
			
			
			pstmt.setString(1,"%"+search+"%");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setNum(rs.getInt("num"));
				searchCrafts.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("viewSearchArt 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchCrafts;
	}//viewSearchArt메소드 끝
	
	public List<SearchVO> viewSearchFancy(int fancyPageNO, int listSize, String search, String ord) {
		List<SearchVO> searchFancy = new ArrayList<SearchVO>();
		fancyPageNO= (fancyPageNO-1)*listSize;
		try {
			
			con = getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "SELECT * FROM fancy where productname like ? order by regdate desc"
						+ " LIMIT "+fancyPageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "SELECT * FROM fancy where productname like ? order by productprice"
						+ " LIMIT "+fancyPageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "SELECT * FROM fancy where productname like ? order by productprice desc"
						+ " LIMIT "+fancyPageNO+","+listSize;
				pstmt = con.prepareStatement(query);
			}
			
			pstmt.setString(1,"%"+search+"%");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SearchVO vo = new SearchVO();
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setSellerName(rs.getString("sellerName"));
				searchFancy.add(vo);
			}
		
		} catch (Exception e) {
			System.out.println("viewSearchFancy 메소드 내부에서 오류 : " + e);
		}finally {
			release();
		}
	
		return searchFancy;
	}//viewSearchFancy메소드 끝

}
