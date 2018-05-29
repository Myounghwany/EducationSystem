package com.es.main;

import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;
import com.es.education.EduHistoryDto;
import com.es.instructor.InstructorDto;
import com.es.manager.InstListDto;

@Component("mainDao")
public class MainDBBean implements MainDao{
	
	public List<MainDto> noticeFive(MainDto maindto){
		return SqlMapClient.getSession().selectList("main.noticeFive", maindto);
	}
	
	@Override
	public List<EduHistoryDto> eduHistoryList(String emp_no) {
		System.out.println("eduHistory ");
		List<EduHistoryDto> result = null;
		if(emp_no.substring(0, 1).equals("E")) {
			System.out.println("직원인지 체크/"+emp_no.substring(0, 1));
			result = SqlMapClient.getSession().selectList("main.EduHistory", emp_no);
		} else if(emp_no.substring(0, 1).equals("I")){
			System.out.println("강사인지 체크/"+emp_no.substring(0, 1));
			result = SqlMapClient.getSession().selectList("main.InstEduHistory", emp_no);
		} 
		return result;
	}
	

	
	@Override
	public List<MainDto> eduFive(MainDto maindto) {
		return SqlMapClient.getSession().selectList("main.eduFive", maindto);
	}
	
	public List selectEduList(InstructorDto instructorDto) {
		return SqlMapClient.getSession().selectList("main.selectEduList", instructorDto);
	}
	
	@Override
	public List<InstructorDto> selectEduList2(String edu_no) {
		return SqlMapClient.getSession().selectList("Instructor.selectEduList2", edu_no);
	}
	
	@Override
	public List<InstListDto> getReqInstList(int approval_state) {
		return SqlMapClient.getSession().selectList("Manager.ReqInstList", approval_state);
	}
}
