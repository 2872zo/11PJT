package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {
	public int addPurchase(Purchase purchase) throws Exception; 
	
	public Purchase getPurchase(int tranNo) throws Exception;
	
	public int updatePurchase(Purchase purchase) throws Exception;
	
	public int updateTranCode(Purchase purchase) throws Exception;
	
	public int deletePurchase(int tranNo) throws Exception;
	
	public Map<String,Object> getPurchaseList(Search search) throws Exception;

	public int cancelTranCode(Purchase purchase) throws Exception;

	public List<Product> getCartView(Search search) throws Exception;

	public void deleteCart(Search search) throws Exception;

	public void addCart(Search search) throws Exception;

	public void addPurchaseByCart(List<Purchase> purchaseList) throws Exception;
}
