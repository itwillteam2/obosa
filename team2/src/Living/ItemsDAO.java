package Living;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import CsCenter.InqRepVO;
import CsCenter.InquiryVO;
import DBUtil.DBConnection;
import Grade.GradeService;

public class ItemsDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	final String CATEGORY = "living";
	
	public void freeResource() {
		try {
			if(conn != null) conn.close();
			if(pstmt != null) pstmt.close();
			if(rs != null) rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//end

	//select all articles list of crafts.
	public List<ItemsVO> getAllContents(int pageNO, int listSize, String ord) {
		
		List<ItemsVO> contentList = new ArrayList<ItemsVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			conn = DBConnection.getConnection();
			
			if(ord.equals("신상품순") || ord.equals("") || ord == null){
				String query = "SELECT * FROM "+CATEGORY+" order by regdate desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);
			}else if(ord.equals("낮은가격순")){
				String query = "SELECT * FROM "+CATEGORY+" order by productprice "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);
			}else if(ord.equals("높은가격순")){
				String query = "SELECT * FROM "+CATEGORY+" order by productprice desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);
			}
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ItemsVO vo = new ItemsVO();
				vo.setNum(rs.getInt("num"));
				vo.setPoint(rs.getInt("point"));
				vo.setProductContent(rs.getString("productContent"));
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductImageName2(rs.getString("productImageName2"));
				vo.setProductImageName3(rs.getString("productImageName3"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setProductQuantity(rs.getInt("productQuantity"));
				vo.setReg_date(rs.getTimestamp("regDate"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setShipping_fee(rs.getInt("shipping_fee"));
				contentList.add(vo);
			}
						
		} catch (Exception e) {
			System.out.println("getAllContents error : " + e.toString());
		}finally {
			freeResource();
		}
		return contentList;
	}//end of selectAllArticles
	
//  -------- 전체 상품 개수 조회 ------- //
	public int getTotalCount() {
		int num = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM "+CATEGORY;
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1);
			}
		
		}catch (Exception e) {
			System.out.println("getTotalCount error : " + e.toString());
		}finally {
			freeResource();
		}

		return num;
	}//end of selectTotalCount

//  -------- 상품 등록 ------- //	
	public int insertContent(ItemsVO vo) {
		int num = 0;
		String sql ="";
		
		try {
			conn = DBConnection.getConnection();
			sql = "select max(num) from "+CATEGORY;
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){ num = rs.getInt(1) + 1;
			}else{ num = 1; }

			String query = "INSERT INTO "+CATEGORY
					+ "(num, productName,productContent,sellerName,productPrice,productImageName1,productImageName2,productImageName3,productQuantity,shipping_fee,point,category) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, num);		
			pstmt.setString(2, vo.getProductName());
			pstmt.setString(3, vo.getProductContent());
			pstmt.setString(4, vo.getSellerName());
			pstmt.setInt(5, vo.getProductPrice());
			pstmt.setString(6, vo.getProductImageName1());
			pstmt.setString(7, vo.getProductImageName2());
			pstmt.setString(8, vo.getProductImageName3());
			pstmt.setInt(9, vo.getProductQuantity());
			pstmt.setInt(10, vo.getShipping_fee());
			pstmt.setInt(11, vo.getPoint());		
			pstmt.setString(12, CATEGORY);
			
			pstmt.executeUpdate();
					
		}catch (Exception e) {
			System.out.println("insertContent error : " + e.toString());
		}finally {
			freeResource();
		}		
		return num;
	}//end 
	
