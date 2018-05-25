package com.es.manager;

public class EmpListDto {
	private String emp_no;
	private String name;
	private String dept_name;
	private String position_name;
	public EmpListDto() { }
	public EmpListDto(String emp_no, String name, String dept_name, String position_name) {
		this.emp_no = emp_no;
		this.name = name;
		this.dept_name = dept_name;
		this.position_name = position_name;
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
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
	
}
