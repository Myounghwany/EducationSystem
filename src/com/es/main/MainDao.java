package com.es.main;

import java.util.List;

public interface MainDao {

	public List<MainDto> noticeFive(MainDto maindto);
	
	public List<MainDto> historyFive(MainDto maindto);
	
	public List<MainDto> instructorFive(MainDto maindto);
	
	public List<MainDto> petitionFive(MainDto maindto);
}
