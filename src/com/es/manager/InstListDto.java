package com.es.manager;

public class InstListDto {
	private String type;
	private String inst_no;
	private String name;
	public InstListDto() { }
	public InstListDto(String type, String inst_no, String name) {
		super();
		this.type = type;
		this.inst_no = inst_no;
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getInst_no() {
		return inst_no;
	}
	public void setInst_no(String inst_no) {
		this.inst_no = inst_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
