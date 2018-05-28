package com.es.main;

import java.util.List;

import com.es.education.EduHistoryDto;

public interface MainDao {

	public List<MainDto> noticeFive(MainDto maindto);
	
	public List<EduHistoryDto> eduHistoryList(String emp_no);
	
	public List<MainDto> instructorFive(MainDto maindto);
	
	public List<MainDto> eduFive(MainDto maindto);
	
	
}
