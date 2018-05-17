package com.es.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Configuration;

import com.es.db.SqlMapClient;
import com.es.instructor.InstructorDto;

@Configuration("ManagerEduDao")
public class ManagerEduDBBean implements ManagerEduDao{
	
	/*교육과정관리 - 교육목록*/
	@Override
	public List<EduListDto> eduList(int startRow, int endRow) {
		HashMap<Object, Object> page = new HashMap<>();
		page.put("startRow", startRow);
		page.put("endRow", endRow);
		return SqlMapClient.getSession().selectList("ManagerEdu.EduList", page);
	}
	
	/*총 교육리시트 갯수*/
	public int count() {
		return SqlMapClient.getSession().selectOne("ManagerEdu.EduListCount");
	};
	
	/*교육 디테일 정보(모달로)*/
	@Override
	public EduListDto eduListDetail(int edu_no) {
		System.out.println("매니저 교육디테일정보 DBBean...");
		return SqlMapClient.getSession().selectOne("ManagerEdu.EduListDetail", edu_no);
	}
	
	/* 교육목록 검색 기능 */
	@Override
	public List<EduListDto> searchAll(String searchOption, String keyword) {
		System.out.println("searchAll DBBean...");
		Map<String, Object> map = new  HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("keyword",  keyword);
		return SqlMapClient.getSession().selectList("ManagerEdu.searchAll", map);
	}
	
	/*총 심사 목록 리스트 개수*/
	@Override
	public int judgeCount() {
		return SqlMapClient.getSession().selectOne("ManagerEdu.EduJudgeCount");
	}
	
	/*교육 심사목록*/
	@Override
	public List<EduListDto> eduJudgeList(int startRow, int endRow) {
		HashMap<Object, Object> page = new HashMap<>();
		page.put("startRow", startRow);
		page.put("endRow", endRow);
		return SqlMapClient.getSession().selectList("ManagerEdu.EduJudgeList", page);
	}
	@Override
	public EduListDto eduDetailStatus(int edu_no) {
		return SqlMapClient.getSession().selectOne("ManagerEdu.EduDetailStatus", edu_no);
	}
	
	/*심사현황 수정*/
	@Override
	public int updateEduState(int edu_no, int app) {
		HashMap<Object, Object> state = new HashMap<>();
		state.put("edu_no", edu_no);
		state.put("app", app);
		return SqlMapClient.getSession().update("ManagerEdu.updateEduState", state);
	}
	
	/*강의 등록*/
	@Override
	public int insertEduReq(InstructorDto instructorDto) {
		return SqlMapClient.getSession().insert("ManagerEdu.insertEduRegist", instructorDto);
	}
	@Override
	public int insertEduReqDetail(InstructorDto instructorDto) {
		return SqlMapClient.getSession().insert("ManagerEdu.insertEduRegistDetail", instructorDto);
	}
}
