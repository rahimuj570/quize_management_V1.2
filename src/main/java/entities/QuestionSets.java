package entities;

import java.util.ArrayList;
import java.util.Date;

public class QuestionSets {
	int qs_id;
	String qs_name;
	Long qs_teacher;
	Date qs_created = new Date();
	int qs_course;
	int qs_batch;
	int qs_section;
	ArrayList<Questions> qs_questions;

	public String getQs_name() {
		return qs_name;
	}

	public void setQs_name(String qs_name) {
		this.qs_name = qs_name;
	}


	public int getQs_id() {
		return qs_id;
	}

	public void setQs_id(int qs_id) {
		this.qs_id = qs_id;
	}

	public Long getQs_teacher() {
		return qs_teacher;
	}

	public void setQs_teacher(Long qs_teacher) {
		this.qs_teacher = qs_teacher;
	}

	public Date getQs_created() {
		return qs_created;
	}

	public void setQs_created(Date qs_created) {
		this.qs_created = qs_created;
	}

	public int getQs_course() {
		return qs_course;
	}

	public void setQs_course(int qs_course) {
		this.qs_course = qs_course;
	}

	public int getQs_batch() {
		return qs_batch;
	}

	public void setQs_batch(int qs_batch) {
		this.qs_batch = qs_batch;
	}

	public int getQs_section() {
		return qs_section;
	}

	public void setQs_section(int qs_section) {
		this.qs_section = qs_section;
	}

	public ArrayList<Questions> getQs_questions() {
		return qs_questions;
	}

	public void setQs_questions(ArrayList<Questions> qs_questions) {
		this.qs_questions = qs_questions;
	}

	public QuestionSets() {
		super();
		// TODO Auto-generated constructor stub
	}

}
