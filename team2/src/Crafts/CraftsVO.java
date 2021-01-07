package Crafts;

import java.sql.Timestamp;

public class CraftsVO {
	
	private int CraftsNum;
	private String productName;
	private String productContent;
	private String sellerName;
	private int productPrice;
	private String productImageName1;
	private String productImageName2;
	private String productImageName3;
	private int productQuantity;
	private int shipping_fee;
	private int point;
	private Timestamp reg_date;
	
	public CraftsVO() {
		// TODO Auto-generated constructor stub
	}

	public CraftsVO(int CraftsNum, String productName, String productContent, String sellerName, int productPrice,
			String productImageName1, String productImageName2, String productImageName3, int productQuantity,
			int shipping_fee, int point) {
		
		this.CraftsNum = CraftsNum;
		this.productName = productName;
		this.productContent = productContent;
		this.sellerName = sellerName;
		this.productPrice = productPrice;
		this.productImageName1 = productImageName1;
		this.productImageName2 = productImageName2;
		this.productImageName3 = productImageName3;
		this.productQuantity = productQuantity;
		this.shipping_fee = shipping_fee;
		this.point = point;
	}

	public int getNum() {
		return CraftsNum;
	}

	public void setNum(int num) {
		this.CraftsNum = num;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductContent() {
		return productContent;
	}

	public void setProductContent(String productContent) {
		this.productContent = productContent;
	}

	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public String getProductImageName1() {
		return productImageName1;
	}

	public void setProductImageName1(String productImageName1) {
		this.productImageName1 = productImageName1;
	}

	public String getProductImageName2() {
		return productImageName2;
	}

	public void setProductImageName2(String productImageName2) {
		this.productImageName2 = productImageName2;
	}

	public String getProductImageName3() {
		return productImageName3;
	}

	public void setProductImageName3(String productImageName3) {
		this.productImageName3 = productImageName3;
	}

	public int getProductQuantity() {
		return productQuantity;
	}

	public void setProductQuantity(int productQuantity) {
		this.productQuantity = productQuantity;
	}

	public int getShipping_fee() {
		return shipping_fee;
	}

	public void setShipping_fee(int shipping_fee) {
		this.shipping_fee = shipping_fee;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
	
	

}
