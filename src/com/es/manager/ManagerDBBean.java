package com.es.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Configuration;

import com.es.db.SqlMapClient;
import com.es.employees.BelongDto;
import com.es.employees.DepartmentDto;
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
	public int getEmpCount(String category, String word) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("category", category);
		map.put("word", word);
		return SqlMapClient.getSession().selectOne("Employees.EmployeesSearchCount", map);
	}

	@Override
	public List<EmpListDto> getEmpList(int start, String category, String word) {
		// TODO Auto-generated method stub
		return null;
	}
	
}
