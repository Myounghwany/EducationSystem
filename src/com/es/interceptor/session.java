package com.es.interceptor;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class session extends HandlerInterceptorAdapter{

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler){
		String no = (String) request.getSession().getAttribute("no");
		
		try {
			//logininfo 세션값이 널일경우
			if( no == null ){
				//로그인페이지로 redirect
				System.out.println("session 이 null 일 경우");

				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('로그인 하셔야 이용가능 합니다.'); history.go(-1);</script>");
				out.flush();
				/*response.sendRedirect("/login");*/	
				/*return true;*/
				
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("session 이 null이 아닐 경우");
		//널이 아니면 정상적으로 컨트롤러 호출
		
		return true;
	}
}
