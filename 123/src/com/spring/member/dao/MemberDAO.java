package com.spring.member.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

public interface MemberDAO {

	//모든 회원정보 검색 
	public List selectAllMembers() throws DataAccessException;
	
	
}
