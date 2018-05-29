package com.es.main;

import java.sql.Timestamp;
import java.util.Date;

public class MainDto {
	//공지사항
	private int notice_no;
	private String title;
	private String writer;
	private Timestamp write_time;
	private String hit;
	//수강내역
	private int edu_no; //교육 번호
	private String edu_name;	//교육명
	private String instructor_no; //강사명
	private String edu_state; //이수여부
	private String edu_schedule;
	private String edu_location;
	private int no;
	private String emp_no;
	private int belong_no;	 //소속번호
	private String edu_field;	//교육분야
	private int edu_code; 	 	//교육코드
	private String edu_target;  //교육대상
	private String manager;		//담당자
	private String edu_way;		//교육방법
	private String edu_date;	 //교육일시
	private String budget; 		 //소요예산
	private String note; 		 //비고
	private int applicants_limit;//신청자제한수
	private String closing_date; //신청마감일
	private int approval_state;  //승인여부
	/* 교육번호로 교육명, 강사번호로 강사명, 교육번호로 일정 알아내기 추가 */
	private String emp_eval; //직원평가
	private String instructor_eval;
	private String file_path;
	private String file_save_name;
	private String file_ori_name;
	private Date end_date; //교육종료일
	private int buttonFlag;
	//강사
	private String name; 	
	private Timestamp hire_date;
	private String instructor_name;
	
	
	//수강자
	private int student;//
	
	public int getStudent() {
		return student;
	}
	public void setStudent(int student) {
		this.student = student;
	}
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Timestamp getWrite_time() {
		return write_time;
	}
	public void setWrite_time(Timestamp write_time) {
		this.write_time = write_time;
	}
	public String getHit() {
		return hit;
	}
	public void setHit(String hit) {
		this.hit = hit;
	}
	public int getEdu_no() {
		return edu_no;
	}
	public void setEdu_no(int edu_no) {
		this.edu_no = edu_no;
	}
	public String getEdu_name() {
		return edu_name;
	}
	public void setEdu_name(String edu_name) {
		this.edu_name = edu_name;
	}
	public String getInstructor_no() {
		return instructor_no;
	}
	public void setInstructor_no(String instructor_no) {
		this.instructor_no = instructor_no;
	}
	public String getEdu_state() {
		return edu_state;
	}
	public void setEdu_state(String edu_state) {
		this.edu_state = edu_state;
	}
	public String getEdu_schedule() {
		return edu_schedule;
	}
	public void setEdu_schedule(String edu_schedule) {
		this.edu_schedule = edu_schedule;
	}
	public String getEdu_location() {
		return edu_location;
	}
	public void setEdu_location(String edu_location) {
		this.edu_location = edu_location;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
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
	public String getEdu_date() {
		return edu_date;
	}
	public void setEdu_date(String edu_date) {
		this.edu_date = edu_date;
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
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFile_save_name() {
		return file_save_name;
	}
	public void setFile_save_name(String file_save_name) {
		this.file_save_name = file_save_name;
	}
	public String getFile_ori_name() {
		return file_ori_name;
	}
	public void setFile_ori_name(String file_ori_name) {
		this.file_ori_name = file_ori_name;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public int getButtonFlag() {
		return buttonFlag;
	}
	public void setButtonFlag(int buttonFlag) {
		this.buttonFlag = buttonFlag;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getHire_date() {
		return hire_date;
	}
	public void setHire_date(Timestamp hire_date) {
		this.hire_date = hire_date;
	}
	public String getInstructor_name() {
		return instructor_name;
	}
	public void setInstructor_name(String instructor_name) {
		this.instructor_name = instructor_name;
	}
	
	
	
	
	
}
