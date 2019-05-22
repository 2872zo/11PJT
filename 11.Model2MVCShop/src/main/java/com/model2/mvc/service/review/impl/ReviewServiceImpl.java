package com.model2.mvc.service.review.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewDao;
import com.model2.mvc.service.review.ReviewService;
import com.model2.mvc.service.util.UtilDao;
import com.model2.mvc.service.util.UtilService;


@Service("reviewService")
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	@Qualifier("reviewDao")
	private ReviewDao reviewDao;
	
	public ReviewServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public boolean addReview(Review review) {
		return reviewDao.addReview(review);
	}

	@Override
	public Map<String,Object> getReviewList(Search search) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("list", reviewDao.getReviewList(search));
		map.put("totalCount", reviewDao.makeTotalCount(search));
		return map;
	}

	@Override
	public boolean updateReview(Review review) {
		return reviewDao.updateReview(review);
	}

	@Override
	public boolean deleteReview(int reviewNo) {
		return reviewDao.deleteReview(reviewNo);
	}

	@Override
	public Review getReview(int reviewNo) {
		return reviewDao.getReview(reviewNo);
	}

	@Override
	public Review getReviewBytranNo(int tranNo) {
		return reviewDao.getReviewBytranNo(tranNo);
	}
}
