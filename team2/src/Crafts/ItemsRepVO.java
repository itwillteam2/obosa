package Crafts;

import java.sql.Timestamp;

public class ItemsRepVO {
	private int rnum; 
	private int num; 
	private String pw;
	private String content; 
	private String writer; 
	private Timestamp date;
	
	public ItemsRepVO() {
		
	}

	public ItemsRepVO(int rnum, int num, String pw, String content, String writer, Timestamp date) {
		this.rnum = rnum;
		this.num = num;
		this.pw = pw;
		this.content = content;
		this.writer = writer;
		this.date = date;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
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
	
	
}
