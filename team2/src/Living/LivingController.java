package Living;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;





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
		
		HttpSession session;
		
		
		 if(action == null || action.equals("listLiving.do")) {
			 
			 
		  
			Map<String, String> livingListMap = new HashMap<String, String>();
			 
			String name = livingListMap.get("name");			
			String passwd = livingListMap.get("passwd");
			String subject = livingListMap.get("subject");
			String image = livingListMap.get("image");
			String content = livingListMap.get("content");
			
			livingVO.setSeller(name);
			//�н�����
			livingVO.setProduct_name(subject);
			livingVO.setPhoto_name(image);
			livingVO.setLiving_content(content);
		
			 
			 
		 }else if(action.equals("listLiving.do")){
		  
		 }else if(action.equals("addLivingItem.do")) {
			
			Map<String, String> addItemMap = upload(request, response);
			
			String name = addItemMap.get("name");			
			String passwd = addItemMap.get("passwd");
			String subject = addItemMap.get("subject");
			String image = addItemMap.get("image");
			String content = addItemMap.get("content");
			
			livingVO.setSeller(name);
			//ADD insert password later.
			livingVO.setProduct_name(subject);
			livingVO.setPhoto_name(image);
			livingVO.setLiving_content(content);
			
			
			
			
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
					System.out.println("�Ķ���͸�:" + fileItem.getFieldName());
					System.out.println("���ϸ� : " + fileItem.getName());
					System.out.println("����ũ�� : " + fileItem.getSize() + "bytes");
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
	}//end of upload
	
	public void downloadFile(HttpServletResponse response, int num, String fileName) {
		try {
			String filePath = realPath + "\\" + num + "\\" + fileName;
			File file = new File(filePath);
			
			OutputStream ops = response.getOutputStream();
			
			response.setHeader("Cache-Control", "no-chche");
			response.addHeader("Cache-Control", "no-store");			
			response.setHeader("Content-disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8") + "\";");
			
			FileInputStream fis = new FileInputStream(file);
			
			byte[] buffer = new byte[1024*8];
			
			while(true) {
				int count = fis.read(buffer);
				
				if(count == -1) {
					break;
				}
				ops.write(buffer,0,count);
			}
			fis.close();
			ops.close();
		} catch (Exception e) {
			System.out.println("downloadFile error : " + e.toString() );
		}
	}// end of downloadFile
	
	//temp to realPath on file of Image 
	public void moveFile(int num, String fileName) {
		try {
			File srcFile = new File(realPath + "\\" + fileName);
			File destDir = new File(realPath + "\\" + num);
			boolean createDestDir = destDir.mkdir();
			
			String filePath = realPath + "\\" + num + "\\" + fileName;
			File file = new File(filePath);
			
			if(!file.exists()) {
				FileUtils.moveDirectoryToDirectory(srcFile, destDir, createDestDir);
			}
			
		} catch (Exception e) {
			System.out.println("moveFile error : " + e.toString());
		}
	}// end of moveFile
	
	//delete file when delete list
	public void deleteFile(int num, String fileName) {
		try {
			String filePath = realPath + "\\" + num + "\\" + fileName;
			File file = new File(filePath);
			
			if(file.exists()) {
				file.delete();
			}
		} catch (Exception e) {
			System.out.println("deleteFile error : " + e.toString());
		}
	}// end of deleteFile
}//end of LivingController
