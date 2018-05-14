package com.es.projectCommunity;


import java.util.HashMap;
import java.util.List;


public interface ProjectCommunityDao {
	public List<ProjectCommunityDto> projectList(HashMap<String, Object> map);
	public List<ProjectReplyDto> commentList(int project_no);
	public int writeProject(ProjectCommunityDto boardDto);
	public ProjectCommunityDto detailProject(int project_no);
	public int updateHit(ProjectCommunityDto boardDto);
	public int modifyProject(ProjectCommunityDto boardDto);
	public int deleteProject(int project_no);
	public int projectListCount(HashMap<String, Object> map);
	public String userName(String emp_no);
	
	public int CommentWrite(ProjectReplyDto replyDto);
	public int updateReq(ProjectReplyDto replyDto);
	public int CommentUpdate(HashMap<String, Object> map);
	public int CommentDelete(HashMap<String, Object> map);
	
}
