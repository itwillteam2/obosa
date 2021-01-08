package CsCenter;

public class InqRepVO {
	private int repnum;
	private String pw;
	private String content;
	private int inqnum;
	
	public InqRepVO() {
		
	}
	
	public InqRepVO(int repnum, String pw, String content, int inqnum) {
		this.repnum = repnum;
		this.pw = pw;
		this.content = content;
		this.inqnum = inqnum;
	}
	
	public int getRepnum() {
		return repnum;
	}
	public void setRepnum(int repnum) {
		this.repnum = repnum;
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
	public int getInqnum() {
		return inqnum;
	}
	public void setInqnum(int inqnum) {
		this.inqnum = inqnum;
	}
	
	

}
