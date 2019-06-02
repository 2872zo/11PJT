package com.model2.mvc.web.product;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.common.util.HttpUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.review.ReviewService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	@Autowired
	@Qualifier("productService")
	ProductService productService;
	
	@Autowired
	@Qualifier("reviewService")
	ReviewService reviewService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['savePath']}")
	String savePath;
	
	public ProductController() {
		System.out.println(this.getClass());
	}

	@RequestMapping("addProduct")
	public String addProduct(@ModelAttribute("product") Product product,@RequestParam("files") MultipartFile[] files, Model model) throws Exception {
		if(files!=null && files.length > 0) {
			String fileName = null;
			for (MultipartFile file : files) {
				fileName = (fileName != null ? fileName+"," : "") + System.currentTimeMillis();
				String originFileName = String.valueOf(System.currentTimeMillis());
				File target = new File(savePath, originFileName);
				
				if(!fileName.equals("")) {
					FileCopyUtils.copy(file.getBytes(), target);
				}
			}
			if(!fileName.equals("")) {
				product.setFileName(fileName);
			}else{
				product.setFileName(null);
			}
		}
		productService.addProduct(product);
		model.addAttribute(product);
		
		return "forward:/product/confirmProduct.jsp";
	}

	@RequestMapping("getProduct")
	public String getProduct(@RequestParam("prodNo") int prodNo, 
			@RequestParam(value="menu", required=false) String menu,
			@CookieValue(value = "history", required = false) Cookie cookie,
			Map<String,Object> map, HttpSession session,
			HttpServletResponse response) throws Exception {
		String targetURI = null;
		Product product = productService.getProduct(prodNo);

		//리뷰 출력을 위한 데이터 조회
		Search search = new Search();
		search.setProdNo(prodNo);
//		search.setUserId(((User)session.getAttribute("user")).getUserId());
		Map<String,Object> reviewMap = reviewService.getReviewList(search);
		List<Review> reviewList = (List<Review>) reviewMap.get("list");
		int reviewCount = (int) reviewMap.get("totalCount");
		
		List<String> columList = new Vector<String>();
		columList.add("리뷰번호");
		columList.add("제목");
		columList.add("작성자");
		columList.add("평점");
		
		List<List> unitList = new Vector<List>();
		List<String> unitDetail = null;
		float avgRating = 0;
		for (int i = 0; i < reviewList.size(); i++) {
			unitDetail = new Vector<String>();
			unitDetail.add(String.valueOf(reviewList.get(i).getReviewNo()));
			unitDetail.add(reviewList.get(i).getTitle());
			unitDetail.add(reviewList.get(i).getUserId());
			String starImg = new String();
			for(int j =0; j<5;j++) {
				if(j < reviewList.get(i).getRating()) {
					starImg += "<img src='/images/star-on.png'/>";
				}else {
					starImg += "<img src='/images/star-off.png'/>";
				}
			}
			unitDetail.add(starImg);	
			unitList.add(unitDetail);
			
			String result = new String();
			if(reviewList.get(i).getFileName() != null) {
				String[] tmpString = reviewList.get(i).getFileName().split(",");
				for(int j=0; j < tmpString.length; j++) {
					result += "<img src='/images/uploadFiles/"+tmpString[j]+"'/><br/>";
				}
			}
			result += reviewList.get(i).getText();
//			System.out.println("resultString : " + result);
			
			result += "<br/><button class='btn btn-default pull-right updateReview'>수정</button>&nbsp;<button class='btn btn-default pull-right deleteReview'>삭제</button>";
			
			unitDetail = new Vector<String>();
			unitDetail.add(result);
			unitList.add(unitDetail);
			avgRating += reviewList.get(i).getRating();
		}
		if(avgRating != 0) {
			avgRating *= 20/reviewList.size();
		}
		
		
		if (menu == null || menu.equals("search")) {
			targetURI = "forward:/product/getProduct.jsp";
		} else if (menu.equals("manage")) {
			targetURI = "forward:/product/updateProductView";
		}

		
		// list 형태로 product 전달
		// domain에 toList() 추가
		map.put("map", product.toMap());
		map.put("reviewCount", reviewCount);
		map.put("product", product);
		map.put("avgRating", avgRating);
		//리뷰를위한 객체
		map.put("columList", columList);
		map.put("unitList", unitList);
		
		if (cookie == null) {
			cookie = new Cookie("history", String.valueOf(prodNo));
		} else if(cookie.getValue().indexOf(String.valueOf(prodNo)) == -1){
			cookie = new Cookie("history", cookie.getValue() +","+prodNo);
		}
		
		cookie.setMaxAge(-1);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		System.out.println("\n==>getProudct End.........");

		return targetURI;
	}

	@RequestMapping(value="listProduct")
	public String getProductList(@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,	Search search,
									@RequestParam("menu") String menu, Map<String, Object> resultMap,
									@RequestParam(value="pageSize", defaultValue="0") int pageSize
									,HttpServletRequest request) throws Exception {
		
		System.out.println("\n==>listProudct-GET Start.........");
		if(request.getMethod().equals("GET")) {
			currentPage = Integer.parseInt(request.getParameter("page")!=null?request.getParameter("page"):"1");
			if(!(CommonUtil.null2str(search.getSearchKeyword()).equals(""))){
				search.setSearchKeyword(HttpUtil.convertKo(search.getSearchKeyword()));
			}
		}

		// currentPage
		search.setCurrentPage(currentPage);
		// pageSize
		if(pageSize == 0) {
			System.out.println("pageSize : 0");
			search.setPageSize(this.pageSize);
		}else {
			search.setPageSize(pageSize);
		}
		

		
		System.out.println("getProductList - search : " + search);
		
		/// 4.DB에 접속하여 결과값을 Map으로 가져옴
		Map<String,Object> map = productService.getProductList(search);

		/// 5.pageView를 위한 객체
		Page resultPage = new Page(currentPage, ((Integer) map.get("totalCount")).intValue(), pageUnit, search.getPageSize());

		System.out.println("ListProductAction-resultPage : " + resultPage);
		System.out.println("ListProductAction-list.size() : " + ((List) map.get("list")).size());

		/// 6.JSP에 출력을 하기위한 설정들
		List<String> sortList = new ArrayList<String>();
		sortList.add("상품번호 오름차순");
		sortList.add("상품번호 내림차순");
		sortList.add("상품명 오름차순");
		sortList.add("상품명 내림차순");
		sortList.add("가격 오름차순");
		sortList.add("가격 오름차순");
		
		List<String> hideList = new ArrayList<String>();
		hideList.add("모든 상품 보기");
		hideList.add("품절 상품 제외");
		
		// searchOptionList 설정
		List<String> searchOptionList = new Vector<String>();
		searchOptionList.add("상품번호");
		searchOptionList.add("상품명");
		searchOptionList.add("상품가격");

		// title 설정
		String title = null;
		if (menu.equals("search")) {
			title = "상품 목록 조회";
		} else if(menu.equals("manage")) {
			title = "판매 목록 관리";
		}

		List unitList = makeProductListForMap((List<Product>) map.get("list"));

		// 출력을 위한 Obejct들
		resultMap.put("title", title);
		resultMap.put("unitList", unitList);
		resultMap.put("searchOptionList", searchOptionList);
		resultMap.put("resultPage", resultPage);
		resultMap.put("sortList", sortList);
		resultMap.put("hideList", hideList);
		
		List<Product> prodList = (List<Product>) map.get("list");
		String prodNoList = null;
		String prodFileList = null;
		if(prodList != null && prodList.size() > 0) {
			prodNoList = String.valueOf(prodList.get(0).getProdNo());
			prodFileList = "'" + String.valueOf(prodList.get(0).getFileName()) + "'";
			for(int i=1;i<prodList.size();i++) {
				prodNoList += "," + String.valueOf(prodList.get(i).getProdNo()); 
				prodFileList += ",'" + String.valueOf(prodList.get(i).getFileName()) + "'"; 
			}
			resultMap.put("prodNoList", prodNoList);
			resultMap.put("prodFileList", prodFileList);		
		}
		
		
		System.out.println("\n==>listProudct-GET End.........");
		
		return "forward:/product/listProduct.jsp";
	}
	

	@RequestMapping("updateProduct")
	public String updateProduct(@RequestParam("prodNo") int prodNo, @ModelAttribute Product product,
			Map<String,String> map,@RequestParam("file") MultipartFile[] files) throws Exception {
		
		if(files!=null && files.length > 0) {
			String fileName = null;
			for (MultipartFile file : files) {
				fileName = (fileName != null ? fileName+"," : "") + file.getOriginalFilename();
				String originFileName = file.getOriginalFilename();
				File target = new File(savePath, originFileName);
				System.out.println("==================" + fileName);
				
				if(!fileName.equals("")) {
					FileCopyUtils.copy(file.getBytes(), target);
				}
			}
			if(!fileName.equals("")) {
				product.setFileName(fileName);
			}else{
				product.setFileName(null);
			}
		}
		
		
		productService.updateProduct(product);

		map.put("prodNo", String.valueOf(prodNo));
		map.put("menu", "search");
		
		return "redirect:/product/getProduct";
	}

	@RequestMapping("updateProductView")
	public String updateProductView(@RequestParam("prodNo") int prodNo, Map<String, Object> map) throws Exception {
		map.put("product", productService.getProduct(prodNo));
		
		return "forward:/product/updateProductView.jsp";
	}
	
	@RequestMapping("deleteProduct")
	public String deleteProduct(@RequestParam("prodNo") int prodNo) throws Exception{
		productService.deleteProduct(prodNo);
		return "forward:/product/listProduct?menu=search";
	}
	
	private List makeProductList(String menu, List<Product> productList, int currentPage) {
		List<List> unitList = new Vector<List>();
		List<String> unitDetail = null;
		String aTagEnd = "</a>";
		
		for (int i = 0; i < productList.size(); i++) {
//			System.out.println(productList.get(i));
			unitDetail = new Vector<String>();
			//1.제품 순서 번호
			unitDetail.add(String.valueOf(i + 1));
			//2.제품 이름
//			String aTagGetProductStart = "<a href='/product/getProduct?prodNo=" + productList.get(i).getProdNo() + "\'>";
//			UnitDetail.add(aTagGetProductStart + productList.get(i).getProdName() + aTagEnd);
			unitDetail.add(productList.get(i).getProdName());
			//3.제품 가격
			unitDetail.add(String.valueOf(productList.get(i).getPrice()));
			//4.제품 등록 날짜
			unitDetail.add(String.valueOf(productList.get(i).getRegDate()));
			//5.제품 상태
			if (menu.equals("manage")) {
				if(productList.get(i).getTranCount() != 0) {
					String aTagSaleListStart = "<a href='/purchase/listSale?prodNo=" + productList.get(i).getProdNo() + "\'>";
					unitDetail.add(aTagSaleListStart + "거래 건수 : " + productList.get(i).getTranCount() + aTagEnd);
				}
			} else {
				if (productList.get(i).getStock() > 0) {
					unitDetail.add("판매중");
				} else {
					unitDetail.add("재고없음");
				}
			}

			
			
			
			//1~5과정을 통해 만들어진 리스트를 삽입
			unitList.add(unitDetail);
		}
		return unitList;
	}
	
	private List makeProductListForMap(List<Product> productList) {
		List<Map> unitList = new Vector<Map>();
		Map<String,String> unitMap = null;
		
		for (int i = 0; i < productList.size(); i++) {
			unitMap = new HashMap<String, String>();
			//제품 이름
			unitMap.put("prodName",productList.get(i).getProdName());
			//제품 가격
			unitMap.put("price",String.valueOf(productList.get(i).getPrice()));
			//제품 사진
			if(productList.get(i).getFileName() != null) {
				String[] fileNames = productList.get(i).getFileName().split(",");
				
				unitMap.put("fileName",String.valueOf(fileNames[0]));
			}
			//평균 평점
			unitMap.put("avgRating", "3");
			//판매 개수
			unitMap.put("salesVolume", "2");
			unitMap.put("stock", String.valueOf(productList.get(i).getStock()));
			
			
			
			//1~5과정을 통해 만들어진 리스트를 삽입
			unitList.add(unitMap);
		}
		return unitList;
	}
}
