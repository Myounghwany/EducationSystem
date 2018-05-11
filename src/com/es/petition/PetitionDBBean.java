package com.es.petition;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("petitionDao")
public class PetitionDBBean implements PetitionDao {

	@Override
	public int petitionListCount(HashMap<String, Object> map) {
		
		if(map.get("src")==null){
			return SqlMapClient.getSession().selectOne("Petition.petitionListCount");
		}else if(map.get("src").equals("0")){ 
			return SqlMapClient.getSession().selectOne("Petition.selectTitleListCount",map);
		}else if(map.get("src").equals("1")) {
			return SqlMapClient.getSession().selectOne("Petition.selectContentListCount",map);
		}else if(map.get("src").equals("2")) {
			return SqlMapClient.getSession().selectOne("Petition.selectTCListCount",map);
		}else {
			return SqlMapClient.getSession().selectOne("Petition.selectWriterListCount",map);
		}
	}
	
	@Override
	public int petitionState(int petition_no) {
		return (Integer)SqlMapClient.getSession().selectOne( "Petition.petitionState", petition_no );
	}
	
	@Override
	public int petitionWrite(PetitionDto petitionDto) { 
		System.out.println("petitionWrite");
		return SqlMapClient.getSession().insert( "Petition.petitionWrite", petitionDto );
	}
	
	@Override
	public PetitionDto petitionDetail(int petition_no) {
		System.out.println("petitionDetail");
		return SqlMapClient.getSession().selectOne( "Petition.petitionDetail", petition_no );
	}
	
	@Override
	public List<PetitionDto> petitionList(HashMap<String, Object> map) {
		System.out.println("petitionList");
		
		if(map.get("src")==null){ 
			return SqlMapClient.getSession().selectList("Petition.petitionList",map);
		}else if(map.get("src").equals("0")){  
			System.out.println("제목으로 검색");
			return SqlMapClient.getSession().selectList("Petition.searchTitleList",map);
		}else if(map.get("src").equals("1")) { 
			return SqlMapClient.getSession().selectList("Petition.searchContentList",map);
		}else if(map.get("src").equals("2")) { 
			return SqlMapClient.getSession().selectList("Petition.searchTCList",map);
		}else { 
			return SqlMapClient.getSession().selectList("Petition.searchWriterList",map);
		}
		 
	}
 
	@Override
	public List<PetitionDto> expireList(HashMap<String, Object> map) {
		System.out.println("expireList");
//		int check = closingEvaluate(map);
		
		if(map.get("src")==null){ 
			return SqlMapClient.getSession().selectList("Petition.expireList",map);
		}else if(map.get("src").equals("0")){  
			System.out.println("제목으로 검색");
			return SqlMapClient.getSession().selectList("Petition.searchTitleList",map);
		}else if(map.get("src").equals("1")) { 
			return SqlMapClient.getSession().selectList("Petition.searchContentList",map);
		}else if(map.get("src").equals("2")) { 
			return SqlMapClient.getSession().selectList("Petition.searchTCList",map);
		}else { 
			return SqlMapClient.getSession().selectList("Petition.searchWriterList",map);
		}
		 
	}

	@Override
	public List<PetitionDto> evaluateList(HashMap<String, Object> map) {
		System.out.println("evaluateList");
		
		if(map.get("src")==null){ 
			return SqlMapClient.getSession().selectList("Petition.evaluateList",map);
		}else if(map.get("src").equals("0")){  
			System.out.println("제목으로 검색");
			return SqlMapClient.getSession().selectList("Petition.searchTitleList",map);
		}else if(map.get("src").equals("1")) { 
			return SqlMapClient.getSession().selectList("Petition.searchContentList",map);
		}else if(map.get("src").equals("2")) { 
			return SqlMapClient.getSession().selectList("Petition.searchTCList",map);
		}else { 
			return SqlMapClient.getSession().selectList("Petition.searchWriterList",map);
		}
	}

	@Override
	public List<PetitionDto> allList(HashMap<String, Object> map) {
		System.out.println("allList");
		
		if(map.get("src")==null){ 
			return SqlMapClient.getSession().selectList("Petition.allList",map);
		}else if(map.get("src").equals("0")){  
			System.out.println("제목으로 검색");
			return SqlMapClient.getSession().selectList("Petition.searchTitleList",map);
		}else if(map.get("src").equals("1")) { 
			return SqlMapClient.getSession().selectList("Petition.searchContentList",map);
		}else if(map.get("src").equals("2")) { 
			return SqlMapClient.getSession().selectList("Petition.searchTCList",map);
		}else { 
			return SqlMapClient.getSession().selectList("Petition.searchWriterList",map);
		}
	}

	

	@Override
	public int closingEvaluate() {
		return SqlMapClient.getSession().update("Petition.closingEvaluate"); 
	}

 

 
 
 
}
