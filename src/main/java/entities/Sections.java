package entities;

public class Sections {
	public int id;
	public String section;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSection() {
		return section;
	}
	public void setSection(String section) {
		this.section = section;
	}
	public Sections(int id, String section) {
		super();
		this.id = id;
		this.section = section;
	}
	public Sections() {
		super();
	}
	
	
}
