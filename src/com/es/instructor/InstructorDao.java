package com.es.instructor;

import java.util.List;

public interface InstructorDao {
	public String selectAccountNo(String id);
	public String selectInstructorCheck(String account_no);
	public List selectInstructorNo(String account_no);
	public int insertInstReq(InstructorDataBean instructorDataBean);
	public List selectEduReq(String account_no);
	public List selectEduList(String account_no);
	public List selectEduCode();
	public List selectBelongNo();
	public String selectEmployeesName(String account_no);
	public List<InstructorDataBean> selectInstructor();
	public List<InstructorDataBean> selectDepartment(String belong_no);
}
