package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.ExamsDao;
import entities.Exams;
import helper.ConnectionProvider;

/**
 * Servlet implementation class ApprovedAllStudent
 */
public class ApprovedAllStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ApprovedAllStudent() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
		HttpSession sc = request.getSession();
		int f = eDao.approvedAllStudent(request.getParameter("exam_id"));
		if (f == 0) {
			sc.setAttribute("permission_BAD", "Something went wrong!");
			response.sendRedirect(request.getHeader("referer"));
		} else {
			sc.setAttribute("permission_OK", "Exam is approved!");
			response.sendRedirect(request.getContextPath() + "/admin/show_permitted_exams.jsp");
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
