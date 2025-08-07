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
 * Servlet implementation class MakeAdminServlet
 */
public class MakeAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MakeAdminServlet() {
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
		int f = dao.makeAdmin(Long.parseLong(request.getParameter("user_id")));
		HttpSession s = request.getSession();
		if(f==0) {
			s.setAttribute("fail_admin", "Something Went Wrong! Try Again.");
		}else {
			s.setAttribute("success_admin", "Successfully Promote "+request.getParameter("user_id")+ "to an admin!");
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
