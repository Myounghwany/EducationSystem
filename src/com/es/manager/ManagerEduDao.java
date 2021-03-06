package com.es.manager;

import java.util.List;

import com.es.instructor.InstructorDto;

public interface ManagerEduDao {
	/*교육과정 관리 - 교육목록*/
	List<EduListDto> eduList(int startRow, int endRow);

	/*총 교육목록 리스트 개수*/
	int count();

	/*교육 상세정보*/
	EduListDto eduListDetail(int edu_no);

	/*교육 검색*/
	List<EduListDto> searchAll(String searchOption, String keyword);

	/*총 심사 목록 리스트 개수*/
	int judgeCount();

	/*교욱 심사목록 */
	List<EduListDto> eduJudgeList(int startRow, int endRow);

	/*심사현황 페이지*/
	EduListDto eduDetailStatus(int edu_no);
	
	/*심사현황 수정 */
	int updateEduState(int edu_no, int app);

	/*강의 등록*/
	int insertEduReq(InstructorDto instructorDto);
	int insertEduReqDetail(InstructorDto instructorDto);
	
	/* 교육목록중 해당 강의, detail 모두 삭제*/
	int eduDelete(int edu_no);
	int eduDetailDelete(int edu_no);


}
