package com.model2.mvc.web.review;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewService;

@RestController
@RequestMapping("/review/*")
public class ReviewRestController {
	@Autowired
	@Qualifier("reviewService")
	ReviewService reviewService;

	public ReviewRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping("json/getReview")
	public Review getReview(@RequestParam("reviewNo") int reviewNo) throws Exception {
		return reviewService.getReview(reviewNo);
	}
	
	@RequestMapping("json/getReviewBytranNo")
	public Review getReviewBytranNo(@RequestBody Map<String,Integer> tranNo) throws Exception {
		return reviewService.getReviewBytranNo(tranNo.get("tranNo"));
	}	
	
	@RequestMapping(value="json/listReview")
	public Map<String,Object> getPurchaseList(@RequestBody Search search) throws Exception {
		return reviewService.getReviewList(search);
	}
//
//	
//	@RequestMapping("json/updatePurchase")
//	public boolean updatePurchase(@RequestBody Purchase purchase) throws Exception {
//		return purchaseService.updatePurchase(purchase)==1;
//	}
//	
//	@RequestMapping("json/updateTranCode")
//	public boolean updateTranCode(@RequestBody Purchase purchase) throws Exception{		
//		return purchaseService.updateTranCode(purchase)==1;
//	}
//	
//	@RequestMapping("json/updateTranCodeByProd")
//	public boolean updateTranCodeByProd(@RequestBody Purchase purchase) throws Exception{		
//		return purchaseService.updateTranCode(purchase)==1;
//	}
//	
//	@RequestMapping("json/cancelPurchase")
//	public boolean cancelPurchase(@RequestParam("tranNo") int tranNo) throws Exception {
//		Purchase purchase = new Purchase();
//		purchase.setTranNo(tranNo);
//		purchase.setTranCode("0");
//
//		return purchaseService.updateTranCode(purchase)==1; 
//	}
	
	@ExceptionHandler(value = Exception.class)
	public String nfeHandler(Exception e) {
		e.printStackTrace();
		return e.getMessage();
	}
}

