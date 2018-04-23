package com.es.education;

import java.util.List;

public interface EduListDao {
	public List<EduListDto> eduList();

	public EduListDto eduDetail(int no);
}
