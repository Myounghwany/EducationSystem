package com.es.user;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Filter implements javax.servlet.Filter{

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		javax.servlet.Filter.super.init(filterConfig);
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest h_request = (HttpServletRequest) request;
		HttpServletResponse h_response = (HttpServletResponse) response;
		
		String uri = h_request.getRequestURI();
		
		HttpSession h_session = h_request.getSession();
		String emp_no = (String) h_session.getAttribute("emp_no");
		
		if (uri.indexOf("user/login.do")<0) {
			System.out.println("인증되지 않은 요청 들어옴.");
			if(emp_no ==null || emp_no.trim().length()<=0 ) {
				System.out.println("로그인 되지 않은 사용자의 요청");
				h_response.sendRedirect("main.do");
				return;
			} else {
				System.out.println(emp_no +"님의 요청입니다.");
			}
			chain.doFilter(request, response); //필터 패스
		}
	}
	
	@Override
	public void destroy() {
		javax.servlet.Filter.super.destroy();
	}
}
