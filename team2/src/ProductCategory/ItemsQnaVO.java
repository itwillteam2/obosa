package ProductCategory;

import java.sql.Timestamp;

public class ItemsQnaVO {
	private int qnum; 
	private int num; 
	private String pw;
	private String content; 
	
	public ItemsQnaVO() {
	
	}
	
	public ItemsQnaVO(int qnum, int num, String pw, String content, String writer, Timestamp date) {
		this.qnum = qnum;
		this.num = num;
		this.pw = pw;
		this.content = content;
		this.writer = writer;
		this.date = date;
	}
	public int getQnum() {
		return qnum;
	}
	public void setQnum(int qnum) {
		this.qnum = qnum;
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
	private String writer; 
	private Timestamp date;
}
