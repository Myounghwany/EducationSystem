package com.es.projectCommunity;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("ProjectCommunityDao")
public class ProjectCommunityDBBean implements ProjectCommunityDao {
	
	@Override
	public List<ProjectCommunityDto> projectList(HashMap<String, Object> map) {
		
		if(map.get("opt")==null){//전체
			return SqlMapClient.getSession().selectList("ProjectCommunity.projectList",map);
		}else if(map.get("opt").equals("0")){ //제목
			System.out.println("제목으로 검색");
			return SqlMapClient.getSession().selectList("ProjectCommunity.selectTitleList",map);
		}else if(map.get("opt").equals("1")) {//내용
			return SqlMapClient.getSession().selectList("ProjectCommunity.selectContentList",map);
		}else if(map.get("opt").equals("2")) {//제목+내용
			return SqlMapClient.getSession().selectList("ProjectCommunity.selectTCList",map);
		}else {//글쓴이
			return SqlMapClient.getSession().selectList("ProjectCommunity.selectWriterList",map);
		}
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
		return SqlMapClient.getSession().delete("ProjectCommunity.projectDelete", project_no);
	}

	@Override
	public int projectListCount(HashMap<String, Object> map) {
		
		if(map.get("opt")==null){//전체
			return SqlMapClient.getSession().selectOne("ProjectCommunity.projectListCount");
		}else if(map.get("opt").equals("0")){ //제목
			System.out.println("제목으로 검색");
			return SqlMapClient.getSession().selectOne("ProjectCommunity.selectTitleListCount",map);
		}else if(map.get("opt").equals("1")) {//내용
			return SqlMapClient.getSession().selectOne("ProjectCommunity.selectContentListCount",map);
		}else if(map.get("opt").equals("2")) {//제목+내용
			return SqlMapClient.getSession().selectOne("ProjectCommunity.selectTCListCount",map);
		}else {//글쓴이
			return SqlMapClient.getSession().selectOne("ProjectCommunity.selectWriterListCount",map);
		}
		
	}
	
	
	/*comment*/
	@Override
	public int CommentWrite(ProjectReplyDto replyDto) {
		return SqlMapClient.getSession().insert("ProjectCommunity.commentWrite", replyDto);
	}
	
	@Override
	public List<ProjectReplyDto> commentList(int project_no) {
		return SqlMapClient.getSession().selectList("ProjectCommunity.commentList",project_no);
	}
	
	@Override
	public int updateReq(ProjectReplyDto replyDto) {
		return SqlMapClient.getSession().update("ProjectCommunity.updateReq",replyDto);
	}
	
	@Override
	public int CommentUpdate(HashMap<String, Object> map) {
		return SqlMapClient.getSession().update("ProjectCommunity.updateComment",map);
	}
	
	@Override
	public int CommentDelete(HashMap<String, Object> map) {
		return SqlMapClient.getSession().delete("ProjectCommunity.deleteComment",map);
	}
	
}
