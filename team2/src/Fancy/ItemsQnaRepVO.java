package Fancy;

public class ItemsQnaRepVO {
	private int qrnum; 
	private int qnum;
	private String pw;
	private String content;
	private int complete;
	
	public ItemsQnaRepVO() {
		
	}

	public ItemsQnaRepVO(int qrnum, int qnum, String pw, String content, int complete) {
		super();
		this.qrnum = qrnum;
		this.qnum = qnum;
		this.pw = pw;
		this.content = content;
		this.complete = complete;
	}


	public int getQrnum() {
		return qrnum;
	}
	public void setQrnum(int qrnum) {
		this.qrnum = qrnum;
	}
	public int getQnum() {
		return qnum;
	}
	public void setQnum(int qnum) {
		this.qnum = qnum;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public int getComplete() {
		return complete;
	}

	public void setComplete(int complete) {
		this.complete = complete;
	}

	

}
