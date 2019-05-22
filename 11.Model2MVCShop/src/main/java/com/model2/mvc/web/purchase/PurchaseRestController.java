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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
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

	public PurchaseRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value="json/addPurchase")
	public boolean addPurchase(@RequestBody Purchase purchase) throws Exception {
		return purchaseService.addPurchase(purchase)==1;
	}
	
	@RequestMapping("json/getPurchase")
	public Purchase getPurchase(@RequestBody int tranNo) throws Exception {
		return purchaseService.getPurchase(tranNo);
	}
	
	@RequestMapping(value="json/listPurchase")
	public Map<String,Object> getPurchaseList(@RequestBody Search search) throws Exception {
		return purchaseService.getPurchaseList(search);
	}

	
	@RequestMapping("json/updatePurchase")
	public boolean updatePurchase(@RequestBody Purchase purchase) throws Exception {
		return purchaseService.updatePurchase(purchase)==1;
	}
	
	@RequestMapping("json/updateTranCode")
	public boolean updateTranCode(@RequestBody Purchase purchase) throws Exception{		
		return purchaseService.updateTranCode(purchase)==1;
	}
	
	@RequestMapping("json/updateTranCodeByProd")
	public boolean updateTranCodeByProd(@RequestBody Purchase purchase) throws Exception{		
		return purchaseService.updateTranCode(purchase)==1;
	}
	
	@RequestMapping("json/cancelPurchase")
	public boolean cancelPurchase(@RequestParam("tranNo") int tranNo) throws Exception {
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode("0");

		return purchaseService.updateTranCode(purchase)==1; 
	}
	
	private List makePurchaseList(int currentPage, List<Purchase> purchaseList, User user) {

		List<List> unitList = new Vector<List>();
		List<String> UnitDetail = null;
		for(int i =0; i<purchaseList.size();i++) {
			UnitDetail = new Vector<String>();
			
			String aTag = "<a href='/purchase/getPurchase?tranNo="+purchaseList.get(i).getTranNo()+"'>";
			String aTagEnd = "</a>";
			UnitDetail.add(aTag + String.valueOf(i+1) + aTagEnd);
			
			String getUserTagStart = "<a href='/user/getUser?userId="+user.getUserId()+"'>";
			String getUserTagEnd = "</a>";
			UnitDetail.add(getUserTagStart + purchaseList.get(i).getBuyer().getUserId() + getUserTagEnd);
			
			UnitDetail.add(purchaseList.get(i).getReceiverName() != null? purchaseList.get(i).getReceiverName():"");
			UnitDetail.add(purchaseList.get(i).getReceiverPhone() != null? purchaseList.get(i).getReceiverPhone():"");
			
			//tranCode에 따른 상태값
			switch(purchaseList.get(i).getTranCode()) {
			case "0":
				UnitDetail.add("구매취소");
				break;
			case "1":
				UnitDetail.add("배송준비중");
				break;
			case "2":
				UnitDetail.add("배송중");
				break;
			case "3":
				UnitDetail.add("거래완료");
				break;
			}
			//배송중인 경우에만 수취완료 표기
			if(purchaseList.get(i).getTranCode().equals("2")) {
				UnitDetail.add("<a href='javascript:fncUpdatePurchaseCode(" + currentPage + "," + purchaseList.get(i).getTranNo() + ");'>" + "수취확인</a>");
			}
			unitList.add(UnitDetail);
		}
		
		return unitList;
	}
}

