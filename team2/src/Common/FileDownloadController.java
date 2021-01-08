package Common;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//viewArticle.jsp에서 전송한 글번호와 이미지파일이름으로 파일 경로를 만든후  해당 파일을 내려 받습니다.

@WebServlet("/download.do")
public class FileDownloadController extends HttpServlet{ //이미지를 다운받아 <img>태그에 제공 해주는 클래스 

	private static String ARTICLE_IMAGE_REPO = "C:\\files\\article_image\\";
	
	
	@Override
	protected void doGet(HttpServletRequest request, 
			             HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, 
			             HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}	
	
	protected void doHandle(HttpServletRequest request, 
            				HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		String productImageName = request.getParameter("productImageName");
		String fileFolder = request.getParameter("fd");
		String num = request.getParameter("num");
		OutputStream out = response.getOutputStream();
		String path = ARTICLE_IMAGE_REPO +fileFolder+"\\"+num+"\\"+productImageName;
		File imageFile = new File(path);
		
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment;filename=" + productImageName);

		FileInputStream in = new FileInputStream(imageFile);
		
		byte[] buffer = new byte[1024*8]; //8kb
		
		while (true) {
			int count = in.read(buffer);
			if(count == -1){
				break;
			}
			out.write(buffer, 0, count);
		}
		System.out.println(path);
		in.close();
		out.close();
	}		
	
}






