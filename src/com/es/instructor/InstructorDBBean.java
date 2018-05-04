package com.es.instructor;

import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("instructorDao")
public class InstructorDBBean implements InstructorDao{
	/*
	@Override
	public String selectAccountNo(String id) {
		return SqlMapClient.getSession().selectOne("Instructor.selectAccountNo", id);
	}
*/
	@Override
	public List selectInstructorNo(String account_no) {
		return SqlMapClient.getSession().selectList("Instructor.selectInstructorNo", account_no);
	}

	@Override
	public String selectInstructorCheck(String account_no) {
		return SqlMapClient.getSession().selectOne("Instructor.selectInstructorCheck", account_no);
	}

	@Override
	public int insertInstReq(InstructorDto InstructorDto) {
		return SqlMapClient.getSession().insert("Instructor.insertInstructorRequest", InstructorDto);
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
	public List<InstructorDto> selectInstructor() {
		return SqlMapClient.getSession().selectList("Instructor.selectInstructor");
	}

	@Override
	public List<InstructorDto> selectDepartment(String belong_no) {
		return SqlMapClient.getSession().selectList("Instructor.selectDepartment", belong_no);
	}

	@Override
	public List<InstructorDto> selectPosition() {
		return SqlMapClient.getSession().selectList("Instructor.selectPosition");
	}

	@Override
	public int insertEduReq(InstructorDto instructorDto) {
		return SqlMapClient.getSession().insert("Instructor.insertEduReq", instructorDto);
	}

	@Override
	public int insertEduReqDetail(InstructorDto instructorDto) {
		return SqlMapClient.getSession().insert("Instructor.insertEduReqDetail", instructorDto);
	}

	@Override
	public List<InstructorDto> selectEduList2(String edu_no) {
		return SqlMapClient.getSession().selectList("Instructor.selectEduList2", edu_no);
	}

	@Override
	public List<InstructorDto> selectEduDetail(String edu_no) {
		return SqlMapClient.getSession().selectList("Instructor.selectEduDetail", edu_no);
	}

	@Override
	public List<InstructorDto> selectEduHistory(String edu_no) {
		return SqlMapClient.getSession().selectList("Instructor.selectEduHistory", edu_no);
	}

	@Override
	public int modifyEdu(InstructorDto instructorDto) {
		return SqlMapClient.getSession().update("Instructor.updateEdu", instructorDto);
	}

	@Override
	public int modifyEduDetail(InstructorDto instructorDto) {
		return SqlMapClient.getSession().update("Instructor.updateEduDetail", instructorDto);
	}

	@Override
	public int updateInstEval(InstructorDto instructorDto) {
		return SqlMapClient.getSession().update("Instructor.updateInstEval", instructorDto);
	}

}
