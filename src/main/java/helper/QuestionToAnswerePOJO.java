package helper;

public class QuestionToAnswerePOJO {
	int question_id;
	String question_statement;
	String question_img;
	int answer_id;
	String answer_statement;
	int selected_option_id;
	String selected_option_statement;

	public QuestionToAnswerePOJO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getQuestion_img() {
		return question_img;
	}

	public void setQuestion_img(String question_img) {
		this.question_img = question_img;
	}

	public String getQuestion_statement() {
		return question_statement;
	}

	public void setQuestion_statement(String question_statement) {
		this.question_statement = question_statement;
	}

	public String getAnswer_statement() {
		return answer_statement;
	}

	public void setAnswer_statement(String answer_statement) {
		this.answer_statement = answer_statement;
	}

	public int getSelected_option_id() {
		return selected_option_id;
	}

	public void setSelected_option_id(int selected_option_id) {
		this.selected_option_id = selected_option_id;
	}

	public String getSelected_option_statement() {
		return selected_option_statement;
	}

	public void setSelected_option_statement(String selected_option_statement) {
		this.selected_option_statement = selected_option_statement;
	}

	public int getQuestion_id() {
		return question_id;
	}

	public void setQuestion_id(int question_id) {
		this.question_id = question_id;
	}

	public int getAnswer_id() {
		return answer_id;
	}

	public void setAnswer_id(int answer_id) {
		this.answer_id = answer_id;
	}

}
