package Auction;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("auction/*")
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
			//리스트 불러오기
		}else if(action.equals("/addAuctionItem.do")) {
			int num = Integer.parseInt(request.getParameter("num"));
			
		}
		
		
	}//end of doHandle
	
	

}
