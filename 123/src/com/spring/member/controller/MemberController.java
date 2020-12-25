package com.spring.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface MemberController {

	//모든 회원정보 조회
	public ModelAndView listMembers(HttpServletRequest request, HttpServletResponse response)throws Exception;
	
}
