package com.es.main;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;
import com.es.education.EduHistoryDto;
import com.es.education.EducationListDto;
import com.es.instructor.InstructorDto;
import com.es.manager.InstListDto;
import com.es.notice.NoticeDataBean;

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
	
	@Override
	public NoticeDataBean detailnotice(int notice_no) {
		return SqlMapClient.getSession().selectOne("notice.detailnotice",notice_no);
	}
	
	public List<EducationListDto> EducationList(HashMap<String, Object> map) {
		
		if(map.get("opt")==null){//전체
			return SqlMapClient.getSession().selectList("Education.EducationList",map);
		}else if(map.get("opt").equals("0")){ //교육명
			return SqlMapClient.getSession().selectList("Education.selectTitleList",map);
		}else if(map.get("opt").equals("1")) {//교육번호
			return SqlMapClient.getSession().selectList("Education.selectNoList",map);
		}else if(map.get("opt").equals("2")) {//교육분야
			System.out.println("DBBean 교육분야 opt : "+map.get("opt")+" condition : "+map.get("condition"));
			return SqlMapClient.getSession().selectList("Education.selectFieldList",map);
		}else {//강사명
			return SqlMapClient.getSession().selectList("Education.selectInstructorList",map);
		}
		
		
	}
	
	@Override
	public int EducationListCount(HashMap<String, Object> map) {
		
		if(map.get("opt")==null){//전체
			System.out.println("EducationListCount DBBean 전체 ");
			return SqlMapClient.getSession().selectOne("Education.EducationListCount");
		}else if(map.get("opt").equals("0")){ //교육명
			return SqlMapClient.getSession().selectOne("Education.selectTitleListCount",map);
		}else if(map.get("opt").equals("1")) {//교육코드
			return SqlMapClient.getSession().selectOne("Education.selectCodeListCount",map);
		}else if(map.get("opt").equals("2")) {//교육분야
			return SqlMapClient.getSession().selectOne("Education.selectFieldListCount",map);
		}else {//강사명
			return SqlMapClient.getSession().selectOne("Education.selectInstructorListCount",map);
		}
	}
}
