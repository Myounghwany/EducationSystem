package com.es.petition;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("petitionDao")
public class PetitionDBBean implements PetitionDao {

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
	public int agreeCountList(HashMap<String, Object> map) {
		System.out.println("추천3개넘김확인쿼리");
		return (Integer)SqlMapClient.getSession().selectOne( "Petition.agreeCountList", map );
	}
 
}
