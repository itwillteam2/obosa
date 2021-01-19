package Crafts;

import java.sql.Timestamp;

public class CraftsJoinVO {
	private int qnum;
	private String title;
	private String content;
	private String writer;
	private Timestamp date;
	private int qrnum;
	private String rcontent;
	private int complete;
	
	public CraftsJoinVO() {
		
	}
	
	public CraftsJoinVO(int qnum, String title, String content, String writer, Timestamp date, int qrnum,
			String rcontent, int complete) {
		this.qnum = qnum;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.date = date;
		this.qrnum = qrnum;
		this.rcontent = rcontent;
		this.complete = complete;
	}



	public int getQnum() {
		return qnum;
	}
	public void setQnum(int qnum) {
		this.qnum = qnum;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getQrnum() {
		return qrnum;
	}
	public void setQrnum(int qrnum) {
		this.qrnum = qrnum;
	}
	public String getRcontent() {
		return rcontent;
	}
	public void setRcontent(String rcontent) {
		this.rcontent = rcontent;
	}
	public int getComplete() {
		return complete;
	}
	public void setComplete(int complete) {
		this.complete = complete;
	}
	
}
