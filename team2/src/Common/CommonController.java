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
			
			String ord = request.getParameter("ord");
			if(ord == null || ord ==""){
				ord = "신상품순";
			}
			request.setAttribute("ord", ord);
			
			String category = request.getParameter("category");
			request.setAttribute("category", category);
			
			int shopSearchCount = searchService.shopSearchCount(search);
			request.setAttribute("shopSearchCount", shopSearchCount);
			
			List<SearchVO> shopSearchList = searchService.shopSearchList(search);
			request.setAttribute("shopSearchList", shopSearchList);
			
			int searchCount = searchService.searchCount(search);
			request.setAttribute("searchCount", searchCount);
			
			List<SearchVO> searchList = searchService.searchList(search, ord);
			request.setAttribute("searchList", searchList);

			int livingCount = searchService.livingCount(search);
			request.setAttribute("livingCount", livingCount);
			
			List<SearchVO> searchLiving = searchService.searchLiving(search, ord);
			request.setAttribute("searchLiving", searchLiving);
			
			int craftsCount = searchService.craftsCount(search);
			request.setAttribute("craftsCount", craftsCount);
			
			List<SearchVO> searchCrafts = searchService.searchCrafts(search, ord);
			request.setAttribute("searchCrafts", searchCrafts);
			
			int fancyCount = searchService.fancyCount(search);
			request.setAttribute("fancyCount", fancyCount);
			
			List<SearchVO> searchFancy = searchService.searchFancy(search, ord);
			request.setAttribute("searchFancy", searchFancy);
			
			nextPage = "/Home/Common/search.jsp";
		}else if(action.equals("/viewSearchItems.do")){
			String kwd = request.getParameter("kwd");
			request.setAttribute("kwd", kwd);
			
			String ord = request.getParameter("ord");
			if(ord == null || ord ==""){
				ord = "신상품순";
			}
			request.setAttribute("ord", ord);
			
			String category = request.getParameter("category");
			request.setAttribute("category", category);
			
			String type = request.getParameter("type");
			request.setAttribute("type", type);
			
			int searchCount = searchService.searchCount(kwd);
			request.setAttribute("searchCount", searchCount);
			
			List<SearchVO> searchList = searchService.searchList(kwd, ord);
			request.setAttribute("searchList", searchList);

			int livingCount = searchService.livingCount(kwd);
			request.setAttribute("livingCount", livingCount);
			
			List<SearchVO> searchLiving = searchService.searchLiving(kwd, ord);
			request.setAttribute("searchLiving", searchLiving);
			
			int craftsCount = searchService.craftsCount(kwd);
			request.setAttribute("craftsCount", craftsCount);
			
			List<SearchVO> searchCrafts = searchService.searchCrafts(kwd, ord);
			request.setAttribute("searchCrafts", searchCrafts);
			
			int fancyCount = searchService.fancyCount(kwd);
			request.setAttribute("fancyCount", fancyCount);
			
			List<SearchVO> searchFancy = searchService.searchFancy(kwd, ord);
			request.setAttribute("searchFancy", searchFancy);
			
			nextPage="/Home/Common/viewSearchItems.jsp";
		}else if(action.equals("/viewSearchShop.do")){
			String kwd = request.getParameter("kwd");
			request.setAttribute("kwd", kwd);
			
			String name = request.getParameter("name");
			request.setAttribute("shopName", name);
			
			int searchCount = searchService.shopCount(name);
			request.setAttribute("searchCount", searchCount);
			
			List<SearchVO> searchList = searchService.shopList(name);
			request.setAttribute("searchList", searchList);

			int livingCount = searchService.shopLivingCount(name);
			request.setAttribute("livingCount", livingCount);
			
			List<SearchVO> searchLiving = searchService.shopLiving(name);
			request.setAttribute("searchLiving", searchLiving);
			
			int craftsCount = searchService.shopCraftsCount(name);
			request.setAttribute("craftsCount", craftsCount);
			
			List<SearchVO> searchCrafts = searchService.shopCrafts(name);
			request.setAttribute("searchCrafts", searchCrafts);
			
			int fancyCount = searchService.shopFancyCount(name);
			request.setAttribute("fancyCount", fancyCount);
			
			List<SearchVO> searchFancy = searchService.shopFancy(name);
			request.setAttribute("searchFancy", searchFancy);
			
			nextPage="/Home/Common/viewSearchShop.jsp";
		}else if(action.equals("/seller.do")){
			String name = request.getParameter("shopName");
			request.setAttribute("shopName", name);
			
			int searchCount = searchService.shopCount(name);
			request.setAttribute("searchCount", searchCount);
			
			List<SearchVO> searchList = searchService.shopList(name);
			request.setAttribute("searchList", searchList);

			int livingCount = searchService.shopLivingCount(name);
			request.setAttribute("livingCount", livingCount);
			
			List<SearchVO> searchLiving = searchService.shopLiving(name);
			request.setAttribute("searchLiving", searchLiving);
			
			int craftsCount = searchService.shopCraftsCount(name);
			request.setAttribute("craftsCount", craftsCount);
			
			List<SearchVO> searchCrafts = searchService.shopCrafts(name);
			request.setAttribute("searchCrafts", searchCrafts);
			
			int fancyCount = searchService.shopFancyCount(name);
			request.setAttribute("fancyCount", fancyCount);
			
			List<SearchVO> searchFancy = searchService.shopFancy(name);
			request.setAttribute("searchFancy", searchFancy);
			
			nextPage="/Home/Seller/seller.jsp";
		}else if(action.equals("/write.do")){
			nextPage="/Home/Seller/write.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	
	}//doHandle메소드 끝	
	
}//CommonController서블릿 클래스 끝