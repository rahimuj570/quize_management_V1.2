package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.util.Date;

import org.apache.catalina.Session;

import dao.UsersDao;
import dao.VerifyPinsDao;
import entities.VerifyPin;
import helper.ConnectionProvider;

/**
 * Servlet implementation class VerifyCodeServlet
 */
public class VerifyCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public VerifyCodeServlet() {
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
		String inputCode = request.getParameter("code");
		System.out.println(inputCode.length());
		System.out.println(inputCode);
		if (inputCode.length() != 6) {
			response.getWriter().append("invalid");
		} else {
			VerifyPinsDao dao = new VerifyPinsDao(ConnectionProvider.main());
			UsersDao udao = new UsersDao(ConnectionProvider.con);
			HttpSession sc = request.getSession();
			VerifyPin vpin = dao.getVerifyCode((long) sc.getAttribute("verify_user_id"));
			System.out.println(vpin);
			if (vpin.getPin_code()==null) {
				response.getWriter().append("request_new_pin");
			} else if (vpin.getExpire_date().before(new Date())) {
				dao.reConnectDb(ConnectionProvider.main());
				dao.deleteVerifyCode((long) sc.getAttribute("verify_user_id"));
				response.getWriter().append("expire");
			} else {
				if (vpin.getPin_code().equals(inputCode) && vpin.getIs_for_reset_password()==0) {
					response.getWriter().append("valid");
					int f = udao.verifiedUser((long) sc.getAttribute("verify_user_id"));
					if(f==0)response.getWriter().append("server_error");
					dao.reConnectDb(ConnectionProvider.main());
					dao.deleteVerifyCode((long) sc.getAttribute("verify_user_id"));
					sc.removeAttribute("verify_user_id");
				} else {
					response.getWriter().append("mismatch");
				}
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
