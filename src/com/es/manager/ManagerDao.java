package com.es.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.es.education.EduCodeDto;
import com.es.education.EduHistoryDto;
import com.es.education.EducationListDto;
import com.es.employees.BelongDto;
import com.es.employees.DepartmentDto;
import com.es.employees.PositionDto;
import com.es.instructor.InstructorDto;

public interface ManagerDao {

	List<EmpListDto> getEmpList(int start);

	List<BelongDto> getBelongList();

	List<DepartmentDto> getDepartmentList();

	List<PositionDto> getPositionList();

	int getEmpCount();

	List<InstListDto> getInstList(int start);

	int getInstCount();

	int getEmpCount(Map<String, Object> srchMap);

	List<EmpListDto> getEmpList(Map<String, Object> srchMap);

	int getInstCount(HashMap<String, Object> srchMap);

	List<InstListDto> getInstList(HashMap<String, Object> srchMap);

	EmpListDto getEmpDetail(String emp_no);

	List<EduHistoryDto> getEmpEduList(String emp_no);

	InstructorDto getInstDetail(String inst_no);

	int getExInstCount();

	int getExInstCount(HashMap<String, Object> srchMap);

	List<InstListDto> getExInstList(int start);

	List<InstListDto> getExInstList(HashMap<String, Object> srchMap);

	ExInstructorDto getExInstDetail(String inst_no);

	String getInstNo(String find_no);

	int setExInst(ExInstructorDto inst);

	int setInst(HashMap<String, String> param);

	List<InstListDto> getReqInstList(int approval_state);

	int changeReqInst(HashMap<String, Object> param);

	List<EduCodeDto> getMustEduList();

	List<EmpListDto> getMustEduEmpList(HashMap<String, Object> emp_map);

	List<MustEduDto> getMustEduStateList(int edu_code);

}
