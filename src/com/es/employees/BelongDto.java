package com.es.employees;

public class BelongDto {
	private int belong_no;
	private String name;	
	
	public BelongDto() { }
	
	public BelongDto(int belong_no, String name) {
		this.belong_no = belong_no;
		this.name = name;
	}

	public int getBelong_no() {
		return belong_no;
	}
	public void setBelong_no(int belong_no) {
		this.belong_no = belong_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
