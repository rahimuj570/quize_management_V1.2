package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

//import com.mysql.cj.xdevapi.PreparableStatement;

import entities.Exams;
import entities.ExamsEvaluation;
import entities.Options;
import entities.QuestionSets;
import entities.Questions;
import helper.ConnectionProvider;

public class ExamsDao {

	Connection con;

	public ExamsDao(Connection con) {
		this.con = con;
	}

	public int createExam(Exams e, String s[]) {
		con = ConnectionProvider.main();
		int f = 0;
		try {
			con.setAutoCommit(false);
			String query = "INSERT INTO exams (exam_name, exam_teacher, exam_batch, exam_section, exam_course, exam_privacy, exam_duration, exam_question_amount, exam_mark, exam_start, exam_end, exam_isOver, exam_isApproved) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement pst = con.prepareStatement(query, new String[] { "exam_id" });
			pst.setString(1, e.getExam_name());
			pst.setLong(2, e.getExam_teacher());
			pst.setInt(3, e.getExam_batch());
			pst.setInt(4, e.getExam_section());
			pst.setInt(5, e.getExam_course());
			pst.setInt(6, e.getExam_privacy());
			pst.setInt(7, e.getExam_duration());
			pst.setInt(8, e.getExam_question_amount());
			pst.setInt(9, e.getExam_marks());
			pst.setTimestamp(10, new Timestamp(e.getExam_start().getTime()));
			pst.setTimestamp(11, new Timestamp(e.getExam_end().getTime()));
			pst.setInt(12, e.getExam_isOver());
			pst.setInt(13, e.getExam_isApproved());
			f = pst.executeUpdate();

			QuestionSetsDao qsDao = new QuestionSetsDao(ConnectionProvider.main());

			if (f == 0) {
				con.rollback();
				return 0;
			} else {
				ResultSet res = pst.getGeneratedKeys();
				int exam_id = res.next() ? res.getInt(1) : 0;
				pst.close();
				for (String qs : s) {
					query = "insert into exam_to_question_set_relation values(?,?)";
					pst = con.prepareStatement(query);
					pst.setInt(1, exam_id);
					pst.setInt(2, Integer.parseInt(qs));
					if (e.getExam_teacher().toString().equals(qsDao.getTeacherOfQuestionSetId(qs).toString())) {
//						con = ConnectionProvider.main()
						f = pst.executeUpdate();
						if (f == 0) {
							con.rollback();
							return 0;
						}
					}
					;
				}
				con.commit();
				con.close();
			}
		} catch (SQLException e1) {
			try {
				con.close();
			} catch (SQLException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			System.out.println(e1 + " ExamsDao; method CreateExam; line 70");
		}
		return f;
	}

	public ArrayList<Exams> getAllExamById(Long teacher_id) {
		con = ConnectionProvider.main();
		ArrayList<Exams> examList = new ArrayList<Exams>();
		String query = "select * from exams where exam_teacher=" + teacher_id + " order by exam_id desc";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Exams e = new Exams();
				e.setExam_batch(res.getInt("exam_batch"));
				e.setExam_course(res.getInt("exam_course"));
				e.setExam_duration(res.getInt("exam_duration"));
				e.setExam_end(res.getTimestamp("exam_end"));
				e.setExam_id(res.getInt("exam_id"));
				e.setExam_isApproved(res.getInt("exam_isApproved"));
				e.setExam_isOver(res.getInt("exam_isOver"));
				e.setExam_marks(res.getInt("exam_mark"));
				e.setExam_name(res.getString("exam_name"));
				e.setExam_privacy(res.getInt("exam_privacy"));
				e.setExam_question_amount(res.getInt("exam_question_amount"));
				e.setExam_section(res.getInt("exam_section"));
				e.setExam_start(res.getTimestamp("exam_start"));
				e.setExam_teacher(res.getLong("exam_teacher"));
				examList.add(e);
			}
		} catch (SQLException e) {
			System.out.println(e + " in ExamsDao; gellAllExamById methon; line 103");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return examList;
	}

