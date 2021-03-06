package Auction;

import java.sql.Timestamp;

public class AuctionVO {
	
	private int num;
	private String productName;
	private String productContent;
	private String sellerName;
	private int startPrice; //경매시작가격
	private String productImageName1;
	private String productImageName2;
	private String productImageName3;
	private int productQuantity;
	private int shipping_fee;	
	private Timestamp auction_date; //경매기간
	
	public AuctionVO() {
		// TODO Auto-generated constructor stub
	}

	public AuctionVO(int num, String productName, String productContent, String sellerName, int startPrice,
			String productImageName1, String productImageName2, String productImageName3, int productQuantity,
			int shipping_fee) {
		
		this.num = num;
		this.productName = productName;
		this.productContent = productContent;
		this.sellerName = sellerName;
		this.startPrice = startPrice;
		this.productImageName1 = productImageName1;
		this.productImageName2 = productImageName2;
		this.productImageName3 = productImageName3;
		this.productQuantity = productQuantity;
		this.shipping_fee = shipping_fee;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
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

	public int getStartPrice() {
		return startPrice;
	}

	public void setStartPrice(int startPrice) {
		this.startPrice = startPrice;
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

	public Timestamp getAuction_date() {
		return auction_date;
	}

	public void setAuction_date(Timestamp auction_date) {
		this.auction_date = auction_date;
	}
	
	

}
