package com.model2.mvc.service.review.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewDao;
import com.model2.mvc.service.util.UtilDao;


@Repository("reviewDao")
public class ReviewDaoImpl implements ReviewDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlsession;
	
	public ReviewDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public boolean addReview(Review review) {
		return (sqlsession.insert("ReviewMapper.addReview",review)==1?true:false);
	}

	@Override
	public List<Review> getReviewList(Search search) {
		return sqlsession.selectList("ReviewMapper.getReviewList",search);
	}

	@Override
	public boolean updateReview(Review review) {
		return (sqlsession.update("ReviewMapper.updateReview",review)==1?true:false);
	}

	@Override
	public boolean deleteReview(int reviewNo) {
		return (sqlsession.delete("ReviewMapper.deleteReview", reviewNo)==1?true:false);
	}

	@Override
	public Review getReview(int reviewNo) {
		return sqlsession.selectOne("ReviewMapper.getReview",reviewNo);
	}
	
	@Override
	public Review getReviewBytranNo(int tranNo) {
		return sqlsession.selectOne("ReviewMapper.getReviewBytranNo",tranNo);
	}

	@Override
	public int makeTotalCount(Search search) {
		return sqlsession.selectOne("ReviewMapper.makeTotalCount",search);
	}
}
