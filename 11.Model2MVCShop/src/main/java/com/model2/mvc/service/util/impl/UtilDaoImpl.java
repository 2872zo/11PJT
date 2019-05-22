package com.model2.mvc.service.util.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.service.util.UtilDao;


@Repository("utilDao")
public class UtilDaoImpl implements UtilDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlsession;
	
	public UtilDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public boolean validationCheck(Map<String, String> map) {
		boolean result = false;
		
		int count = sqlsession.selectOne("UtilMapper.validationCheck", map);
		System.out.println("count : " + count);
		if(count == 0) {
			result = true;
		}
		return result;
	}

	@Override
	public List<String> getData(Map<String, String> map) {
		return sqlsession.selectList("UtilMapper.getData", map);
	}

	@Override
	public boolean updateData(Map<String, String> map) {
		return sqlsession.update("UtilMapper.updateData", map)==1?true:false;
	}
}
