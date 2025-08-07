package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

import dao.UsersDao;
import dao.VerifyPinsDao;
import entities.Users;
import entities.VerifyPin;
import helper.ConnectionProvider;
import helper.GEmailSender;
import helper.GeneratePinCode;

/**
 * Servlet implementation class ResentCodeServlet
 */
public class ResentCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ResentCodeServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession sc = request.getSession();
		Users u = (Users) sc.getAttribute("current_user");
		System.out.println(u.getUser_is_varified());
		System.out.println(u.getUser_is_varified());
		if (u.getUser_is_varified() == 1 || sc.getAttribute("verify_user_id") == null) {
			response.getWriter().append("login_redirect");
		} else {
			String email = new UsersDao(ConnectionProvider.main())
					.checkExistUser((long) sc.getAttribute("verify_user_id"));
			if (email != null) {
				VerifyPinsDao dao = new VerifyPinsDao(ConnectionProvider.main());
				VerifyPin vpin = dao.getVerifyCode((long) sc.getAttribute("verify_user_id"));
				if ((vpin.getPin_code() == null || vpin.getExpire_date().before(new Date()))) {
					VerifyPin verify_pin = new VerifyPin();
					verify_pin.setPin_code(GeneratePinCode.getCode());
					verify_pin.setUser_id((long) sc.getAttribute("verify_user_id"));
					GEmailSender gEmailSender = new GEmailSender();
					gEmailSender.sendEmail(email.strip(), "rujr2002@gmail.com",
							"Account Verification Code for QuizeManagement",
							"Your varification code is this 6characters => " + verify_pin.getPin_code()
									+ "\n (This code will expire in10minutes.)");
					VerifyPinsDao pinsDao = new VerifyPinsDao(ConnectionProvider.main());
					int f = pinsDao.saveVerifyCode(verify_pin);
					if (f == 0) {
						response.getWriter().append("server_error");
					} else {
						response.getWriter().append("sent");
					}
				} else {
					response.getWriter().append("not_sent");
				}

			} else {
				response.getWriter().append("user_not_exist");
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

//	protected void reSentCode(long user_id) {
//		VerifyPin verify_pin = new VerifyPin();
//		verify_pin.setPin_code(GeneratePinCode.getCode());
//		verify_pin.setUser_id(user_id);
//		GEmailSender gEmailSender = new GEmailSender();
//		 gEmailSender.sendEmail(u.getUser_email().strip(), "rujr2002@gmail.com","Account Verification Code for QuizeManagement", "Your varification code is this 6 characters => " + verifyCode+"\n (This code will expire in 10minutes.)");
//		VerifyPinsDao pinsDao = new VerifyPinsDao(ConnectionProvider.main());
//		pinsDao.saveVerifyCode(verify_pin);
//	}

}
