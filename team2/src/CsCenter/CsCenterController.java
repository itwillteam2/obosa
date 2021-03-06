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

import Living.ItemsVO;
import Page.Paging;

@WebServlet("/CsCenter/*")
public class CsCenterController extends HttpServlet {
	
	CsCenterService CsCenterService;
	NoticeVO NoticeVO;
	InquiryVO InquiryVO;
	InqRepVO InqRepVO;
	InquiryJoinVO InqJoinVO;

	
	//서블릿 초기화시 BoardService객체를 생성합니다.
	@Override
	public void init() throws ServletException {
		CsCenterService = new CsCenterService();
		NoticeVO = new NoticeVO();
		InquiryVO = new InquiryVO();
		InqRepVO = new InqRepVO();
		InqJoinVO = new InquiryJoinVO();
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

		String action = request.getPathInfo();
		System.out.println("action변수에 저장된 요청한 주소 : " + action);

		String nextPage = null;

		List<NoticeVO> NoticeList = null;
		List<InquiryVO> InquiryList = null;
		List<InqRepVO> InqRepList = null;
		
		if (action.equals("/NoticeWrite.do")) {
			nextPage = "/Home/CsCenter/NoticeWrite.jsp";
		} else if (action.equals("/NoticeList.do")) {
			
			int totalCount = CsCenterService.totalCount();
			Paging paging = new Paging();
			int pageNO = (request.getParameter("pageNO") == null) ? 1 : Integer.parseInt(request.getParameter("pageNO"));
			int pageSize = 5;
			int listSize = 5;
			
			paging.makePage(totalCount, pageNO, pageSize, listSize); 
			
			NoticeList  = CsCenterService.listNotice(); 
			
			request.setAttribute("NoticeList", NoticeList);
			
			List <NoticeVO> pagingList = CsCenterService.pagingList(pageNO,listSize);
			request.setAttribute("pagingList", pagingList);	
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("paging", paging);

			nextPage = "/Home/CsCenter/NoticeList.jsp";
		
		}else if (action.equals("/NoticeSearch.do")) {
			
			int totalCount = CsCenterService.totalCount();
			Paging paging = new Paging();
			int pageNO = (request.getParameter("pageNO") == null) ? 1 : Integer.parseInt(request.getParameter("pageNO"));
			int pageSize = 5;
			int listSize = 5;
			
			paging.makePage(totalCount, pageNO, pageSize, listSize); 
			
			NoticeList  = CsCenterService.listNotice(); 
			
			String searchText = request.getParameter("searchText");
			String category = request.getParameter("category");
			
			request.setAttribute("NoticeList", NoticeList);
			
			request.setAttribute("category", category);
			request.setAttribute("searchText", searchText);
			
			List <NoticeVO> pagingList = CsCenterService.NoticeSearchList(pageNO,listSize,category,searchText);
			request.setAttribute("pagingList", pagingList);	
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("paging", paging);

			nextPage = "/Home/CsCenter/NoticeList.jsp";
		
		}else if (action.equals("/InquiryList.do")) {
			
			int totalCount2= CsCenterService.totalCount2();
			Paging paging = new Paging();
			int pageNO = (request.getParameter("pageNO") == null) ? 1 : Integer.parseInt(request.getParameter("pageNO"));
			int pageSize = 5;
			int listSize = 5;
			
			paging.makePage(totalCount2, pageNO, pageSize, listSize); 
			
			InquiryList  = CsCenterService.listInquiry(); 
			InqRepList = CsCenterService.listInqRep();
			request.setAttribute("InquiryList", InquiryList);
			request.setAttribute("InqRepList", InqRepList);

			List <InquiryVO> pagingList = CsCenterService.pagingList2(pageNO,listSize);
			request.setAttribute("pagingList", pagingList);	
			request.setAttribute("totalCount", totalCount2);
			request.setAttribute("paging", paging);
			
			List <InquiryJoinVO> JoinList = CsCenterService.JoinList(pageNO,listSize);
			request.setAttribute("JoinList", JoinList);	
			request.setAttribute("totalCount", totalCount2);
			request.setAttribute("paging", paging);
			
			nextPage = "/Home/CsCenter/InquiryList.jsp";
		}else if (action.equals("/InquirySearch.do")) {
			
			int totalCount2 = CsCenterService.totalCount2();
			Paging paging = new Paging();
			int pageNO = (request.getParameter("pageNO") == null) ? 1 : Integer.parseInt(request.getParameter("pageNO"));
			int pageSize = 5;
			int listSize = 5;
			
			paging.makePage(totalCount2, pageNO, pageSize, listSize); 
			
			InquiryList  = CsCenterService.listInquiry(); 
			InqRepList = CsCenterService.listInqRep();
			request.setAttribute("InquiryList", InquiryList);
			request.setAttribute("InqRepList", InqRepList);
			
			String searchText = request.getParameter("searchText");
			String category = request.getParameter("category");
			
			request.setAttribute("category", category);
			request.setAttribute("searchText", searchText);
			
			List <InquiryVO> pagingList = CsCenterService.InquirySearchList(pageNO,listSize,category,searchText);
			request.setAttribute("pagingList", pagingList);	
			request.setAttribute("totalCount", totalCount2);
			request.setAttribute("paging", paging);

			nextPage = "/Home/CsCenter/InquiryList.jsp";
		
		}else if (action.equals("/InquiryWrite.do")) {
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
		
		}else if (action.equals("/NoticeModifyUp.do")) {
			
			int check = 0;
			
			int nnum = Integer.parseInt(request.getParameter("nnum"));		
			String pw = request.getParameter("pw");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			NoticeVO.setPw(pw);
			NoticeVO.setNnum(nnum);
			NoticeVO.setTitle(title);
			NoticeVO.setContent(content);

			check = CsCenterService.modifyNotice(NoticeVO);
			
			PrintWriter pw2 = response.getWriter();
			
			if(check == 1){
				pw2.print("<script> alert('글이 수정되었습니다.');" + 
						" location.href='" + request.getContextPath() + "/CsCenter/NoticeList.do'; " +
						"</script>");	
			}else{
				pw2.print("<script> alert('비밀번호가 틀립니다.');" +
				"history.back();" + 
				"</script>");	
			}
			
		}else if (action.equals("/modifyInquiry.do")) {
			
			int check = 0;
			
			int inqnum = Integer.parseInt(request.getParameter("inqnum"));
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

			check = CsCenterService.modifyInquiry(InquiryVO);
			
			PrintWriter pw2 = response.getWriter();
			
			if(check == 1){
				pw2.print("<script> alert('글이 수정되었습니다.');" + 
						" location.href='" + request.getContextPath() + "/CsCenter/InquiryList.do'; " +
						"</script>");	
			}else{
				pw2.print("<script> alert('비밀번호가 틀립니다.');" +
				"history.back();" + 
				"</script>");	
			}
			
		}else if (action.equals("/addReply.do")) {		
				
				int repnum = 0;
			
				int inqnum = Integer.parseInt(request.getParameter("inqnum"));
				String content = request.getParameter("content");
				String pw = request.getParameter("pw");
				
				InqRepVO.setRepnum(repnum);
				InqRepVO.setInqnum(inqnum);
				InqRepVO.setContent(content);
				InqRepVO.setPw(pw);


				repnum = CsCenterService.addInqRep(InqRepVO);
				
				PrintWriter pw2 = response.getWriter();
				pw2.print("<script>" + "  alert('답변을 등록 했습니다.');" + "window.opener.location.reload(); " +
				"window.close();"+ "</script>");	
		
		}else if (action.equals("/DeleteReply.do")) {
			int check = 0;
			
			int inqnum = Integer.parseInt(request.getParameter("inqnum"));
			String pw = request.getParameter("pw");
			
			check = CsCenterService.delteReply(inqnum, pw);
			
			PrintWriter pw2 = response.getWriter();
			
			if(check == 1){
					pw2.print("<script> alert('답변이 삭제되었습니다.');" + 
							" location.href='" + request.getContextPath() + "/CsCenter/InquiryList.do'; " +
							"</script>");	
					}else{
						pw2.print("<script> alert('비밀번호가 틀립니다.');" +
						"history.back();" + 
						"</script>");	
					}
		
		}else if (action.equals("/ModifyReply.do")) {
			
			int check = 0;
			
			int inqnum = Integer.parseInt(request.getParameter("inqnum"));
			String content = request.getParameter("content");
			String pw = request.getParameter("pw");
			
			InqRepVO.setInqnum(inqnum);
			InqRepVO.setContent(content);
			InqRepVO.setPw(pw);

			check = CsCenterService.modifyReply(InqRepVO);
			
			PrintWriter pw2 = response.getWriter();
			
			if(check == 1){
				pw2.print("<script>" + "  alert('답변을 수정 했습니다.');" + "window.opener.location.reload(); " +
						"window.close();"+ "</script>");
			}else{
				pw2.print("<script> alert('비밀번호가 틀립니다.');" +
				"history.back();" + 
				"</script>");	
			}
			
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	}
}
