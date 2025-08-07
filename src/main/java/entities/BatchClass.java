package entities;

public class BatchClass {
	int id;
	String batchClass;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBatchClass() {
		return batchClass;
	}
	public void setBatchClass(String batchClass) {
		this.batchClass = batchClass;
	}
	public BatchClass(int id, String batchClass) {
		super();
		this.id = id;
		this.batchClass = batchClass;
	}
	public BatchClass() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

}
