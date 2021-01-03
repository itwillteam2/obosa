package Common;

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

@WebServlet("/common/*")
public class CommonController extends HttpServlet{

//	MemberDAO memberDAO;
//	
//	@Override
//	public void init() throws ServletException {
//		memberDAO = new MemberDAO();
//	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//인코딩 방식 UTF-8로 설정
		request.setCharacterEncoding("utf-8");
		//웹브라우저로 응답할 MIME-TYPE설정(데이터유형 설정)
		response.setContentType("text/html; charset=utf-8");
		
		//request객체의 getPathInfo()메소드를 호출해  
		//요청한 전체 URL주소중에서 .. 2단계 요청 주소를 얻는다
		String action = request.getPathInfo();  // /memberForm.do
		System.out.println("action변수에 저장된 요청한 주소 : " + action);
		
		//MVC 중 View화면 주소를 변수에 저장하기 위한 변수 선언
		String nextPage = null;
		
		//action변수에 값에 따라 if문을 분기해서 요청한 작업을 수행하는데..
		//만약 action변수의 값이 null이거나  /listMembers.do인 경우에는
		//회원 검색 기능을 수행합니다.
		//-> 회원 조회 기능 요청이 들어 오면(/listMembers.do)
		if(action.equals("/index.do")){
			nextPage = "/T2_tmp/Home/index.jsp";
		}else if(action.equals("/cart.do")){
			nextPage = "/T2_tmp/Home/Order/Cart.jsp";
		}else if(action.equals("/living.do")){
			nextPage = "/T2_tmp/Home/Living/living.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		//실제 재요청(포워딩)시 request, response전달
		dispatcher.forward(request, response);
	
	}//doHandle메소드 끝	
	
}//MemberController서블릿 클래스 끝



