package com.mega.plt.shop;

public class ProductVO {
	private String pdID;
	private String name;
	private int price;
	private String dsc;
	private String img;
	private int category;
	
	
	public String getPdID() {
		return pdID;
	}
	public void setPdID(String pdID) {
		this.pdID = pdID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDsc() {
		return dsc;
	}
	public void setDsc(String dsc) {
		this.dsc = dsc;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}

}