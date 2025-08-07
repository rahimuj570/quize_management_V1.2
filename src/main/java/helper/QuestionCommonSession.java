package helper;

public class QuestionCommonSession {
	String batch;
	String section;
	String q_set;
	String course;
	String privacy;
	String difficulty;

	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}

	public String getSection() {
		return section;
	}

	public void setSection(String section) {
		this.section = section;
	}

	public String getQ_set() {
		return q_set;
	}

	public void setQ_set(String q_set) {
		this.q_set = q_set;
	}

	public String getCourse() {
		return course;
	}

	public void setCourse(String course) {
		this.course = course;
	}

	public String getPrivacy() {
		return privacy;
	}

	public void setPrivacy(String privacy) {
		this.privacy = privacy;
	}

	public String getDifficulty() {
		return difficulty;
	}

	public void setDifficulty(String difficulty) {
		this.difficulty = difficulty;
	}

	@Override
	public String toString() {
		return "QuestionCommonSession [batch=" + batch + ", section=" + section + ", q_set=" + q_set + ", course="
				+ course + ", privacy=" + privacy + ", difficulty=" + difficulty + "]";
	}

}
