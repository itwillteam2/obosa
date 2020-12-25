package com.spring.member.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

public interface MemberService {
	
	//모든 회원정보 조회 추상메소드
	public List listMembers() throws DataAccessException;
	
	
}
