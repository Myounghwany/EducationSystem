package com.es.projectCommunity;

import java.util.List;


public interface ProjectCommunityDao {
	public List<ProjectCommunityDto> projectList();
	public int writeProject(ProjectCommunityDto boardDto);
	public ProjectCommunityDto detailProject(int project_no);
	public int updateHit(ProjectCommunityDto boardDto);
}