//  -------- 특정 상품 조회 ------- //
	public ItemsVO getContent(int num) {
		ItemsVO vo = new ItemsVO();
		
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT * FROM "+CATEGORY+ " WHERE num = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setNum(rs.getInt("num"));
				vo.setPoint(rs.getInt("point"));
				vo.setProductContent(rs.getString("productContent"));
				vo.setProductImageName1(rs.getString("productImageName1"));
				vo.setProductImageName2(rs.getString("productImageName2"));
				vo.setProductImageName3(rs.getString("productImageName3"));
				vo.setProductName(rs.getString("productName"));
				vo.setProductPrice(rs.getInt("productPrice"));
				vo.setProductQuantity(rs.getInt("productQuantity"));
				vo.setReg_date(rs.getTimestamp("regDate"));
				vo.setSellerName(rs.getString("sellerName"));
				vo.setShipping_fee(rs.getInt("shipping_fee"));
				vo.setCategory(rs.getString("category"));
			}
		} catch (Exception e) {
			System.out.println("getContent error : " + e.toString());
		}finally {
			freeResource();
		}
		return vo;
	}//end

//  -------- 상품 수정 ------- //		
	public int updateContent(ItemsVO vo) {
		int num = 0;
		
		try {
			conn = DBConnection.getConnection();
			String query = "UPDATE "+CATEGORY+" SET productName=?,productContent=?,sellerName=?,productPrice=?,"
					+"productImageName1=?,productImageName2=?,productImageName3=?,"
					+"productQuantity=?,shipping_fee=?,point=?"
			        +" WHERE num=?";
				
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, vo.getProductName());
			pstmt.setString(2, vo.getProductContent());
			pstmt.setString(3, vo.getSellerName());
			pstmt.setInt(4, vo.getProductPrice());
			pstmt.setString(5, vo.getProductImageName1());
			pstmt.setString(6, vo.getProductImageName2());
			pstmt.setString(7, vo.getProductImageName3());
			pstmt.setInt(8, vo.getProductQuantity());
			pstmt.setInt(9, vo.getShipping_fee());
			pstmt.setInt(10, vo.getPoint());	
			pstmt.setInt(11, vo.getNum());
			
			pstmt.executeUpdate();
	
			num = vo.getNum();

		} catch (Exception e) {
			System.out.println("updateContent error : " + e.toString());
		}finally {
			freeResource();
		}
	return num;
	}//end 
	
