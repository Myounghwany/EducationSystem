package com.es.manager;

import java.util.List;
import java.util.Map;

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

	int getEmpCount(Map<String, Object> srchMap);

	List<EmpListDto> getEmpList(Map<String, Object> srchMap);

}
