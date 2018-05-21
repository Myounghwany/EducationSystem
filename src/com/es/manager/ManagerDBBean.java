package com.es.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Configuration;

import com.es.db.SqlMapClient;
import com.es.education.EduHistoryDto;
import com.es.employees.BelongDto;
import com.es.employees.DepartmentDto;
import com.es.employees.EmployeesDto;
import com.es.employees.PositionDto;

@Configuration("ManagerDao")
public class ManagerDBBean implements ManagerDao {

	@Override
	public List<EmpListDto> getEmpList(int start) {
		return SqlMapClient.getSession().selectList("Manager.EmpMainList", start);		
	}

	@Override
	public List<BelongDto> getBelongList() {
		return SqlMapClient.getSession().selectList("Employees.BelongList");
	}

	@Override
	public List<DepartmentDto> getDepartmentList() {
		return SqlMapClient.getSession().selectList("Employees.DepartmentList");
	}

	@Override
	public List<PositionDto> getPositionList() {
		return SqlMapClient.getSession().selectList("Employees.PositionList");
	}

	@Override
	public int getEmpCount() {
		return SqlMapClient.getSession().selectOne("Employees.EmployeesCount");
	}

	@Override
	public List<InstListDto> getInstList(int start) {
		return SqlMapClient.getSession().selectList("Manager.InstMainList", start);
	}

	@Override
	public int getInstCount() {
		return SqlMapClient.getSession().selectOne("Instructor.InstructorCount");
	}

	@Override
	public int getEmpCount(Map<String, Object> srchMap) {
		return SqlMapClient.getSession().selectOne("Employees.EmployeesCategoryCount", srchMap);
	}

	@Override
	public List<EmpListDto> getEmpList(Map<String, Object> srchMap) {
		return SqlMapClient.getSession().selectList("Manager.EmpSearchList", srchMap);
	}

	@Override
	public int getInstCount(HashMap<String, Object> srchMap) {
		return SqlMapClient.getSession().selectOne("Instructor.InstructorCategoryCount", srchMap);
	}

	@Override
	public List<InstListDto> getInstList(HashMap<String, Object> srchMap) {
		return SqlMapClient.getSession().selectList("Manager.InstSearchList", srchMap);
	}

	@Override
	public EmpListDto getEmpDetail(String emp_no) {
		return SqlMapClient.getSession().selectOne("Manager.EmpDetail", emp_no);
	}

	@Override
	public List<EduHistoryDto> getEmpEduList(String emp_no) {
		return SqlMapClient.getSession().selectList("Education.EduHistory", emp_no);
	}
}
