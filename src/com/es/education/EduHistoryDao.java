package com.es.education;

import java.util.List;

public interface EduHistoryDao {
	//전체 수강목록 가져오기
	public List<EduHistoryDto> eduHistoryList(String emp_no);
	
	//직원 수강내역 해당과목의 디테일
	public EduHistoryDto eduHistoryDetail(int no);
	
	//강의평가 제출
	public int insertEmpEval(int no, String emp_eval);

	//강의평가 보기
	public EduHistoryDto EduHistoryShowEval(int edu_no, String emp_no);
	
}
