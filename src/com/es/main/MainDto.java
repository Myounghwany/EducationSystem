package com.es.main;

import java.sql.Timestamp;

public class MainDto {
	//공지사항
	private int notice_no;
	private String title;
	private String writer;
	private Timestamp write_time;
	private String hit;
	
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
	//수강내역
	private int edu_no; //교육 번호
	private String edu_name;	//교육명
	private String edu_schedule; //교육일정
	private String edu_location; //이수여부

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

	//강사
	
	private String instructor_no; 
	private String name; 	
	private Timestamp hire_date;

	

	
	
	//청원
	
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
	public Timestamp getHire_date() {
		return hire_date;
	}
	public void setHire_date(Timestamp hire_date) {
		this.hire_date = hire_date;
	}
	private int petition_no;
	private Timestamp closing_date;

	public int getPetition_no() {
		return petition_no;
	}
	public void setPetition_no(int petition_no) {
		this.petition_no = petition_no;
	}
	public Timestamp getClosing_date() {
		return closing_date;
	}
	public void setClosing_date(Timestamp closing_date) {
		this.closing_date = closing_date;
	}
	
	
	
	
}
