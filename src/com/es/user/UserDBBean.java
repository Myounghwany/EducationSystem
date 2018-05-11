package com.es.user;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Configuration;

import com.es.db.SqlMapClient;

@Configuration("UserDao")
public class UserDBBean implements UserDao{
	/*로그인 처리*/
	@Override
	public int loginCheck(String emp_no, String password) {
		int result = 0;
		HashMap<Object, Object> check = new HashMap<>();
		check.put("emp_no", emp_no);
		check.put("password", password);
		System.out.println("User DBBean.. ");
		
		UserDto temp = SqlMapClient.getSession().selectOne("User.LoginCheck", check);
		if(temp==null) {
			result = 0;
		} else if(password.equals(temp.getPassword())) {
			result = 1;
		} else {
			result = -1;
		}
		
		return result;
	}
	
	@Override
	public UserDto findById(String emp_no, String password) {
		HashMap<Object, Object> check = new HashMap<>();
		check.put("emp_no", emp_no);
		check.put("password", password);
		return  SqlMapClient.getSession().selectOne("User.findById", check);
	}
	
	/*로그아웃 처리*/
	@Override
	public void logout(HttpSession session) {
//		session.invalidate();
		session.removeAttribute("emp_no");
		System.out.println("session invalidate()");
	}
}
