package com.es.main;

import java.util.List;

import com.es.education.EduHistoryDto;
import com.es.instructor.InstructorDto;
import com.es.manager.InstListDto;

public interface MainDao {

	public List<MainDto> noticeFive(MainDto maindto);
	
	public List<EduHistoryDto> eduHistoryList(String emp_no);
	
	public List<MainDto> eduFive(MainDto maindto);
	
	public List selectEduList(InstructorDto eduList);
	
	public List<InstructorDto> selectEduList2(String edu_no);
	
	List<InstListDto> getReqInstList(int approval_state); 
	
	
}
