package com.es.manager;

public class MustEduDto extends EmpListDto {
	private int edu_code;
	private String edu_state;

	public MustEduDto() {
		super();
	}

	public int getEdu_code() {
		return edu_code;
	}
	public void setEdu_code(int edu_code) {
		this.edu_code = edu_code;
	}
	public String getEdu_state() {
		return edu_state;
	}
	public void setEdu_state(String edu_state) {
		this.edu_state = edu_state;
	}
	
}
