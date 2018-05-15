package com.es.interceptor;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class sessionExternalInst extends HandlerInterceptorAdapter{

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler){
		String no = (String) request.getSession().getAttribute("no");
		String inst = (String) request.getSession().getAttribute("inst");

		try {
			if(no != null && no.substring(0, 1) == "I" && inst.equals("inst")) {
				//외부강사 권한
				//로그인페이지로 redirect
				System.out.println("----외부강사 세션일 경우------");

				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('외부강사는 권한이 없습니다.'); history.go(-1);</script>");
				out.flush();
				response.sendRedirect("/main.do");
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("session 이 null이 아닐 경우");
		//널이 아니면 정상적으로 컨트롤러 호출
		
		return true;
	}
}
