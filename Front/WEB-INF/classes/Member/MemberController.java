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

//modMemberForm.jsp페이지(수정창)에서 수정하기 전에 조회한 회원정보를 화면에서 보고 수정할 내용 입력 후 수정버튼 클릭했을 때
//modMeober.do에 의해 수정요청을 받는 MemberController 서블릿
@WebServlet("/member/*") //웹브라우저를 통해 요청시  두 단계로 요청이 이루어집니다.

//삭제하는 과정
//1. 회원목록창(listMembers.jsp)에서 삭제를 클릭해 요청명 /member/delMember.do 주소와 삭제할 회원 ID를 컨트롤러로 전달
//2. 컨트롤러는 request 객체의 getPathInfo()메소드를 이용해 요청명 /delMember.do를 가져온다
//3. 삭제할 회원 ID를 sql문으로 전달해 delete문 완성 후 t_member테이블에서 회원정보를 삭제
//4. delete에 성공하면 성공한 msg값을 request영역에 저장 후 다시 컨트롤러로 /member/listMembers.do 요청명으로 재요청해
//모든 회원정보 조회 후 listMembers.do로 포워딩하면서 조회된 회원목록을 출력
public class MemberController extends HttpServlet{

	MemberDAO memberDAO;
	
	//init()메소드에서 MemberDAO객체를 생성하여 초기화시킴
	@Override
	public void init() throws ServletException {
		memberDAO = new MemberDAO();
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
		if(action.equals("/addMember.do")){
			//입력한 회원정보들을 request 객체영역에서 꺼내오기
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
			
			//MemberVO객체 생성 후 입력한 회원정보들을 각 변수에 저장
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
				//MemberDAO객체의 addMember(MemberVO vo)메소드 호출시 MemberVO객체를 매개변수로 전달하여 insert작업 수행
				memberDAO.addCustomer(vo);
			}else{
				memberDAO.addSeller(vo);
			}
			
			//회원가입에 성공했을 때 이동할 뷰페이지 주소 저장
			nextPage = "/Home/Member/Login.jsp";
		
		}else if(action.equals("/loginCK.do")){
			String id = request.getParameter("memid");
			String pwd = request.getParameter("mempwd");
			String recentURI = request.getParameter("recentURI");
			
			MemberVO vo = new MemberVO();
			vo.setId(id);
			vo.setPwd(pwd);
			
			Boolean check = false;
			
			check = memberDAO.login(vo);
			
			if(check){
				HttpSession session = request.getSession();
				session.setAttribute("id", id);
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
		}else if(action.equals("/userInfo")){
			nextPage = "/Home/Member/userInfo.jsp";
		}
		//listMembers.jsp페이지에서 수정 클릭했을 때 컨트롤러에 ID로 회원정보 조회 후 수정창으로 포o워딩
//		}else if(action.equals("/modMemberForm.do")){
//			//수정할 회원 id를 request객체로부터 얻는다
//			String id = request.getParameter("id");
//			
//			//회원정보 수정창을 요청하면서 전송된 ID를 이용해 수정 전 회원정보를 검색
//			MemberVO memInfo = memberDAO.findMember(id);
//			
//			//request객체 내부에 저장(바인딩)하여 회원정보 수정창으로 전송하여 이동(재요청, 포워딩)
//			request.setAttribute("memInfo", memInfo);
//			
//			//회원정보 수정창 페이지로 포워딩하기 위해 URL주소를 저장
//			nextPage = "/test03/modMemberForm.jsp";
//			
//		//modMemberForm.jsp에서 수정할 내용을 입력하고 수정하기 버튼을 눌러 수정 요청 주소를 받았을 때
//		}else if(action.equals("/modMember.do")){
//			//회원정보 수정창에서 수정을 위해 입력한 전송된 정보를 가져온 후
//			String id = request.getParameter("id");
//			String pwd = request.getParameter("pwd");
//			String name = request.getParameter("name");
//			String email = request.getParameter("email");
//			
//			//MemberVO객체의 각 변수에 저장
//			MemberVO memberVO = new MemberVO(id, pwd, name, email);
//			
//			//MemberDAO객체의 modMember메소드 호출시 MemberVO객체를 전달하여 update작업
//			memberDAO.modMember(memberVO);
//			
//			//수정성공 메세지를 request내장객체 영역에 저장 후
//			request.setAttribute("msg", "modified");
//			
//			//수정 후 재요청하여 이동시킬 뷰의 주소를 nextPage변수에 저장
//			nextPage = "/member/listMembers.do";
//			
//		//삭제요청 주소를 받았을 때
//		}else if(action.equals("/delMember.do")){
//			//삭제할 회원 ID를 request 내장객체 영역에서 꺼내오기
//			String id = request.getParameter("id");
//			
//			//삭제할 회원 ID를 이용하여 DB의 회원테이블의 데이터 삭제
//			memberDAO.delMember(id);
//			
//			//삭제 후 회원목록창으로 삭제작업완료 메세지를 전달
//			request.setAttribute("msg", "deleted");
//			
//			//삭제 후 모든 회원을 조회하는 요청
//			nextPage = "/member/listMembers.do";
//			
//		}else{
//			List membersList = memberDAO.listMembers();
//			request.setAttribute("membersList", membersList);
//			nextPage = "/test03/listMembers.jsp";
//		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		//실제 재요청(포워딩)시 request, response전달
		dispatcher.forward(request, response);
	
	}//doHandle메소드 끝	
	
}//MemberController서블릿 클래스 끝



