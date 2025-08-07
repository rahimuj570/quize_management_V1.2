package entities;

import java.util.Date;

public class Exams {
	int exam_id;
	String exam_name;
	Long exam_teacher;
	int exam_batch;
	int exam_section;
	int exam_course;
	int exam_privacy;
	int exam_duration;
	int exam_question_amount;
	int exam_marks;
	Date exam_start;
	Date exam_end;
	int exam_isOver;
	int exam_isApproved;

	
	public int getExam_isApproved() {
		return exam_isApproved;
	}

	public void setExam_isApproved(int exam_isApproved) {
		this.exam_isApproved = exam_isApproved;
	}

	public int getExam_isOver() {
		return exam_isOver;
	}

	public void setExam_isOver(int exam_isOver) {
		this.exam_isOver = exam_isOver;
	}

	public Long getExam_teacher() {
		return exam_teacher;
	}

	public void setExam_teacher(Long exam_teacher) {
		this.exam_teacher = exam_teacher;
	}

	public int getExam_batch() {
		return exam_batch;
	}

	public void setExam_batch(int exam_batch) {
		this.exam_batch = exam_batch;
	}

	public int getExam_section() {
		return exam_section;
	}

	public void setExam_section(int exam_section) {
		this.exam_section = exam_section;
	}

	public int getExam_course() {
		return exam_course;
	}

	public void setExam_course(int exam_course) {
		this.exam_course = exam_course;
	}

	public int getExam_id() {
		return exam_id;
	}

	public void setExam_id(int exam_id) {
		this.exam_id = exam_id;
	}

	public String getExam_name() {
		return exam_name;
	}

	public void setExam_name(String exam_name) {
		this.exam_name = exam_name;
	}

	public int getExam_privacy() {
		return exam_privacy;
	}

	public void setExam_privacy(int exam_privacy) {
		this.exam_privacy = exam_privacy;
	}

	public int getExam_duration() {
		return exam_duration;
	}

	public void setExam_duration(int exam_duration) {
		this.exam_duration = exam_duration;
	}

	public int getExam_question_amount() {
		return exam_question_amount;
	}

	public void setExam_question_amount(int exam_question_amount) {
		this.exam_question_amount = exam_question_amount;
	}

	public int getExam_marks() {
		return exam_marks;
	}

	public void setExam_marks(int exam_marks) {
		this.exam_marks = exam_marks;
	}

	public Date getExam_start() {
		return exam_start;
	}

	public void setExam_start(Date exam_start) {
		this.exam_start = exam_start;
	}

	public Date getExam_end() {
		return exam_end;
	}

	public void setExam_end(Date exam_end) {
		this.exam_end = exam_end;
	}

	public Exams() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "Exams [exam_id=" + exam_id + ", exam_name=" + exam_name + ", exam_teacher=" + exam_teacher
				+ ", exam_batch=" + exam_batch + ", exam_section=" + exam_section + ", exam_course=" + exam_course
				+ ", exam_privacy=" + exam_privacy + ", exam_duration=" + exam_duration + ", exam_question_amount="
				+ exam_question_amount + ", exam_marks=" + exam_marks + ", exam_start=" + exam_start + ", exam_end="
				+ exam_end + ", exam_isOver=" + exam_isOver + "]";
	}

}
