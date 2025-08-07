package entities;

public class ExamsEvaluation {
	Long student_id;
	int exam_id;
	int correct_answer;
	int wrong_answer;
	int pass_question;
	int isExpelled;

	public ExamsEvaluation() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Long getStudent_id() {
		return student_id;
	}

	public void setStudent_id(Long student_id) {
		this.student_id = student_id;
	}

	public int getExam_id() {
		return exam_id;
	}

	public void setExam_id(int exam_id) {
		this.exam_id = exam_id;
	}

	public int getCorrect_answer() {
		return correct_answer;
	}

	public void setCorrect_answer(int correct_answer) {
		this.correct_answer = correct_answer;
	}

	public int getWrong_answer() {
		return wrong_answer;
	}

	public void setWrong_answer(int wrong_answer) {
		this.wrong_answer = wrong_answer;
	}

	public int getPass_question() {
		return pass_question;
	}

	public void setPass_question(int pass_question) {
		this.pass_question = pass_question;
	}

	public int getIsExpelled() {
		return isExpelled;
	}

	public void setIsExpelled(int isExpelled) {
		this.isExpelled = isExpelled;
	}

}
