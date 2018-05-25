package com.es.petition;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("petitionDao")
public class PetitionDBBean implements PetitionDao {
	
	@Override
	public int petitionListCount(HashMap<String, Object> map) {
		System.out.println(map.get("src"));
		System.out.println(map.get("sort"));

			return SqlMapClient.getSession().selectOne("Petition.petitionListCount",map);
	}
 
	
	
	
	@Override
	public int petitionState(int petition_no) {
		return (Integer)SqlMapClient.getSession().selectOne( "Petition.petitionState", petition_no );
	}
	
	@Override
	public int petitionWrite(PetitionDto petitionDto) { 
		return SqlMapClient.getSession().insert( "Petition.petitionWrite", petitionDto );
	}
	
	@Override
	public PetitionDto petitionDetail(int petition_no) {
		return SqlMapClient.getSession().selectOne( "Petition.petitionDetail", petition_no );
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
	public List<PetitionDto> answerList(HashMap<String, Object> map) {
		System.out.println("answerList"); 
		return SqlMapClient.getSession().selectList("Petition.answerList",map); 
	}
	
	@Override
	public List<PetitionDto> allList(HashMap<String, Object> map) {
		System.out.println("allList"); 
			return SqlMapClient.getSession().selectList("Petition.allList",map); 
	}


	@Override
	public int replyWrite(PetitionDto petitionDto) {
		return SqlMapClient.getSession().update("Petition.replyWrite",petitionDto); 
	}




	@Override
	public int acceptUpdate(int petition_no) {
		System.out.println("채택");
		return SqlMapClient.getSession().update("Petition.acceptUpdate",petition_no); 
	}




	@Override
	public int refusalUpdate(int petition_no) {
		System.out.println("거절");
		return SqlMapClient.getSession().update("Petition.refusalUpdate",petition_no); 
	}




	@Override
	public int petitionDelete(int petition_no) {
		return SqlMapClient.getSession().delete("Petition.petitionDelete",petition_no); 
		
	}




 
 
 
}
