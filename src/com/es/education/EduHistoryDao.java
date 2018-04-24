package com.es.education;

import java.util.List;

public interface EduHistoryDao {
	public List<EduHistoryDto> eduHistoryList();
	
	public EduHistoryDto eduHistoryDetail(int no);
	
	public int insertEmpEval(int no, String emp_eval);
}
