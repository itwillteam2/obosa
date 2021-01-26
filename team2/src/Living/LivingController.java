package Living;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

import Grade.GradeService;
import Page.Paging;

@WebServlet("/living/*")
public class LivingController extends HttpServlet {

	ItemsVO vo;
	ItemsService service;
	ItemsRepVO repVO;
	ItemsQnaVO qnaVO;
	ItemsQnaRepVO qnarepVO;
	LivingJoinVO joinVO;
	String realPath;
	final String CATEGORY="living";
	private static String ARTICLE_IMAGE_REPO = "C:\\files\\article_image";

	@Override
	public void init() throws ServletException {
		vo = new ItemsVO();
		repVO = new ItemsRepVO();
		qnaVO = new ItemsQnaVO();
		qnarepVO = new ItemsQnaRepVO();
		joinVO = new LivingJoinVO();
		service = new ItemsService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String nextPage = null;
		realPath = request.getServletContext().getRealPath("/files/"+CATEGORY);
		String action = request.getPathInfo();
		
		List<ItemsQnaRepVO> QnaRepList = null;
		List<LivingJoinVO> joinList = null;

		
		System.out.println("act:"+action);
		
		if (action == null || action.equals("/list.do")) {
			int totalCount = service.totalCount();
			Paging paging = new Paging();
			int pageNO = (request.getParameter("pageNO") == null) ? 1 : Integer.parseInt(request.getParameter("pageNO"));
			int pageSize = 5;  // 원하는 세팅 값 입력, 페이지 하단 숫자 표시 개수
			int listSize = 4;  // 원하는 세팅 값 입력, 출력 게시물 개수
			
			paging.makePage(totalCount, pageNO, pageSize, listSize); 
			
			String ord = request.getParameter("ord");
			request.setAttribute("ord", ord);
			
			request.setAttribute("category", "living");
			
			if(ord == "" || ord == null){
				ord="신상품순";
			}
			
			List <ItemsVO> contentList = service.ContentList(pageNO,listSize, ord);
	
			request.setAttribute("contentList", contentList);
			request.setAttribute("category", CATEGORY);	 //------ 카테고리 입력
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("paging", paging);
			
			nextPage="/Home/Common/category.jsp";
	// ---- category 평균 평점  		
		}else if (action.equals("/countAvg.do")) {	
			GradeService gservice = new GradeService();
			int pnum = Integer.parseInt(request.getParameter("pnum"));
			PrintWriter pw = response.getWriter();
			pw.print(gservice.getGradeAvg(pnum,CATEGORY));		
			pw.flush();
			return;
	// ---- category 평균 평점 끝 
		}else if (action.equals("/addItem.do")) {
			Map<String, String> addItemMap = upload(request, response);

			String productName = addItemMap.get("productName");
			String productContent = addItemMap.get("productContent");
			String sellerName = addItemMap.get("sellerName");
			int productPrice = Integer.parseInt(addItemMap.get("productPrice"));
			String productImageName1 = addItemMap.get("productImageName1");
			String productImageName2 = addItemMap.get("productImageName2");
			String productImageName3 = addItemMap.get("productImageName3");
			int productQuantity = Integer.parseInt(addItemMap.get("productQuantity"));
			int shipping_fee = Integer.parseInt(addItemMap.get("shipping_fee"));
			int point = Integer.parseInt(addItemMap.get("point"));
		
			vo.setProductName(productName);
			vo.setProductContent(productContent);
			vo.setSellerName(sellerName);
			vo.setProductPrice(productPrice);
			vo.setProductImageName1(productImageName1);
			vo.setProductImageName2(productImageName2);
			vo.setProductImageName3(productImageName3);
			vo.setProductQuantity(productQuantity);
			vo.setShipping_fee(shipping_fee);
			vo.setPoint(point);

			int num = service.insertContent(vo);
			if (num > 0) {
				File srcDir = new File(ARTICLE_IMAGE_REPO+"\\temp");
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\"+CATEGORY+"\\" + num);
				destDir.mkdir();
				File files[] = srcDir.listFiles();
				for (int i = 0; i < files.length; i++) {
					File srcFile = files[i];
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
				}	
				nextPage = "/"+CATEGORY+"/list.do";
			} else {
				PrintWriter out = response.getWriter();
				out.print("<script>");
				out.print("alert('등록에 실패 했습니다.');");
				out.print("</script>");
			}
		} else if (action.equals("/ToUpdateContent.do")) {
			String num =request.getParameter("num");
			ItemsVO content = (ItemsVO) service.ContentDetail(Integer.parseInt(num));
			request.setAttribute("content", content);
			
			nextPage = "/Home/Seller/modContent.jsp";
			
		}else if(action.equals("/updateContent.do")) {
			Map<String, String> ListMap = upload(request, response);

			int num =Integer.parseInt(ListMap.get("num"));
			String productName = ListMap.get("productName");
			String productContent = ListMap.get("productContent");
			String sellerName = ListMap.get("sellerName");
			int productPrice = Integer.parseInt(ListMap.get("productPrice"));
			String productImageName1 = ListMap.get("productImageName1");
			String productImageName2 = ListMap.get("productImageName2");
			String productImageName3 = ListMap.get("productImageName3");
			int productQuantity = Integer.parseInt(ListMap.get("productQuantity"));
			int shipping_fee = Integer.parseInt(ListMap.get("shipping_fee"));
			int point = Integer.parseInt(ListMap.get("point"));

			vo.setNum(num);
			vo.setProductName(productName);
			vo.setProductContent(productContent);
			vo.setSellerName(sellerName);
			vo.setProductPrice(productPrice);
			vo.setProductImageName1(productImageName1);
			vo.setProductImageName2(productImageName2);
			vo.setProductImageName3(productImageName3);
			vo.setProductQuantity(productQuantity);
			vo.setShipping_fee(shipping_fee);
			vo.setPoint(point);

			int result = service.updateContent(vo);
			ItemsVO content = (ItemsVO) service.ContentDetail(result);
			request.setAttribute("content", content);
			
			nextPage = "/Home/Common/content.jsp";

		} else if (action.equals("/viewContent.do")) {
			int num = Integer.parseInt(request.getParameter("num"));
			int totalCount = service.totalCountRep();		
			int totalCount2 = service.totalCountQna();
			int totalCount3 = service.totalCountQnaRep();
			Paging paging = new Paging();
			int pageNO = (request.getParameter("pageNO") == null) ? 1 : Integer.parseInt(request.getParameter("pageNO"));
			int pageSize = 5;
			int listSize = 5;
			paging.makePage(totalCount, pageNO, pageSize, listSize); 
			
			ItemsVO content = (ItemsVO) service.ContentDetail(num);
			request.setAttribute("content", content);
			List <ItemsRepVO> ReppagingList = service.ReppagingList(pageNO,listSize, num);
	// ----- 후기 평점
			String writer=null;
			int pnum,grd=0;
			GradeService gservice = new GradeService();
			List <Integer> grdList = new ArrayList<Integer>();
			for(int i=0;i<ReppagingList.size();i++) {
				writer=ReppagingList.get(i).getWriter();
				pnum=ReppagingList.get(i).getNum();
				grd=gservice.getGrade(pnum, CATEGORY, writer);
				grdList.add(grd);
			}
			request.setAttribute("grdCount", grdList);
	// -----후기 평점	끝	
			request.setAttribute("ReppagingList", ReppagingList);	
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("paging", paging);
			
			List <ItemsQnaVO> QnaPagingList = service.QnaPagingList(pageNO,listSize, num);
			request.setAttribute("QnaPagingList", QnaPagingList);	
			request.setAttribute("totalCount2", totalCount2);
			request.setAttribute("paging", paging);
			
			QnaRepList = service.listQnaRep();
			request.setAttribute("QnaRepList", QnaRepList);
			
			List <ItemsQnaRepVO> QnaRepPagingList = service.QnaRepPagingList(pageNO,listSize, num);
			request.setAttribute("QnaRepPagingList", QnaRepPagingList);	
			request.setAttribute("totalCount3", totalCount3);
			request.setAttribute("paging", paging);
			
			List <LivingJoinVO> QnaPagingJoinList = service.QnaPagingJoinList(pageNO,listSize, num);
			request.setAttribute("QnaPagingJoinList", QnaPagingJoinList);	
			request.setAttribute("totalCount2", totalCount2);
			request.setAttribute("paging", paging);
			
			int totalCountrep = service.CountRep(num);
			request.setAttribute("totalCountrep", totalCountrep);
			int totalCountqna = service.CountQna(num);		
			request.setAttribute("totalCountqna", totalCountqna);
			
			
			nextPage = "/Home/Common/content.jsp";
		
		} else if (action.equals("/deleteContent.do")) {
			String num = request.getParameter("num");
			int result= service.deleteContent(Integer.parseInt(num));
			System.out.println(result);
			if(result==1) deleteFolder(Integer.parseInt(num));
			nextPage = "/"+CATEGORY+"/list.do";
			
		} else if (action.equals("/addReply.do")) {
			
			int rnum = 0;
			
			int num = Integer.parseInt(request.getParameter("num"));
			String title = request.getParameter("title");
			String pw = request.getParameter("pw");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
						
			repVO.setRnum(rnum);
			repVO.setNum(num);
			repVO.setTitle(title);
			repVO.setPw(pw);
			repVO.setContent(content);
			repVO.setWriter(writer);
				
			rnum = service.addReply(repVO);
		// ----평점 등록
			int grade = Integer.parseInt(request.getParameter("grade"));
			GradeService gservice = new GradeService();
			gservice.addGrade(writer,num,CATEGORY,rnum,grade);
		// ----평점 등록 끝
			PrintWriter pw2 = response.getWriter();
			pw2.print("<script>" + "  alert('상품후기를 등록 했습니다.');" + "window.opener.location.reload(); " +
			"window.close();"+ "</script>");	
		} else if (action.equals("/addQna.do")) {
			
			int qnum = 0;
			
			int num = Integer.parseInt(request.getParameter("num"));
			String title = request.getParameter("title");
			String pw = request.getParameter("pw");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");
			
			qnaVO.setQnum(qnum);
			qnaVO.setNum(num);
			qnaVO.setTitle(title);
			qnaVO.setPw(pw);
			qnaVO.setContent(content);
			qnaVO.setWriter(writer);
			
			
			qnum = service.addQna(qnaVO);

			PrintWriter pw2 = response.getWriter();
			pw2.print("<script>" + "  alert('질문을 등록 했습니다.');" + "window.opener.location.reload(); " +
			"window.close();"+ "</script>");	
		} else if (action.equals("/addQnaReply.do")) {
			int qrnum = 0;
			
			int qnum = Integer.parseInt(request.getParameter("qnum"));
			String content = request.getParameter("content");
			String pw = request.getParameter("pw");
			
			qnarepVO.setQrnum(qrnum);
			qnarepVO.setQnum(qnum);
			qnarepVO.setContent(content);
			qnarepVO.setPw(pw);

			qnum = service.addQnaRep(qnarepVO);
			
			PrintWriter pw2 = response.getWriter();
			pw2.print("<script>" + "  alert('답변을 등록 했습니다.');" + "window.opener.location.reload(); " +
			"window.close();"+ "</script>");	
		
		}else if (action.equals("/QnaReplyDelete.do")) {
			int check = 0;
			
			int qrnum = Integer.parseInt(request.getParameter("qrnum"));
			String pw = request.getParameter("pw");
			String num = request.getParameter("num");
			
			check = service.QnaReplyDelete(qrnum, pw);
			
			PrintWriter pw2 = response.getWriter();
			
			if (check == 1) {
				pw2.print("<script> alert('답변이 삭제되었습니다.');" + " location.href='" + request.getContextPath()
						+ "/"+CATEGORY+"/viewContent.do?num="+num+"'; " + "</script>");
			} else {
				pw2.print("<script> alert('비밀번호가 틀립니다.');" + "history.back();" + "</script>");
			}
		}else if (action.equals("/QnaReplyModify.do")) {
			
			int check = 0;
			
			int qrnum = Integer.parseInt(request.getParameter("qrnum"));
			String content = request.getParameter("content");
			String pw = request.getParameter("pw");
			
			qnarepVO.setQrnum(qrnum);
			qnarepVO.setContent(content);
			qnarepVO.setPw(pw);

			check = service.modifyReply(qnarepVO);
			 
			PrintWriter pw2 = response.getWriter();
			
			if(check == 1){
				pw2.print("<script>" + "  alert('답변을 수정 했습니다.');" + "window.opener.location.reload(); " +
						"window.close();"+ "</script>");
			}else{
				pw2.print("<script> alert('비밀번호가 틀립니다.');" +
				"history.back();" + 
				"</script>");	
			}
		}else if (action.equals("/countRep.do")) {
			int num = Integer.parseInt(request.getParameter("pnum"));
	
			num = service.CountRep(num);
			PrintWriter pw = response.getWriter();
				pw.print(num);
				pw.flush();
				return;
			}
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	}//end of doHandle

