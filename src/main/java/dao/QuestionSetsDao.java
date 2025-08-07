package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import entities.QuestionSets;
import helper.ConnectionProvider;

public class QuestionSetsDao {
	Connection con;

	public QuestionSetsDao(Connection con) {
		this.con = con;
	}

	public ArrayList<QuestionSets> getAllQuestionSet(Long uid) {
		con = ConnectionProvider.main();
		ArrayList<QuestionSets> setList = new ArrayList<QuestionSets>();
		String query = "select * from question_sets where qs_teacher=" + uid + " order by qs_id desc";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				QuestionSets qs = new QuestionSets();
				qs.setQs_batch(res.getInt("qs_batch"));
				qs.setQs_course(res.getInt("qs_course"));
				qs.setQs_created(res.getTimestamp("qs_created"));
				qs.setQs_id(res.getInt("qs_id"));
				qs.setQs_name(res.getString("qs_name"));
				qs.setQs_teacher(res.getLong("qs_teacher"));
				qs.setQs_section(res.getInt("qs_section"));
				setList.add(qs);
			}
		} catch (SQLException e) {
			System.out.println(e + " in QuestionSetsDao; gellAllQSet methon; line 36");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return setList;
	}

	public ArrayList<QuestionSets> getAllQuestionSet(Long uid, String courseId, String batchhId) {
		con = ConnectionProvider.main();
		ArrayList<QuestionSets> setList = new ArrayList<QuestionSets>();
		String query = "select * from question_sets where qs_teacher=" + uid + " and qs_course=" + courseId
				+ " and qs_batch=" + batchhId + " order by qs_id desc";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				QuestionSets qs = new QuestionSets();
				qs.setQs_batch(res.getInt("qs_batch"));
				qs.setQs_course(res.getInt("qs_course"));
				qs.setQs_created(res.getTimestamp("qs_created"));
				qs.setQs_id(res.getInt("qs_id"));
				qs.setQs_name(res.getString("qs_name"));
				qs.setQs_teacher(res.getLong("qs_teacher"));
				qs.setQs_section(res.getInt("qs_section"));
				setList.add(qs);
			}
		} catch (SQLException e) {
			System.out.println(e + " in QuestionSetsDao; gellAllQSet methon; line 36");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return setList;
	}

	public QuestionSets getQuestionSetById(String qs_id) {
		con = ConnectionProvider.main();
		QuestionSets qs = new QuestionSets();
		String query = "select * from question_sets where qs_id=" + qs_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				qs.setQs_batch(res.getInt("qs_batch"));
				qs.setQs_course(res.getInt("qs_course"));
				qs.setQs_created(res.getTimestamp("qs_created"));
				qs.setQs_id(res.getInt("qs_id"));
				qs.setQs_name(res.getString("qs_name"));
				qs.setQs_teacher(res.getLong("qs_teacher"));
				qs.setQs_section(res.getInt("qs_section"));
			}
		} catch (SQLException e) {
			System.out.println(e + " in QuestionSetsDao; gellQSet methon; line 58");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return qs;
	}

	public Long getTeacherOfQuestionSetId(String qs_id) {
		con = ConnectionProvider.main();
		Long teacherId = null;
		String query = "select qs_teacher from question_sets where qs_id=" + qs_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				teacherId = res.getLong(1);
			}
		} catch (SQLException e) {
			System.out.println(e + " in QuestionSetsDao; gellTeacherIDQSet method; line 94");
		}
//		try {
////			con.close();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		return teacherId;
	}

	public int getTotalQuestionAmount(int id) {
		con = ConnectionProvider.main();
		int amount = 0;
		String query = "select count(*) from question_set_to_question_relation where qs_id=" + id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			amount = res.next() ? res.getInt(1) : 0;
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
		return amount;
	}

	public int createQuestionSet(QuestionSets qs) {
		con = ConnectionProvider.main();
		int f = 0;
		String query = "insert into question_sets (qs_name,qs_teacher, qs_section, qs_batch, qs_course,qs_created) values (?,?,?,?,?,?)";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, qs.getQs_name());
			pst.setLong(2, qs.getQs_teacher());
			pst.setInt(3, qs.getQs_section());
			pst.setInt(4, qs.getQs_batch());
			pst.setInt(5, qs.getQs_course());
			pst.setTimestamp(6, new Timestamp(qs.getQs_created().getTime()));
			f = pst.executeUpdate();
		} catch (SQLException e) {
			System.out.println(e + " QuestionSetDao; method createQuestionSet; line 67");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}

	public int addToQuestionSet(String qs_id, String q_ids[]) {
		con = ConnectionProvider.main();
		int f = 0;
		try {
			for (String s : q_ids) {
				String query = "insert into  question_set_to_question_relation values (" + s + "," + qs_id + ")";
				PreparedStatement pst = con.prepareStatement(query);
				f = pst.executeUpdate();
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
		return f;
	}

	public int removeToQuestionSet(String qs_id, String q_id) {
		con = ConnectionProvider.main();
		int f = 0;
		String query = "delete from question_set_to_question_relation where q_id=" + q_id + " and qs_id=" + qs_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			f = pst.executeUpdate();
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
		return f;
	}

	public int deleteQuestionSetById(String qs_id) {
		con = ConnectionProvider.main();
		int f = 0;
		try {

			String query = "delete from question_sets where qs_id=" + qs_id;
			PreparedStatement pst2 = con.prepareStatement(query);
			f = pst2.executeUpdate();
			con.close();
		} catch (SQLException e) {
			f = 0;
			try {
				con.rollback();
				con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			// TODO Auto-generated catch block
			System.out.println(e + "QuestionDao;" + " line 198");
		}

		return f;
	}
}
