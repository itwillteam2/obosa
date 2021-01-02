package Living;

public class LivingQnaRepVO {
	private int rnum; 
	private int num; 
	private String content; 
	
	public LivingQnaRepVO() {
		
	}
	
	public LivingQnaRepVO(int rnum, int num, String content) {
		super();
		this.rnum = rnum;
		this.num = num;
		this.content = content;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
