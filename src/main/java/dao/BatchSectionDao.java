package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entities.BatchClass;
import entities.Course;
import entities.Sections;
import helper.ConnectionProvider;
import helper.GetBatchSectionOfStudentPOJO;

public class BatchSectionDao {
	Connection con;

	public BatchSectionDao(Connection con) {
		// TODO Auto-generated constructor stub
		this.con = con;
	}

	public ArrayList<Sections> getAllSection() {
		con = ConnectionProvider.main();
		ArrayList<Sections> sectionList = new ArrayList<Sections>();
		String query = "select * from sections order by id";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Sections sec = new Sections(res.getInt(1), res.getString(2));
				sectionList.add(sec);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sectionList;
	}

	public ArrayList<BatchClass> getAllClass() {
		con = ConnectionProvider.main();
		ArrayList<BatchClass> classList = new ArrayList<BatchClass>();
		String query = "select * from batch_class";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				BatchClass bc = new BatchClass(res.getInt(1), res.getString(2));
				classList.add(bc);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return classList;
	}

	public ArrayList<Course> getAllCourse() {
		con = ConnectionProvider.main();
		ArrayList<Course> courseList = new ArrayList<Course>();
		String query = "select * from course";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Course c = new Course(res.getInt(1), res.getString(2));
				courseList.add(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return courseList;
	}

	public String getSectionNameById(int id) {
		con = ConnectionProvider.main();
		String sec_name = "";
		String query = "select section_name from sections where id=" + id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			sec_name = res.next() ? res.getString(1) : "";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sec_name;
	}

	public String getCourseNameById(int id) {
		con = ConnectionProvider.main();
		String sec_name = "";
		String query = "select course_name from course where course_id=" + id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			sec_name = res.next() ? res.getString(1) : "";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sec_name;
	}

	public String getBatchNameById(int id) {
		con = ConnectionProvider.main();
		String sec_name = "";
		String query = "select batch_class from batch_class where id=" + id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			sec_name = res.next() ? res.getString(1) : "";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sec_name;
	}
	
	public GetBatchSectionOfStudentPOJO getBatchSectionOfStudent(Long student_id) {
		con = ConnectionProvider.main();
		GetBatchSectionOfStudentPOJO bss = new GetBatchSectionOfStudentPOJO();
		String query="select * from batch_section_user_relation where user_id="+student_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if(res.next()) {
				bss.setBatchId(res.getInt(2));
				bss.setSectionId(res.getInt(3));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bss;
	}
}
