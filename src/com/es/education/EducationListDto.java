package com.es.education;

public class EducationListDto {
	
	/*education_list*/
	private int edu_no;
	private int belong_no;
	private String edu_field;
	private int edu_code;
	private String edu_name;
	private String edu_target;
	private String manager;
	private String edu_way;
	private String edu_schedule;
	private String edu_date;
	private String edu_location;
	private String instructor_no; //강사번호
	private String budget;
	private String note;
	private int applicants_limit;
	private String closing_date;
	private int approval_state;
	
	/*instructor*/
	private String instructor_name;
	
	
	/*belong*/
	private String belong_name;
	
	/*education_code*/
	private String edu_code_name;

	
	public int getEdu_no() {
		return edu_no;
	}

	public void setEdu_no(int edu_no) {
		this.edu_no = edu_no;
	}

	public int getBelong_no() {
		return belong_no;
	}

	public void setBelong_no(int belong_no) {
		this.belong_no = belong_no;
	}

	public String getEdu_field() {
		return edu_field;
	}

	public void setEdu_field(String edu_field) {
		this.edu_field = edu_field;
	}

	public int getEdu_code() {
		return edu_code;
	}

	public void setEdu_code(int edu_code) {
		this.edu_code = edu_code;
	}

	public String getEdu_name() {
		return edu_name;
	}

	public void setEdu_name(String edu_name) {
		this.edu_name = edu_name;
	}

	public String getEdu_target() {
		return edu_target;
	}

	public void setEdu_target(String edu_target) {
		this.edu_target = edu_target;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getEdu_way() {
		return edu_way;
	}

	public void setEdu_way(String edu_way) {
		this.edu_way = edu_way;
	}

	public String getEdu_schedule() {
		return edu_schedule;
	}

	public void setEdu_schedule(String edu_schedule) {
		this.edu_schedule = edu_schedule;
	}

	public String getEdu_date() {
		return edu_date;
	}

	public void setEdu_date(String edu_date) {
		this.edu_date = edu_date;
	}

	public String getEdu_location() {
		return edu_location;
	}

	public void setEdu_location(String edu_location) {
		this.edu_location = edu_location;
	}

	public String getInstructor_no() {
		return instructor_no;
	}

	public void setInstructor_no(String instructor_no) {
		this.instructor_no = instructor_no;
	}

	public String getBudget() {
		return budget;
	}

	public void setBudget(String budget) {
		this.budget = budget;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public int getApplicants_limit() {
		return applicants_limit;
	}

	public void setApplicants_limit(int applicants_limit) {
		this.applicants_limit = applicants_limit;
	}

	public String getClosing_date() {
		return closing_date;
	}

	public void setClosing_date(String closing_date) {
		this.closing_date = closing_date;
	}

	public int getApproval_state() {
		return approval_state;
	}

	public void setApproval_state(int approval_state) {
		this.approval_state = approval_state;
	}

	public String getInstructor_name() {
		return instructor_name;
	}

	public void setInstructor_name(String instructor_name) {
		this.instructor_name = instructor_name;
	}

	public String getBelong_name() {
		return belong_name;
	}

	public void setBelong_name(String belong_name) {
		this.belong_name = belong_name;
	}

	public String getEdu_code_name() {
		return edu_code_name;
	}

	public void setEdu_code_name(String edu_code_name) {
		this.edu_code_name = edu_code_name;
	} 
	
	
}
