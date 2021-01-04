package CsCenter;

import java.sql.Timestamp;

public class NoticeVO {
	private int nnum;
	private String title;
	private String content;
	private Timestamp date;
	
	public NoticeVO() {
		
	}

	public NoticeVO(int nnum, String title, String content, Timestamp date) {
		this.nnum = nnum;
		this.title = title;
		this.content = content;
		this.date = date;
	}



	public int getNnum() {
		return nnum;
	}
	public void setNnum(int nnum) {
		this.nnum = nnum;
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
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	
	
	
}
