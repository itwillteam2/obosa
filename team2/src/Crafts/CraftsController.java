package Crafts;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.file.Files;
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

import Page.Paging;


@WebServlet("/crafts/*")
public class CraftsController extends HttpServlet{
	
	ItemsVO vo;
	ItemsService service;
	ItemsRepVO repVO;
	String realPath;
	final String CATEGORY="crafts";
	private static String ARTICLE_IMAGE_REPO = "C:\\files\\article_image";
		
	@Override
	public void init() throws ServletException {
		vo = new ItemsVO();
		repVO = new ItemsRepVO();
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
		
		String nextPage="";
		realPath = request.getServletContext().getRealPath("/files/crafts");
		String action = request.getPathInfo();
		
		if(action == null || action.equals("/list.do")) {
			List<ItemsVO> contentList = service.ContentList();
			request.setAttribute("contentList", contentList);
			request.setAttribute("category", CATEGORY);	 //------ 카테고리 입력
			int totalCount = service.totalCount();
			int page = (request.getParameter("page") == null) ? 1 : Integer.parseInt(request.getParameter("page"));
			
			Paging paging = new Paging();
			paging.setPageNo(page); // 현재 페이지 번호
			paging.setPageSize(10); // 한페이지에서 불러낼 게시물의 갯수
			paging.setTotalCount(totalCount); // 총 게시물 수
			
			page = (page -1) * 10; //select해오는 기준
			request.setAttribute("paging", paging);
			
			nextPage="/Home/Common/category.jsp";			
			
		}else if(action.equals("/addItem.do")) {
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
			vo.setProductImageName1(productImageName1);
			vo.setProductImageName2(productImageName2);
			vo.setProductImageName3(productImageName3);
			vo.setProductPrice(productPrice);
			vo.setProductQuantity(productQuantity);
			vo.setShipping_fee(shipping_fee);
			vo.setPoint(point);	
			
			int num = service.insertContent(vo);
			if (num > 0) {
				File srcDir = new File(ARTICLE_IMAGE_REPO+"\\temp");
				File destDir = new File(ARTICLE_IMAGE_REPO + "\\crafts\\" + num);
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
				out.print("<alert='등록에 실패 했습니다.'>");
				out.print("</script>");
			}
		} else if (action.equals("/ToUpdateItem.do")) {
			String num =request.getParameter("num");
			ItemsVO content = (ItemsVO) service.ContentDetail(Integer.parseInt(num));
			request.setAttribute("content", content);
			
			nextPage = "/Home/Seller/modContent.jsp";	
			
		}else if(action.equals("/updateItem.do")) {
			Map<String, String> addItemMap = upload(request, response);
		
			int num = Integer.parseInt(addItemMap.get("num"));
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
			
			vo.setNum(num);
			vo.setProductName(productName);
			vo.setProductContent(productContent);
			vo.setProductImageName1(productImageName1);
			vo.setProductImageName2(productImageName2);
			vo.setProductImageName3(productImageName3);
			vo.setProductPrice(productPrice);
			vo.setProductQuantity(productQuantity);
			vo.setSellerName(sellerName);			
			vo.setShipping_fee(shipping_fee);
			vo.setPoint(point);
			
			int result = service.updateContent(vo);
			ItemsVO content = (ItemsVO) service.ContentDetail(result);
			request.setAttribute("content", content);
			
			nextPage = "/Home/Common/content.jsp";
			
		} else if (action.equals("/viewContent.do")) {
			String num = request.getParameter("num");
			ItemsVO content = (ItemsVO) service.ContentDetail(Integer.parseInt(num));
			request.setAttribute("content", content);
			
			nextPage = "/Home/Common/content.jsp";
		
		} else if (action.equals("/addReply.do")) {

			int rnum = service.addReply(repVO);
			int num = Integer.parseInt(request.getParameter("num"));
			String pw = request.getParameter("pw");
			String content = request.getParameter("content");
			String writer = request.getParameter("writer");

			repVO.setRnum(rnum);
			repVO.setNum(num);
			repVO.setPw(pw);
			repVO.setContent(content);
			repVO.setWriter(writer);

			PrintWriter pw2 = response.getWriter();
			pw2.print("<script>" + " alert('상품후기를 등록 했습니다.');" + " location.href='" + "/crafts/viewContent.do?num="
					+ num + "';" + "</script>");
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
	
	
	
	
	
	
	
	// temp to realPath on file of Image
	public void moveFile(int num, String fileName) {
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
	
	private void downloadFile(HttpServletResponse response, int num, String fileName){
		try {			
			String filePath = realPath + "\\" + num + "\\" + fileName;
			File file = new File(filePath);
		
			OutputStream out = response.getOutputStream();			
			
			response.setHeader("Cache-Control", "no-chche");
			response.addHeader("Cache-Control", "no-store");			
			response.setHeader("Content-disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8") + "\";");
			
			FileInputStream in = new FileInputStream(file);	
			
			byte[] buffer = new byte[1024*8];
			
			while(true) {
				int count = in.read(buffer);
				
				if(count == -1) {
					break;
				}
				out.write(buffer, 0, count);;
			}
			
			in.close();
			out.close();
		} catch (Exception e) {
			System.out.println("downloadFile()메소드 내부에서 오류 : " + e.toString());
		}		
	}
	
	private String getFileType1(int num, String productImageName1){
		String craftsFileType = "";

		try {
			String filePath = realPath + "\\" + num + "\\" + productImageName1;
			File file = new File(filePath);
			
			String mimeType = Files.probeContentType(file.toPath());
			craftsFileType = mimeType.split("/")[0];
			
		} catch (Exception e) {
			System.out.println("getFileType()메소드 내부에서 오류 : " + e.toString());
		}
		
		return craftsFileType;
	}//end of getFileType1
	
	private String getFileType2(int num, String productImageName2){
		String craftsFileType = "";

		try {
			String filePath = realPath + "\\" + num + "\\" + productImageName2;
			File file = new File(filePath);
			
			String mimeType = Files.probeContentType(file.toPath());
			craftsFileType = mimeType.split("/")[0];
			
		} catch (Exception e) {
			System.out.println("getFileType()메소드 내부에서 오류 : " + e.toString());
		}
		
		return craftsFileType;
	}//end of getFileType2
	
	private String getFileType3(int num, String productImageName3){
		String craftsFileType = "";

		try {
			String filePath = realPath + "\\" + num + "\\" + productImageName3;
			File file = new File(filePath);
			
			String mimeType = Files.probeContentType(file.toPath());
			craftsFileType = mimeType.split("/")[0];
			
		} catch (Exception e) {
			System.out.println("getFileType()메소드 내부에서 오류 : " + e.toString());
		}
		
		return craftsFileType;
	}//end of getFileType3
	
}
