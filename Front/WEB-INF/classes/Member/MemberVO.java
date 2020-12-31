package Member;

import java.sql.Date;

//MVC중에 Model의 역할을 하는 클래스 

public class MemberVO {
	
	private String id;
	private String pwd;
	private String businessRegNum;
	private String shopName;
	private String name;
	private String pnum;
	private String cpnum;
	private String email;
	private String postcode;
	private String addr1;
	private String addr2;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getBusinessRegNum() {
		return businessRegNum;
	}
	public void setBusinessRegNum(String businessRegNum) {
		this.businessRegNum = businessRegNum;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPnum() {
		return pnum;
	}
	public void setPnum(String pnum) {
		this.pnum = pnum;
	}
	public String getCpnum() {
		return cpnum;
	}
	public void setCpnum(String cpnum) {
		this.cpnum = cpnum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	
}




