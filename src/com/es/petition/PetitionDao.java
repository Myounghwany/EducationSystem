package com.es.petition;

import java.util.HashMap;
import java.util.List;

public interface PetitionDao {
  
	
	int petitionListCount(HashMap<String, Object> map); // 청원 게시글 개수 
	
	int petitionState(int petition_no); 				// 청원 상태 체크
	
	int petitionWrite(PetitionDto petitionDto);			// 청원 작성
	int replyWrite(PetitionDto petitionDto);			// 청원 답변 작성
	
	int petitionDelete(int petition_no); 				// 관리자 청원 삭제
	
	PetitionDto petitionDetail(int petition_no); 		// 청원 상세페이지
	
	int acceptUpdate(int petition_no); 					// 청원 채택
	int refusalUpdate(int petition_no); 				// 청원 거절
	
	
	List<PetitionDto> expireList(HashMap<String, Object> map);   // 기간만료
	
	List<PetitionDto> ongoingList(HashMap<String, Object> map);  // 진행중
	
	List<PetitionDto> evaluateList(HashMap<String, Object> map); // 심사중
	
	List<PetitionDto> answerList(HashMap<String, Object> map);   // 심사완료
	
	List<PetitionDto> allList(HashMap<String, Object> map);      // 모든청원
	  
}
