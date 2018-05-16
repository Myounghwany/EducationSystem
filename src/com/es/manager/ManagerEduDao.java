package com.es.manager;

import java.util.HashMap;
import java.util.List;

public interface ManagerEduDao {
	/*교육과정 관리 - 교육목록*/
	List<EduListDto> eduList(int startRow, int endRow);

	/*총 교육목록 리스트 개수*/
	int count();

	/*교육 상세정보*/
	EduListDto eduListDetail(int edu_no);

	/*교육 검색*/
	List<EduListDto> searchAll(String searchOption, String keyword);

}
