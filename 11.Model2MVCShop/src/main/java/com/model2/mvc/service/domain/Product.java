package com.model2.mvc.service.domain;

import java.sql.Date;
import java.util.List;
import java.util.Vector;

public class Product {

	///Field
	private int prodNo;
	private String prodName;
	private String prodDetail;
	private int price;
	private String manuDate;
	private Date regDate;
	private String fileName;
	private String proTranCode;
	private int stock;
	private int tranCount;

	///Constructor
	public Product() {
	}

	///Method
	public String getProTranCode() {
		return (proTranCode != null) ? proTranCode.trim() : proTranCode;
	}

	public void setProTranCode(String proTranCode) {
		this.proTranCode = proTranCode;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getManuDate() {
		return manuDate;
	}

	public void setManuDate(String manuDate) {
		this.manuDate = manuDate;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getProdDetail() {
		return prodDetail;
	}

	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public int getProdNo() {
		return prodNo;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}
	
	public int getTranCount() {
		return tranCount;
	}

	public void setTranCount(int tranCount) {
		this.tranCount = tranCount;
	}

	@Override
	public String toString() {
		return "Product [prodNo=" + prodNo + ", prodName=" + prodName + ", prodDetail=" + prodDetail + ", price="
				+ price + ", manuDate=" + manuDate + ", regDate=" + regDate + ", fileName=" + fileName
				+ ", proTranCode=" + proTranCode + ", stock=" + stock + " ]";
	}

	public List<String> toList() {
		List<String> productList = new Vector<String>();
		productList.add("��ǰ �� ��ȸ");
		productList.add("��ǰ��ȣ,"+prodNo);
		productList.add("��ǰ��,"+prodName);
		productList.add("��ǰ�̹���,"+(fileName != null?"<img src='../images/uploadFiles/"+fileName+"'/>":"<img src='http://placehold.it/400x400'/>"));
		productList.add("��ǰ������,"+prodDetail);
		productList.add("��������,"+manuDate);
		productList.add("����,"+price);
		productList.add("�������,"+regDate);
		productList.add("���,"+stock);
		return productList;
	}
	
}