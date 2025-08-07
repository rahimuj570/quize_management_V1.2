package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.QuestionSetsDao;
import dao.QuestionsDao;
import entities.QuestionSets;
import entities.Questions;
import entities.Users;
import helper.ConnectionProvider;

/**
 * Servlet implementation class RemoveToQuestionSetServlet
 */
public class RemoveToQuestionSetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemoveToQuestionSetServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String qs_id = request.getParameter("qs");
		String q_id = request.getParameter("q_id");
		QuestionSetsDao qsDao = new QuestionSetsDao(ConnectionProvider.main());
		QuestionSets qs = qsDao.getQuestionSetById(qs_id);
		HttpSession sc = request.getSession();
		Users cu = (Users) sc.getAttribute("current_user");
		if(cu.getUser_id().toString().equals(qs.getQs_teacher().toString())) {
			int f = qsDao.removeToQuestionSet(qs_id, q_id);
			if (f != 0) {
				sc.setAttribute("remove_to_question_set_OK", "Successfully Removed!");
				response.sendRedirect(request.getHeader("referer"));
			} else {
				sc.setAttribute("remove_to_question_set_BAD", "Something Went Wrong!");
				response.sendRedirect(request.getHeader("referer"));
			}
		}else {
			sc.setAttribute("other_question_remove", "Can't be allowed to modify other teacher's question set! ");
			response.sendRedirect(request.getHeader("referer"));
		}
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
