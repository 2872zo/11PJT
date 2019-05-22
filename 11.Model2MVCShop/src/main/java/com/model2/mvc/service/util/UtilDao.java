package com.model2.mvc.service.util;

import java.util.List;
import java.util.Map;

public interface UtilDao {
	public boolean validationCheck(Map<String,String> map);
	
	public List<String> getData(Map<String,String> map);

	public boolean updateData(Map<String, String> map);
}
