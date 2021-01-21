package Member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Order.OrderVO;

@WebServlet("/member/*")
public class MemberController extends HttpServlet{

	private MemberService memberService;
	
	@Override
	public void init() throws ServletException {
		memberService = new MemberService();
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
		
		if(action.equals("/addMember.do")){
			String memtype = request.getParameter("memtype");
			String id = request.getParameter("memid");
			String pwd = request.getParameter("mempwd");
			String name = null;
			String sellnum = null;
			String sellname = null;
			String pnum1 = null;
			String pnum2 = null;
			String pnum3 = null;
			String pnum = null;
			
			if(memtype.equals("customer")){
				name = request.getParameter("memname");
			}else{
				sellnum = request.getParameter("sellnum");
				sellname = request.getParameter("sellname");
				pnum1 = request.getParameter("mempnum1");
				pnum2 = request.getParameter("mempnum2");
				pnum3 = request.getParameter("mempnum3");
				pnum = pnum1 + "-" + pnum2 + "-" + pnum3;
			}
			
			String cpnum1 = request.getParameter("memcpnum1");
			String cpnum2 = request.getParameter("memcpnum2");
			String cpnum3 = request.getParameter("memcpnum3");
			String cpnum = cpnum1 + "-" + cpnum2 + "-" + cpnum3;
			
			String email = request.getParameter("mememail");
			String postcode = request.getParameter("mempostcode");
			String addr1 = request.getParameter("memaddr1");
			String addr2 = request.getParameter("memaddr2");
			
			MemberVO vo = new MemberVO();
			vo.setId(id);
			vo.setPwd(pwd);
			if(memtype.equals("customer")){
				vo.setName(name);
			}else{
				vo.setBusinessRegNum(sellnum);
				vo.setShopName(sellname);
				vo.setPnum(pnum);
			}
			vo.setCpnum(cpnum);
			vo.setEmail(email);
			vo.setPostcode(postcode);
			vo.setAddr1(addr1);
			vo.setAddr2(addr2);
			
			if(memtype.equals("customer")){
				memberService.addCustomer(vo);
			}else{
				memberService.addSeller(vo);
			}
			
			nextPage = "/member/login.do";
		
		}else if(action.equals("/loginCK.do")){
			String id = request.getParameter("memid");
			String pwd = request.getParameter("mempwd");
			String recentURI = request.getParameter("recentURI");
			
			MemberVO vo = new MemberVO();
			vo.setId(id);
			vo.setPwd(pwd);
			
			Boolean check = memberService.login(vo);
			
			if(check){
				HttpSession session = request.getSession();
				session.setAttribute("id", id);
				vo = memberService.searchUser(id);
				String shopName = vo.getShopName();
				if(shopName == null || shopName == ""){
					session.setAttribute("memtype", "customer");
					String name = vo.getName();
					session.setAttribute("name", name);
				}else{
					session.setAttribute("memtype", "seller");
					String name = vo.getShopName();
					session.setAttribute("name", name);
				}
				PrintWriter pw = response.getWriter();
				pw.print("<script>" 
				         + " location.href='"+recentURI+"'; "
						 +"</script>");
			}else{
				PrintWriter pw = response.getWriter();
				pw.print("<script>" 
						 + " alert('아이디 또는 비밀번호가 잘못되었습니다.');"  
				         + " location.href=document.referrer;"
						 +"</script>");
			}
			
		}else if(action.equals("/logout.do")){
			HttpSession session = request.getSession();
			session.invalidate();
			PrintWriter pw = response.getWriter();
			pw.print("<script>" 
			         + " location.href=document.referrer;"
					 +"</script>");
		}else if(action.equals("/login.do")){
			nextPage = "/Home/Member/Login.jsp";
		}else if(action.equals("/join.do")){
			nextPage = "/Home/Member/Join.jsp";
		}else if(action.equals("/userInfoCK.do")){
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			
			MemberVO vo = memberService.searchUser(id);
			request.setAttribute("vo", vo);
			
			nextPage = "/Home/Member/userInfoCK.jsp";
		}else if(action.equals("/userInfo.do")){
			String recentURI = request.getParameter("recentURI");
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			MemberVO vo = memberService.searchUser(id);
			request.setAttribute("vo", vo);
			request.setAttribute("recentURI", recentURI);
			
			nextPage = "/Home/Member/userInfo.jsp";
		}else if(action.equals("/modMember.do")){
			String recentURI = request.getParameter("recentURI");
			String memtype = request.getParameter("memtype");
			String id = request.getParameter("memid");
			String pwd = request.getParameter("mempwd");
			String name = null;
			String sellnum = null;
			String sellname = null;
			String pnum1 = null;
			String pnum2 = null;
			String pnum3 = null;
			String pnum = null;
			
			if(memtype.equals("customer")){
				name = request.getParameter("memname");
			}else{
				sellnum = request.getParameter("sellnum");
				sellname = request.getParameter("sellname");
				pnum1 = request.getParameter("mempnum1");
				pnum2 = request.getParameter("mempnum2");
				pnum3 = request.getParameter("mempnum3");
				pnum = pnum1 + "-" + pnum2 + "-" + pnum3;
			}
			
			String cpnum1 = request.getParameter("memcpnum1");
			String cpnum2 = request.getParameter("memcpnum2");
			String cpnum3 = request.getParameter("memcpnum3");
			String cpnum = cpnum1 + "-" + cpnum2 + "-" + cpnum3;
			
			String email = request.getParameter("mememail");
			String postcode = request.getParameter("mempostcode");
			String addr1 = request.getParameter("memaddr1");
			String addr2 = request.getParameter("memaddr2");
			
			MemberVO vo = new MemberVO();
			vo.setId(id);
			vo.setPwd(pwd);
			if(memtype.equals("customer")){
				vo.setName(name);
			}else{
				vo.setBusinessRegNum(sellnum);
				vo.setShopName(sellname);
				vo.setPnum(pnum);
			}
			vo.setCpnum(cpnum);
			vo.setEmail(email);
			vo.setPostcode(postcode);
			vo.setAddr1(addr1);
			vo.setAddr2(addr2);
			
			if(memtype.equals("customer")){
				memberService.modCustomer(vo);
			}else{
				memberService.modSeller(vo);
			}
			
			PrintWriter pw = response.getWriter();
			pw.print("<script>" 
					 + " alert('정보 수정이 완료되었습니다.');"  
					 + " location.href='"+recentURI+"'; "
					 +"</script>");
		}else if(action.equals("/find.do")){
			nextPage = "/Home/Member/find.jsp";
		}else if(action.equals("/modPwd.do")){
			String id = request.getParameter("memid");
			String pwd = request.getParameter("mempwd");
			memberService.modPwd(id, pwd);
			
			PrintWriter pw = response.getWriter();
			pw.print("<script>" 
					 + " alert('비밀번호 변경이 완료되었습니다.'); "  
					 +"</script>");
			nextPage = "/Home/Member/Login.jsp";
		}else if(action.equals("/delete.do")){
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			System.out.println(id);
			memberService.delete(id);
			session.invalidate();
			
			PrintWriter pw = response.getWriter();
			pw.print("<script>" 
					 + " alert('회원정보가 삭제되었습니다.'); "  
					 +"</script>");
			nextPage = "/Home/index.jsp";
		}else if(action.equals("/orderList.do")){
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");

			List<OrderVO> orderList = memberService.orderList(id);
			request.setAttribute("orderList", orderList);
			
			nextPage = "/Home/Member/orderList.jsp";
		}else if(action.equals("/orderDetail.do")){
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			
			int num = Integer.parseInt(request.getParameter("num"));
			request.setAttribute("num", num);
			
			OrderVO vo = memberService.orderDetail(id, num);
			request.setAttribute("vo", vo);
			
			MemberVO memberVO = new MemberVO();
			
			String sellerName = vo.getSellerName();
			memberVO = memberService.findSeller(sellerName);
			request.setAttribute("seller", memberVO);
			
			nextPage = "/Home/Member/orderDetail.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	
	}//doHandle메소드 끝	
	
}//MemberController서블릿 클래스 끝



