package com.es.petition;

import java.sql.Timestamp;

public class PetitionDto {
	private int petition_no; // 청원 글번호
	private String classification; // 분류
	private String title; // 제목
	private String content; // 내용
	private String writer; // 작성자
	private Timestamp write_time; // 작성시간
	private Timestamp closing_date; // 청원 마감시간
	private int agree; // 청원찬성
	private int approval_state; // 청원진행상태 0 - 진행 중, 1 - 심사시작, 2 - 청원수용, 3 - 청원거부, 4 - 기간만료 
	private String comment; // 답변글
	private String file_path;
	private String file_save_name;
	private String file_ori_name;
 
	public int getPetition_no() {
		return petition_no;
	}
	public void setPetition_no(int petition_no) {
		this.petition_no = petition_no;
	}
	public String getClassification() {
		return classification;
	}
	public void setClassification(String classification) {
		this.classification = classification;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public int getApproval_state() {
		return approval_state;
	}
	public void setApproval_state(int approval_state) {
		this.approval_state = approval_state;
	}
	public Timestamp getClosing_date() {
		return closing_date;
	}
	public void setClosing_date(Timestamp closing_date) {
		this.closing_date = closing_date;
	}
	public int getAgree() {
		return agree;
	}
	public void setAgree(int agree) {
		this.agree = agree;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	

}
