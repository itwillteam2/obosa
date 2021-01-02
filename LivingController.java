package Living;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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




@WebServlet("/living/*")
public class LivingController extends HttpServlet{

	LivingVO livingVO;
	LivingService livingService;
	String realPath;
	
	private static String ARTICLE_IMAGE_REPO = "C:\\files\\article_image"; 
	
	@Override
	public void init() throws ServletException {
		 livingVO = new LivingVO();
		 livingService = new LivingService();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nextPage="";
		realPath = request.getServletContext().getRealPath("/files/living");
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String action = request.getPathInfo();
		System.out.println("action :" + action);
		
		
		
		
		 if(action == null || action.equals("listLiving.do")) {
		  
			
		 }else if(action.equals("listLiving.do")){
		  
		 }else if(action.equals("/addLivingItem.do")) {
			
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
			
			int isRegistSuccess = livingService.insertLiving(livingVO);
			if(isRegistSuccess > 0) {
				
				nextPage = "T2_tmp/Home/Living/living.jsp";
				
			}else{
				PrintWriter out = response.getWriter();
				out.print("<script>");
				out.print("<alert='등록에 실패 했습니다.'>");
				out.print("</script>");
			}				
			
		}else if(action.equals("updateLivingProduct.do")) {
			Map<String,String> livingListMap = upload(request, response);
			
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
			
			
		}
		
	
		if(!nextPage.equals("")) {			
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
		}
	}// end of doHandle	
	
	private Map<String,String> upload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	
		Map<String,String> articleMap = new HashMap<String,String>();
		String encoding = "UTF-8";
		File currentDirPath = new File(ARTICLE_IMAGE_REPO);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath); //�ӽ� ��������
		factory.setSizeThreshold(1024*1024*1); // ���� ������
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		try {
			List items = upload.parseRequest(request);
			for(int i =0; i<items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);
				if(fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				}else {
					System.out.println("파일이름:" + fileItem.getFieldName());
					System.out.println("파일이름 : " + fileItem.getName());
					System.out.println("파일크기 : " + fileItem.getSize() + "bytes");
					if(fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if(idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}
						
						String fileName = fileItem.getName().substring(idx + 1);
						articleMap.put(fileItem.getFieldName(), fileName);
						File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);
						fileItem.write(uploadFile);
					}
				}
				
			}
		}catch (Exception e) {
			System.out.println("upload error : " + e.toString());
		}			
		return articleMap;
	}	
}//end of LivingController

/*
 * 
 * else if(action.equals("detailLivingProduct.do")) {
 * 
 * int productNum = Integer.parseInt(request.getParameter("productNum"));
 * Map<String, Object> livingProductMap =
 * livingService.detailLivingProduct(productNum);
 * request.setAttribute("livingProductMap", livingProductMap);
 * 
 * nextPage="/livingProduct/detailProduct.jsp"; //<-- 디테일 한번 추가하기 }
 * 
 */