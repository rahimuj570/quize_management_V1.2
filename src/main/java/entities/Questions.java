package entities;

import java.util.ArrayList;

public class Questions {
	int q_id;
	String q_statement;
	String q_img;
	ArrayList<String>options;
	ArrayList<String>answers;
	int q_batch;
	int q_section;
	int q_privacy;
	int q_difficulty;
	int q_subject;
	long q_teacher;
	
	public Questions() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getQ_id() {
		return q_id;
	}
	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}
	public String getQ_statement() {
		return q_statement;
	}
	public void setQ_statement(String q_statement) {
		this.q_statement = q_statement;
	}
	public String getQ_img() {
		return q_img;
	}
	public void setQ_img(String q_img) {
		this.q_img = q_img;
	}
	public ArrayList<String> getOptions() {
		return options;
	}
	public void setOptions(ArrayList<String> options) {
		this.options = options;
	}
	public ArrayList<String> getAnswers() {
		return answers;
	}
	public void setAnswers(ArrayList<String> answers) {
		this.answers = answers;
	}
	public int getQ_batch() {
		return q_batch;
	}
	public void setQ_batch(int q_batch) {
		this.q_batch = q_batch;
	}
	public int getQ_section() {
		return q_section;
	}
	public void setQ_section(int q_section) {
		this.q_section = q_section;
	}
	public int getQ_privacy() {
		return q_privacy;
	}
	public void setQ_privacy(int q_privacy) {
		this.q_privacy = q_privacy;
	}
	public int getQ_difficulty() {
		return q_difficulty;
	}
	public void setQ_difficulty(int q_difficulty) {
		this.q_difficulty = q_difficulty;
	}
	public int getQ_subject() {
		return q_subject;
	}
	public void setQ_subject(int q_subject) {
		this.q_subject = q_subject;
	}
	public long getQ_teacher() {
		return q_teacher;
	}
	public void setQ_teacher(long q_teacher) {
		this.q_teacher = q_teacher;
	}
	@Override
	public String toString() {
		return "Questions [q_id=" + q_id + ", q_statement=" + q_statement + ", q_img=" + q_img + ", options=" + options
				+ ", answers=" + answers + ", q_batch=" + q_batch + ", q_section=" + q_section + ", q_privacy="
				+ q_privacy + ", q_difficulty=" + q_difficulty + ", q_subject=" + q_subject + ", q_teacher=" + q_teacher
				+ "]";
	}
	
	
	
}
