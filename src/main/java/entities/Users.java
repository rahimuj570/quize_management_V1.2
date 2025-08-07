package entities;

public class Users {
	Long user_id;
	String user_first_name;
	String user_last_name;
	String user_email;
	String user_password;
	String user_batch;
	String user_section;
	int user_is_teacher;
	int user_is_admin=0;
	int user_is_approved=0;
	int user_is_varified=0;
	
	
	
	public String getUser_batch() {
		return user_batch;
	}
	public void setUser_batch(String user_batch) {
		this.user_batch = user_batch;
	}
	public String getUser_section() {
		return user_section;
	}
	public void setUser_section(String user_section) {
		this.user_section = user_section;
	}
	public int getUser_is_varified() {
		return user_is_varified;
	}
	public void setUser_is_varified(int user_is_varified) {
		this.user_is_varified = user_is_varified;
	}
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public String getUser_first_name() {
		return user_first_name;
	}
	public void setUser_first_name(String user_first_name) {
		this.user_first_name = user_first_name;
	}
	public String getUser_last_name() {
		return user_last_name;
	}
	public void setUser_last_name(String user_last_name) {
		this.user_last_name = user_last_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public int getUser_is_teacher() {
		return user_is_teacher;
	}
	public void setUser_is_teacher(int user_is_teacher) {
		this.user_is_teacher = user_is_teacher;
	}
	public int getUser_is_admin() {
		return user_is_admin;
	}
	public void setUser_is_admin(int user_is_admin) {
		this.user_is_admin = user_is_admin;
	}
	public int getUser_is_approved() {
		return user_is_approved;
	}
	public void setUser_is_approved(int user_is_approved) {
		this.user_is_approved = user_is_approved;
	}

	public Users() {
		// TODO Auto-generated constructor stub
	}
	public Users(Long user_id, String user_first_name, String user_last_name, String user_email, String user_password,
			String user_batch, String user_section, int user_is_teacher, int user_is_admin, int user_is_approved,
			int user_is_varified) {
		super();
		this.user_id = user_id;
		this.user_first_name = user_first_name;
		this.user_last_name = user_last_name;
		this.user_email = user_email;
		this.user_password = user_password;
		this.user_batch = user_batch;
		this.user_section = user_section;
		this.user_is_teacher = user_is_teacher;
		this.user_is_admin = user_is_admin;
		this.user_is_approved = user_is_approved;
		this.user_is_varified = user_is_varified;
	}
	
	@Override
	public String toString() {
		return "Users [user_id=" + user_id + ", user_first_name=" + user_first_name + ", user_last_name="
				+ user_last_name + ", user_email=" + user_email + ", user_password=" + user_password + ", user_batch="
				+ user_batch + ", user_section=" + user_section + ", user_is_teacher=" + user_is_teacher
				+ ", user_is_admin=" + user_is_admin + ", user_is_approved=" + user_is_approved + ", user_is_varified="
				+ user_is_varified + "]";
	}

	
	
}