	public Exams getExamById(String id) {
		con = ConnectionProvider.main();
		String query = "select * from exams where exam_id=" + id;
		Exams e = new Exams();
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				e.setExam_batch(res.getInt("exam_batch"));
				e.setExam_course(res.getInt("exam_course"));
				e.setExam_duration(res.getInt("exam_duration"));
				e.setExam_end(res.getTimestamp("exam_end"));
				e.setExam_id(res.getInt("exam_id"));
				e.setExam_isApproved(res.getInt("exam_isApproved"));
				e.setExam_isOver(res.getInt("exam_isOver"));
				e.setExam_marks(res.getInt("exam_mark"));
				e.setExam_name(res.getString("exam_name"));
				e.setExam_privacy(res.getInt("exam_privacy"));
				e.setExam_question_amount(res.getInt("exam_question_amount"));
				e.setExam_section(res.getInt("exam_section"));
				e.setExam_start(res.getTimestamp("exam_start"));
				e.setExam_teacher(res.getLong("exam_teacher"));
			}
		} catch (SQLException exc) {
			System.out.println(exc + " in ExamsDao; getAllExamById method; line 130");
		}
		try {
			con.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return e;
	}

	public ArrayList<Integer> getAllQuestionSetById(String exam_id) {
		con = ConnectionProvider.main();
		ArrayList<Integer> qs = new ArrayList<Integer>();
		String query = "select qs_id from exam_to_question_set_relation where exam_id=" + exam_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				qs.add(res.getInt(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + " in ExamsDao; getAllQuestioSetId method; line 146");
		}
//		try {
//			con.close();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		return qs;
	}

	public int updateExam(Exams e, String s[]) {
		con = ConnectionProvider.main();
		System.out.println("kkkkkkkkk");
		System.out.println(e);
		int f = 0;
		try {
			con.setAutoCommit(false);
			String query = "update exams SET exam_name=?, exam_teacher=?, exam_batch=?, exam_section=?, exam_course=?, exam_privacy=?, exam_duration=?, exam_question_amount=?, exam_mark=?, exam_start=?, exam_end=?, exam_isOver=?, exam_isApproved=? where exam_id=?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setString(1, e.getExam_name());
			pst.setLong(2, e.getExam_teacher());
			pst.setInt(3, e.getExam_batch());
			pst.setInt(4, e.getExam_section());
			pst.setInt(5, e.getExam_course());
			pst.setInt(6, e.getExam_privacy());
			pst.setInt(7, e.getExam_duration());
			pst.setInt(8, e.getExam_question_amount());
			pst.setInt(9, e.getExam_marks());
			pst.setTimestamp(10, new Timestamp(e.getExam_start().getTime()));
			pst.setTimestamp(11, new Timestamp(e.getExam_end().getTime()));
			pst.setInt(12, e.getExam_isOver());
			pst.setInt(13, e.getExam_isApproved());
			pst.setInt(14, e.getExam_id());
			f = pst.executeUpdate();

			QuestionSetsDao qsDao = new QuestionSetsDao(ConnectionProvider.main());
			if (f == 0) {
				con.rollback();
				return 0;
			} else {
				pst.close();
				f = deleteExams_QuestionSet_relation(e.getExam_id(), pst);
				System.out.println(f);
				pst.close();
				if (f == 0) {
					con.rollback();
					return 0;
				}

				for (String qs : s) {
					query = "insert into exam_to_question_set_relation values(?,?)";
					pst = con.prepareStatement(query);
					pst.setInt(1, e.getExam_id());
					pst.setInt(2, Integer.parseInt(qs));
					if (e.getExam_teacher().toString().equals(qsDao.getTeacherOfQuestionSetId(qs).toString())) {
						f = pst.executeUpdate();
						if (f == 0) {
							con.rollback();
							return 0;
						}
					}
					;
				}
				con.commit();
				con.close();
			}
		} catch (SQLException e1) {
			try {
				con.close();
			} catch (SQLException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			System.out.println(e1 + " ExamsDao; method UpdateExam; line 205");
		}
		return f;
	}

	private int deleteExams_QuestionSet_relation(int exam_id, PreparedStatement pst) {
		int f = 0;
		String query = "delete from exam_to_question_set_relation where exam_id=" + exam_id;
		try {
			con.setAutoCommit(false);
			pst = con.prepareStatement(query);
			f = pst.executeUpdate();
			pst.close();
		} catch (SQLException e) {
			f = 0;
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f;
	}

	public int deleteExam(int exam_id) {
		con = ConnectionProvider.main();
		int f = 0;
		try {
			String query = "delete from exams where exam_id=" + exam_id;
			PreparedStatement pst = con.prepareStatement(query);
			f = pst.executeUpdate();
			con.close();
		} catch (SQLException e) {
			f = 0;
			try {
				con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println(e + " ExamsDao; deleteExam method; line 257");

		}

		return f;
	}

	public ArrayList<Exams> getAllStudentExamById(int batchId, int sectionId, String courseId) {
		con = ConnectionProvider.main();
		ArrayList<Exams> examList = new ArrayList<Exams>();
		String query = "select * from exams where exam_isOver=0 and exam_batch=" + batchId + " and (exam_section="
				+ sectionId + " or exam_section=0)";
		if (!courseId.equals("")) {
			query = query + " and exam_course=" + courseId;
		}
		query = query + " order by exam_start asc";
		 System.out.println(query);
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Exams e = new Exams();
				e.setExam_batch(res.getInt("exam_batch"));
				e.setExam_course(res.getInt("exam_course"));
				e.setExam_duration(res.getInt("exam_duration"));
				e.setExam_end(res.getTimestamp("exam_end"));
				e.setExam_id(res.getInt("exam_id"));
				e.setExam_isApproved(res.getInt("exam_isApproved"));
				e.setExam_isOver(res.getInt("exam_isOver"));
				e.setExam_marks(res.getInt("exam_mark"));
				e.setExam_name(res.getString("exam_name"));
				e.setExam_privacy(res.getInt("exam_privacy"));
				e.setExam_question_amount(res.getInt("exam_question_amount"));
				e.setExam_section(res.getInt("exam_section"));
				e.setExam_start(res.getTimestamp("exam_start"));
				e.setExam_teacher(res.getLong("exam_teacher"));
				examList.add(e);
			}
		} catch (SQLException e) {
			System.out.println(e + " in ExamsDao; gellStudentAllExamById methon; line 293");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return examList;
	}

	public ArrayList<Questions> getAllQuestionOfExam(int exam_id, int limit) {
		con = ConnectionProvider.main();
		ArrayList<Questions> qList = new ArrayList<Questions>();
		ArrayList<Integer> exam_set = getAllQuestionSetById(exam_id + "");
		String query = "select q.q_id , q.q_statement, q.q_img, q.q_batch, q.q_subject, q.q_privacy, q.q_section, q.q_teacher, q.q_difficulty from questions q join question_set_to_question_relation qsr join exam_to_question_set_relation eqr where q.q_id=qsr.q_id and (";
		for (int i = 0; i < exam_set.size(); i++) {
			query = query + " qsr.qs_id=" + exam_set.get(i);
			if (i < exam_set.size() - 1) {
				query = query + " or ";
			}
		}
		query = query + ") and eqr.qs_id=qsr.qs_id and eqr.exam_id="+exam_id+" order by rand() limit " + limit;
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
			System.out.println("ExamsDao 362");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return qList;
	}

	public ArrayList<Options> get4OptionByExamId(int exam_id) {
		con = ConnectionProvider.main();
		ArrayList<Options> optList = new ArrayList<Options>();
		String query = "select * from ((SELECT * FROM options where opt_question=" + exam_id
				+ " and opt_isAnswer=0 order by rand() limit 3) union all (select * from options where opt_question="
				+ exam_id + " and opt_isAnswer=1 order by rand() limit 1)) as t order by rand()";
		// System.out.println(query);
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Options opt = new Options();
				opt.setIsAnswer(res.getInt("opt_isAnswer"));
				opt.setOpt_id(res.getInt("opt_id"));
				opt.setOpt_question(res.getInt("opt_question"));
				opt.setOpt_text(res.getString("opt_text"));
				optList.add(opt);
			}
		} catch (SQLException e) {
			System.out.println("examsDao 393");
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
//		try {
//			con.close();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		return optList;
	}

	public int createExamEvaluation(ExamsEvaluation eev) {
		con = ConnectionProvider.main();
		int f = 0;
		String query = "insert into exams_evaluation values(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setLong(1, eev.getStudent_id());
			pst.setInt(2, eev.getExam_id());
			pst.setInt(3, eev.getCorrect_answer());
			pst.setInt(4, eev.getWrong_answer());
			pst.setInt(5, eev.getPass_question());
			pst.setInt(6, eev.getIsExpelled());
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

	public int updateExamEvaluation(ExamsEvaluation eev) {
		con = ConnectionProvider.main();
		int f = 0;
		String query = "update exams_evaluation set student_id=?, exam_id=?, correct_answer=?, wrong_answer=?, pass_question=?, isExpelled=?";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			pst.setLong(1, eev.getStudent_id());
			pst.setInt(2, eev.getExam_id());
			pst.setInt(3, eev.getCorrect_answer());
			pst.setInt(4, eev.getWrong_answer());
			pst.setInt(5, eev.getPass_question());
			pst.setInt(6, eev.getIsExpelled());
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

	public ArrayList<Exams> getAllParticipatedExamById(Long student_id) {
		con = ConnectionProvider.main();
		ArrayList<Exams> examList = new ArrayList<Exams>();
		String query = "select e.exam_id, e.exam_name, e.exam_teacher, e.exam_batch, e.exam_section, e.exam_course, e.exam_privacy, e.exam_duration, e.exam_question_amount, e.exam_mark, e.exam_start, e.exam_end, e.exam_isOver, e.exam_isApproved from exams e join exams_evaluation ev where e.exam_id=ev.exam_id and ev.student_id="
				+ student_id;
		query = query + " order by exam_end desc";
		// System.out.println(query);
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Exams e = new Exams();
				e.setExam_batch(res.getInt("exam_batch"));
				e.setExam_course(res.getInt("exam_course"));
				e.setExam_duration(res.getInt("exam_duration"));
				e.setExam_end(res.getTimestamp("exam_end"));
				e.setExam_id(res.getInt("exam_id"));
				e.setExam_isApproved(res.getInt("exam_isApproved"));
				e.setExam_isOver(res.getInt("exam_isOver"));
				e.setExam_marks(res.getInt("exam_mark"));
				e.setExam_name(res.getString("exam_name"));
				e.setExam_privacy(res.getInt("exam_privacy"));
				e.setExam_question_amount(res.getInt("exam_question_amount"));
				e.setExam_section(res.getInt("exam_section"));
				e.setExam_start(res.getTimestamp("exam_start"));
				e.setExam_teacher(res.getLong("exam_teacher"));
				examList.add(e);
			}
		} catch (SQLException e) {
			System.out.println(e + " in ExamsDao; gellParticipatedExamById methon; line 429");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return examList;
	}

	public ExamsEvaluation getExamEvaluation(long student_id, int exam_id) {
		con = ConnectionProvider.main();
		ExamsEvaluation ev = new ExamsEvaluation();
		String query = "select * from exams_evaluation where student_id=" + student_id + " and exam_id=" + exam_id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				ev.setCorrect_answer(res.getInt("correct_answer"));
				ev.setExam_id(res.getInt("exam_id"));
				ev.setIsExpelled(res.getInt("isExpelled"));
				ev.setPass_question(res.getInt("pass_question"));
				ev.setStudent_id(res.getLong("student_id"));
				ev.setWrong_answer(res.getInt("wrong_answer"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + " in ExamsDao; getExamEvaluaton method; line 450");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ev;
	}

	public ArrayList<ExamsEvaluation> getAllExamEvaluation(int exam_id) {
		con = ConnectionProvider.main();
		ArrayList<ExamsEvaluation> evList = new ArrayList<ExamsEvaluation>();
		String query = "SELECT * FROM exams_evaluation ev where exam_id=" + exam_id + " order by correct_answer desc";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				ExamsEvaluation ev = new ExamsEvaluation();
				ev.setCorrect_answer(res.getInt("correct_answer"));
				ev.setExam_id(res.getInt("exam_id"));
				ev.setIsExpelled(res.getInt("isExpelled"));
				ev.setPass_question(res.getInt("pass_question"));
				ev.setStudent_id(res.getLong("student_id"));
				ev.setWrong_answer(res.getInt("wrong_answer"));
				evList.add(ev);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println(e + " in ExamsDao; getExamEvaluaton method; line 450");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return evList;
	}

	public ArrayList<Exams> getPendingExam() {
		con = ConnectionProvider.main();
		ArrayList<Exams> pendingExamList = new ArrayList<Exams>();
		String query = "select * from exams where exam_isApproved=0";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Exams e = new Exams();
				e.setExam_batch(res.getInt("exam_batch"));
				e.setExam_course(res.getInt("exam_course"));
				e.setExam_duration(res.getInt("exam_duration"));
				e.setExam_end(res.getTimestamp("exam_end"));
				e.setExam_id(res.getInt("exam_id"));
				e.setExam_isApproved(res.getInt("exam_isApproved"));
				e.setExam_isOver(res.getInt("exam_isOver"));
				e.setExam_marks(res.getInt("exam_mark"));
				e.setExam_name(res.getString("exam_name"));
				e.setExam_privacy(res.getInt("exam_privacy"));
				e.setExam_question_amount(res.getInt("exam_question_amount"));
				e.setExam_section(res.getInt("exam_section"));
				e.setExam_start(res.getTimestamp("exam_start"));
				e.setExam_teacher(res.getLong("exam_teacher"));
				pendingExamList.add(e);
			}
		} catch (SQLException exc) {
			System.out.println(exc + " in ExamsDao; getAllExamById method; line 130");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pendingExamList;
	}

	public int addStudentPermission(Exams e, ArrayList<Long> ids) {
		con = ConnectionProvider.main();
		int f = 0;
		PreparedStatement pst = null;
		try {
			con.setAutoCommit(false);
			System.out.println("before");
			System.out.println(ids.size()+"size");
			for (Long id : ids) {
				System.out.println(id);
				if (isAlredyPermited(id, e.getExam_id()) == false) {
					String query = "insert into exams_permission values(?,?,?)";
					pst = con.prepareStatement(query);
					pst.setInt(1, e.getExam_id());
					pst.setLong(2, id);
					pst.setTimestamp(3, new Timestamp(e.getExam_end().getTime() + (7 * 24 * 60 * 60 * 1000)));
					f = pst.executeUpdate();
					pst.close();
					System.out.println(f);
					if (f == 0) {
						con.rollback();
						pst.close();
						return 0;
					}
				}
			}
			String query = "update exams set exam_isApproved=1 where exam_id=" + e.getExam_id();
			pst = con.prepareStatement(query);
			f = pst.executeUpdate();
			pst.close();
			if (f >= 1) {
				con.commit();
				con.close();
			}
		} catch (SQLException e1) {
			try {
				con.rollback();
				pst.close();
				con.close();
				return 0;
			} catch (SQLException e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return f;
	}

	public boolean isAlredyPermited(Long id, int exam_id) {
		con = ConnectionProvider.main();
		boolean f = false;
		String query = "select count(*) from exams_permission where exam_id=" + exam_id + " and student_id=" + id;
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				int f2 = res.getInt(1);
				f = f2 == 0 ? false : true;
				//con.close();
			}
		} catch (SQLException e) {
			
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}

		System.out.println(f);
		return f;
	}

	public ArrayList<Exams> getPermittedExam() {
		con = ConnectionProvider.main();
		ArrayList<Exams> permittedExamList = new ArrayList<Exams>();
		String query = "select * from exams where exam_privacy=1 and exam_isApproved=1";
		try {
			PreparedStatement pst = con.prepareStatement(query);
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Exams e = new Exams();
				e.setExam_batch(res.getInt("exam_batch"));
				e.setExam_course(res.getInt("exam_course"));
				e.setExam_duration(res.getInt("exam_duration"));
				e.setExam_end(res.getTimestamp("exam_end"));
				e.setExam_id(res.getInt("exam_id"));
				e.setExam_isApproved(res.getInt("exam_isApproved"));
				e.setExam_isOver(res.getInt("exam_isOver"));
				e.setExam_marks(res.getInt("exam_mark"));
				e.setExam_name(res.getString("exam_name"));
				e.setExam_privacy(res.getInt("exam_privacy"));
				e.setExam_question_amount(res.getInt("exam_question_amount"));
				e.setExam_section(res.getInt("exam_section"));
				e.setExam_start(res.getTimestamp("exam_start"));
				e.setExam_teacher(res.getLong("exam_teacher"));
				permittedExamList.add(e);
			}
		} catch (SQLException exc) {
			System.out.println(exc + " in ExamsDao; getAllExamById method; line 130");
		}
		try {
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return permittedExamList;
	}

	public int approvedAllStudent(String exam_id) {
		con = ConnectionProvider.main();
		int f = 0;
		String query = "update exams set exam_privacy=0, exam_isApproved=1 where exam_id=" + exam_id;
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

}
