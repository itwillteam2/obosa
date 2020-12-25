package com.spring.ex02;

//사람을 나타내는 클래스로
//PersonService인터페이스의 추상메소드를 오버라이딩 시켜 구현한 클래스입니다.
public class PersonServiceImpl implements PersonService{
	
	private String name;
	private int age;
	
	
	//person.xml에서 인자가 한개인 생성자 설정시 사용됩니다.
	public PersonServiceImpl(String name) {
		this.name = name;
	}
	
	//person.xml에서 인자가 두개인 생성자 설정시 사용됩니다.
	public PersonServiceImpl(String name,int age) {
		this.name = name;
		this.age = age;
	}
	
	//setter중에 setName메소드 만들기
	public void setName(String name) {//<-- person.xml파일에서 setName메소드 호출시..
										//<-- 이름을 전달 하여 위 name변수에 저장 할 것임
		this.name = name;				
	}
	
	//이름과 나이를 출력 해주는 기능의 추상메소드 오버라이딩
	@Override
	public void sayHello() {
		
		System.out.println("이름 : " + name);
		System.out.println("나이 : " + age);
		
	}

}
