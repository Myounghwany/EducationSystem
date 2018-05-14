package com.es.user;

public class UserDto {
	private String emp_no; //사번
	private String passwd; //비밀번호
	private String changePasswd; //비밀번호
	private String checkPasswd; //비밀번호
	private String name;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
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
