package com.es.petition;

import org.springframework.stereotype.Component;

import com.es.db.SqlMapClient;

@Component("petitionLikeDao")
public class PetitionLikeDBBean implements PetitionLikeDao {

	@Override
	public int petitionAgree(PetitionLikeDto petitionLikeDto) {
		System.out.println("Agree DBBean");
		
		int check = agreeCheck(petitionLikeDto);  // 이미 참여 여부
		if (check != 0) {
			return 0;
		}
		
//		int count = agreeCount(petitionLikeDto);  // 
//		if(count >2) { 
//			System.out.println(count);
//			approvalUpdate(petitionLikeDto);
//		}
		
		return SqlMapClient.getSession().insert( "Petition.petitionAgree", petitionLikeDto );
	}
	
	@Override
	public int agreeCheck (PetitionLikeDto petitionLikeDto) {
		System.out.println("이미동의했는지 확인여부");
		return (Integer)SqlMapClient.getSession().selectOne( "Petition.agreeCheck", petitionLikeDto );
	}
	
	@Override
	public int agreeCount (PetitionLikeDto petitionLikeDto) {
		System.out.println("추천3개넘김확인쿼리");
		return (Integer)SqlMapClient.getSession().selectOne( "Petition.agreeCount", petitionLikeDto );
	}
	
	@Override
	public int approvalUpdate (int petition_no) { 
		System.out.println("추천3개넘어서 update");
		return SqlMapClient.getSession().update( "Petition.approvalUpdate", petition_no );
	}

	@Override
	public int agreeCount(int petition_no) {
		return (Integer)SqlMapClient.getSession().selectOne( "Petition.agreeCount", petition_no );
	}
 

}
