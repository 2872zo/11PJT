package com.model2.mvc.service.domain;

import java.sql.Date;
import java.util.List;
import java.util.Vector;

public class Review {

	///Field
	private int reviewNo;
	private int tranNo;
	private int prodNo;
	private String userId;
	private String title;
	private String text;
	private String fileName;
	private int rating;
	private Date regDate;
	
	///Constructor
	public Review() {
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getProdNo() {
		return prodNo;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	public int getTranNo() {
		return tranNo;
	}

	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}

	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", prodNo=" + prodNo + ", userId=" + userId + ", title=" + title
				+ ", text=" + text + ", fileName=" + fileName + ", rating=" + rating + ", regDate=" + regDate + "]";
	}
	
}