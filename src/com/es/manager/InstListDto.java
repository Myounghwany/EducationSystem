package com.es.manager;

import java.sql.Timestamp;

public class InstListDto {
	private String emp_no;
	private String instructor_no;
	private String name;
	private String dept_name;
	private String position_name;
	private Timestamp approval_date;
	private int approval_state;
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
	public Timestamp getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(Timestamp approval_date) {
		this.approval_date = approval_date;
	}
	public int getApproval_state() {
		return approval_state;
	}
	public void setApproval_state(int approval_state) {
		this.approval_state = approval_state;
	}
	
}
