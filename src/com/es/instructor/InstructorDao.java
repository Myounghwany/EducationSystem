package com.es.instructor;

import java.util.List;

public interface InstructorDao {
	/*public String selectAccountNo(String id);*/
	public String selectInstructorCheck(String account_no);
	public List selectInstructorNo(String account_no);
	public int insertInstReq(InstructorDto InstructorDto);
	public List selectEduReq(String account_no);
	public List selectEduList(InstructorDto eduList);
	public List selectEduCode();
	public List selectBelongNo();
	public String selectEmployeesName(String account_no);
	public List<InstructorDto> selectInstructor();
	public List<InstructorDto> selectDepartment(String belong_no);
	public List<InstructorDto> selectPosition();
	public int insertEduReq(InstructorDto instructorDto);
	public int insertEduReqDetail(InstructorDto instructorDto);
	public List<InstructorDto> selectEduList2(String edu_no);
	public List<InstructorDto> selectEduDetail(String edu_no);
	public List<InstructorDto> selectEduHistory(String edu_no);
	public int modifyEdu(InstructorDto instructorDto);
	public int modifyEduDetail(InstructorDto instructorDto);
	public int updateInstEval(InstructorDto instructorDto);
	public int selectEduListCnt(String account_no);
}
