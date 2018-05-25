package com.es.user;

public class UserDto {
	private String no; //사번 or 외부강사
	private String passwd; //비밀번호
	private String changePasswd; //비밀번호
	private String checkPasswd; //비밀번호
	private String name;
	private int belong_no; //소속번호 - 인사팀인지 구분하기 위해(HR:400)
	
	public int getBelong_no() {
		return belong_no;
	}
	public void setBelong_no(int belong_no) {
		this.belong_no = belong_no;
	}
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
