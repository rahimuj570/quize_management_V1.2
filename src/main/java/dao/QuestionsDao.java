package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

//import org.apache.tomcat.dbcp.dbcp2.PStmtKey;

import entities.Options;
import entities.Questions;
import helper.ConnectionProvider;
import helper.ShowQuestionFilterPOJO;

public class QuestionsDao {
	Connection con;

	public QuestionsDao(Connection con) {
		super();
		this.con = con;
	}

	public ArrayList<Questions> getAllQuestion(ShowQuestionFilterPOJO q_pojo) {
		
		System.out.println(q_pojo);
		
		con = ConnectionProvider.main();
		ArrayList<Questions> qList = new ArrayList<Questions>();
		String query = "select * from questions where (q_teacher=" + q_pojo.getQ_teacher() + " or q_privacy=" + 0 + ")";


		if (!q_pojo.getOwn().equals("0")) {
			query = "select * from questions where q_teacher=" + q_pojo.getQ_teacher();
		}
		if (!q_pojo.getOther().equals("0")) {
			
			
			
			query = "select * from questions where (q_privacy=0 and q_teacher != " + q_pojo.getQ_teacher() + ")";
			System.out.println(q_pojo.getQ_teacher());
		}
		if (!q_pojo.getOwn().equals("0") && !q_pojo.getOther().equals("0")) {
			query = "select * from questions where (q_privacy=0 or q_teacher = " + q_pojo.getQ_teacher() + ")";
		}
		if (!q_pojo.getDifficulty().equals("0")) {
			query = query + " and q_difficulty=" + q_pojo.getDifficulty();
		}
		if (!q_pojo.getCourse().equals("0")) {
			query = query + " and q_subject=" + q_pojo.getCourse();
		}
		if (!q_pojo.getSection().equals("21")) {
			query = query + " and q_section=" + q_pojo.getSection();
		}
		if (!q_pojo.getBatch().equals("0")) {
			query = query + " and q_batch=" + q_pojo.getBatch();
		}

		if (!q_pojo.getExclude_qs_id().equals("0")) {
			query = query
					+ " and q_id not in (select q.q_id from questions q join question_set_to_question_relation qr on qr.qs_id = "
					+ q_pojo.getExclude_qs_id() + " where qr.q_id=q.q_id)";
		} else if (!q_pojo.getQs_id().equals("0")) {
			query = query
					+ " and q_id in (select q.q_id from questions q join question_set_to_question_relation qr on qr.qs_id= "
					+ q_pojo.getQs_id() + " where qr.q_id=q.q_id)";
		}
System.out.println(query);
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Questions q = new Questions();
				q.setQ_batch(res.getInt("q_batch"));
				q.setQ_difficulty(res.getInt("q_difficulty"));
				q.setQ_id(res.getInt("q_id"));
				q.setQ_img(res.getString("q_img"));
				q.setQ_privacy(res.getInt("q_privacy"));
				q.setQ_section(res.getInt("q_section"));
				q.setQ_statement(res.getString("q_statement"));
				q.setQ_subject(res.getInt("q_subject"));
				q.setQ_teacher(res.getLong("q_teacher"));
				qList.add(q);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + " QuestionDao; line 76");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return qList;
	}

	public Questions getQuestionById(int id) {
		con = ConnectionProvider.main();
		Questions q = new Questions();
		String query = "select * from questions where q_id=" + id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				q.setQ_batch(res.getInt("q_batch"));
				q.setQ_difficulty(res.getInt("q_difficulty"));
				q.setQ_id(res.getInt("q_id"));
				q.setQ_img(res.getString("q_img"));
				q.setQ_privacy(res.getInt("q_privacy"));
				q.setQ_section(res.getInt("q_section"));
				q.setQ_statement(res.getString("q_statement"));
				q.setQ_subject(res.getInt("q_subject"));
				q.setQ_teacher(res.getLong("q_teacher"));
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
		return q;
	}

	public int updateQuestion(String allWrongOpt[], String allAns[], Questions questions, int q_id) {
		con = ConnectionProvider.main();
		int f = 0;

		try {
			con.setAutoCommit(false);
			String query = "update questions set q_statement=?, q_img=?, q_batch=?, q_subject=?, q_privacy=?, q_section=?, q_teacher=?, q_difficulty=? where q_id="
					+ q_id;
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, questions.getQ_statement());
			pst.setString(2, questions.getQ_img());
			pst.setInt(3, questions.getQ_batch());
			pst.setInt(4, questions.getQ_subject());
			pst.setInt(5, questions.getQ_privacy());
			pst.setInt(6, questions.getQ_section());
			pst.setLong(7, questions.getQ_teacher());
			pst.setLong(8, questions.getQ_difficulty());
			f = pst.executeUpdate();
			if (f == 1) {
				pst.close();
				String deleteOptQuery = "delete from options where opt_question=" + q_id;
				pst = con.prepareStatement(deleteOptQuery);
				f = pst.executeUpdate();

				ArrayList<Options> allOpt = new ArrayList<Options>();
				for (String s : allWrongOpt) {
					if (!s.isBlank()) {
						Options temp_opt = new Options(q_id, s, 0);
						allOpt.add(temp_opt);
					}
				}
				for (String s : allAns) {
					if (!s.isBlank()) {
						Options temp_opt = new Options(q_id, s, 1);
						allOpt.add(temp_opt);
					}
				}

				for (Options opt : allOpt) {
					String query2 = "insert into options (opt_question, opt_text, opt_isAnswer) values (?,?,?)";
					pst = con.prepareStatement(query2);
					pst.setInt(1, opt.getOpt_question());
					pst.setString(2, opt.getOpt_text());
					pst.setInt(3, opt.getIsAnswer());
					f = pst.executeUpdate();
					pst.close();
				}

				con.commit();
				con.close();
			} else {
				f = 0;
				con.rollback();
				con.close();
				return 0;
			}
		} catch (SQLException e) {
			try {
				f = 0;
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				f = 0;
				System.out.println(e1 + "QuestionDao;" + " line 167");
			}
			// TODO Auto-generated catch block
			f = 0;
			System.out.println(e + "QuestionDao;" + " line 171");
		}

		return f;
	}

	public int deleteQuestionById(String q_id) {
		con = ConnectionProvider.main();
		int f = 0;
		try {
			String query = "delete from questions where q_id=" + q_id;
			PreparedStatement pst = con.prepareStatement(query);
			f = pst.executeUpdate();
			pst.close();
			con.close();
		} catch (SQLException e) {
			System.out.println(3333);
			f = 0;
			// TODO Auto-generated catch block
			System.out.println(e + "QuestionDao;" + " line 198");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return f;
	}
}