//  -------- 상품 삭제 ------- //	
	public int deleteContent(int NUM) {
		int num =0;
		try {
			conn = DBConnection.getConnection();
			String query = "DELETE FROM "+CATEGORY+" where NUM = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, NUM);
			pstmt.executeUpdate();					
			
			num=1;
		} catch (Exception e) {
			System.out.println("deleteContent error : " + e.toString());
		}finally {
			freeResource();
		}
		return num;
	}//end

	
	public int insertNewReply(ItemsRepVO repVO) {
		int rnum = 0;
		String sql ="";
		GradeService gservice = new GradeService();
		
		try {
			conn = DBConnection.getConnection();
			sql = "select max(rnum) from "	
			+CATEGORY+"_rep";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){ 	rnum = rs.getInt(1) + 1;
			}else{	rnum = 1; }
			
			int num = repVO.getNum();
			String title = repVO.getTitle();
			String pw = repVO.getPw();
			String content = repVO.getContent();
			String writer = repVO.getWriter();
				
			String query = "INSERT INTO "+CATEGORY+"_rep(rnum, num, title, pw, content, writer)"
					+ "VALUES(?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, rnum);
			pstmt.setInt(2, num);
			pstmt.setString(3, title);
			pstmt.setString(4, pw);
			pstmt.setString(5, content);
			pstmt.setString(6, writer);
	
			pstmt.executeUpdate();

			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}
		return rnum;
	}//end
	public int getTotalCountRep() {
		int num = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM "+CATEGORY+"_rep";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1);
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}

		return num;
	}
	
	public List<ItemsRepVO> getAllReply(int pageNO, int listSize, int num) {
		List<ItemsRepVO> ReppagingList = new ArrayList<ItemsRepVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			conn = DBConnection.getConnection();
			
				String query = "SELECT * FROM "+CATEGORY+"_rep where num = " + num + " order by rnum desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ItemsRepVO vo = new ItemsRepVO();
				vo.setRnum(rs.getInt("rnum"));
				vo.setNum(rs.getInt("num"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setPw(rs.getString("pw"));
				vo.setContent(rs.getString("content"));
				vo.setDate(rs.getTimestamp("date"));
				ReppagingList.add(vo);
			}
						
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return ReppagingList;
	}

	public int insertNewQna(ItemsQnaVO qnaVO) {
		int qnum = 0;
		String sql ="";
		
		try {
			conn = DBConnection.getConnection();
			sql = "select max(qnum) from "	
			+CATEGORY+"_qna";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){ 	qnum = rs.getInt(1) + 1;
			}else{	qnum = 1; }
			
			int num = qnaVO.getNum();
			String title = qnaVO.getTitle();
			String pw = qnaVO.getPw();
			String content = qnaVO.getContent();
			String writer = qnaVO.getWriter();

			String query = "INSERT INTO "+CATEGORY+"_qna(qnum, num, title, pw, content, writer)"
					+ "VALUES(?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, qnum);
			pstmt.setInt(2, num);
			pstmt.setString(3, title);
			pstmt.setString(4, pw);
			pstmt.setString(5, content);
			pstmt.setString(6, writer);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}
		return qnum;
	}

	public int getTotalCountQna() {
		int num = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM "+CATEGORY+"_qna";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1);
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}

		return num;
	}

	public List<ItemsQnaVO> getAllQna(int pageNO, int listSize, int num) {
		List<ItemsQnaVO> QnaPagingList = new ArrayList<ItemsQnaVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			conn = DBConnection.getConnection();
			
				String query = "SELECT * FROM "+CATEGORY+"_qna where num = " + num + " order by qnum desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ItemsQnaVO vo = new ItemsQnaVO();
				vo.setQnum(rs.getInt("qnum"));
				vo.setNum(rs.getInt("num"));
				vo.setTitle(rs.getString("title"));
				vo.setWriter(rs.getString("writer"));
				vo.setPw(rs.getString("pw"));
				vo.setContent(rs.getString("content"));
				vo.setDate(rs.getTimestamp("date"));
				QnaPagingList.add(vo);

			}
			
						
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return QnaPagingList;
	}

	public int insertNewQnaRep(ItemsQnaRepVO qnarepVO) {
		int qrnum = 0;

		String sql = "";

		try {
			conn = DBConnection.getConnection();
			sql = "select max(qrnum) from "+CATEGORY+"_qna_rep";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				qrnum = rs.getInt(1) + 1;
			} else {
				qrnum = 1;
			}
			
			int qnum = qnarepVO.getQnum();
			String content = qnarepVO.getContent();
			String pw = qnarepVO.getPw();

			String query = "INSERT INTO "+CATEGORY+"_qna_rep(qrnum, qnum, pw, content, complete)"
					+ "VALUES(?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(query);

			pstmt.setInt(1, qrnum);
			pstmt.setInt(2, qnum);
			pstmt.setString(3, pw);
			pstmt.setString(4, content);
			pstmt.setInt(5, 1);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}

		return qrnum;
	}

	public List<ItemsQnaRepVO> selectAllQnaRep() {
		List listQnaRep = new ArrayList();

		try {
			conn = DBConnection.getConnection();

			String query = "select * from "+CATEGORY+"_qna_rep order by qnum desc";

			pstmt = conn.prepareStatement(query);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				int qrnum = rs.getInt("qrnum");
				int qnum = rs.getInt("qnum");
				String content = rs.getString("content");		
				String pw = rs.getString("pw");
				int complete = rs.getInt("complete");

				ItemsQnaRepVO qr = new ItemsQnaRepVO();
				qr.setQrnum(qrnum);
				qr.setQnum(qnum);
				qr.setContent(content);
				qr.setPw(pw);
				qr.setComplete(complete);
				
				listQnaRep.add(qr);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			freeResource();
		}

		return listQnaRep;
	}

	public int getTotalCountQnaRep() {
		int num = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT count(*) FROM "+CATEGORY+"_qna_rep";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1);
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}

		return num;
	}

	public List<ItemsQnaRepVO> getAllQnaRep(int pageNO, int listSize, int num) {
		List<ItemsQnaRepVO> QnaRepPagingList = new ArrayList<ItemsQnaRepVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			conn = DBConnection.getConnection();
			
				String query = "SELECT * FROM "+CATEGORY+"_qna_rep order by qnum desc "+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ItemsQnaRepVO vo = new ItemsQnaRepVO();
				vo.setQrnum(rs.getInt("qrnum"));
				vo.setQnum(rs.getInt("qnum"));
				vo.setPw(rs.getString("pw"));
				vo.setContent(rs.getString("content"));
				vo.setComplete(rs.getInt("complete"));
				QnaRepPagingList.add(vo);
			}
						
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return QnaRepPagingList;
	}

	public List<LivingJoinVO> JoinQna(int pageNO, int listSize, int num) {
		List<LivingJoinVO> QnaPagingJoinList = new ArrayList<LivingJoinVO>();
		pageNO= (pageNO-1)*listSize;
		try {
			conn = DBConnection.getConnection();
				String query = "select q.qnum, q.title, q.content, q.writer, q.date, ifnull(r.qrnum,0) qrnum, ifnull(r.content,0) rcontent, ifnull(r.complete, 0) complete "
								+ "FROM "+CATEGORY+"_qna q left outer join "+CATEGORY+"_qna_rep r on q.qnum = r.qnum order by qnum desc"+" LIMIT "+pageNO+","+listSize;
				pstmt = conn.prepareStatement(query);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				LivingJoinVO vo = new LivingJoinVO();
				vo.setQnum(rs.getInt("qnum"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setWriter(rs.getString("writer"));
				vo.setDate(rs.getTimestamp("date"));
				vo.setQrnum(rs.getInt("qrnum"));
				vo.setRcontent(rs.getString("rcontent"));
				vo.setComplete(rs.getInt("complete"));
				QnaPagingJoinList.add(vo);	
				
				System.out.println(rs.getInt("qnum"));
				System.out.println(rs.getString("title"));
			}
						
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}
		return QnaPagingJoinList;
	}

	public int QnaReplyDelete(int qrnum, String pw) {
		int check = 0;
		
		String sql = "";
		
		try {
			conn = DBConnection.getConnection();
			
			sql = "select pw from "+CATEGORY+"_qna_rep where qrnum = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qrnum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pw.equals(rs.getString("pw"))){

					check = 1;

					sql = "delete from "+CATEGORY+"_qna_rep where qrnum=?";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, qrnum);

					
					pstmt.executeUpdate();
				}else{
					check = 0;
				}
			}		
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			freeResource();
		}
		
		return check;
	}

	public int modifyReply(ItemsQnaRepVO qnarepVO) {
		int check = 0;
		String sql = "";
		
		try {
			conn = DBConnection.getConnection();
			
			sql = "select pw from "+CATEGORY+"_qna_rep where qrnum = ?";
			
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, qnarepVO.getQrnum());

			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(qnarepVO.getPw().equals(rs.getString("pw"))){
					check = 1;
					sql = "update "+CATEGORY+"_qna_rep set content=? where qrnum=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, qnarepVO.getContent());
					pstmt.setInt(2, qnarepVO.getQrnum());

					pstmt.executeUpdate();
				}else{
					check = 0;
				}
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			freeResource();
		}
		return check;
	}

	public int getCountRep(int num) {
		int count = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT ifnull(count(*),0)count FROM "+CATEGORY+"_rep where num = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}

		return count;
	}

	public int getCountQna(int num) {
		int count = 0;
		try {
			conn = DBConnection.getConnection();
			String query = "SELECT ifnull(count(*),0)count FROM "+CATEGORY+"_qna where num = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt(1);
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			freeResource();
		}

		return count;
	}

}