	private Map<String, String> upload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Map<String, String> articleMap = new HashMap<String, String>();
		String encoding = "UTF-8";
		File currentDirPath = new File(ARTICLE_IMAGE_REPO);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024 * 1024 * 1);
		ServletFileUpload upload = new ServletFileUpload(factory);

		try {
			List items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);
				if (fileItem.isFormField()) {
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				} else {
					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}

						String fileName = fileItem.getName().substring(idx + 1);
						articleMap.put(fileItem.getFieldName(), fileName);
						File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);
						fileItem.write(uploadFile);
					}
				}

			}
		} catch (Exception e) {
			System.out.println("upload error : " + e.toString());
		}
		return articleMap;
	}//end 
	
	
	// delete file when delete content
	public void deleteFile(int num, String fileName) {
		try {
			String filePath = realPath + "\\" + num + "\\" + fileName;
			File file = new File(filePath);

			if (file.exists()) {
				file.delete();
			}
		} catch (Exception e) {
			System.out.println("deleteFile error : " + e.toString());
		}
	}// end of deleteFile
	
	// delete folder when delete list
	public void deleteFolder(int num) {
		try {
			String folderPath = ARTICLE_IMAGE_REPO +"\\"+CATEGORY+"\\" + num;
			
			System.out.println(folderPath);
			File folder = new File(folderPath);

			if (folder.exists()) {
				File files[] = folder.listFiles();
			
				for (int i=0;i<files.length;i++) {
				 File delFile = files[i];
				 delFile.delete();
				}
				 folder.delete();
			}
		} catch (Exception e) {
			System.out.println("deleteFile error : " + e.toString());
		}
	}// end of deleteFolder
	

}// end