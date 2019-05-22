package com.model2.mvc.common;

import java.util.Arrays;
/*
 * FileName : Search.java
 *   ㅇ Dynamic SQL 구성시  <foreach> elements 를 이용 반복적 구문생성시 전달되는 
 *       Collection List , Array 갖는 ValueObeject  
  */
public class Search{
	///Field
	private String userId;
	private int prodNo;
	private int currentPage;
	private String searchCondition;
	private String searchKeyword;
	private String[] splitKeyword;
	private int pageSize;
	private int sortCode;
	private boolean hiddingEmptyStock;
	private int endRowNum;
	private int startRowNum;
	
	///Constructor
	public Search() {
	}

	///Method
	public int getCurrentPage() {
		return currentPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public int getPageSize() {
		return pageSize;
	}

	public int getSortCode() {
		return sortCode;
	}

	public boolean isHiddingEmptyStock() {
		return hiddingEmptyStock;
	}
	
	public String[] getSplitKeyword() {
		return splitKeyword;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
		if(searchKeyword != null && searchKeyword.indexOf(",") != -1) {
			splitKeyword = searchKeyword.split(",");
			Arrays.sort(splitKeyword);
		}
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public void setSortCode(int sortCode) {
		this.sortCode = sortCode;
	}

	public void setHiddingEmptyStock(boolean hiddingEmptyStock) {
		this.hiddingEmptyStock = hiddingEmptyStock;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public void setSplitKeyword(String[] splitKeyword) {
		this.splitKeyword = splitKeyword;
	}

	//==> Select Query 시 ROWNUM 마지막 값 
	public int getEndRowNum() {
		return getCurrentPage()*getPageSize();
	}
	//==> Select Query 시 ROWNUM 시작 값
	public int getStartRowNum() {
		return (getCurrentPage()-1)*getPageSize()+1;
	}

	public int getProdNo() {
		return prodNo;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	@Override
	public String toString() {
		return "Search [userId=" + userId + ", prodNo=" + prodNo + ", currentPage=" + currentPage + ", searchCondition="
				+ searchCondition + ", searchKeyword=" + searchKeyword + ", splitKeyword="
				+ Arrays.toString(splitKeyword) + ", pageSize=" + pageSize + ", sortCode=" + sortCode
				+ ", hiddingEmptyStock=" + hiddingEmptyStock +"]";
	}

	
	
	
	
}//end of class