package Member;

public class MemberService{

	MemberDAO memberDAO = new MemberDAO();
	
	public void addCustomer(MemberVO vo) {
		memberDAO.addCustomer(vo);
	}
	
	public void addSeller(MemberVO vo) {
		memberDAO.addSeller(vo);
	}
	
	public boolean login(MemberVO vo){
		boolean check = false;
		check = memberDAO.login(vo);
		return check;
	}
	
	public MemberVO searchUser(String id){
		MemberVO vo = new MemberVO();
		vo = memberDAO.searchUser(id);
		return vo;
	}
	
	public void modCustomer(MemberVO vo){
		memberDAO.modCustomer(vo);
	}
	
	public void modSeller(MemberVO vo){
		memberDAO.modSeller(vo);
	}

	public void modPwd(String id, String pwd) {
		memberDAO.modPwd(id, pwd);
	}

	public Boolean findPwd(String id, String name, String email) {
		Boolean check = memberDAO.findPwd(id, name, email);
		return check;
	}

	public String findIdByCpnum(String name, String cpnum) {
		String id = memberDAO.findIdByCpnum(name, cpnum);
		return id;
	}

	public String findIdByEmail(String name, String email) {
		String id = memberDAO.findIdByEmail(name, email);
		return id;
	}

	public void delete(String id) {
		memberDAO.delete(id);
	}
	
	public void addPoint(String id, int point){
		memberDAO.addPoint(id, point);
	}
}
