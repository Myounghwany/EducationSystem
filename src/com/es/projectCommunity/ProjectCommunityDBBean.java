package com.es.projectCommunity;

import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("ProjectCommunityDao")
public class ProjectCommunityDBBean implements ProjectCommunityDao {
	
	@Override
	public List<ProjectCommunityDto> projectList() {
		return SqlMapClient.getSession().selectList("ProjectCommunity.projectList");
	}
	
	@Override
	public int writeProject(ProjectCommunityDto boardDto) {
		return SqlMapClient.getSession().insert("ProjectCommunity.projectWrite", boardDto);
	}
	
	@Override
	public ProjectCommunityDto detailProject(int project_no) {
		return SqlMapClient.getSession().selectOne("ProjectCommunity.projectDetail",project_no);
	}
	
	@Override
	public int updateHit(ProjectCommunityDto boardDto) {
		return SqlMapClient.getSession().update("ProjectCommunity.updateHit",boardDto);
	}
	
	@Override
	public int modifyProject(ProjectCommunityDto boardDto) {
		return SqlMapClient.getSession().update("ProjectCommunity.projectModify",boardDto);
	}
	
	@Override
	public int deleteProject(int project_no) {
		System.out.println("deleteProject project_no : "+project_no);
		return SqlMapClient.getSession().delete("ProjectCommunity.projectDelete", project_no);
	}
}
