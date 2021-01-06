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

import Living.LivingVO;

@WebServlet("/CsCenter/*")
public class CsCenterController extends HttpServlet {
	
	CsCenterService CsCenterService;
	NoticeVO NoticeVO;
	InquiryVO InquiryVO;
	
	//서블릿 초기화시 BoardService객체를 생성합니다.
	@Override
	public void init() throws ServletException {
		CsCenterService = new CsCenterService();
		NoticeVO = new NoticeVO();
		InquiryVO = new InquiryVO();
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
		List<InquiryVO> InquiryList = null;
		
		if (action.equals("/NoticeWrite.do")) {
			nextPage = "/Home/CsCenter/NoticeWrite.jsp";
		} else if (action.equals("/NoticeList.do")) {
			
			NoticeList  = CsCenterService.listNotice(); 
			
			request.setAttribute("NoticeList", NoticeList);

			nextPage = "/Home/CsCenter/NoticeList.jsp";
		}else if (action.equals("/InquiryList.do")) {
			
			InquiryList  = CsCenterService.listInquiry(); 
			
			request.setAttribute("InquiryList", InquiryList);
			System.out.println(InquiryList);
			nextPage = "/Home/CsCenter/InquiryList.jsp";
		}  
		
		
		  else if (action.equals("/InquiryWrite.do")) {
			nextPage = "/Home/CsCenter/InquiryWrite.jsp";
		} else if (action.equals("/addNotice.do")) {
			
			int nnum = 0;			
			String pw = request.getParameter("pw");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			NoticeVO.setPw(pw);
			NoticeVO.setNnum(nnum);
			NoticeVO.setTitle(title);
			NoticeVO.setContent(content);

			nnum = CsCenterService.addNotice(NoticeVO);
			
			PrintWriter pw2 = response.getWriter();
			pw2.print("<script>" + "  alert('공지사항을 추가 했습니다.');" + " location.href='" + request.getContextPath()
					+ "/CsCenter/NoticeList.do';" + "</script>");
			
		}else if (action.equals("/addInquiry.do")) {
			
			int inqnum = 0;			
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String title = request.getParameter("title");
			String email = request.getParameter("email");
			String content = request.getParameter("content");
			String category = request.getParameter("category");
			
			InquiryVO.setInqnum(inqnum);
			InquiryVO.setId(id);
			InquiryVO.setPw(pw);
			InquiryVO.setTitle(title);
			InquiryVO.setEmail(email);
			InquiryVO.setContent(content);
			InquiryVO.setCategory(category);

			inqnum = CsCenterService.addInquiry(InquiryVO);
			
			PrintWriter pw2 = response.getWriter();
			pw2.print("<script>" + "  alert('질문을 등록 했습니다.');" + " location.href='" + request.getContextPath()
					+ "/CsCenter/InquiryList.do';" + "</script>");			
		}else if (action.equals("/DeleteInquiry.do")) {
			
			int check = 0;
			
			int inqnum = Integer.parseInt(request.getParameter("inqnum"));
			String pw = request.getParameter("pw");
			
			check = CsCenterService.delteInquiry(inqnum, pw);
			
			PrintWriter pw2 = response.getWriter();
			
			if(check == 1){
					pw2.print("<script> alert('글이 삭제되었습니다.');" + 
							" location.href='" + request.getContextPath() + "/CsCenter/InquiryList.do'; " +
							"</script>");	
					}else{
						pw2.print("<script> alert('비밀번호가 틀립니다.');" +
						"history.back();" + 
						"</script>");	
					}
		}else if (action.equals("/DeleteNotice.do")) {
			
			int check = 0;
			
			int nnum = Integer.parseInt(request.getParameter("nnum"));
			String pw = request.getParameter("pw");
			
			check = CsCenterService.delteNotice(nnum, pw);
			
			PrintWriter pw2 = response.getWriter();
			
			if(check == 1){
					pw2.print("<script> alert('글이 삭제되었습니다.');" + 
							" location.href='" + request.getContextPath() + "/CsCenter/NoticeList.do'; " +
							"</script>");	
					}else{
						pw2.print("<script> alert('비밀번호가 틀립니다.');" +
						"history.back();" + 
						"</script>");	
					}
		}else if (action.equals("/NoticeModify.do")) {
			
			String nnum = request.getParameter("nnum");
			
			NoticeVO notice = CsCenterService.viewNotice(Integer.parseInt(nnum));
			
			request.setAttribute("notice", notice);
			
			nextPage = "/Home/CsCenter/NoticeModify.jsp";
			
		}else if (action.equals("/InquiryModify.do")) {
			
			String inqnum = request.getParameter("inqnum");
			
			InquiryVO inquiry = CsCenterService.viewInquiry(Integer.parseInt(inqnum));
			
			request.setAttribute("inquiry", inquiry);
			
			nextPage = "/Home/CsCenter/InquiryModify.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		// 실제 재요청(포워딩)시 request, response전달
		dispatcher.forward(request, response);
	}
}
