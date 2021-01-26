package Grade;

public class GradeService{

	GradeDAO dao = new GradeDAO();
	
	public void addGrade(String id, int pnum, String category, int rNum, int grade) {
		int result=dao.getGrade(pnum,category,id,rNum);
		if (result>=0) {
			dao.modGrade(id,pnum,category,rNum,grade);
		}else {
			dao.addGrade(id,pnum,category,rNum,grade);	
		}
	}
	
	public int getGradeAvg(int pnum, String category) {
		int result=dao.getGradeAvg(pnum,category);
		return result;
	}
	
	public int getGrade(int pnum, String category, String id, int rNum){
		int result=dao.getGrade(pnum,category,id,rNum);
		return result;
	}
}
