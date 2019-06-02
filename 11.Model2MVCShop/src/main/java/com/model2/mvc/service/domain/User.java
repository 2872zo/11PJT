package com.model2.mvc.service.domain;

import java.sql.Date;


//==>회원정보를 모델링(추상화/캡슐화)한 Bean
public class User {
	
	///Field
	private String userId;
	private String userName;
	private String password;
	private String role;
	private String ssn;
	private String phone;
	private String addr;
	private String zoneCode;
	private String firstAddress;
	private String secondAddress;
	private String email;
	private Date regDate;
	/////////////// EL 적용 위해 추가된 Field ///////////
	private String phone1;
	private String phone2;
	private String phone3;
	///////////////////////////////////////////////
	private String kakao;

	
	
	///Constructor
	public User(){
	}
	
	///Method 
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getSsn() {
		return ssn;
	}
	public void setSsn(String ssn) {
		this.ssn = ssn;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
		/////////////// EL 적용 위해 추가 ///////////
		if(phone != null && phone.length() !=0 ){
			phone1 = phone.split("-")[0];
			phone2 = phone.split("-")[1];
			phone3 = phone.split("-")[2];
		}
	}
	public String getAddr() {
		if(this.zoneCode != null && this.firstAddress != null && this.secondAddress != null) {
			return this.zoneCode+","+this.firstAddress+","+this.secondAddress;
		}else {
			return addr;
		}
	}
	
	public void setAddr(String addr) {
		if(addr != null) {
			String[] stringArray = addr.split(",");
			if(stringArray.length > 1) {
				setZoneCode(stringArray[0]);
				setFirstAddress(stringArray[1]);
				setSecondAddress(stringArray[2]);
			}else {
				this.addr = addr;
			}
		}
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	/////////////// EL 적용 위해 추가된 getter Method ///////////
	public String getPhone1() {
		return phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public String getPhone3() {
		return phone3;
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
	
	

	public String getKakao() {
		return kakao;
	}

	public void setKakao(String kakao) {
		this.kakao = kakao;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", password=" + password + ", role=" + role
				+ ", ssn=" + ssn + ", phone=" + phone + ", addr=" + addr + ", zoneCode=" + zoneCode + ", firstAddress="
				+ firstAddress + ", secondAddress=" + secondAddress + ", email=" + email + ", regDate=" + regDate
				+ ", phone1=" + phone1 + ", phone2=" + phone2 + ", phone3=" + phone3 + ", kakao=" + kakao + "]";
	}

}