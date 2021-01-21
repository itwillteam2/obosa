package Cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/cart/*")
public class CartController extends HttpServlet{
	
	CartService service;
	
	@Override
	public void init() throws ServletException {
		service = new CartService();
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
		String nextPage = null;
		HttpSession session = request.getSession();
		String customer_id = (String)session.getAttribute("id");
		
		
		
		if(action.equals("/cartList.do")){	
			List<CartVO> cart = new ArrayList<CartVO>();
			cart = service.getCart(customer_id);
			request.setAttribute("cart", cart);
				
			nextPage="/Home/Common/cart.jsp";
		
		} else if (action.equals("/addCart.do")) {	
			int pnum=Integer.parseInt(request.getParameter("pnum"));
			String category=request.getParameter("category");		
			int cartQuantity=Integer.parseInt(request.getParameter("cartQuantity"));
			int count = service.insertContent(pnum,category,customer_id,cartQuantity);
			if(count!=0) { 
				request.setAttribute("cartCount", count);
				PrintWriter pw = response.getWriter();
				pw.print("<script>"
					+"alert('장바구니에 등록하였습니다.');"
					+"history.back();"
					+"</script>");		
				pw.flush();
				return;
				
			}else {
				PrintWriter pw = response.getWriter();
				pw.print("<script>"
					+"alert('장바구니 등록에 실패하였습니다.'); "
					+"history.back();"
					+"</script>");		
				pw.flush();
				return;
			}
		} else if (action.equals("/delChkCart.do")) {
			String[] pnums  = request.getParameterValues("pnum");
			String[] categorys  = request.getParameterValues("category");
			for(int i=0;i<pnums.length;i++) {
				int pnum = Integer.parseInt(pnums[i]);
				service.deleteContent(pnum,categorys[i],customer_id);
			}
			return;
		} else if (action.equals("/modCart.do")) {
			int pnum=Integer.parseInt(request.getParameter("pnum"));
			String category=request.getParameter("category");		
			int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"));
			int totalPrice=Integer.parseInt(request.getParameter("totalPrice"));
			
			int result=service.updateContent(pnum,category,customer_id,cartQuantity,totalPrice);
			if(result==1) {
				PrintWriter pw = response.getWriter();
				pw.print("updated");	
				pw.flush();
				return;
			}else {
				PrintWriter pw = response.getWriter();
				pw.print("failed");		
				pw.flush();
				return;
			}
		} else if (action.equals("/delCart.do")) {	
			int pnum=Integer.parseInt(request.getParameter("pnum"));
			String category=request.getParameter("category");		
			
			int result = service.deleteContent(pnum,category,customer_id);
			if(result!=0) {
				PrintWriter pw = response.getWriter();
				pw.print(result);	
				pw.flush();
				return;
			}else {
				PrintWriter pw = response.getWriter();
				pw.print("<script>"
					+"alert('상품 내용 삭제에 실패하였습니다.'); "
					+"history.back();"
					+"</script>");		
				pw.flush();
				return;
			}	
		} else if (action.equals("/countCart.do")) {
			int count = service.totalCount(customer_id);
			PrintWriter pw = response.getWriter();
			pw.print(count);		
			pw.flush();
			return;
		
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	
	}//end Handle
}//end Class