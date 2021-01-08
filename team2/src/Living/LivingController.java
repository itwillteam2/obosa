package Living;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

import Page.Paging;

@WebServlet("/living/*")
public class LivingController extends HttpServlet {

	LivingVO livingVO;
	LivingService livingService;
	LivingRepVO livingRepVO;
	String realPath;
	

	private static String ARTICLE_IMAGE_REPO = "C:\\files\\article_image";

	@Override
	public void init() throws ServletException {
		livingVO = new LivingVO();
		livingRepVO = new LivingRepVO();
		livingService = new LivingService();
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
		String nextPage = "";
		realPath = request.getServletContext().getRealPath("/files/living");

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String action = request.getPathInfo();
		System.out.println("action :" + action);

		

		if (action == null || action.equals("/listLiving.do")) {
			System.out.println(action);
			List <LivingVO> livingList = livingService.livingList();
			request.setAttribute("livingList", livingList);	
			
			int totalCount = livingService.totalCountList();
			int page = (request.getParameter("page") == null) ? 1 : Integer.parseInt(request.getParameter("page"));
			
			Paging paging = new Paging();
			paging.setPageNo(page); // 현재 페이지 번호
			paging.setPageSize(10); // 한페이지에서 불러낼 게시물의 갯수
			paging.setTotalCount(totalCount); // 총 게시물 수
			
			page = (page -1) * 10; //select해오는 기준
			
			request.setAttribute("paging", paging);
		
			
			nextPage="/Home/Living/living.jsp";
			
		}else  if(action.equals("detailLivingItem.do")) {
			int livingNum = Integer.parseInt(request.getParameter("livingNum"));
			
			Map<String, Object> livingMap = livingService.detailLiving(livingNum);
			
			livingVO = (LivingVO)livingMap.get("livingVO");
			String productImageName1 = livingVO.getProductImageName1();
			String productImageName2 = livingVO.getProductImageName2();
			String productImageName3 = livingVO.getProductImageName3();
			
			if(productImageName1 !=null && productImageName1 != "") {
				String livingFileType = getFileType1(livingNum, productImageName1);
				livingMap.put("livingFileType", livingFileType);
			}
			if(productImageName2 !=null && productImageName2 != "") {
				String livingFileType = getFileType1(livingNum, productImageName2);
				livingMap.put("livingFileType", livingFileType);
			}
			if(productImageName3 !=null && productImageName3 != "") {
				String livingFileType = getFileType1(livingNum, productImageName3);
				livingMap.put("livingFileType", livingFileType);
			}
			
			request.setAttribute("livingMap", livingMap);
			
			nextPage=""; //<-- 상세페이지 주소
			
		}else  if (action.equals("/addLivingItem.do")) {

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
			/* String reg_date = addItemMap.get("reg_date"); */

			livingVO.setPoint(point);
			livingVO.setProductContent(productContent);
			livingVO.setProductImageName1(productImageName1);
			livingVO.setProductImageName2(productImageName2);
			livingVO.setProductImageName3(productImageName3);
			livingVO.setProductName(productName);
			livingVO.setProductPrice(productPrice);
			livingVO.setProductQuantity(productQuantity);
			livingVO.setSellerName(sellerName);
			/* livingVO.setReg_date(reg_date); */
			livingVO.setShipping_fee(shipping_fee);

			int num = livingService.insertLiving(livingVO);
			if (num > 0) {

				if( productImageName1 != null &&  productImageName1.length() != 0 ){
					File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" +  productImageName1);
					File destDir = new File(ARTICLE_IMAGE_REPO + "\\living\\" + num);
					destDir.mkdir();//글번호에 대한 폴더 생성 ~
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
					
				}
				
				nextPage = "/living/listLiving.do";

			} else {
				PrintWriter out = response.getWriter();
				out.print("<script>");
				out.print("<alert='등록에 실패 했습니다.'>");
				out.print("</script>");
			}

		} else if (action.equals("/updateLivingProduct.do")) {
			Map<String, String> livingListMap = upload(request, response);

			String productName = livingListMap.get("productName");
			String productContent = livingListMap.get("productContent");
			String sellerName = livingListMap.get("sellerName");
			int productPrice = Integer.parseInt(livingListMap.get("productPrice"));
			String productImageName1 = livingListMap.get("productImageName1");
			String productImageName2 = livingListMap.get("productImageName2");
			String productImageName3 = livingListMap.get("productImageName3");
			int productQuantity = Integer.parseInt(livingListMap.get("productQuantity"));
			int shipping_fee = Integer.parseInt(livingListMap.get("shipping_fee"));
			int point = Integer.parseInt(livingListMap.get("point"));

		} else if (action.equals("/addLiving.do")) {
			int num = 0;
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

			livingVO.setNum(num);
			livingVO.setProductName(productName);
			livingVO.setProductContent(productContent);
			livingVO.setSellerName(sellerName);
			livingVO.setProductPrice(productPrice);
			livingVO.setProductImageName1(productImageName1);
			livingVO.setProductImageName2(productImageName2);
			livingVO.setProductImageName3(productImageName3);
			livingVO.setProductQuantity(productQuantity);
			livingVO.setShipping_fee(shipping_fee);
			livingVO.setPoint(point);

			num = livingService.addLiving(livingVO);

			if( productImageName1 != null &&  productImageName1.length() != 0 ){
				
				//temp폴더에 임시로 업로드된 파일에 접근하기 위해 File객체를 생성합니다
				File srcFile = new File(ARTICLE_IMAGE_REPO + "\\" + "temp" + "\\" +  productImageName1);
				
				// C:\board\article_image 폴더 내부에  글번호 폴더를 생성합니다
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\living\\" + num);
				destDir.mkdir();//글번호에 대한 폴더 생성 ~
				
				//temp폴더에 업로드된 이미지 파일을  글번호 폴더로 이동
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
				
			}
			
			
			PrintWriter pw = response.getWriter();
			pw.print("<script>" + "  alert('새글을 추가 했습니다.');" + " location.href='" + request.getContextPath()
					+ "/living/listLiving.do';" + "</script>");

			return;

		} else if (action.equals("/addReply.do")) {

			int rnum = livingService.addReply(livingRepVO);

			int num = Integer.parseInt(request.getParameter("num"));
			String pw = request.getParameter("pw");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");

			livingRepVO.setRnum(rnum);
			livingRepVO.setNum(num);
			livingRepVO.setPw(pw);
			livingRepVO.setContent(content);
			livingRepVO.setWriter(writer);

			PrintWriter pw2 = response.getWriter();
			pw2.print("<script>" + " alert('상품후기를 등록 했습니다.');" + " location.href='" + "/living/viewContent.do?num="
					+ num + "';" + "</script>");

			return;

		} else if (action.equals("/viewContent.do")) {
			String num = request.getParameter("num");
			LivingVO content = livingService.viewContent(Integer.parseInt(num));
			request.setAttribute("content", content);
			
			nextPage = "/Home/Living/content.jsp";

		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);

		dispatcher.forward(request, response);

	}

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
	}
	// temp to realPath on file of Image
	/*public void moveFile(int num, String fileName) {
		try {
			File srcFile = new File(realPath + "\\" + fileName);
			File destDir = new File(realPath + "\\" + num);
			boolean createDestDir = destDir.mkdir();

			String filePath = realPath + "\\" + num + "\\" + fileName;
			File file = new File(filePath);

			if (!file.exists()) {
				FileUtils.moveDirectoryToDirectory(srcFile, destDir, createDestDir);
			}

		} catch (Exception e) {
			System.out.println("moveFile error : " + e.toString());
		}
	}// end of moveFile
*/
	
	// delete file when delete list
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
	
	private String getFileType1(int livingNum, String productImageName1){
		String livingFileType = "";

		try {
			String filePath = realPath + "\\" + livingNum + "\\" + productImageName1;
			File file = new File(filePath);
			
			String mimeType = Files.probeContentType(file.toPath());
			livingFileType = mimeType.split("/")[0];
			
		} catch (Exception e) {
			System.out.println("getFileType()메소드 내부에서 오류 : " + e.toString());
		}
		
		return livingFileType;
	}//end of getFileType1
	
	private String getFileType2(int livingNum, String productImageName2){
		String livingFileType = "";

		try {
			String filePath = realPath + "\\" + livingNum + "\\" + productImageName2;
			File file = new File(filePath);
			
			String mimeType = Files.probeContentType(file.toPath());
			livingFileType = mimeType.split("/")[0];
			
		} catch (Exception e) {
			System.out.println("getFileType()메소드 내부에서 오류 : " + e.toString());
		}
		
		return livingFileType;
	}//end of getFileType2
	
	private String getFileType3(int livingNum, String productImageName3){
		String livingFileType = "";

		try {
			String filePath = realPath + "\\" + livingNum + "\\" + productImageName3;
			File file = new File(filePath);
			
			String mimeType = Files.probeContentType(file.toPath());
			livingFileType = mimeType.split("/")[0];
			
		} catch (Exception e) {
			System.out.println("getFileType()메소드 내부에서 오류 : " + e.toString());
		}
		
		return livingFileType;
	}//end of getFileType3
	
}// end of LivingController