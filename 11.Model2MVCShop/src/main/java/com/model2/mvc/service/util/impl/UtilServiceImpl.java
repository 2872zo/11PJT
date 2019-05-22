package com.model2.mvc.service.util.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.util.UtilDao;
import com.model2.mvc.service.util.UtilService;


@Service("utilService")
public class UtilServiceImpl implements UtilService {
	@Autowired
	@Qualifier("utilDao")
	private UtilDao utilDao;
	
	public UtilServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public boolean validationCheck(Map<String, String> map) {
		return utilDao.validationCheck(map);
	}

	@Override
	public List<String> getData(Map<String, String> map) {
		return utilDao.getData(map);
	}

	@Override
	public boolean updateData(Map<String, String> map) {
		return utilDao.updateData(map);
	}

}
