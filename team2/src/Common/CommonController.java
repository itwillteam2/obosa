package Common;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Crafts.ItemsVO;
import Living.ItemsDAO;
import Member.MemberDAO;
import Member.MemberVO;
import Page.Paging;


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
			
			int pageSize = 5;  // 원하는 세팅 값 입력, 페이지 하단 숫자 표시 개수
			int listSize = 8;  // 원하는 세팅 값 입력, 출력 게시물 개수
			
			//전체
			int searchCount = searchService.searchCount(kwd);
			request.setAttribute("searchCount", searchCount);
			
			int allPageNO = (request.getParameter("allPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("allPageNO"));
			
			List<SearchVO> searchList = searchService.viewSearchList(allPageNO, listSize, kwd, ord);
			request.setAttribute("searchList", searchList);
			
			Paging allPaging = new Paging();
			allPaging.makePage(searchCount, allPageNO, listSize, pageSize);
			request.setAttribute("allPaging", allPaging);
			
			//리빙리스트
			int livingCount = searchService.livingCount(kwd);
			request.setAttribute("livingCount", livingCount);
			
			int livingPageNO = (request.getParameter("livingPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("livingPageNO"));
			
			List<SearchVO> searchLiving = searchService.viewSearchLiving(livingPageNO, listSize, kwd, ord);
			request.setAttribute("searchLiving", searchLiving);
			
			Paging livingPaging = new Paging();
			livingPaging.makePage(searchCount, livingPageNO, listSize, pageSize);
			request.setAttribute("livingPaging", livingPaging);
			
			//공예리스트
			int craftsCount = searchService.craftsCount(kwd);
			request.setAttribute("craftsCount", craftsCount);
			
			int craftsPageNO = (request.getParameter("craftsPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("craftsPageNO"));
			
			List<SearchVO> searchCrafts = searchService.viewSearchCrafts(craftsPageNO, listSize, kwd, ord);
			request.setAttribute("searchCrafts", searchCrafts);
			
			Paging craftsPaging = new Paging();
			craftsPaging.makePage(searchCount, craftsPageNO, listSize, pageSize);
			request.setAttribute("craftsPaging", craftsPaging);
			
			//팬시리스트
			int fancyCount = searchService.fancyCount(kwd);
			request.setAttribute("fancyCount", fancyCount);
			
			int fancyPageNO = (request.getParameter("fancyPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("fancyPageNO"));
			
			List<SearchVO> searchFancy = searchService.viewSearchFancy(fancyPageNO, listSize, kwd, ord);
			request.setAttribute("searchFancy", searchFancy);
			
			Paging fancyPaging = new Paging();
			fancyPaging.makePage(searchCount, fancyPageNO, listSize, pageSize);
			request.setAttribute("fancyPaging", fancyPaging);
			
			nextPage="/Home/Common/viewSearchItems.jsp";
		}else if(action.equals("/viewSearchShop.do")){
			String kwd = request.getParameter("kwd");
			request.setAttribute("kwd", kwd);
			
			String ord = request.getParameter("ord");
			if(ord == null || ord ==""){
				ord = "신상품순";
			}
			request.setAttribute("ord", ord);
			
			String category = request.getParameter("category");
			request.setAttribute("category", category);
			
			String name = request.getParameter("name");
			request.setAttribute("shopName", name);
			
			int pageSize = 5;  // 원하는 세팅 값 입력, 페이지 하단 숫자 표시 개수
			int listSize = 8;  // 원하는 세팅 값 입력, 출력 게시물 개수
			
			//전체
			int searchCount = searchService.shopCount(name);
			request.setAttribute("searchCount", searchCount);
			
			int allPageNO = (request.getParameter("allPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("allPageNO"));
			
			List<SearchVO> searchList = searchService.shopList(allPageNO, listSize, name, ord);
			request.setAttribute("searchList", searchList);
			
			Paging allPaging = new Paging();
			allPaging.makePage(searchCount, allPageNO, listSize, pageSize);
			request.setAttribute("allPaging", allPaging);
			
			//리빙리스트
			int livingCount = searchService.shopLivingCount(name);
			request.setAttribute("livingCount", livingCount);
			
			int livingPageNO = (request.getParameter("livingPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("livingPageNO"));
			
			List<SearchVO> searchLiving = searchService.shopLiving(livingPageNO, listSize, name, ord);
			request.setAttribute("searchLiving", searchLiving);
			
			Paging livingPaging = new Paging();
			livingPaging.makePage(searchCount, livingPageNO, listSize, pageSize);
			request.setAttribute("livingPaging", livingPaging);
			
			//공예리스트
			int craftsCount = searchService.shopCraftsCount(name);
			request.setAttribute("craftsCount", craftsCount);
			
			int craftsPageNO = (request.getParameter("craftsPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("craftsPageNO"));
			
			List<SearchVO> searchCrafts = searchService.shopCrafts(craftsPageNO, listSize, name, ord);
			request.setAttribute("searchCrafts", searchCrafts);
			
			Paging craftsPaging = new Paging();
			craftsPaging.makePage(searchCount, craftsPageNO, listSize, pageSize);
			request.setAttribute("craftsPaging", craftsPaging);
			
			//문구리스트
			int fancyCount = searchService.shopFancyCount(name);
			request.setAttribute("fancyCount", fancyCount);
			
			int fancyPageNO = (request.getParameter("fancyPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("fancyPageNO"));
			
			List<SearchVO> searchFancy = searchService.shopFancy(fancyPageNO, listSize, name, ord);
			request.setAttribute("searchFancy", searchFancy);
			
			Paging fancyPaging = new Paging();
			fancyPaging.makePage(searchCount, fancyPageNO, listSize, pageSize);
			request.setAttribute("fancyPaging", fancyPaging);
			
			nextPage="/Home/Common/viewSearchShop.jsp";
		}else if(action.equals("/seller.do")){
			String name = request.getParameter("shopName");
			request.setAttribute("shopName", name);
			
			String ord = request.getParameter("ord");
			if(ord == null || ord ==""){
				ord = "신상품순";
			}
			request.setAttribute("ord", ord);
			
			int pageSize = 5;  // 원하는 세팅 값 입력, 페이지 하단 숫자 표시 개수
			int listSize = 8;  // 원하는 세팅 값 입력, 출력 게시물 개수
			
			String category = request.getParameter("category");
			request.setAttribute("category", category);
			
			//전체
			int searchCount = searchService.shopCount(name);
			request.setAttribute("searchCount", searchCount);
			
			int allPageNO = (request.getParameter("allPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("allPageNO"));
			
			List<SearchVO> searchList = searchService.shopList(allPageNO, listSize, name, ord);
			request.setAttribute("searchList", searchList);
			
			Paging allPaging = new Paging();
			allPaging.makePage(searchCount, allPageNO, listSize, pageSize);
			request.setAttribute("allPaging", allPaging);
			
			//리빙리스트
			int livingCount = searchService.shopLivingCount(name);
			request.setAttribute("livingCount", livingCount);
			
			int livingPageNO = (request.getParameter("livingPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("livingPageNO"));
			
			List<SearchVO> searchLiving = searchService.shopLiving(livingPageNO, listSize, name, ord);
			request.setAttribute("searchLiving", searchLiving);
			
			Paging livingPaging = new Paging();
			livingPaging.makePage(searchCount, livingPageNO, listSize, pageSize);
			request.setAttribute("livingPaging", livingPaging);
			
			//공예리스트
			int craftsCount = searchService.shopCraftsCount(name);
			request.setAttribute("craftsCount", craftsCount);
			
			int craftsPageNO = (request.getParameter("craftsPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("craftsPageNO"));
			
			List<SearchVO> searchCrafts = searchService.shopCrafts(craftsPageNO, listSize, name, ord);
			request.setAttribute("searchCrafts", searchCrafts);
			
			Paging craftsPaging = new Paging();
			craftsPaging.makePage(searchCount, craftsPageNO, listSize, pageSize);
			request.setAttribute("craftsPaging", craftsPaging);
			
			//문구리스트
			int fancyCount = searchService.shopFancyCount(name);
			request.setAttribute("fancyCount", fancyCount);
			
			int fancyPageNO = (request.getParameter("fancyPageNO") == null) ? 1 : Integer.parseInt(request.getParameter("fancyPageNO"));
			
			List<SearchVO> searchFancy = searchService.shopFancy(fancyPageNO, listSize, name, ord);
			request.setAttribute("searchFancy", searchFancy);
			
			Paging fancyPaging = new Paging();
			fancyPaging.makePage(searchCount, fancyPageNO, listSize, pageSize);
			request.setAttribute("fancyPaging", fancyPaging);
			
			nextPage="/Home/Seller/seller.jsp";
		}else if(action.equals("/write.do")){
			nextPage="/Home/Seller/upContent.jsp";
		}else if(action.equals("/payment.do")){
			String fd = request.getParameter("fd");
			request.setAttribute("fd", fd);
			
			int num = Integer.parseInt(request.getParameter("num"));
			request.setAttribute("num", num);
			
			int qty = Integer.parseInt(request.getParameter("qty"));
			request.setAttribute("qty", qty);
			
			MemberDAO memberdao = new MemberDAO();
			MemberVO membervo = new MemberVO();
			
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			
			membervo = memberdao.searchUser(id);
			request.setAttribute("user", membervo);
			
			ItemsDAO livingdao = new ItemsDAO();
			Living.ItemsVO livingvo = new Living.ItemsVO();
			
			Crafts.ItemsDAO craftsdao = new Crafts.ItemsDAO();
			ItemsVO craftsvo = new ItemsVO();
			
			if(fd.equals("living")){
				livingvo = livingdao.getContent(num);
				request.setAttribute("item", livingvo);
			}else if(fd.equals("crafts")){
				craftsvo = craftsdao.getContent(num);
				request.setAttribute("item", craftsvo);
			}
			
			nextPage="/Home/Common/payment.jsp";
		}else if(action.equals("/pay.do")){
			String oname = request.getParameter("oname");
			request.setAttribute("oname", oname);
			
			String email = request.getParameter("email");
			request.setAttribute("email", email);
			
			String cpnum = request.getParameter("cpnum");
			request.setAttribute("cpnum", cpnum);
			
			String address = request.getParameter("address");
			request.setAttribute("address", address);
			
			String postcode = request.getParameter("postcode");
			request.setAttribute("postcode", postcode);
			
			String productName = request.getParameter("productName");
			request.setAttribute("productName", productName);
			
			String qty = request.getParameter("qty");
			request.setAttribute("qty", qty);
			
			int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
			request.setAttribute("totalPrice", totalPrice);
			
			String fd = request.getParameter("fd");
			request.setAttribute("fd", fd);
			
			String num = request.getParameter("num");
			request.setAttribute("num", num);
			
			String productImageName = request.getParameter("productImageName");
			request.setAttribute("productImageName", productImageName);
			
			String recentURI = request.getParameter("recentURI");
			request.setAttribute("recentURI", recentURI);
			
			nextPage="/Home/Common/pay.jsp";
		}else if(action.equals("/success.do")){
			String productName = request.getParameter("productName");
			request.setAttribute("productName", productName);
			
			String qty = request.getParameter("qty");
			request.setAttribute("qty", qty);
			
			int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
			request.setAttribute("totalPrice", totalPrice);
			
			String fd = request.getParameter("fd");
			request.setAttribute("fd", fd);
			
			String num = request.getParameter("num");
			request.setAttribute("num", num);
			
			String productImageName = request.getParameter("productImageName");
			request.setAttribute("productImageName", productImageName);
			System.out.println("★★" + productImageName);
			
			nextPage="/Home/Common/success.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	
	}//doHandle메소드 끝	
	
}//CommonController서블릿 클래스 끝