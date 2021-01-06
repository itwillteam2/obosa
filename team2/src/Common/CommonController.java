package Common;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/common/*")
public class CommonController extends HttpServlet{
	
	SearchVO searchVO;
	SearchService searchService;
	
	@Override
	public void init() throws ServletException {
		searchService = new SearchService();
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
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String action = request.getPathInfo();
		System.out.println("action변수에 저장된 요청한 주소 : " + action);
		
		String nextPage = null;

		if(action.equals("/index.do")){
			nextPage = "/Home/index.jsp";
		}else if(action.equals("/cart.do")){
			nextPage = "/Home/Order/Cart.jsp";
		}else if(action.equals("/living.do")){
			nextPage = "/Home/Living/living.jsp";
		}else if(action.equals("/search.do")){
			String search = request.getParameter("kwd");
			request.setAttribute("kwd", search);

			int shopSearchCount = searchService.shopSearchCount(search);
			request.setAttribute("shopSearchCount", shopSearchCount);
			
			List<SearchVO> shopSearchList = searchService.shopSearchList(search);
			request.setAttribute("shopSearchList", shopSearchList);
			
			int searchCount = searchService.searchCount(search);
			request.setAttribute("searchCount", searchCount);
			
			List<SearchVO> searchList = searchService.searchList(search);
			request.setAttribute("searchList", searchList);

			int livingCount = searchService.livingCount(search);
			request.setAttribute("livingCount", livingCount);
			
			List<SearchVO> searchLiving = searchService.searchLiving(search);
			request.setAttribute("searchLiving", searchLiving);
			
			int artCount = searchService.artCount(search);
			request.setAttribute("artCount", artCount);
			
			List<SearchVO> searchArt = searchService.searchArt(search);
			request.setAttribute("searchArt", searchArt);
			
			int fancyCount = searchService.fancyCount(search);
			request.setAttribute("fancyCount", fancyCount);
			
			List<SearchVO> searchFancy = searchService.searchFancy(search);
			request.setAttribute("searchFancy", searchFancy);
			
			nextPage = "/Home/Common/search.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	
	}//doHandle메소드 끝	
	
}//CommonController서블릿 클래스 끝