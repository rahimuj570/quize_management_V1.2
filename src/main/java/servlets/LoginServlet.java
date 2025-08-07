package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.UsersDao;
import entities.Users;
import helper.ConnectionProvider;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
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
		String save_login = request.getParameter("save_login");
		Users u = null;
		UsersDao dao = new UsersDao(ConnectionProvider.main());
		if (request.getParameter("email_id").contains("@")) {
			u = dao.getUser("email", request.getParameter("email_id"), request.getParameter("password"));
		} else {
			u = dao.getUser("id", request.getParameter("email_id"), request.getParameter("password"));
		}
		HttpSession s = request.getSession();
		if (u == null) {
			s.setAttribute("user404", "User not found!");
			response.sendRedirect("login.jsp");
		} else if (u.getUser_is_varified() == 0) {
			s.setAttribute("verify_user_id", u.getUser_id());
			s.setAttribute("current_user", u);
			response.sendRedirect("verify.jsp");
		} else if (u.getUser_is_approved() == 0) {
			s.setAttribute("not-approved", "Your account is not approved yet!");
			response.sendRedirect("login.jsp");
		} else {
			s.setAttribute("current_user", u);
			
			if(save_login!=null) {
				Cookie loginCookie = new Cookie("save_login", u.getUser_id()+""); // 'username' is the logged-in user's name
				loginCookie.setMaxAge(60 * 60); // Valid for 1 hour
				loginCookie.setPath("/"); // Accessible across the entire app
				loginCookie.setSecure(true); // Use only over HTTPS
				loginCookie.setHttpOnly(true); // Prevent JavaScript access

				response.addCookie(loginCookie);
			}

			
			
			if (u.getUser_is_teacher() == 1) {
				response.sendRedirect(request.getContextPath() + "/teacher/dashboard.jsp");
			} else if (u.getUser_is_admin() == 1) {
				response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
			} else {
				response.sendRedirect(request.getContextPath() + "/student/dashboard.jsp");
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
