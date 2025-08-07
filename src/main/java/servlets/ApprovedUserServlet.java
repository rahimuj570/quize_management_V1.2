package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.UsersDao;
import helper.ConnectionProvider;

/**
 * Servlet implementation class ApprovedUserServlet
 */
public class ApprovedUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ApprovedUserServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		UsersDao dao = new UsersDao(ConnectionProvider.main());
		int f = dao.approvedUser((Long.parseLong(request.getParameter("user_id"))));
		System.out.println(f);
		HttpSession s = request.getSession();
		if (f == 0) {
			s.setAttribute("fail_approved", "Failed To Approved! Please Try Again.");
		} else {
			s.setAttribute("success_approved", "Successfully Approved " + request.getParameter("user_id"));
		}
		response.sendRedirect("admin/pending_users.jsp");
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
