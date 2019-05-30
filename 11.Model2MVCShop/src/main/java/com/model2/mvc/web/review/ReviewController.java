package com.model2.mvc.web.review;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.review.ReviewService;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
	@Autowired
	@Qualifier("reviewService")
	ReviewService reviewService;

	@Value("#{commonProperties['savePath']}")
	String savePath;
	
	public ReviewController() {
		System.out.println(this.getClass());
	}

	@RequestMapping("addReview")
	public ModelAndView addReview(@ModelAttribute Review review, @RequestParam("files") MultipartFile[] files) throws Exception {
		
		System.out.println("filesLength : " + files.length);
		if(files!=null && files.length > 0) {
			String fileName = null;
			for (MultipartFile file : files) {
				System.out.println("file");
				if(!file.isEmpty()) {
					System.out.println("notEmpty");
					String originFileExtension = file.getOriginalFilename().substring(file.getOriginalFilename().indexOf("."));
					String saveFileName = System.currentTimeMillis() + originFileExtension;
					fileName = (fileName != null ? fileName+"," : "") + saveFileName;
					File target = new File(savePath, saveFileName);
					
					FileCopyUtils.copy(file.getBytes(), target);
				}
			}
			if(fileName != null && !fileName.equals("")) {
				review.setFileName(fileName);
			}else{
				review.setFileName(null);
			}
		}
		
		reviewService.addReview(review);
		
		return new ModelAndView("forward:/product/getProduct?prodNo="+review.getProdNo());
	}

	@RequestMapping("listReview")
	public ModelAndView getReviewList(@ModelAttribute Search search) throws Exception {
		Map<String, Object> map = reviewService.getReviewList(search);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list",map.get("list"));
		modelAndView.addObject("totalCount",map.get("totalCount"));
		return modelAndView;
	}

	@RequestMapping("updateReview")
	public ModelAndView updateReview(@ModelAttribute Review review) throws Exception {
			
		reviewService.updateReview(review);
		review = reviewService.getReview(review.getReviewNo());
		ModelAndView modelAndView = new ModelAndView("forward:/purchase/listPurchase");
		
		modelAndView.addObject("review", review);
		
		return modelAndView;
	}
	
	@RequestMapping("updateReviewView")
	public ModelAndView updateReviewView(@ModelAttribute Review review) throws Exception {
			
		reviewService.updateReview(review);
		review = reviewService.getReview(review.getReviewNo());
		ModelAndView modelAndView = new ModelAndView("forward:/review/updateReviewView");
		
		modelAndView.addObject("review", review);
		
		return modelAndView;
	}

	@RequestMapping("deleteReview")
	public ModelAndView deleteReview(@RequestParam("reviewNo") int reviewNo) throws Exception {
		reviewService.deleteReview(reviewNo);
		
		return new ModelAndView("forward:/purchase/listPurchase");
	}
	
	@ExceptionHandler(value = Exception.class)
	public String nfeHandler(Exception e) {
		e.printStackTrace();
		return e.getMessage();
	}
}

