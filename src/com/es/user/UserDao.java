package com.es.user;

import javax.servlet.http.HttpSession;

public interface UserDao {
	/* 로그인 */
	public int loginCheck(String emp_no, String passwd);
	public UserDto findById(String emp_no, String passwd);

	/* 로그아웃 */
	public void logout(HttpSession session);

	/* 비밀번호 변경*/
	public int changePasswd(String emp_no, UserDto user);
	
	/* 기존 비밀번호 일치여부 확인 */
	public int checkPassword(String emp_no, String passwd);

}
