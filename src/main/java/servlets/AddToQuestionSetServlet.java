package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.QuestionSetsDao;
import helper.ConnectionProvider;

/**
 * Servlet implementation class AddToQuestionSetServlet
 */
public class AddToQuestionSetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddToQuestionSetServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String q_ids[] = request.getParameterValues("mark[]");
		
		
//		System.out.println(q_ids.length);
		
		
		String qs_id = request.getParameter("qs");
		HttpSession sc = request.getSession();
		if (q_ids == null) {
			sc.setAttribute("no_question_slected", "Need to Mark the Questions!");
			response.sendRedirect(request.getHeader("referer"));
		} else if (qs_id.equals("0")) {
			sc.setAttribute("no_question_set_slected", "No Question Set Selected!");
			response.sendRedirect(request.getHeader("referer"));
		}

		else {
			QuestionSetsDao qsDao = new QuestionSetsDao(ConnectionProvider.main());
			int f = qsDao.addToQuestionSet(qs_id, q_ids);
			if (f != 0) {
				sc.setAttribute("add_to_question_set_OK", "Successfully Added!");
				response.sendRedirect(request.getHeader("referer"));
			} else {
				sc.setAttribute("add_to_question_set_BAD", "Something Went Wrong!");
				response.sendRedirect(request.getHeader("referer"));
			}
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
