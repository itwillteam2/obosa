package Crafts;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/crafts/*")
public class CraftsController extends HttpServlet{

	CraftsVO craftsVO;
	CraftsService craftsService;
	CraftsDAO craftsDAO;
	String realPath;
	
	@Override
	public void init() throws ServletException {
		craftsVO = new CraftsVO();
		craftsService = new CraftsService();
		craftsDAO = new CraftsDAO();
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
		
		String nextPath="";
		realPath = request.getServletContext().getRealPath("/files/crafts");
		
		response.setContentType("text/html; charset=utf-8");
		String action = request.getPathInfo();
		System.out.println("action : " + action);
		
		if(action == null || action.equals("/listCrafts.do")) {
			
		}
		
	}
	
}
