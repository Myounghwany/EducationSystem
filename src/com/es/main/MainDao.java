package com.es.main;

import java.util.HashMap;
import java.util.List;

import com.es.education.EduHistoryDto;
import com.es.education.EducationListDto;
import com.es.instructor.InstructorDto;
import com.es.manager.InstListDto;
import com.es.notice.NoticeDataBean;

public interface MainDao {

	public List<MainDto> noticeFive(MainDto maindto);
	
	public List<EduHistoryDto> eduHistoryList(String emp_no);
	
	public List<MainDto> eduFive(MainDto maindto);
	
	public List selectEduList(InstructorDto eduList);
	
	public List<InstructorDto> selectEduList2(String edu_no);
	
	List<InstListDto> getReqInstList(int approval_state); 
	
	public NoticeDataBean detailnotice(int notice_no);
	
	public List<EducationListDto> EducationList(HashMap<String, Object> map);
	
	public int EducationListCount(HashMap<String, Object> map);
}
