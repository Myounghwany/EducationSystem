package com.es.manager;

import java.util.List;

import com.es.employees.BelongDto;
import com.es.employees.DepartmentDto;
import com.es.employees.PositionDto;

public interface ManagerDao {

	List<EmpListDto> getEmpList(int start);

	List<BelongDto> getBelongList();

	List<DepartmentDto> getDepartmentList();

	List<PositionDto> getPositionList();

	int getEmpCount();

	List<InstListDto> getInstList(int start);

	int getInstCount();

	int getEmpCount(String category, String word);

	List<EmpListDto> getEmpList(int start, String category, String word);

	/*교육과정 관리 - 교육목록*/
	List<EduListDto> eduList(int startRow, int endRow);

	/*총 교육목록 리스트 개수*/
	int count();

	/*교육 상세정보*/
	EduListDto eduListDetail(int edu_no);

}
