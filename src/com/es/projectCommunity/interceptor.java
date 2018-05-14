package com.es.projectCommunity;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class interceptor extends HandlerInterceptorAdapter{

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler){
		try {
			//logininfo 세션값이 널일경우
			if(request.getSession().getAttribute("logininfo") == null ){
				//로그인페이지로 redirect
				/*response.sendRedirect("/login");*/	
				
				System.out.println("session 이 null 일 경우");
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






