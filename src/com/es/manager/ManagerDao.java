package com.es.manager;

import java.util.List;

import com.es.employees.BelongDto;
import com.es.employees.DepartmentDto;
import com.es.employees.EmployeesDto;
import com.es.employees.PositionDto;

public interface ManagerDao {

	List<EmpListDto> getEmpList(int pageNum);

	List<BelongDto> getBelongList();

	List<DepartmentDto> getDepartmentList();

	List<PositionDto> getPositionList();

	int getEmpCount();

}
