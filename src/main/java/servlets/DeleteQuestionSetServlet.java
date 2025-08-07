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
 * Servlet implementation class DeleteQuestionSetServlet
 */
public class DeleteQuestionSetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteQuestionSetServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		QuestionSetsDao qDao = new QuestionSetsDao(ConnectionProvider.main());
		String qs_id = request.getParameter("qs");
		HttpSession sc = request.getSession();
		Users cu = (Users) sc.getAttribute("current_user");
		QuestionSets q = qDao.getQuestionSetById(qs_id);
		if (cu.getUser_id().toString().equals(q.getQs_teacher().toString())) {
			int f = qDao.deleteQuestionSetById(qs_id);
			if (f != 0) {
				sc.setAttribute("qs_delete_OK", "Successfully Deleted! ");
				response.sendRedirect(request.getHeader("referer"));
			} else {
				sc.setAttribute("qs_delete_BAD", "Can't Delete! ");
				response.sendRedirect(request.getHeader("referer"));
			}
		} else {
			sc.setAttribute("other_qs_delete", "Can't be allowed to delete other teacher's question sets! ");
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
