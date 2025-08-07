package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import entities.Options;
import entities.Questions;
import helper.ConnectionProvider;

public class CreateQuestionDao {
	Connection con;

	public CreateQuestionDao(Connection con) {
		super();
		this.con = con;
	}

	public int createQuestion(String allWrongOpt[], String allAns[], Questions questions, int question_set) {
		con = ConnectionProvider.main();
		int f = 0;
//		System.out.println();

		try {
			con.setAutoCommit(false);
			String query = "insert into questions (q_statement, q_img, q_batch, q_subject, q_privacy, q_section, q_teacher, q_difficulty) values (?,?,?,?,?,?,?,?)";
			PreparedStatement pst = con.prepareStatement(query, new String[] { "q_id" });
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
				ResultSet res = pst.getGeneratedKeys();
				int q_id = res.next() ? res.getInt(1) : 0;
				pst.close();

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

				if (question_set != 0) {
					String query3 = "insert into question_set_to_question_relation values(?,?)";
					pst = con.prepareStatement(query3);
					pst.setInt(1, q_id);
					pst.setInt(2, question_set);
					f = pst.executeUpdate();
				}

				con.commit();
				con.close();
			} else {
				con.rollback();
				con.close();
				return 0;
			}
		} catch (SQLException e) {
			try {
				f=0;
				con.rollback();
				con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				f=0;
				e1.printStackTrace();
			}
			// TODO Auto-generated catch block
			f=0;
			e.printStackTrace();
		}

		return f;
	}

}
