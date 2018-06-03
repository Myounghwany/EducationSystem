package com.es.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Configuration;

import com.es.db.SqlMapClient;
import com.es.education.EduCodeDto;
import com.es.education.EduHistoryDto;
import com.es.education.EducationListDto;
import com.es.employees.BelongDto;
import com.es.employees.DepartmentDto;
import com.es.employees.PositionDto;
import com.es.instructor.InstructorDto;

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

	@Override
	public InstructorDto getInstDetail(String inst_no) {
		return SqlMapClient.getSession().selectOne("Manager.InstDetail", inst_no);
	}

	@Override
	public int getExInstCount() {
		return SqlMapClient.getSession().selectOne("Manager.ExInstructorCount");
	}

	@Override
	public int getExInstCount(HashMap<String, Object> srchMap) {
		return SqlMapClient.getSession().selectOne("Manager.ExInstructorCategoryCount", srchMap);
	}

	@Override
	public List<InstListDto> getExInstList(int start) {
		return SqlMapClient.getSession().selectList("Manager.ExInstMainList", start);
	}

	@Override
	public List<InstListDto> getExInstList(HashMap<String, Object> srchMap) {
		return SqlMapClient.getSession().selectList("Manager.ExInstSearchList", srchMap);
	}

	@Override
	public ExInstructorDto getExInstDetail(String inst_no) {
		return SqlMapClient.getSession().selectOne("Manager.ExInstDetail", inst_no);
	}

	@Override
	public String getInstNo(String find_no) {
		return SqlMapClient.getSession().selectOne("Manager.FindInstNumber", find_no);
	}

	@Override
	public int setExInst(ExInstructorDto inst) {
		return SqlMapClient.getSession().insert("Manager.InsertExInst", inst);
	}

	@Override
	public int setInst(HashMap<String, String> param) {
		return SqlMapClient.getSession().insert("Manager.InsertExInInst", param);
	}

	@Override
	public List<InstListDto> getReqInstList(int approval_state) {
		return SqlMapClient.getSession().selectList("Manager.ReqInstList", approval_state);
	}

	@Override
	public int changeReqInst(HashMap<String, Object> param) {
		return SqlMapClient.getSession().update("Manager.ChangeReqInst", param);
	}

	@Override
	public List<EduCodeDto> getMustEduList() {
		return SqlMapClient.getSession().selectList("Manager.MustEducationList");
	}

	@Override
	public List<EmpListDto> getMustEduEmpList(HashMap<String, Object> emp_map) {
		return SqlMapClient.getSession().selectList("Manager.MustEduCationEmpList", emp_map);
	}

	@Override
	public List<MustEduDto> getMustEduStateList(int edu_code) {
		return SqlMapClient.getSession().selectList("Manager.MustEduCationStateList", edu_code);
	}

	@Override
	public int deleteReqInst(String inst_no) {
		return SqlMapClient.getSession().delete("Manager.DeleteReqInst", inst_no);
	}
}
