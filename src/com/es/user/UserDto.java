package com.es.user;

public class UserDto {
	private String no; //사번 or 외부강사
	private String passwd; //비밀번호
	private String changePasswd; //비밀번호
	private String checkPasswd; //비밀번호
	private String name;
	
	
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getChangePasswd() {
		return changePasswd;
	}
	public void setChangePasswd(String changePasswd) {
		this.changePasswd = changePasswd;
	}
	public String getCheckPasswd() {
		return checkPasswd;
	}
	public void setCheckPasswd(String checkPasswd) {
		this.checkPasswd = checkPasswd;
	}
	
	
	

}
