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
 * Servlet implementation class ChangePasswordServlet
 */
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String password = request.getParameter("p");
		UsersDao uDao = new UsersDao(ConnectionProvider.main());
		HttpSession sc = request.getSession();
		Users cu = (Users) sc.getAttribute("current_user");
		if(cu.getUser_id()==0) {
			response.sendRedirect(request.getHeader("referer"));
		}else {			
			int f= uDao.changePassword(cu,password);
			if(f!=0) {
				sc.setAttribute("password_change_OK", "Password Changed!");
				response.sendRedirect(request.getHeader("referer"));
			}else {
				sc.setAttribute("password_change_BAD", "Password isn't Changed!");
				response.sendRedirect(request.getHeader("referer"));
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
