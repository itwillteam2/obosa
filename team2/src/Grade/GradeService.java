package Grade;

public class GradeService{

	GradeDAO dao = new GradeDAO();
	
	public void addGrade(String id, int pnum, String category, int repNum, int grade) {
		dao.addGrade(id,pnum,category,repNum,grade);
	}
	
	public int getGradeAvg(int pnum, String category) {
		int result=dao.getGradeAvg(pnum,category);
		return result;
	}
	
	public int getGrade(int pnum, String category, String id){
		int result=dao.getGrade(pnum,category,id);
		return result;
	}
}
