package com.model2.mvc.web.product;

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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.common.util.HttpUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	@Autowired
	@Qualifier("productService")
	ProductService productService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	public ProductRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping("json/addProduct")
	public Product addProduct(@RequestBody Product product) throws Exception {

		productService.addProduct(product);
		return productService.getProduct(10008);
	}
	
	@RequestMapping(value="json/getProduct/{prodNo}",method = RequestMethod.GET)
	public Product getProduct(@PathVariable int prodNo) throws Exception {
		return productService.getProduct(prodNo);
	}

	@RequestMapping(value="json/getProduct",method = RequestMethod.POST)
	public Product getProduct(@RequestBody int prodNo, HttpServletRequest request) throws Exception {
		return productService.getProduct(prodNo);
	}

	@RequestMapping(value="json/listProduct",method=RequestMethod.GET)
	public Map<String,Object> getProductList() throws Exception {
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		
		return productService.getProductList(search);
	}
	
	@RequestMapping(value="json/listProduct",method=RequestMethod.POST)
	public Map<String,Object> getProductList(@RequestBody Search search) throws Exception {
		return productService.getProductList(search);
	}

	@RequestMapping(value = "json/updateProduct",method = RequestMethod.POST)
	public boolean updateProduct(@RequestBody Product product) throws Exception {	
		return (productService.updateProduct(product)==1?true:false);
	}
}
