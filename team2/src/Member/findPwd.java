package Member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/findPwd")
public class findPwd extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		response.setHeader("Access-Control-Allow-Origin","*");

		PrintWriter writer = response.getWriter();

		String id = request.getParameter("v_memid");
		String name = request.getParameter("v_memname");
		String email = request.getParameter("v_mememail");
		
		MemberService memberService = new MemberService();
		Boolean check = memberService.findPwd(id, name, email);
		if(check){
			EmailConfirm emailconfirm = new EmailConfirm();
			String authNum=emailconfirm.connectEmail(email);
			writer.print(authNum);
		}
	}
}