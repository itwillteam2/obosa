package Auction;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.sql.Timestamp;
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

import Page.Paging;

@WebServlet("/auction/*")
public class AuctionController extends HttpServlet{

	AuctionVO auctionVO;
	AuctionService auctionService;
	String realPath;
	private static String ARTICLE_IMAGE_REPO = "C:\\files\\auction";

	
	@Override
	public void init() throws ServletException {
		
		auctionVO = new AuctionVO();
		auctionService = new AuctionService();
		
	
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request,response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request,response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String nextPage="";
		realPath = request.getServletContext().getRealPath("/file/");
		
		System.out.println("realPath : " +  realPath);
		
		System.out.println("ServletContext : " + request.getServletContext());
		
		String action = request.getPathInfo();
		System.out.println(action);
		if(action==null || action.equals("/auctionList.do")) {
			List<AuctionVO> articleList = new ArrayList<AuctionVO>();
			Paging paging = new Paging();
			
			//paging 
			int pageNo=1;
			int listSize = 10;
			int totalPages = paging.getTotalPages(); //총 페이지수
			int startPage = paging.getStartPage();//시작페이지
			int endPage = paging.getEndPage();//끝페이지
			
			if(request.getParameter("pageNo") !=null) {
				pageNo = Integer.parseInt(request.getParameter("pageNo"));
			}
			int listCount = auctionService.totalCount();//글 총 갯수 받아오기
			articleList = auctionService.getArticleList(pageNo, listSize); //한페이지에 글 갯수 받아오기
			
			paging.setTotalPages(totalPages);
			paging.setStartPage(startPage);
			paging.setEndPage(endPage);
			request.setAttribute("paging", paging);
			request.setAttribute("listCount", listCount);
			request.setAttribute("articleList", articleList);			
			
			nextPage="Home/Auction/list.jsp";						
			
		}else if(action.equals("/addAuctionItem.do")) {
			Map<String, String> addItemMap = upload(request, response);
			
			
			String productName = addItemMap.get("productName");
			String productContent = addItemMap.get("productContent");
			String sellerName = addItemMap.get("sellerName");
			int startPrice = Integer.parseInt(addItemMap.get("startPrice"));
			String productImageName1 = addItemMap.get("productImageName1");
			String productImageName2 = addItemMap.get("productImageName2");
			String productImageName3 = addItemMap.get("productImageName3");
			int productQuantity = Integer.parseInt(addItemMap.get("productQuantity"));
			int shipping_fee = Integer.parseInt(addItemMap.get("shipping_fee"));
			
			
			
			auctionVO.setProductContent(productContent);
			auctionVO.setProductImageName1(productImageName1);
			auctionVO.setProductImageName2(productImageName2);
			auctionVO.setProductImageName3(productImageName3);
			auctionVO.setProductName(productName);
			auctionVO.setProductQuantity(productQuantity);
			auctionVO.setSellerName(sellerName);
			auctionVO.setShipping_fee(shipping_fee);
			auctionVO.setStartPrice(startPrice);
			
			int maxNum = auctionService.insertAuctionItem(auctionVO);
			
			nextPage ="/Home/Auction/list.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);		
		
	}//end of doHandle
	
	//upload
	private Map<String, String> upload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Map<String, String> articleMap = new HashMap<String, String>();
		String encoding = "utf-8";
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
						
							

						String fileName = fileItem.getName().substring(idx + 1);
						articleMap.put(fileItem.getFieldName(), fileName);
						File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);						
						fileItem.write(uploadFile);
						
						if(!uploadFile.exists()) {
							uploadFile.mkdir();
						}
						
						}
					}
				}
			}
			
		} catch (Exception e) {
			System.out.println("upload error : " + e.toString());
		}
		
		return articleMap;		
		
	}//end of upload
	
	private void moveFile(int num, String fileName) {
		try {
			File srcFile = new File(realPath + "\\temp\\" + fileName);
			File destDir = new File(realPath + "\\" + num);
			Boolean createDestDir = destDir.mkdirs();
			
			String filePath = realPath + "\\" + num + "\\" + fileName;
			File file = new File(filePath);
			
			if(!file.exists()) {
				FileUtils.moveFileToDirectory(srcFile, destDir, createDestDir);
				
			}	
		}catch (Exception e) {
			System.out.println("moveFile error : " + e.toString());
		}
	}//end of moveFile
	
	// delete file when delete content
		private void deleteFile(int num, String fileName) {
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
		
		//movefile
		
		
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
		}//end of downloadFile
		
		private String getFileType(int num, String fileName){
			String campingFileType = "";

			try {
				String filePath = realPath + "\\" + num + "\\" + fileName;
				File file = new File(filePath);
				
				String mimeType = Files.probeContentType(file.toPath());
				campingFileType = mimeType.split("/")[0];
				
			} catch (Exception e) {
				System.out.println("getFileType()메소드 내부에서 오류 : " + e.toString());
			}
			
			return campingFileType;
		}//end of getFileType

		private void deleteDirectory(int num){
			try {
				String realDirPath = realPath + "\\" + num;
				File realDir = new File(realDirPath);
				
				if(realDir.exists()) {
					FileUtils.deleteDirectory(realDir);
				}
			} catch (Exception e) {
				System.out.println("deleteFile()메소드 내부에서 오류 : " + e.toString());
			}
		}//end of deleteDirectory
}
