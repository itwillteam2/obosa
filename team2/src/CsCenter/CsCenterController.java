package CsCenter;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CsCenter/*")
public class CsCenterController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String action = request.getPathInfo();  // /memberForm.do
		System.out.println("action변수에 저장된 요청한 주소 : " + action);

		String nextPage = null;
		
		if(action.equals("/NoticeWrite.do")){
			nextPage = "/Home/CsCenter/NoticeWrite.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		//실제 재요청(포워딩)시 request, response전달
		dispatcher.forward(request, response);
	}
}
