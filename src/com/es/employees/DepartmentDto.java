package com.es.employees;

public class DepartmentDto {
	private int dept_no;
	private String dept_name;
	private int belong_no;
	
	public DepartmentDto() { }

	public DepartmentDto(int dept_no, String dept_name, int belong_no) {
		this.dept_no = dept_no;
		this.dept_name = dept_name;
		this.belong_no = belong_no;
	}

	public int getDept_no() {
		return dept_no;
	}

	public void setDept_no(int dept_no) {
		this.dept_no = dept_no;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}

	public int getBelong_no() {
		return belong_no;
	}

	public void setBelong_no(int belong_no) {
		this.belong_no = belong_no;
	}
	
	
	
}
