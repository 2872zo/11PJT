package com.model2.mvc.service.review;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;

public interface ReviewDao {
	public boolean addReview(Review review);
	
	public List<Review> getReviewList(Search search);

	public boolean updateReview(Review review);
	
	public boolean deleteReview(int reviewNo);

	public Review getReview(int reviewNo);

	public int makeTotalCount(Search search);

	public Review getReviewBytranNo(int tranNo);
}
