package com.es.instructor;

import java.util.List;

public class InstructorDto {
	private String id;
	private String account_no;
	private String instructor_no;
	private int approval_state;
	private String instructor_check;
	private String hire_date;
	private String approval_date;
	private int edu_no;
	private int belong_no;
	private String belong_name;
	private String name;
	private String edu_field;
	private int edu_code;
	private String edu_name;
	private String edu_target;
	private String manager;
	private String edu_way;
	private String edu_schedule;
	private String edu_date;
	private String edu_location;
	private String budget;
	private String note;
	private int applicants_limit;
	private String closing_date;
	private String emp_no;
	private int dept_no;
	private String dept_name;
	private int position_no;
	private String position_name;
	private int task_no;
	private String start_date;
	private String end_date;
	private int input_time;
	private int input_num;
	private String file_path;
	private String file_ori_name;
	private String file_save_name;
	private int no;
	private String edu_state;
	private String emp_eval;
	private String instructor_eval;
	private String edu_code_name;
	private String instructor_name;
	private String deadLine;
	private int student;
	private int page;
	private int eduListNum;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAccount_no() {
		return account_no;
	}
	public void setAccount_no(String account_no) {
		this.account_no = account_no;
	}
	public String getInstructor_no() {
		return instructor_no;
	}
	public void setInstructor_no(String instructor_no) {
		this.instructor_no = instructor_no;
	}
	public int getApproval_state() {
		return approval_state;
	}
	public void setApproval_state(int approval_state) {
		this.approval_state = approval_state;
	}
	public String getInstructor_check() {
		return instructor_check;
	}
	public void setInstructor_check(String instructor_check) {
		this.instructor_check = instructor_check;
	}
	public String getHire_date() {
		return hire_date;
	}
	public void setHire_date(String hire_date) {
		this.hire_date = hire_date;
	}
	public String getApproval_date() {
		return approval_date;
	}
	public void setApproval_date(String approval_date) {
		this.approval_date = approval_date;
	}
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
	public String getBelong_name() {
		return belong_name;
	}
	public void setBelong_name(String belong_name) {
		this.belong_name = belong_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
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
	public int getPosition_no() {
		return position_no;
	}
	public void setPosition_no(int position_no) {
		this.position_no = position_no;
	}
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
	public int getTask_no() {
		return task_no;
	}
	public void setTask_no(int task_no) {
		this.task_no = task_no;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public int getInput_time() {
		return input_time;
	}
	public void setInput_time(int input_time) {
		this.input_time = input_time;
	}
	public int getInput_num() {
		return input_num;
	}
	public void setInput_num(int input_num) {
		this.input_num = input_num;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_ori_name() {
		return file_ori_name;
	}
	public void setFile_ori_name(String file_ori_name) {
		this.file_ori_name = file_ori_name;
	}
	public String getFile_save_name() {
		return file_save_name;
	}
	public void setFile_save_name(String file_save_name) {
		this.file_save_name = file_save_name;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getEdu_state() {
		return edu_state;
	}
	public void setEdu_state(String edu_state) {
		this.edu_state = edu_state;
	}
	public String getEmp_eval() {
		return emp_eval;
	}
	public void setEmp_eval(String emp_eval) {
		this.emp_eval = emp_eval;
	}
	public String getInstructor_eval() {
		return instructor_eval;
	}
	public void setInstructor_eval(String instructor_eval) {
		this.instructor_eval = instructor_eval;
	}
	public String getEdu_code_name() {
		return edu_code_name;
	}
	public void setEdu_code_name(String edu_code_name) {
		this.edu_code_name = edu_code_name;
	}
	public String getInstructor_name() {
		return instructor_name;
	}
	public void setInstructor_name(String instructor_name) {
		this.instructor_name = instructor_name;
	}
	public String getDeadLine() {
		return deadLine;
	}
	public void setDeadLine(String deadLine) {
		this.deadLine = deadLine;
	}
	public int getStudent() {
		return student;
	}
	public void setStudent(int student) {
		this.student = student;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getEduListNum() {
		return eduListNum;
	}
	public void setEduListNum(int eduListNum) {
		this.eduListNum = eduListNum;
	}
	
}
