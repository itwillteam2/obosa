package Common;

import java.io.IOException;
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

import Cart.CartService;
import Crafts.ItemsService;
import Crafts.ItemsVO;
import Member.MemberService;
import Member.MemberVO;
import Order.OrderService;
import Order.OrderVO;
import Page.Paging;


@WebServlet("/common/*")
public class CommonController extends HttpServlet{
	
	SearchVO searchVO;
	SearchService searchService;
	NewArrrivalVO newArrivalVO;
	NewArrivalService newArrivalService;
	
	@Override
	public void init() throws ServletException {
		searchService = new SearchService();
		newArrivalService = new NewArrivalService();
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
			List <NewArrrivalVO> NewArrivalList = newArrivalService.NewArrivalList();
			request.setAttribute("NewArrivalList", NewArrivalList);
		
			nextPage = "/Home/index.jsp";
		}else if(action.equals("/living.do")){		
			nextPage = "/Home/Living/living.jsp";
		}else if(action.equals("/search.do")){
			String search = request.getParameter("kwd");
			String navCategory = (request.getParameter("navCategory")==null)?"all":request.getParameter("navCategory");
			String ord = request.getParameter("ord")==null?"신상품순":request.getParameter("ord");
			
			int count =0; 
			List<SearchVO> list=null; 
			
			int shopSearchCount = searchService.shopSearchCount(search);
			request.setAttribute("shopSearchCount", shopSearchCount);
			
			List<SearchVO> shopSearchList = searchService.shopSearchList(search);
			request.setAttribute("shopSearchList", shopSearchList);
			
			if(navCategory.equals("all")) {
				count=searchService.searchCount(search);
				list = searchService.searchList(search, ord);
			}else if(navCategory.equals("living")){
				count = searchService.livingCount(search);
				list = searchService.searchLiving(search, ord);
			}else if(navCategory.equals("crafts")){			
				count = searchService.craftsCount(search);
				list = searchService.searchCrafts(search, ord);
			}else if(navCategory.equals("fancy")){	
				count = searchService.fancyCount(search);	
				list = searchService.searchFancy(search, ord);
			}
			
			request.setAttribute("ord", ord);
			request.setAttribute("kwd", search);
			request.setAttribute("count", count);
			request.setAttribute("list", list);
			request.setAttribute("navCategory", navCategory);
			
			nextPage = "/Home/Common/search.jsp";
		}else if(action.equals("/viewSearchItems.do")){
			int pageNO = (request.getParameter("pageNO") == null) ? 1 :Integer.parseInt(request.getParameter("pageNO"));
			String navCategory = (request.getParameter("navCategory")==null)?"all":request.getParameter("navCategory");
			String ord = request.getParameter("ord")==null?"신상품순":request.getParameter("ord");
			String kwd = request.getParameter("kwd");
			
			String category = request.getParameter("category");
			request.setAttribute("category", category);
			
			String type = request.getParameter("type");
			request.setAttribute("type", type);
			
			int pageSize = 5;  // 원하는 세팅 값 입력, 페이지 하단 숫자 표시 개수
			int listSize = 8;  // 원하는 세팅 값 입력, 출력 게시물 개수
			
			int count =0; 
			List<SearchVO> list=null; 
			
				if(navCategory.equals("all")) {
					count=searchService.searchCount(kwd);
					list = searchService.viewSearchList(pageNO, listSize, kwd, ord);
				}else if(navCategory.equals("living")){
					count = searchService.livingCount(kwd);
					list = searchService.viewSearchLiving(pageNO, listSize, kwd, ord);
				}else if(navCategory.equals("crafts")){			
					count = searchService.craftsCount(kwd);
					list = searchService.viewSearchCrafts(pageNO, listSize, kwd, ord);
				}else if(navCategory.equals("fancy")){	
					count = searchService.fancyCount(kwd);
					list = searchService.viewSearchFancy(pageNO, listSize, kwd, ord);
				}
			Paging paging = new Paging();
			paging.makePage(count, pageNO, pageSize,listSize);
			
			request.setAttribute("count", count);
			request.setAttribute("list", list);
			request.setAttribute("kwd", kwd);
			request.setAttribute("Paging", paging);
			request.setAttribute("navCategory", navCategory);
			request.setAttribute("ord", ord);
			
			nextPage="/Home/Common/viewSearchItems.jsp";
		}else if(action.equals("/viewSearchShop.do")){
			String kwd = request.getParameter("kwd");
			String name = request.getParameter("shopName");
			int pageNO = (request.getParameter("pageNO") == null) ? 1 :Integer.parseInt(request.getParameter("pageNO"));
			String navCategory = (request.getParameter("navCategory")==null)?"all":request.getParameter("navCategory");
			String ord = request.getParameter("ord")==null?"신상품순":request.getParameter("ord");
			
			int pageSize = 5;  // 원하는 세팅 값 입력, 페이지 하단 숫자 표시 개수
			int listSize = 8;  // 원하는 세팅 값 입력, 출력 게시물 개수
			
			int count =0; 
			List<SearchVO> list=null; 
			
				if(navCategory.equals("all")) {
					count=searchService.shopCount(name);
					list = searchService.shopList(pageNO, listSize, name, ord);
				}else if(navCategory.equals("living")){
					count = searchService.shopLivingCount(name);
					list = searchService.shopLiving(pageNO, listSize, name, ord);
				}else if(navCategory.equals("crafts")){			
					count = searchService.shopCraftsCount(name);
					list = searchService.shopCrafts(pageNO, listSize, name, ord);
				}else if(navCategory.equals("fancy")){	
					count = searchService.shopFancyCount(name);		
					list = searchService.shopFancy(pageNO, listSize, name, ord);
				}
				
			Paging paging = new Paging();
			paging.makePage(count, pageNO, pageSize,listSize);
				
			request.setAttribute("ord", ord);
			request.setAttribute("shopName", name);
			request.setAttribute("navCategory", navCategory);
			request.setAttribute("count", count);
			request.setAttribute("list", list);
			request.setAttribute("Paging", paging);
			request.setAttribute("shopName", name);
			request.setAttribute("kwd", kwd);
			
			nextPage="/Home/Common/viewSearchShop.jsp";
		}else if(action.equals("/seller.do")){
			String name = request.getParameter("shopName");
			int pageNO = (request.getParameter("pageNO") == null) ? 1 :Integer.parseInt(request.getParameter("pageNO"));
			String navCategory = (request.getParameter("navCategory")==null)?"all":request.getParameter("navCategory");
			String ord = request.getParameter("ord")==null?"신상품순":request.getParameter("ord");
	
			int pageSize = 5;  // 원하는 세팅 값 입력, 페이지 하단 숫자 표시 개수
			int listSize = 8;  // 원하는 세팅 값 입력, 출력 게시물 개수
	
			int count =0; 
			List<SearchVO> list=null; 
			
				if(navCategory.equals("all")) {
					count=searchService.shopCount(name);
					list = searchService.shopList(pageNO, listSize, name, ord);
				}else if(navCategory.equals("living")){
					count = searchService.shopLivingCount(name);
					list = searchService.shopLiving(pageNO, listSize, name, ord);
				}else if(navCategory.equals("crafts")){			
					count = searchService.shopCraftsCount(name);
					list = searchService.shopCrafts(pageNO, listSize, name, ord);
				}else if(navCategory.equals("fancy")){	
					count = searchService.shopFancyCount(name);		
					list = searchService.shopFancy(pageNO, listSize, name, ord);
				}
				
			Paging paging = new Paging();
			paging.makePage(count, pageNO, pageSize,listSize);
			
			request.setAttribute("count", count);
			request.setAttribute("list", list);
			request.setAttribute("Paging", paging);
			request.setAttribute("shopName", name);
			request.setAttribute("navCategory", navCategory);
			request.setAttribute("ord", ord);
			
			nextPage="/Home/Seller/seller.jsp";
		}else if(action.equals("/write.do")){
			nextPage="/Home/Seller/upContent.jsp";
		}else if(action.equals("/purchase.do")){
			
			String fd = request.getParameter("fd");
			request.setAttribute("fd", fd);
			
			int num = Integer.parseInt(request.getParameter("num"));
			request.setAttribute("num", num);
			
			MemberService mservice = new MemberService();
			MemberVO membervo = new MemberVO();
			
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			
			membervo = mservice.searchUser(id);
			request.setAttribute("user", membervo);
			
			Living.ItemsService lservice = new Living.ItemsService();
			Living.ItemsVO livingvo = new Living.ItemsVO();
			
			ItemsService cservice = new ItemsService();
			ItemsVO craftsvo = new ItemsVO();
			
			Fancy.ItemsService fservice = new Fancy.ItemsService();
			Fancy.ItemsVO fancyvo = new Fancy.ItemsVO();
			
			if(fd.equals("living")){
				livingvo = lservice.getContent(num);
				request.setAttribute("item", livingvo);
			}else if(fd.equals("crafts")){
				craftsvo = cservice.getContent(num);
				request.setAttribute("item", craftsvo);
			}else if(fd.equals("fancy")){
				fancyvo = fservice.getContent(num);
				request.setAttribute("item", fancyvo);
			}

			nextPage="/Home/Common/purchase.jsp";
		}else if(action.equals("/payment.do")){
			String fd = request.getParameter("fd");
			request.setAttribute("fd", fd);
			
			int num = Integer.parseInt(request.getParameter("num"));
			request.setAttribute("num", num);
			
			int qty = Integer.parseInt(request.getParameter("qty"));
			request.setAttribute("qty", qty);
			
			MemberService mservice = new MemberService();
			MemberVO membervo = new MemberVO();
			
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			
			membervo = mservice.searchUser(id);
			request.setAttribute("user", membervo);
			
			Living.ItemsService lservice = new Living.ItemsService();
			Living.ItemsVO livingvo = new Living.ItemsVO();
			
			ItemsService cservice = new ItemsService();
			ItemsVO craftsvo = new ItemsVO();
			
			Fancy.ItemsService fservice = new Fancy.ItemsService();
			Fancy.ItemsVO fancyvo = new Fancy.ItemsVO();
			
			if(fd.equals("living")){
				livingvo = lservice.getContent(num);
				request.setAttribute("item", livingvo);
			}else if(fd.equals("crafts")){
				craftsvo = cservice.getContent(num);
				request.setAttribute("item", craftsvo);
			}else if(fd.equals("fancy")){
				fancyvo = fservice.getContent(num);
				request.setAttribute("item", fancyvo);
			}
			
			nextPage="/Home/Common/payment.jsp";
		}else if(action.equals("/pay.do")){
			Map<String, String> paymentMap = paymentMap(request, response);
			request.setAttribute("paymentMap",  paymentMap);
			
			nextPage="/Home/Common/pay.jsp";
		}else if(action.equals("/success.do")){
			Map<String, String> paymentMap = paymentMap(request, response);
			request.setAttribute("paymentMap",  paymentMap);
			
			String fd = paymentMap.get("fd");
			int num = Integer.parseInt(paymentMap.get("num"));
			String sellerName = "";
			int shipping_fee = 0;
			int point = Integer.parseInt(paymentMap.get("point"));
			int gainPoint = Integer.parseInt(paymentMap.get("gainPoint"));
			int usingPoint = Integer.parseInt(paymentMap.get("usingPoint"));
			int p = gainPoint - usingPoint + point;
			System.out.println(gainPoint + "-" + usingPoint + "+" + point + " = " + p);
			
			if(fd.equals("living")){
				Living.ItemsService lservice = new Living.ItemsService();
				Living.ItemsVO lvo = lservice.getContent(num);
				sellerName = lvo.getSellerName();
				shipping_fee = lvo.getShipping_fee();
			}else if(fd.equals("crafts")){
				ItemsService cservice = new ItemsService();
				ItemsVO cvo = cservice.getContent(num);
				sellerName = cvo.getSellerName();
				shipping_fee = cvo.getShipping_fee();
			}else if(fd.equals("fancy")){
				Fancy.ItemsService fservice = new Fancy.ItemsService();
				Fancy.ItemsVO fvo = fservice.getContent(num);
				sellerName = fvo.getSellerName();
				shipping_fee = fvo.getShipping_fee();
			}
			
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
	
			//장바구니 삭제
			CartService cservice = new CartService();
			cservice.deleteContent(num, fd, id);
			
			OrderService oservice = new OrderService();
			OrderVO ovo = new OrderVO();
			 
			ovo.setId(id);
			ovo.setName(paymentMap.get("oname"));
			ovo.setCpnum(paymentMap.get("cpnum"));
			ovo.setEmail(paymentMap.get("email"));
			ovo.setPostcode(paymentMap.get("postcode"));
			ovo.setAddress(paymentMap.get("address"));
			ovo.setCategory(fd);
			ovo.setItemnum(num);
			ovo.setProductName(paymentMap.get("productName"));
			ovo.setSellerName(sellerName);
			ovo.setQuantity(Integer.parseInt(paymentMap.get("qty")));
			ovo.setPrice(Integer.parseInt(paymentMap.get("totalPrice")));
			ovo.setShipping_fee(shipping_fee);
			
			oservice.addOrder(ovo);
			
			MemberService mservice = new MemberService();
			mservice.addPoint(id, p);
			
			nextPage="/Home/Common/success.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	
	}//doHandle메소드 끝	
	
