package com.es.petition;

import java.util.HashMap;
import java.util.List;

public interface PetitionDao {
  
	int petitionWrite(PetitionDto petitionDto);

	PetitionDto petitionDetail(int petition_no);
	
	List<PetitionDto> petitionList(HashMap<String, Object> map);
 

}
