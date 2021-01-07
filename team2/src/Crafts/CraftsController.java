package Crafts;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

@WebServlet("/crafts/*")
public class CraftsController extends HttpServlet{

	private static String CRAFTS_IMAGE_REPO = "C:\\files\\crafts_image";
	
	CraftsVO craftsVO;
	CraftsService craftsService;
	CraftsDAO craftsDAO;
	String realPath;
	
	
	@Override
	public void init() throws ServletException {
		craftsVO = new CraftsVO();
		craftsService = new CraftsService();
		craftsDAO = new CraftsDAO();
		
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
		
		String nextPath="";
		realPath = request.getServletContext().getRealPath("/files/crafts");
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String action = request.getPathInfo();
		System.out.println("action : " + action);
		
		if(action == null || action.equals("/listCrafts.do")) {
			System.out.println(action);
			
			
			
			
		}
		
	}//end of doHandle
	
	private Map<String, String> upload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Map<String, String> articleMap = new HashMap<String, String>();
		String encoding = "UTF-8";
		File currentDirPath = new File(CRAFTS_IMAGE_REPO);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024 * 1024 * 1);
		ServletFileUpload upload = new ServletFileUpload(factory);

		try {
			List items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);
				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				} else {
					System.out.println("파일이름:" + fileItem.getFieldName());
					System.out.println("파일이름 : " + fileItem.getName());
					System.out.println("파일크기 : " + fileItem.getSize() + "bytes");
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
	public void moveFile(int CraftsNum, String fileName) {
		try {
			File srcFile = new File(realPath + "\\" + fileName);
			File destDir = new File(realPath + "\\" + CraftsNum);
			boolean createDestDir = destDir.mkdir();

			String filePath = realPath + "\\" + CraftsNum + "\\" + fileName;
			File file = new File(filePath);

			if (!file.exists()) {
				FileUtils.moveDirectoryToDirectory(srcFile, destDir, createDestDir);
			}

		} catch (Exception e) {
			System.out.println("moveFile error : " + e.toString());
		}
	}// end of moveFile

	// delete file when delete list
	public void deleteFile(int CraftsNum, String fileName) {
		try {
			String filePath = realPath + "\\" + CraftsNum + "\\" + fileName;
			File file = new File(filePath);

			if (file.exists()) {
				file.delete();
			}
		} catch (Exception e) {
			System.out.println("deleteFile error : " + e.toString());
		}
	}// end of deleteFile
	
	private void downloadFile(HttpServletResponse response, int CraftsNum, String fileName){
		try {			
			String filePath = realPath + "\\" + CraftsNum + "\\" + fileName;
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
	
	private String getFileType1(int CraftsNum, String productImageName1){
		String livingFileType = "";

		try {
			String filePath = realPath + "\\" + CraftsNum + "\\" + productImageName1;
			File file = new File(filePath);
			
			String mimeType = Files.probeContentType(file.toPath());
			livingFileType = mimeType.split("/")[0];
			
		} catch (Exception e) {
			System.out.println("getFileType()메소드 내부에서 오류 : " + e.toString());
		}
		
		return livingFileType;
	}//end of getFileType1
	
	private String getFileType2(int CraftsNum, String productImageName2){
		String livingFileType = "";

		try {
			String filePath = realPath + "\\" + CraftsNum + "\\" + productImageName2;
			File file = new File(filePath);
			
			String mimeType = Files.probeContentType(file.toPath());
			livingFileType = mimeType.split("/")[0];
			
		} catch (Exception e) {
			System.out.println("getFileType()메소드 내부에서 오류 : " + e.toString());
		}
		
		return livingFileType;
	}//end of getFileType2
	
	private String getFileType3(int CraftsNum, String productImageName3){
		String livingFileType = "";

		try {
			String filePath = realPath + "\\" + CraftsNum + "\\" + productImageName3;
			File file = new File(filePath);
			
			String mimeType = Files.probeContentType(file.toPath());
			livingFileType = mimeType.split("/")[0];
			
		} catch (Exception e) {
			System.out.println("getFileType()메소드 내부에서 오류 : " + e.toString());
		}
		
		return livingFileType;
	}//end of getFileType3
	
}
