package com.es.employees;

public class EmployeesDto {
	private String emp_no;
	private String name;
	private String identity_no;
	private String address;
	private String phone;
	private String email;
	private int position_no;
	private int dept_no;
	private int belong_no;
	
	public EmployeesDto() {	}	
	
	public EmployeesDto(String emp_no, String name, String identity_no, String address, String phone, String email,
			int position_no, int dept_no, int belong_no) {
		this.emp_no = emp_no;
		this.name = name;
		this.identity_no = identity_no;
		this.address = address;
		this.phone = phone;
		this.email = email;
		this.position_no = position_no;
		this.dept_no = dept_no;
		this.belong_no = belong_no;
	}

	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIdentity_no() {
		return identity_no;
	}
	public void setIdentity_no(String identity_no) {
		this.identity_no = identity_no;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getPosition_no() {
		return position_no;
	}
	public void setPosition_no(int position_no) {
		this.position_no = position_no;
	}
	public int getDept_no() {
		return dept_no;
	}
	public void setDept_no(int dept_no) {
		this.dept_no = dept_no;
	}
	public int getBelong_no() {
		return belong_no;
	}
	public void setBelong_no(int belong_no) {
		this.belong_no = belong_no;
	}
	
	
}
