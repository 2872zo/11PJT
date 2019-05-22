package com.model2.mvc.web.purchase;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

//@Controller
public class PurchaseControllerString {
	@Autowired
	@Qualifier("purchaseService")
	PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productService")
	ProductService productService;

	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	public PurchaseControllerString() {
		System.out.println(this.getClass());
	}

	@RequestMapping("/addPurchase.do")
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase, HttpSession session, @RequestParam("prodNo") int prodNo) throws Exception {
		User user = (User) session.getAttribute("user");
		Product product = new Product();
		product.setProdNo(prodNo);
		
		//puchase ����
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setTranCode("1");
		
		//����
		purchaseService.addPurchase(purchase);
		
		
		return "forward:/purchase/confirmPurchase.jsp";
	}
	
	@RequestMapping("/addPurchaseView.do")
	public String addPurchaseView(@RequestParam("prodNo") int prodNo,Map<String,Object> resultMap) throws Exception {		
		Product product = null;
		System.out.println("�� : " + product);
		product = productService.getProduct(prodNo);
		System.out.println("�� : " + product);	
		
		resultMap.put("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}

	@RequestMapping("/getPurchase.do")
	public String getPurchase(@RequestParam("tranNo") int tranNo, Map<String,Object> map) throws Exception {
		System.out.println("\n==>getPurchase Start.........");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
				
		List<String> purchaseList = purchase.toList();
		
		map.put("list", purchaseList);
		map.put("purchase", purchase);
		
		System.out.println("getPurchaseAction�� getTranCode�� : "+purchase.getTranCode());
		
		System.out.println("\n==>getPurchase End.........");
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	@RequestMapping(value="/listPurchase.do")
	public String getPurchaseList(@RequestParam(value = "page", defaultValue = "1") int page, 
								  @RequestParam(value = "currentPage", defaultValue= "1") int currentPage,
								  HttpServletRequest request,
								  Map<String, Object> resultMap,	HttpSession session) throws Exception {
		
		System.out.println("\n==>listPurchase Start.........");
		
		if(request.getMethod().equals("GET")) {
			currentPage = page;
		}
		
		
				
		User user = (User)session.getAttribute("user");		

		//3.DB ������ ���� search
		Search search = new Search();
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
		columList.add("ȸ����");
		columList.add("��ȭ��ȣ");
		columList.add("�ŷ�����");
		columList.add("��������");
		
		//UnitList ����
		List unitList = makePurchaseList(currentPage, (List<Purchase>)map.get("list"), user);
		
		
		//����� ���� Object
		resultMap.put("title", title);
		resultMap.put("columList", columList);
		resultMap.put("unitList", unitList);
		resultMap.put("resultPage", resultPage);

		System.out.println("\n==>listPurchase End.........");
		
		return "forward:/purchase/listPurchase.jsp";
	}

	
	@RequestMapping("/updatePurchase.do")
	public String updatePurchase(@ModelAttribute Purchase purchase, Map<String,Object> map) throws Exception {
		System.out.println("\n==>updatePurchase Start.........");
			
		purchaseService.updatePurchase(purchase);
		map.put("tranNo", purchase.getTranNo());
		
		System.out.println("\n==>updatePurchase End.........");
		
		return "forward:/getPurchase.do?";
	}

	@RequestMapping("/updatePurchaseView.do")
	public String updatePurchaseView(@RequestParam("tranNo") int tranNo, Map<String, Object> map) throws Exception {
		Purchase purchase = purchaseService.getPurchase(tranNo);

		map.put("purchase", purchase);

		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
	@RequestMapping("/updateTranCode.do")
	public String updateTranCode(@RequestParam("tranCode") String tranCode, @RequestParam("tranNo") int tranNo) throws Exception{
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);

		System.out.println(purchase);
		
		purchaseService.updateTranCode(purchase);

		return "forward:/listPurchase.do?";
	}
	
	@RequestMapping("/updateTranCodeByProd.do")
	public String updateTranCodeByProd(Map<String,Object> resultMap,@RequestParam("prodNo") int prodNo, 
			@RequestParam("tranCode") String tranCode, @RequestParam("page") String page,
			@RequestParam("menu") String menu, Search search) throws Exception{		
		Product product = new Product();
		Purchase purchase = new Purchase();
		product.setProdNo(prodNo);
		purchase.setPurchaseProd(product);
		purchase.setTranCode(tranCode);

		purchaseService.updateTranCode(purchase);

		resultMap.put("page", page);
		resultMap.put("tranCode", tranCode);
		resultMap.put("menu", menu);
		if(search.getSearchCondition() != null) {
			resultMap.put("searchCondition", search.getSearchCondition());
			resultMap.put("searchKeyword", search.getSearchKeyword());
		}
		
		return "forward:/listProduct.do?";
	}
	
	@RequestMapping("/cancelPurchase.do")
	public String cancelPurchase(@RequestParam("tranNo") int tranNo) throws Exception {
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode("0");

		purchaseService.updateTranCode(purchase);

		return "forward:/listPurchase.do";
	}
	
	private List makePurchaseList(int currentPage, List<Purchase> purchaseList, User user) {

		List<List> unitList = new Vector<List>();
		List<String> UnitDetail = null;
		for(int i =0; i<purchaseList.size();i++) {
			UnitDetail = new Vector<String>();
			
			String aTag = "<a href='/getPurchase.do?tranNo="+purchaseList.get(i).getTranNo()+"'>";
			String aTagEnd = "</a>";
			UnitDetail.add(aTag + String.valueOf(i+1) + aTagEnd);
			
			String getUserTagStart = "<a href='/getUser.do?userId="+user.getUserId()+"'>";
			String getUserTagEnd = "</a>";
			UnitDetail.add(getUserTagStart + purchaseList.get(i).getBuyer().getUserId() + getUserTagEnd);
			
			UnitDetail.add(purchaseList.get(i).getReceiverName() != null? purchaseList.get(i).getReceiverName():"");
			UnitDetail.add(purchaseList.get(i).getReceiverPhone() != null? purchaseList.get(i).getReceiverPhone():"");
			
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
			if(purchaseList.get(i).getTranCode().equals("2")) {
				UnitDetail.add("<a href='javascript:fncUpdatePurchaseCode(" + currentPage + "," + purchaseList.get(i).getTranNo() + ");'>" + "����Ȯ��</a>");
			}
			unitList.add(UnitDetail);
		}
		
		return unitList;
	}
}

