package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.UsersDao;
import entities.Users;
import helper.ConnectionProvider;

/**
 * Servlet implementation class DeclineUserServlet
 */
public class DeclineUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeclineUserServlet() {
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
		UsersDao dao = new UsersDao(ConnectionProvider.main());
		HttpSession s = request.getSession();
		Users me = (Users) s.getAttribute("current_user");
		if (me.getUser_id() == ((Long.parseLong(request.getParameter("user_id"))))) {
			s.setAttribute("fail_decline", "Failed To Decline! Please Try Again.");
		} else {
			int f = dao.declineUser( (Long.parseLong(request.getParameter("user_id"))));
			System.out.println(f);
			if (f == 0) {
				s.setAttribute("fail_decline", "Failed To Decline! Please Try Again.");
			} else {
				s.setAttribute("success_decline", "Successfully Decline " + request.getParameter("user_id"));
			}
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
