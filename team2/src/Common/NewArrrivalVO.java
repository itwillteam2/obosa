package Common;

import java.sql.Timestamp;

public class NewArrrivalVO {

	private int num;
	private String productImageName1;
	private String productName;
	private String productPrice;
	private Timestamp regdate;
	private String category;
	
	public NewArrrivalVO() {
		
	}

	public NewArrrivalVO(int num, String productImageName1, String productName, String productPrice, Timestamp regdate,
			String category) {
		super();
		this.num = num;
		this.productImageName1 = productImageName1;
		this.productName = productName;
		this.productPrice = productPrice;
		this.regdate = regdate;
		this.category = category;
	}

	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getProductImageName1() {
		return productImageName1;
	}
	public void setProductImageName1(String productImageName1) {
		this.productImageName1 = productImageName1;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(String productPrice) {
		this.productPrice = productPrice;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	
}
