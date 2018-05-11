package com.es.petition;

public interface PetitionLikeDao {

	int petitionAgree(PetitionLikeDto petitionLikeDto);

	int agreeCheck(PetitionLikeDto petitionLikeDto);

	int countCheck(int petition_no);
  
	int approvalUpdate(int petition_no);
  
}
