package com.spring.ex03;

import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.FileSystemResource;

//역할 : 스프링 컨테이너가 member.xml설정파일을 읽어 들인 후 빈(객체)를 생성해서 저장 해 둡니다.
//		그리고 <bean>의 id속성의 값이 memberSerivce인 생성된 빈(객체)를 스프링컨테이너 내부에서 꺼내어서 주입받아 사용 
public class MemberTest1 {

	public static void main(String[] args) {

		//스프링 컨테이너 객체 생성
		//MemberServiceImpl객체, MemberDAOImpl객체 생성후 스프링 컨테이너 공간에 저장해 주고 있다.
		//내부적으로 MemberSerivceImpl객체의 MemberDAO memberDAO변수에 MemberDAOImpl객체가 저장 되게 된다.
		XmlBeanFactory factory = new XmlBeanFactory(new FileSystemResource("member.xml"));
		
		//스프링 컨테이너 내부에서.. MemberServiceImpl객체를 얻어 MemberDAOImpl객체의 listMembers()메소드를 호출 할수 있다.
		Object obj = factory.getBean("memberService"); // MemberServiceImpl객체를 얻어
		
		MemberServiceImpl service = (MemberServiceImpl)obj; //다운캐스팅 후 사용
		
								//MemberServiceImpl객체의 listMembers()메소드를 호출하면 내부적으로....
		service.listMembers(); //MemberDAOImpl객체의 listMembers()메소드를 호출(DB에 존재하는 모든 회원정보 검색) 할수 있다.

	}

}
