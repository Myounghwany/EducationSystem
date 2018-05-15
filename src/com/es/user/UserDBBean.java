package com.es.user;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Configuration;

import com.es.db.SqlMapClient;

@Configuration("UserDao")
public class UserDBBean implements UserDao{
	/*로그인 처리*/
	@Override
	public int loginCheck(String emp_no, String passwd) {
		int result = 0;
		HashMap<Object, Object> check = new HashMap<>();
		check.put("emp_no", emp_no);
		check.put("passwd", passwd);
		UserDto temp = null;
		String no = emp_no.substring(0,1);
		System.out.println("User DBBean.. 직원/외부강사 ?" + no);
		
		//if emp_no 의 앞자리가 E로 시작하면
		if( no.equals("E")) {
			temp = SqlMapClient.getSession().selectOne("User.EmpLoginCheck", check);
			System.out.println("직원 로그인");
			System.out.println("temp:"+ temp);
		}
		//emp_no의 앞자리가 I로 시작하면
		else if( no.equals("I")) {
			//외부강사 테이블에서 확인하는 쿼리
			temp = SqlMapClient.getSession().selectOne("User.InstLoginCheck", check);
			System.out.println("외부강사 로그인");
			System.out.println("temp:"+ temp);
		}
		if(temp==null) {
			result = 0;
		} else if(passwd.equals(temp.getPasswd())) {
			result = 1;
		} else {
			result = -1;
		}
		
		return result;
	}
	
	@Override
	public UserDto findById(String emp_no, String passwd) {
		HashMap<Object, Object> check = new HashMap<>();
		check.put("emp_no", emp_no);
		check.put("passwd", passwd);
		return  SqlMapClient.getSession().selectOne("User.findById", check);
	}
	
	/*로그아웃 처리*/
	@Override
	public void logout(HttpSession session) {
//		session.invalidate();
		session.removeAttribute("no");
		System.out.println("session invalidate()");
	}
	
	/*비밀번호 변경*/
	@Override
	public int changePasswd(String emp_no, UserDto user) {
		HashMap<Object, Object> check = new HashMap<>();
		check.put("emp_no", emp_no);
		check.put("passwd", user.getPasswd());
		check.put("newPasswd", user.getCheckPasswd());
		System.out.println("check :" + check);
		return SqlMapClient.getSession().update("User.changePasswd", check);
	}
	
	/* 기존 비밀번호 일치여부 확인 */
	@Override
	public int checkPassword(String emp_no, String passwd) {
		int result = 0;
		HashMap<Object, Object> check = new HashMap<>();
		check.put("emp_no", emp_no);
		check.put("passwd", passwd);
		UserDto temp = SqlMapClient.getSession().selectOne("User.checkPassword", check);
		
		if(temp == null) {
			result = 0; //불일치
		} else {
			result = 1; //일치
		}
		return result;
	}
}
