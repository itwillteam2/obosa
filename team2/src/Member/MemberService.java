package Member;

import java.util.List;

import Order.OrderDAO;
import Order.OrderVO;

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
	
	public List<OrderVO> orderList(String id) {
		OrderDAO orderDAO = new OrderDAO();
		List<OrderVO> orderList = orderDAO.orderList(id);
		return orderList;
	}

	public OrderVO orderDetail(String id, int num) {
		OrderDAO orderDAO = new OrderDAO();
		OrderVO orderVO = orderDAO.orderDetail(id, num);
		return orderVO;
	}

	public MemberVO findSeller(String sellerName) {
		MemberVO vo = new MemberVO();
		vo = memberDAO.findSeller(sellerName);
		return vo;
	}
	
}
