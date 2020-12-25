package com.spring.ex01;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory; //스프링에서 제공해주는 컨테이너
import org.springframework.core.io.FileSystemResource;

//라이브러리에서 제공하는 컨테이너 역할을 하는 클래스를 이용해 XML파일의 <bean>을 읽어와서 객체 생성후 컨테이너에 저장 해둡니다.
//그리고 컨테이너 내부에 저장됨 <bean>(객체)를 꺼내와서 현재 클래스에 주입시켜 사용하게 됩니다.

public class PersonTest {

	public static void main(String[] args) {
		
		//스프링 라이브러리에서 제공해주는 컨테이너 역할을 하는 객체 생성!
		//객체 생성시 생성자로 person.xml에 접근하기 위한 new FileSystemResource("person.xml")객체를 전달 하여 저장함.
		//스프링컨테이너 역할을 하는 new XmlBeanFactory객체는 person.xml파일의 <bean>태그들을 읽어들여
		//<bean id="personSerivce" class="com.spring.ex01.PersonServiceImpl">태그에 대한 객체(빈) 생성후 스프링컨테이너에 심어 둔다.
		BeanFactory factory = new XmlBeanFactory(new FileSystemResource("person.xml"));
		
		//스프링 컨테이너에 저장되어 있는 <bean>태그에 대한 PersonServiceImpl객체를 반환 받아 저장(컨테이너에서 객체를 꺼내어 주입받음)
		//<bean>태그의 id속성값이 personService인 PersonServiceImpl객체(빈)을 컨테이너 안에서 꺼내온다.
		PersonServiceImpl person = (PersonServiceImpl)factory.getBean("personSerivce");
		
		//PersonServiceImpl person1 = new PersonServiceImpl(); <-- 더이상 자바코드에서 객체를 직접 생성하지 않아도 된다.
		
		//주입받은 PersonServiceImpl객체의 sayHello()메소드 호출!
		person.sayHello();
		

	}

}
