package com.model2.mvc.service.review;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;

public interface ReviewService {
	public boolean addReview(Review review);
	
	public Map<String,Object> getReviewList(Search search);

	public boolean updateReview(Review review);
	
	public boolean deleteReview(int reviewNo);

	public Review getReview(int reviewNo);

	public Review getReviewBytranNo(int tranNo);
}
