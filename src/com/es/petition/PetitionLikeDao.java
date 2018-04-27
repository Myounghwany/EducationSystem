package com.es.petition;

public interface PetitionLikeDao {

	int petitionAgree(PetitionLikeDto petitionLikeDto);

	int agreeCount(PetitionLikeDto petitionLikeDto);

	int approvalUpdate(int petition_no);

	int agreeCheck(PetitionLikeDto petitionLikeDto);

	int agreeCount(int petition_no);
 

}
