package com.model2.mvc.service.domain;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class Purchase implements Cloneable{
	
	private int tranNo;
	private Product purchaseProd;
	private User buyer;
	private String paymentOption;
	private String receiverName;
	private String receiverPhone;
	private String phone1;
	private String phone2;
	private String phone3;
	private String dlvyAddr;
	private String zoneCode;
	private String firstAddress;
	private String secondAddress;
	private String dlvyRequest;
	private String tranCode;
	private Date orderDate;
	private String dlvyDate;
	private int quantity;
	
	public Purchase(){
	}
	
	public User getBuyer() {
		return buyer;
	}
	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}
	public String getDlvyAddr() {
		if(this.zoneCode != null && this.firstAddress != null && this.secondAddress != null) {
			return this.zoneCode+","+this.firstAddress+","+this.secondAddress;
		}else {
			return dlvyAddr;
		}
	}
	public void setDlvyAddr(String dlvyAddr) {
		if(dlvyAddr != null) {
			String[] stringArray = dlvyAddr.split(",");
			if(stringArray.length > 1) {
				setZoneCode(stringArray[0]);
				setFirstAddress(stringArray[1]);
				setSecondAddress(stringArray[2]);
			}else {
				this.dlvyAddr = dlvyAddr;
			}
		}
	}
	public String getDlvyDate() {
		return dlvyDate;
	}
	public void setDlvyDate(String dlvyDate) {
		this.dlvyDate = (dlvyDate!=null && dlvyDate.length()>10?dlvyDate.substring(0, 11):dlvyDate);
	}
	public String getDlvyRequest() {
		return dlvyRequest;
	}
	public void setDlvyRequest(String dlvyRequest) {
		this.dlvyRequest = dlvyRequest;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public String getPaymentOption() {
		return paymentOption;
	}
	public void setPaymentOption(String paymentOption) {
		this.paymentOption = paymentOption != null ? paymentOption.trim() : paymentOption;
	}
	public Product getPurchaseProd() {
		return purchaseProd;
	}
	public void setPurchaseProd(Product purchaseProd) {
		this.purchaseProd = purchaseProd;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getReceiverPhone() {
		if(this.phone1 != null && this.phone2 != null && this.phone3 != null) {
			return this.phone1+","+this.phone2+","+this.phone3;
		}else {
			return receiverPhone;
		}
	}
	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}
	public String getTranCode() {
		return tranCode;
	}
	public void setTranCode(String tranCode) {
		this.tranCode = tranCode.trim();
	}
	public int getTranNo() {
		return tranNo;
	}
	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public String getZoneCode() {
		return zoneCode;
	}

	public String getFirstAddress() {
		return firstAddress;
	}

	public String getSecondAddress() {
		return secondAddress;
	}

	public void setZoneCode(String zoneCode) {
		this.zoneCode = zoneCode;
	}

	public void setFirstAddress(String firstAddress) {
		this.firstAddress = firstAddress;
	}

	public void setSecondAddress(String secondAddress) {
		this.secondAddress = secondAddress;
	}
	
	public String getPhone1() {
		return phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public String getPhone3() {
		return phone3;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}

	@Override
	public String toString() {
		return "Purchase [tranNo=" + tranNo + ", purchaseProd=" + purchaseProd + ", buyer=" + buyer + ", paymentOption="
				+ paymentOption + ", receiverName=" + receiverName + ", receiverPhone=" + receiverPhone + ", dlvyAddr="
				+ dlvyAddr + ", zoneCode=" + zoneCode + ", firstAddress=" + firstAddress + ", secondAddress="
				+ secondAddress + ", dlvyRequest=" + dlvyRequest + ", tranCode=" + tranCode + ", orderDate=" + orderDate
				+ ", dlvyDate=" + dlvyDate + ", quantity=" + quantity + "]";
	}
	
	public List<String> toList() {
		String paymentString = null;
		System.out.println("paymentOption : " + paymentOption);
		switch(paymentOption) {
			case "0" :
				paymentString = "���ݱ���";
				break;
			case "1" :
				paymentString = "�ſ뱸��";
				break;
		}
		
		List<String> purchaseList = new ArrayList<String>();
		purchaseList.add("���� �� ��ȸ");
		purchaseList.add("��ǰ��ȣ,"+purchaseProd.getProdNo());
		purchaseList.add("�����ھ��̵�,"+buyer.getUserId());
		purchaseList.add("���Ź��,"+paymentString);
		purchaseList.add("�������̸�,"+receiverName);
		
		if(receiverPhone != null) {
			purchaseList.add("�����ڿ���ó,"+receiverPhone);
		}else {
			purchaseList.add("�����ڿ���ó,"+phone1+phone2+phone3);
		}
		
		if(dlvyAddr != null) {
			purchaseList.add("�������ּ�,"+dlvyAddr);
		}else {
			purchaseList.add("�������ּ�,�����ȣ :"+zoneCode+"<br/>"+"�ּ� : " + firstAddress + " " + secondAddress);
		}
		purchaseList.add("���ſ�û����,"+dlvyRequest);
		purchaseList.add("��������,"+dlvyDate);
		purchaseList.add("���� ����,"+quantity);
		purchaseList.add("�ֹ���,"+orderDate);
		
		return purchaseList;
	}
	
	@Override
	public Purchase clone() throws CloneNotSupportedException { // public ���� �ٲ�����.
		return (Purchase) super.clone();
	}
}