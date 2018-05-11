package com.es.petition;

import java.util.HashMap;
import java.util.List;

public interface PetitionDao {
  
	int petitionListCount(HashMap<String, Object> map);
	
	int petitionState(int petition_no);
	
	int petitionWrite(PetitionDto petitionDto);

	PetitionDto petitionDetail(int petition_no);
	
	
	List<PetitionDto> expireList(HashMap<String, Object> map);
	List<PetitionDto> petitionList(HashMap<String, Object> map);
	List<PetitionDto> evaluateList(HashMap<String, Object> map);
	List<PetitionDto> allList(HashMap<String, Object> map);
	
	int closingEvaluate();

	 
 

 
 

}
