package CsCenter;

import java.sql.Timestamp;

public class InquiryJoinVO {
	private String id;
	private int inqnum;
	private String title;
	private String content;
	private Timestamp date;
	private int repnum;
	private String rcontent;
	
	public InquiryJoinVO() {

	}

	
	
	
	
	public InquiryJoinVO(String id, int inqnum, String title, String content, Timestamp date, int repnum,
			String rcontent) {
		this.id = id;
		this.inqnum = inqnum;
		this.title = title;
		this.content = content;
		this.date = date;
		this.repnum = repnum;
		this.rcontent = rcontent;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getInqnum() {
		return inqnum;
	}
	public void setInqnum(int inqnum) {
		this.inqnum = inqnum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRepnum() {
		return repnum;
	}
	public void setRepnum(int repnum) {
		this.repnum = repnum;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}
	
	

}
