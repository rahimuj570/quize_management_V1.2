package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import dao.ExamsDao;
import entities.Exams;
import entities.ExamsEvaluation;
import entities.Users;
import helper.ConnectionProvider;
import helper.QuestionToAnswerePOJO;

/**
 * Servlet implementation class EvaluateExamServlet
 */
public class EvaluateExamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EvaluateExamServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String exam_id = request.getParameter("exam_id");
		HttpSession sc = request.getSession();
		Users cu = (Users) sc.getAttribute("current_user");
		ArrayList<QuestionToAnswerePOJO> qaPOJOList = (ArrayList<QuestionToAnswerePOJO>) sc
				.getAttribute("current_exam_selected_options");
		ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
		Exams e = eDao.getExamById(exam_id);
		Map<String, String[]> selectedOptList = request.getParameterMap();

		for (QuestionToAnswerePOJO qaPOJO : qaPOJOList) {
			if (selectedOptList.containsKey(qaPOJO.getQuestion_id() + "")) {
				qaPOJO.setSelected_option_id(Integer.parseInt((selectedOptList.get(qaPOJO.getQuestion_id() + "")[0])));
			}

		}
		int correct_ans = 0;
		int wrong_answer = 0;
		int pass_answer = 0;
		for (QuestionToAnswerePOJO qaPOJO : qaPOJOList) {
			if (qaPOJO.getSelected_option_id() == qaPOJO.getAnswer_id()) {
				correct_ans++;
			} else if (qaPOJO.getSelected_option_id() == 0) {
				pass_answer++;
			} else {
				wrong_answer++;
			}
		}
		ExamsEvaluation eev = new ExamsEvaluation();
		eev.setCorrect_answer(correct_ans);
		eev.setExam_id(e.getExam_id());
		eev.setIsExpelled(0);
		eev.setPass_question(pass_answer);
		eev.setStudent_id(cu.getUser_id());
		eev.setWrong_answer(wrong_answer);
		System.out.println(correct_ans);
		System.out.println(wrong_answer);
		System.out.println(pass_answer);
		int f = eDao.updateExamEvaluation(eev);
		if (f == 0) {
			sc.setAttribute("exam_valuation_BAD", "Something Went Wrong! Immediately contact with your course Teacher");
		} else {
			sc.setAttribute("current_exam_evaluation", eev);
		}
		response.sendRedirect(request.getContextPath()+"/student/exam_evaluation.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
