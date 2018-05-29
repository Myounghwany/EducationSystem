package com.es.petition;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;
import com.es.projectCommunity.ProjectCommunityDto;

@Component("petitionLikeDao")
public class PetitionLikeDBBean implements PetitionLikeDao {
	
	@Override
	public int petitionAgree(PetitionLikeDto petitionLikeDto) {
 
		int petition_no = petitionLikeDto.getPetition_no();
		int agree = agreeCheck(petitionLikeDto); // 참여 중복 여부 체크
		
		if (agree != 0) {
			return 0;
		}
		
		insertAgree(petitionLikeDto); // 청원 참여
		
		PetitionDao petitionDao = new PetitionDBBean();
		
		PetitionDto result = petitionDao.petitionDetail(petition_no);

		return SqlMapClient.getSession().update( "Petition.agreeUpdate", result );
	}
	
	private int insertAgree(PetitionLikeDto petitionLikeDto) { 
		return SqlMapClient.getSession().insert( "Petition.petitionAgree", petitionLikeDto );
	}
 
	private int agreeCheck (PetitionLikeDto petitionLikeDto) { 
		return SqlMapClient.getSession().selectOne( "Petition.agreeCheck", petitionLikeDto );
	}
	
	@Override
	public int countCheck (int petition_no) { // 청원 참여 개수 확인 
		return SqlMapClient.getSession().selectOne( "Petition.countCheck", petition_no );
	}
	
	@Override
	public int approvalUpdate (int petition_no) { // 심사중 업데이트
		return SqlMapClient.getSession().update( "Petition.approvalUpdate", petition_no );
	}

	 
}
