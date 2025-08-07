package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import dao.QuestionsDao;
import entities.Questions;
import entities.Users;
import helper.ConnectionProvider;

/**
 * Servlet implementation class DeleteQuestionServlet
 */
public class DeleteQuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteQuestionServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		QuestionsDao qDao = new QuestionsDao(ConnectionProvider.main());
		String q_id = request.getParameter("q_id");
		HttpSession sc = request.getSession();
		Users cu = (Users) sc.getAttribute("current_user");
		Questions q = qDao.getQuestionById(Integer.parseInt(q_id));
		if (cu.getUser_id() == q.getQ_teacher()) {
			int f = qDao.deleteQuestionById(q_id);
			if (f != 0) {
				sc.setAttribute("question_delete_OK", "Successfully Deleted! ");

				File file = new File(getServletContext().getRealPath("/") + File.separator + "q_img" + File.separator
						+ q.getQ_img());
				file.delete();

				response.sendRedirect(request.getHeader("referer"));
			} else {
				sc.setAttribute("question_delete_BAD", "Can't Delete! ");
				response.sendRedirect(request.getHeader("referer"));
			}
		} else {
			sc.setAttribute("other_question_delete", "Can't be allowed to delete other teacher's questions! ");
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
