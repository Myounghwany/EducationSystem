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
}
