package com.spring.ex03;


//MemberServiceImpl클래스는 MemberDAOImpl클래스를 의존 한다.
//의존하는 클래스의 메소드를 호출 하게 된다.
public class MemberServiceImpl implements MemberService {

	//의존하는 객체를 주입 받기 위해서 MemberDAO인터페이스 타입의 참조변수 선언
	private MemberDAO memberDAO;
	
	//member.xml설정 파일에서 setter메소드 호출 설정을 통하여
	//MemberDAOImpl객체를 매개변수로 받아 위 memberDAO변수에 저장
	public void setMemberDAO(MemberDAO memberDAO) {
		this.memberDAO = memberDAO;
	}
	
	@Override
	public void listMembers() {

		//위 주입된 빈(MemberDAOImpl객체)의 listMembers()메소드를 호출
		memberDAO.listMembers();

	}

}
