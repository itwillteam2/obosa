package CsCenter;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CsCenter/*")
public class CsCenterController extends HttpServlet {
	
	CsCenterService CsCenterService;
	NoticeVO NoticeVO;
	
	//서블릿 초기화시 BoardService객체를 생성합니다.
	@Override
	public void init() throws ServletException {
		CsCenterService = new CsCenterService();
		NoticeVO = new NoticeVO();
	}
	
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

		String action = request.getPathInfo(); // /memberForm.do
		System.out.println("action변수에 저장된 요청한 주소 : " + action);

		String nextPage = null;

		List<NoticeVO> NoticeList = null;
		
		if (action.equals("/NoticeWrite.do")) {
			nextPage = "/Home/CsCenter/NoticeWrite.jsp";
		} else if (action.equals("/NoticeList.do")) {
			
			NoticeList  = CsCenterService.listNotice(); 
			
			request.setAttribute("NoticeList", NoticeList);
			
			nextPage = "/Home/CsCenter/NoticeList.jsp";
		} 
		  else if (action.equals("/InquiryWrite.do")) {
			nextPage = "/Home/CsCenter/InquiryWrite.jsp";
		} else if (action.equals("/addNotice.do")) {
			
			int nnum = 0;			
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			NoticeVO.setNnum(nnum);
			NoticeVO.setTitle(title);
			NoticeVO.setContent(content);

			nnum = CsCenterService.addNotice(NoticeVO);
			
			PrintWriter pw = response.getWriter();
			pw.print("<script> alert('공지사항을 추가 했습니다.'); </script>");
			
			nextPage = "/Home/CsCenter/NoticeList.jsp";
			
		} else if (action.equals("/InquiryList.do")) {
			nextPage = "/Home/CsCenter/InquiryList.jsp";
		} 
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		// 실제 재요청(포워딩)시 request, response전달
		dispatcher.forward(request, response);
	}
}
