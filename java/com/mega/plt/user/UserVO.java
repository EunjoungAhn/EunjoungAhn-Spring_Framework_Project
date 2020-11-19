package com.mega.plt.user;

public class UserVO {
	private String uID;
	private String name;
	private String password;
	private String address;
	private String phone;
	
	public UserVO() {
		super();
	}
	
	public UserVO(String uID, String name, String password, String address, String phone) {
		super();
		this.uID = uID;
		this.name = name;
		this.password = password;
		this.address = address;
		this.phone = phone;
	}

	public String getuID() {
		return uID;
	}
	public void setuID(String uID) {
		this.uID = uID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Override
	public String toString() {
		return "UserVO [uID=" + uID + ", name=" + name + ", password=" + password + ", address=" + address + ", phone="
				+ phone + "]";
	}
}
