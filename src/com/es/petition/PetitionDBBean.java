package com.es.petition;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("petitionDao")
public class PetitionDBBean implements PetitionDao {
 
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
	public int petitionListCount(HashMap<String, Object> map) {
		System.out.println(map.get("src"));
		System.out.println(map.get("sort"));

			return SqlMapClient.getSession().selectOne("Petition.petitionListCount");
	}
	
	@Override
	public List<PetitionDto> ongoingList(HashMap<String, Object> map) {
		System.out.println("ongoingList");
			return SqlMapClient.getSession().selectList("Petition.ongoingList",map);
	}
  
	@Override
	public List<PetitionDto> expireList(HashMap<String, Object> map) {
		System.out.println("expireList");
			return SqlMapClient.getSession().selectList("Petition.expireList",map); 
	}

	@Override
	public List<PetitionDto> evaluateList(HashMap<String, Object> map) {
		System.out.println("evaluateList");
			return SqlMapClient.getSession().selectList("Petition.evaluateList",map); 
	}

	@Override
	public List<PetitionDto> allList(HashMap<String, Object> map) {
		System.out.println("allList"); 
			return SqlMapClient.getSession().selectList("Petition.allList",map); 
	}


	@Override
	public int closingEvaluate() {
		return SqlMapClient.getSession().update("Petition.closingEvaluate"); 
	}

 

 

 
 
 
}
