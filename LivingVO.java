package Living;

import java.sql.Timestamp;

public class LivingVO {

	private int num;
	private String product_name;
	private String living_content;
	private String seller;
	private int sellingprice;
	private String photo_name;
	private int order_qty;
	private int shipping_fee;
	private int point;
	private Timestamp reg_date;
	
	public LivingVO() {
	
	}

	public LivingVO(int num, String product_name, String living_content, String seller, int sellingprice,
			String photo_name, int order_qty, int shipping_fee, int point) {
		
		this.num = num;
		this.product_name = product_name;
		this.living_content = living_content;
		this.seller = seller;
		this.sellingprice = sellingprice;
		this.photo_name = photo_name;
		this.order_qty = order_qty;
		this.shipping_fee = shipping_fee;
		this.point = point;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getLiving_content() {
		return living_content;
	}

	public void setLiving_content(String living_content) {
		this.living_content = living_content;
	}

	public String getSeller() {
		return seller;
	}

	public void setSeller(String seller) {
		this.seller = seller;
	}

	public int getSellingprice() {
		return sellingprice;
	}

	public void setSellingprice(int sellingprice) {
		this.sellingprice = sellingprice;
	}

	public String getPhoto_name() {
		return photo_name;
	}

	public void setPhoto_name(String photo_name) {
		this.photo_name = photo_name;
	}

	public int getOrder_qty() {
		return order_qty;
	}

	public void setOrder_qty(int order_qty) {
		this.order_qty = order_qty;
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
