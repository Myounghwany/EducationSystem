package com.es.user;

import javax.servlet.http.HttpSession;

public interface UserDao {
	/* 로그인 */
	public int loginCheck(String emp_no, String password);

	/* 로그아웃 */
	public void logout(HttpSession session);

	public UserDto findById(String emp_no, String password);

}
