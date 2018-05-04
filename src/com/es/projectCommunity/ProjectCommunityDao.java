package com.es.projectCommunity;


import java.util.HashMap;
import java.util.List;


public interface ProjectCommunityDao {
	public List<ProjectCommunityDto> projectList(HashMap<String, Object> map);
	public int writeProject(ProjectCommunityDto boardDto);
	public ProjectCommunityDto detailProject(int project_no);
	public int updateHit(ProjectCommunityDto boardDto);
	public int modifyProject(ProjectCommunityDto boardDto);
	public int deleteProject(int project_no);
	public int projectListCount(HashMap<String, Object> map);
}
