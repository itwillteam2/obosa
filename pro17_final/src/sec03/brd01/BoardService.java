package sec03.brd01;

import java.util.List;

//BoardController서블릿으로 부터 호출되는 메소드들이 들어 있는 서비스를 제공하는 클래스 
public class BoardService {
	
	BoardDAO boardDAO;
	
	public BoardService() {//생성자 호출시..BoardDAO객체 생성후 저장 
		boardDAO = new BoardDAO();
	}
							
	//BoardController서블릿으로 부터 호출되는 listArticles메소드 만들기
	public List<ArticleVO> listArticles(){ //<---단위기능 : 모든회원조회기능
		//BoardDAO객체의 selectArticles()메소드를 호출해 전체글을 검색해옴
		List<ArticleVO> articlesList = boardDAO.selectAllArticles();
		//서블릿으로 arrayList반환
		return articlesList;
	}			
	
}
/*
	여기서 잠깐  쉬어 가기 !
	BoardDAO 클래스의 메소드 이름은  보통 각메소드들이 실행하는 SQL문에 의해 결정됩니다.
	예를 들어 selectAticles()메소드는 
	전체 글 정보를 조회하는 SQL문을 실행하므로 메소드 이름에 selectAll이 들어갑니다
*/



