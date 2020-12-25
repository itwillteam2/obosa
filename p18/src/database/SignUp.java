package database;

public class SignUp {
	private String id2;
	private String pw2;
	private String name2;
	private String address2;
	
	public SignUp(){
		
	}
	public SignUp(String id2, String pw2, String name2, String address2){
		this.id2 = id2;
		this.pw2 = pw2;
		this.name2 = name2;
		this.address2 = address2;
	}
	public SignUp(String pw2, String name2, String address2){
		this.pw2 = pw2;
		this.name2 = name2;
		this.address2 = address2;
	}
	
	public String getId2() {
		return id2;
	}
	public void setId2(String id2) {
		this.id2 = id2;
	}
	public String getPw2() {
		return pw2;
	}
	public void setPw2(String pw2) {
		this.pw2 = pw2;
	}
	public String getName2() {
		return name2;
	}
	public void setName2(String name2) {
		this.name2 = name2;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}

}
