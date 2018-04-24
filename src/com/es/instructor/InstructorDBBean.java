package com.es.instructor;

import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("instructorDao")
public class InstructorDBBean implements InstructorDao{

	@Override
	public String selectAccountNo(String id) {
		return SqlMapClient.getSession().selectOne("Instructor.selectAccountNo", id);
	}

	@Override
	public List selectInstructorNo(String account_no) {
		return SqlMapClient.getSession().selectList("Instructor.selectInstructorNo", account_no);
	}

	@Override
	public String selectInstructorCheck(String account_no) {
		return SqlMapClient.getSession().selectOne("Instructor.selectInstructorCheck", account_no);
	}

	@Override
	public int insertInstReq(InstructorDataBean instructorDataBean) {
		return SqlMapClient.getSession().insert("Instructor.insertInstructorRequest", instructorDataBean);
	}
	
	@Override
	public List selectEduReq(String account_no) {
		return SqlMapClient.getSession().selectList("Instructor.selectEduReq", account_no);
	}
	

	@Override
	public List selectEduList(String account_no) {
		return SqlMapClient.getSession().selectList("Instructor.selectEduList", account_no);
	}

	@Override
	public List selectEduCode() {
		return SqlMapClient.getSession().selectList("Instructor.selectEduCode");
	}

	@Override
	public List selectBelongNo() {
		return SqlMapClient.getSession().selectList("Instructor.selectBelongNo");
	}

	@Override
	public String selectEmployeesName(String account_no) {
		return SqlMapClient.getSession().selectOne("Instructor.selectEmployeesName", account_no);
	}

	@Override
	public List<InstructorDataBean> selectInstructor() {
		return SqlMapClient.getSession().selectList("Instructor.selectInstructor");
	}

	@Override
	public List<InstructorDataBean> selectDepartment(String belong_no) {
		return SqlMapClient.getSession().selectList("Instructor.selectDepartment", belong_no);
	}
}
