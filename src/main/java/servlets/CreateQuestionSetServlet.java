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
import entities.Users;
import helper.ConnectionProvider;

/**
 * Servlet implementation class CreateQuestionSetServlet
 */
public class CreateQuestionSetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateQuestionSetServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String qs_name = request.getParameter("qs_name");
		String qs_batch = request.getParameter("batch");
		String qs_section = request.getParameter("section");
		String qs_course = request.getParameter("course");
		QuestionSets qs = new QuestionSets();
		qs.setQs_batch(Integer.parseInt(qs_batch));
		qs.setQs_course(Integer.parseInt(qs_course));
		qs.setQs_name(qs_name);
		qs.setQs_section(Integer.parseInt(qs_section));
		HttpSession sc = request.getSession();
		Users cu = (Users) sc.getAttribute("current_user");
		qs.setQs_teacher(cu.getUser_id());
		QuestionSetsDao qsDao = new QuestionSetsDao(ConnectionProvider.main());
		int f = qsDao.createQuestionSet(qs);
		
		if(f==1) {
			sc.setAttribute("qs_create_success", "Question Set Created Successfully!");
		}else {
			sc.setAttribute("qs_create_fail", "Something Went Wrong!");
		}
		response.sendRedirect(request.getHeader("referer"));
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
