package com.es.petition;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;
import com.es.projectCommunity.ProjectCommunityDto;

@Component("petitionLikeDao")
public class PetitionLikeDBBean implements PetitionLikeDao {
	
	@Override
	public int petitionAgree(PetitionLikeDto petitionLikeDto) {
		System.out.println("Agree DBBean");
		int petition_no = petitionLikeDto.getPetition_no();
		int agree = agreeCheck(petitionLikeDto);
		if (agree != 0) {
			return 0;
		}
		
		// count 업데이트 
		insertAgree(petitionLikeDto);
		
		PetitionDao petitionDao = new PetitionDBBean();
		
		PetitionDto result = petitionDao.petitionDetail(petition_no);

		return SqlMapClient.getSession().update( "Petition.agreeUpdate", result );
	}
	
	private int insertAgree(PetitionLikeDto petitionLikeDto) {
		System.out.println("insert 찬성");
		return SqlMapClient.getSession().insert( "Petition.petitionAgree", petitionLikeDto );
		
	}

	@Override
	public int agreeCheck (PetitionLikeDto petitionLikeDto) {
		System.out.println("이미동의했는지 확인여부");
		return SqlMapClient.getSession().selectOne( "Petition.agreeCheck", petitionLikeDto );
	}
	
	@Override
	public int countCheck (int petition_no) {
		System.out.println("추천갯수 확인");
		return SqlMapClient.getSession().selectOne( "Petition.countCheck", petition_no );
	}
	
	@Override
	public int approvalUpdate (int petition_no) {
		System.out.println("추천3개 확인 후 업데이트");
		return SqlMapClient.getSession().update( "Petition.approvalUpdate", petition_no );
	}

	 
}