	private Map<String, String> paymentMap(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Map<String, String> paymentMap = new HashMap<String, String>();
		
		String oname = request.getParameter("oname");
		String email = request.getParameter("email");
		String cpnum = request.getParameter("cpnum");
		String address = request.getParameter("address");
		String postcode = request.getParameter("postcode");
		String productName = request.getParameter("productName");
		String qty = request.getParameter("qty");
		String totalPrice = request.getParameter("totalPrice");
		String fd = request.getParameter("fd");
		String num = request.getParameter("num");
		String productImageName = request.getParameter("productImageName");
		String recentURI = request.getParameter("recentURI");
		String point = request.getParameter("point");
		String gainPoint = request.getParameter("gainPoint");
		String usingPoint = request.getParameter("usingPoint");
		
		paymentMap.put("oname", oname);
		paymentMap.put("email", email);
		paymentMap.put("cpnum", cpnum);
		paymentMap.put("address", address);
		paymentMap.put("postcode", postcode);
		paymentMap.put("productName", productName);
		paymentMap.put("qty", qty);
		paymentMap.put("totalPrice", totalPrice);
		paymentMap.put("fd", fd);
		paymentMap.put("num", num);
		paymentMap.put("productImageName", productImageName);
		paymentMap.put("recentURI", recentURI);
		paymentMap.put("point", point);
		paymentMap.put("gainPoint", gainPoint);
		paymentMap.put("usingPoint", usingPoint);
		
		return paymentMap;
	}//end 

}//CommonController서블릿 클래스 끝