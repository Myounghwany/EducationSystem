package com.es.petition;

import java.util.HashMap;
import java.util.List;

public interface PetitionDao {
  
	int petitionListCount(HashMap<String, Object> map);
	
	int petitionState(int petition_no);
	
	int petitionWrite(PetitionDto petitionDto);

	PetitionDto petitionDetail(int petition_no);
	
	
	List<PetitionDto> expireList(HashMap<String, Object> map);
	List<PetitionDto> ongoingList(HashMap<String, Object> map);
	List<PetitionDto> evaluateList(HashMap<String, Object> map);
	List<PetitionDto> answerList(HashMap<String, Object> map);
	List<PetitionDto> allList(HashMap<String, Object> map);
	 
	int replyWrite(PetitionDto petitionDto);
 
	int acceptUpdate(int petition_no);
	int refusalUpdate(int petition_no);

	int petitionDelete(int petition_no);

	 

	 

	 
 

 
 

}
