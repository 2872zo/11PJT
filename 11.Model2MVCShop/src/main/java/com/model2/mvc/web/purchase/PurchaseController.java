package com.model2.mvc.web.purchase;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.util.UtilService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	@Autowired
	@Qualifier("purchaseService")
	PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productService")
	ProductService productService;
	
	@Autowired
	@Qualifier("utilService")
	UtilService utilService;

	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	public PurchaseController() {
		System.out.println(this.getClass());
	}

	@RequestMapping("addPurchase")
	public ModelAndView addPurchase(@ModelAttribute("purchase") Purchase purchase, HttpSession session, @RequestParam("prodNo") int prodNo) throws Exception {
		User user = (User) session.getAttribute("user");
		Product product = new Product();
		product.setProdNo(prodNo);
		
		//puchase ����
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setTranCode("1");
		
		//����
		purchaseService.addPurchase(purchase);
		
		
		return new ModelAndView("forward:/purchase/confirmPurchase.jsp");
	}
	
	@RequestMapping("addPurchaseView")
	public ModelAndView addPurchaseView(@RequestParam("prodNo") int prodNo) throws Exception {		
		Product product = null;
		System.out.println("�� : " + product);
		product = productService.getProduct(prodNo);
		System.out.println("�� : " + product);	
		
		ModelAndView modelAndView = new ModelAndView("forward:/purchase/addPurchaseView.jsp");
		modelAndView.addObject("product", product);
		
		return modelAndView;
	}

	@RequestMapping("getPurchase")
	public ModelAndView getPurchase(@RequestParam("tranNo") int tranNo) throws Exception {
		System.out.println("\n==>getPurchase Start.........");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
				
		List<String> purchaseList = purchase.toList();
		System.out.println("getPurchaseAction�� getTranCode�� : "+purchase.getTranCode());
		
		ModelAndView modelAndView = new ModelAndView("forward:/purchase/getPurchase.jsp");
		modelAndView.addObject("list", purchaseList);
		modelAndView.addObject("purchase", purchase);
		
		System.out.println("\n==>getPurchase End.........");
		
		return modelAndView;
	}
	
	@RequestMapping(value="listPurchase")
	public ModelAndView getPurchaseList(@RequestParam(value = "page", defaultValue = "1") int page, 
								  @RequestParam(value = "currentPage", defaultValue= "1") int currentPage,
								  @ModelAttribute Search search, @RequestParam(value="pageSize", defaultValue="0") int pageSize,
								  HttpServletRequest request,HttpSession session) throws Exception {
		
		System.out.println("\n==>listPurchase Start.........");
		
		if(request.getMethod().equals("GET")) {
			currentPage = page;
		}
		
		if(pageSize == 0) {
			pageSize = this.pageSize;
		}
		
		User user = (User)session.getAttribute("user");
		
		//3.DB ������ ���� search
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setUserId(user.getUserId());

		///4.DB�� �����Ͽ� ������� Map���� ������
		Map<String, Object> map = purchaseService.getPurchaseList(search);

		
		///5.pageView�� ���� ��ü
		Page resultPage = new Page(currentPage, ((Integer) map.get("totalCount")).intValue(),
				pageUnit, pageSize);
		
		System.out.println("ListPurchaseAction-resultPage : " + resultPage);
		System.out.println("ListPurchaseAction-list.size() : " + ((List)map.get("list")).size());
		
		
		///6.JSP�� ����� �ϱ����� ������
		//title ����
		String title = "���� ��� ��ȸ";
		
		//colum ����
		List<String> columList = new ArrayList<String>();
		columList.add("No");
		columList.add("ȸ��ID");
		columList.add("��ǰ�̸�");
		columList.add("���ż���");
		columList.add("�ŷ�����");
		columList.add("���");

		// UnitList ����
		List<Purchase> list = (List<Purchase>) map.get("list");
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setPurchaseProd(productService.getProduct(list.get(i).getPurchaseProd().getProdNo()));
		}
		List unitList = makePurchaseList(currentPage, list, user);

		//����� ���� Object
		ModelAndView modelAndView = new ModelAndView("forward:/purchase/listPurchase.jsp");
		modelAndView.addObject("title", title);
		modelAndView.addObject("columList", columList);
		modelAndView.addObject("unitList", unitList);
		modelAndView.addObject("resultPage", resultPage);
		
		String tranNoList= null;
		String prodNoList= null;
		System.out.println("purchaseController-list.size() : " + list.size());
		if(list != null && list.size() > 0) {
			tranNoList = String.valueOf(list.get(0).getTranNo());
			prodNoList = String.valueOf(list.get(0).getPurchaseProd().getProdNo());
			for (int i = 1; i < list.size(); i++) {
				tranNoList += "," + list.get(i).getTranNo();
				prodNoList += "," + list.get(i).getPurchaseProd().getProdNo();
			}
			modelAndView.addObject("tranNoList",tranNoList);
			modelAndView.addObject("prodNoList",prodNoList);
		}

		System.out.println("\n==>listPurchase End.........");
		
		return modelAndView;
	}

	
	@RequestMapping("updatePurchase")
	public ModelAndView updatePurchase(@ModelAttribute Purchase purchase, Map<String,Object> map) throws Exception {
		System.out.println("\n==>updatePurchase Start.........");
			
		purchaseService.updatePurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView("forward:/purchase/getPurchase");
		modelAndView.addObject("tranNo", purchase.getTranNo());
		
		System.out.println("\n==>updatePurchase End.........");
		return modelAndView;
	}

	@RequestMapping("updatePurchaseView")
	public ModelAndView updatePurchaseView(@RequestParam("tranNo") int tranNo, Map<String, Object> map) throws Exception {
		Purchase purchase = purchaseService.getPurchase(tranNo);

		ModelAndView modelAndView = new ModelAndView("forward:/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);

		return modelAndView;
	}
	
	@RequestMapping("updateTranCode")
	public ModelAndView updateTranCode(@RequestParam("tranCode") String tranCode, @RequestParam("tranNo") int tranNo) throws Exception{
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);

		System.out.println(purchase);
		
		purchaseService.updateTranCode(purchase);
		
		return new ModelAndView("forward:/purchase/listPurchase");
	}
	
	@RequestMapping("updateTranCodeByProd")
	public ModelAndView updateTranCodeByProd(@RequestParam("prodNo") int prodNo, @RequestParam("tranCode") String tranCode, 
			@RequestParam("page") String page, @RequestParam("menu") String menu, Search search) throws Exception{		
		Product product = new Product();
		Purchase purchase = new Purchase();
		product.setProdNo(prodNo);
		purchase.setPurchaseProd(product);
		purchase.setTranCode(tranCode);

		purchaseService.updateTranCode(purchase);
		
		ModelAndView modelAndView = new ModelAndView("forward:/product/listProduct?");
		
		modelAndView.addObject("page", page);
		modelAndView.addObject("tranCode", tranCode);
		modelAndView.addObject("menu", menu);
		if(search.getSearchCondition() != null) {
			modelAndView.addObject("searchCondition", search.getSearchCondition());
			modelAndView.addObject("searchKeyword", search.getSearchKeyword());
		}
		
		return modelAndView;
	}
	
	@RequestMapping("cancelPurchase")
	public ModelAndView cancelPurchase(@RequestParam("tranNo") int tranNo) throws Exception {
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode("0");

		purchaseService.cancelTranCode(purchase);
		
		return new ModelAndView("forward:/purchase/listPurchase");
	}
	
	@RequestMapping("listSale")
	public ModelAndView getSaleList(HttpServletRequest request,@RequestParam int prodNo, HttpSession session, 
					@RequestParam(value="currentPage",defaultValue="1") int currentPage,
					@ModelAttribute Search search) throws Exception {
		System.out.println("\n==>listPurchase Start.........");
		
		User user = (User)session.getAttribute("user");
		
		if(currentPage == 1 && request.getMethod().equals("GET")) {
			currentPage = (request.getParameter("page")!=null?Integer.parseInt(request.getParameter("page")):1);
		}
		
		//3.DB ������ ���� search
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		search.setUserId(user.getUserId());
		search.setProdNo(prodNo);

		///4.DB�� �����Ͽ� ������� Map���� ������
		Map<String, Object> map = purchaseService.getPurchaseList(search);

		///5.pageView�� ���� ��ü
		Page resultPage = new Page(currentPage, ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		System.out.println("ListPurchaseAction-resultPage : " + resultPage);
		System.out.println("ListPurchaseAction-list.size() : " + ((List)map.get("list")).size());
		
		
		///6.JSP�� ����� �ϱ����� ������
		//title ����
		String title = "���� ��� ��ȸ";
		
		//colum ����
		List<String> columList = new ArrayList<String>();
		columList.add("No");
		columList.add("ȸ��ID");
		columList.add("��ǰ�̸�");
		columList.add("���ż���");
		columList.add("�ŷ�����");
		columList.add("��������");
		
		//UnitList ����
		List<Purchase> list =	(List<Purchase>)map.get("list");
		for(int i = 0; i < list.size(); i++) {
			list.get(i).setPurchaseProd(productService.getProduct(list.get(i).getPurchaseProd().getProdNo()));
		}
		List unitList = makePurchaseList(currentPage, list, user);
		
		
		//����� ���� Object
		ModelAndView modelAndView = new ModelAndView("forward:/purchase/listPurchase.jsp");
		modelAndView.addObject("title", title);
		modelAndView.addObject("columList", columList);
		modelAndView.addObject("unitList", unitList);
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search",search);

		System.out.println("\n==>listPurchase End.........");
		
		return modelAndView;
	}
	
	@RequestMapping("viewCart")
	public ModelAndView viewCart(HttpSession session) throws Exception {
		ModelAndView modelAndView = new ModelAndView("/purchase/viewCart.jsp");
		
		User user = (User)session.getAttribute("user");
		Search search = new Search();
		search.setUserId(user.getUserId());
		List<Product> productList = purchaseService.getCartView(search);
		
		/// 6.JSP�� ����� �ϱ����� ������
		// searchOptionList ����
		List<String> searchOptionList = new Vector<String>();
		searchOptionList.add("��ǰ��ȣ");
		searchOptionList.add("��ǰ��");
		searchOptionList.add("��ǰ����");

		// title ����
		String title = "��ٱ���";

		// colum ����
		List<String> columList = new ArrayList<String>();
		columList.add("No");
		columList.add("��ǰ��ȣ");
		columList.add("��ǰ��");
		columList.add("����");
		columList.add("���ż���");
		columList.add("����");

		// UnitList ����
		List unitList = makeProductList(productList);

		// ����� ���� Obejct��

		modelAndView.addObject("title", title);
		modelAndView.addObject("columList", columList);
		modelAndView.addObject("unitList", unitList);

		List<Product> prodList = productList;
		String prodNoList = null;
		if (prodList != null && prodList.size() > 0) {
			prodNoList = String.valueOf(prodList.get(0).getProdNo());
			for (int i = 1; i < prodList.size(); i++) {
				prodNoList += "," + String.valueOf(prodList.get(i).getProdNo());
			}
			modelAndView.addObject("prodNoList", prodNoList);
		}
		
		modelAndView.addObject("user",user);
		modelAndView.addObject("checkboxOn",true);
		
		return modelAndView;
	}
	
	@RequestMapping("deleteCart")
	public void deleteCart(@RequestParam("prodNo") int prodNo,HttpSession session) throws Exception {
		Search search = new Search();
		search.setUserId(((User)session.getAttribute("user")).getUserId());
		search.setProdNo(prodNo);
				
		purchaseService.deleteCart(search);
	}
	

	
	@RequestMapping("addPurchaseByCart")
	public void addPurchaseByCart(@ModelAttribute("purchase") Purchase purchase,@RequestParam("jsonData") String jsonData,
			HttpSession session) throws Exception{
		System.out.println(purchase);
		System.out.println(jsonData);
		
//		JSONArray jsonObject = (JSONArray)JSONValue.parse(jsonData);
//		System.out.println("jsonObject : " + jsonObject);
//		
		ObjectMapper objectMapper = new ObjectMapper();
		List<Product> list = objectMapper.readValue(jsonData, new TypeReference<List<Product>>() {});
		
		System.out.println("list : " + list);
		User user = (User)session.getAttribute("user");
		purchase.setBuyer(user);
		
		List<Purchase> purchaseList = new ArrayList<Purchase>();
		for(int i = 0; i < list.size(); i++) {
			purchase.setPurchaseProd(list.get(i));
			purchaseList.add(purchase.clone());
		}
	
		purchaseService.addPurchaseByCart(purchaseList);
	}
	
	private List makeProductList(List<Product> productList) {
		List<List> unitList = new Vector<List>();
		List<String> UnitDetail = null;
		
		for (int i = 0; i < productList.size(); i++) {
			System.out.println(productList.get(i));
			UnitDetail = new Vector<String>();
			//1.��ǰ ���� ��ȣ
			UnitDetail.add(String.valueOf(i + 1));
			//2.��ǰ ��ȣ
			UnitDetail.add(String.valueOf(productList.get(i).getProdNo()));
			//3.��ǰ �̸�
			UnitDetail.add(productList.get(i).getProdName());
			//4.��ǰ ����
			UnitDetail.add(String.valueOf(productList.get(i).getPrice()));
			//5.���� ����
			UnitDetail.add(String.valueOf(productList.get(i).getStock()));
			//6.��ٱ��� ����
			UnitDetail.add("<img src='../images/trash.png'/>");
			
			//1~6������ ���� ������� ����Ʈ�� ����
			unitList.add(UnitDetail);
		}
		return unitList;
	}
	
	private List makePurchaseList(int currentPage, List<Purchase> purchaseList, User user) {

		List<List> unitList = new Vector<List>();
		List<String> UnitDetail = null;
		for(int i =0; i<purchaseList.size();i++) {
			UnitDetail = new Vector<String>();
			
			String updatePurchaseTag = "<a href='/purchase/getPurchase?tranNo="+purchaseList.get(i).getTranNo()+"'>";
			String aTagEnd = "</a>";
//			UnitDetail.add(updatePurchaseTag + String.valueOf(i+1) + aTagEnd);
			UnitDetail.add(String.valueOf(i+1));
			
			UnitDetail.add(purchaseList.get(i).getBuyer().getUserId());
			
			String updateProductTagStart = "<a href='/product/getProduct?prodNo="+purchaseList.get(i).getPurchaseProd().getProdNo()+"'>";
//			UnitDetail.add(updateProductTagStart + purchaseList.get(i).getPurchaseProd().getProdName() + aTagEnd);
			UnitDetail.add(purchaseList.get(i).getPurchaseProd().getProdName());
			UnitDetail.add(String.valueOf(purchaseList.get(i).getQuantity()));
			
			//tranCode�� ���� ���°�
			switch(purchaseList.get(i).getTranCode()) {
			case "0":
				UnitDetail.add("�������");
				break;
			case "1":
				UnitDetail.add("����غ���");
				break;
			case "2":
				UnitDetail.add("�����");
				break;
			case "3":
				UnitDetail.add("�ŷ��Ϸ�");
				break;
			}
			//������� ��쿡�� ����Ϸ� ǥ��
			if(user.getRole().equals("admin") && purchaseList.get(i).getTranCode().equals("1")) {
				UnitDetail.add("<a>������</a>");
			}
			if(user.getRole().equals("user") && purchaseList.get(i).getTranCode().equals("2")) {
				UnitDetail.add("<a>����Ȯ��</a>");
			}
			if(purchaseList.get(i).getTranCode().equals("3")) {
				Map<String,String> map = new HashMap<String,String>();
				map.put("valueColum", "title");
				map.put("colum", "tran_no");
				map.put("tableName", "review");
				map.put("value", String.valueOf(purchaseList.get(i).getTranNo()));
				if(utilService.validationCheck(map)) {
					UnitDetail.add("<a>�����ۼ�</a>");
				}else {
					UnitDetail.add("<a>����Ȯ��</a>");
				}
				
				
			}
			//�ش� tranNo�� ���䰡 �ۼ��Ǿ��ִ��� Ȯ���ϰ� ���ٸ� �����ۼ�,�ִٸ� ���亸��
			unitList.add(UnitDetail);
		}
		
		return unitList;
	}
}

