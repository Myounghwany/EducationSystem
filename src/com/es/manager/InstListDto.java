package com.es.manager;

public class InstListDto {
	private String emp_no;
	private String instructor_no;
	private String name;
	public InstListDto() { }
	public InstListDto(String emp_no, String instructor_no, String name) {
		this.emp_no = emp_no;
		this.instructor_no = instructor_no;
		this.name = name;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getInstructor_no() {
		return instructor_no;
	}
	public void setInstructor_no(String instructor_no) {
		this.instructor_no = instructor_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
