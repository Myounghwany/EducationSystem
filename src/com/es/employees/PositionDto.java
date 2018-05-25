package com.es.employees;

public class PositionDto {
	private int position_no;
	private String position_name;
	
	public PositionDto() { }
	public PositionDto(int position_no, String position_name) {
		this.position_no = position_no;
		this.position_name = position_name;
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
}
