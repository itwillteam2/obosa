package CsCenter;

import java.sql.Timestamp;

public class InquiryVO {
	
	private int inqnum;
	private String id;
	private String pw;
	private String title;
	private String email;
	private String content;
	private Timestamp date;
	private String category;
	
	public InquiryVO() {

	}
	
	

	public InquiryVO(int inqnum, String id, String pw, String title, String email, String content, Timestamp date,
			String category) {
		this.inqnum = inqnum;
		this.id = id;
		this.pw = pw;
		this.title = title;
		this.email = email;
		this.content = content;
		this.date = date;
		this.category = category;
	}



	public int getInqnum() {
		return inqnum;
	}

	public void setInqnum(int inqnum) {
		this.inqnum = inqnum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	
	
	
	
}
