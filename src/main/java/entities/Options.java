package entities;

public class Options {
	int opt_id;
	int opt_question;
	String opt_text;
	int isAnswer;

	public int getOpt_id() {
		return opt_id;
	}

	public void setOpt_id(int opt_id) {
		this.opt_id = opt_id;
	}

	public int getOpt_question() {
		return opt_question;
	}

	public void setOpt_question(int opt_question) {
		this.opt_question = opt_question;
	}

	public String getOpt_text() {
		return opt_text;
	}

	public void setOpt_text(String opt_text) {
		this.opt_text = opt_text;
	}

	public int getIsAnswer() {
		return isAnswer;
	}

	public void setIsAnswer(int isAnswer) {
		this.isAnswer = isAnswer;
	}

	public Options() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Options( int opt_question, String opt_text, int isAnswer) {
		super();
		this.opt_question = opt_question;
		this.opt_text = opt_text;
		this.isAnswer = isAnswer;
	}

}
