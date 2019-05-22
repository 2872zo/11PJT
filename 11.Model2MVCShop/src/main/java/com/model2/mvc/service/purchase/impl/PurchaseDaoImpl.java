package com.model2.mvc.service.purchase.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDao")
public class PurchaseDaoImpl implements PurchaseDao{
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession)  throws Exception{
		this.sqlSession = sqlSession;
	}

	public PurchaseDaoImpl()  throws Exception{
		System.out.println(this.getClass());
	}
	
	@Override
	public int addPurchase(Purchase purchase)  throws Exception{
		return (sqlSession.insert("PurchaseMapper.addPurchase", purchase)==1 && sqlSession.update("ProductStockMapper.decreaseStock",purchase)==1)?1:0;
	}

	@Override
	public Purchase getPurchase(int tranNo)  throws Exception{
		return sqlSession.selectOne("PurchaseMapper.getPurchase", tranNo);
	}

	@Override
	public int updatePurchase(Purchase purchase)  throws Exception{
		return sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}
	
	@Override
	public int updateTranCode(Purchase purchase) throws Exception {
		return sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}

	@Override
	public int deletePurchase(int tranNo) throws Exception {
		return sqlSession.delete("PurchaseMapper.deletePurchase", tranNo);
	}

	@Override
	public List<Purchase> getPurchaseList(Search search) throws Exception {
		return sqlSession.selectList("PurchaseMapper.getPurchaseList", search);
	}

	@Override
	public int makeTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.makeTotalCount", search);
	}

	@Override
	public int cancelTranCode(Purchase purchase) throws Exception {
		return sqlSession.update("ProductStockMapper.cancelPurchase", purchase);
	}

	public List<Product> getCartView(Search search) throws Exception {
		return sqlSession.selectList("CartMapper.getCart",search);
	}

	@Override
	public void deleteCart(Search search) throws Exception {
		System.out.println(sqlSession.delete("CartMapper.deleteCart",search));		
	}

	@Override
	public void addCart(Search search) throws Exception {
		System.out.println(sqlSession.insert("CartMapper.addCart",search));		
		
	}

	@Override
	public void addPurchaseByCart(List<Purchase> purchaseList) throws Exception {
		System.out.println(sqlSession.insert("PurchaseMapper.addPurchaseByCart",purchaseList));
	}
}
