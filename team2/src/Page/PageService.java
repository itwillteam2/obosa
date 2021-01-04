package Page;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Living.LivingDAO;
import Living.LivingService;

public class PageService implements Action{

	LivingDAO livingDAO;
	LivingService livingService;
	
	public PageService() {
		livingDAO = new LivingDAO();
		livingService = new LivingService();
		
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int totalCount = livingDAO.selectAllArticles(pagingMap);
		int page = (request.getParameter("page") == null) ? 1:Integer.parseInt(request.getParameter("page"));
		
		PaginationController paging = new PaginationController();
		paging.setPageNo(page); //get방식의 parameter값으로 반은 page변수, 현재 페이지번호
		paging.setPageSize(10);//한페이지에 불러낼 게시물의 개수 지정
		paging.setTotalCount(totalCount);
		
		page = (page - 1) * 10; //select해오는 기준을 구한다
		
		list<Map<String,String>> = livingDAO.getProductList(); //<-- 한페이지에 나오는거 구하는듯?
		
		request.setAttribute("list", list);
		request.setAttribute("paging", paging);
		
		
		
	}
	
	
	
	
}
