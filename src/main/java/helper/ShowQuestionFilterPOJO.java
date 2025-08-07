package helper;

public class ShowQuestionFilterPOJO {
	String qs_id = "0";
	long q_teacher = 0;
	long current_user = 0;
	String own = "0";
	String other = "0";
	String difficulty = "0";
	String course = "0";
	String section = "21";
	String batch = "0";
	String exclude_qs_id = "0";

	public String getExclude_qs_id() {
		return exclude_qs_id;
	}

	public void setExclude_qs_id(String exclude_qs_id) {
		this.exclude_qs_id = exclude_qs_id;
	}

	public String getQs_id() {
		return qs_id;
	}

	public void setQs_id(String qs_id) {
		this.qs_id = qs_id;
	}

	public long getQ_teacher() {
		return q_teacher;
	}

	public void setQ_teacher(long q_teacher) {
		this.q_teacher = q_teacher;
	}

	public String getOwn() {
		return own;
	}

	public void setOwn(String own) {
		this.own = own;
	}

	public String getOther() {
		return other;
	}

	public void setOther(String other) {
		this.other = other;
	}

	public String getDifficulty() {
		return difficulty;
	}

	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty;
	}

	public String getCourse() {
		return course;
	}

	public void setCourse(String course) {
		this.course = course;
	}

	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}

	public ShowQuestionFilterPOJO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public long getCurrent_user() {
		return current_user;
	}

	public void setCurrent_user(long current_user) {
		this.current_user = current_user;
	}

	@Override
	public String toString() {
		return "ShowQuestionFilterPOJO [qs_id=" + qs_id + ", q_teacher=" + q_teacher + ", current_user=" + current_user
				+ ", own=" + own + ", other=" + other + ", difficulty=" + difficulty + ", course=" + course
				+ ", section=" + section + ", batch=" + batch + ", exclude_qs_id=" + exclude_qs_id + "]";
	}

}
