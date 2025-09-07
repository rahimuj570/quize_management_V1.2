package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import secret.VERIFY_CODE;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import dao.UsersDao;
import dao.VerifyPinsDao;
import entities.Users;
import entities.VerifyPin;
import helper.ConnectionProvider;
import helper.GEmailSender;
import helper.GeneratePinCode;
import helper.GetBatchSectionOfStudentPOJO;

/**
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
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
		Users u = new Users();
		u.setUser_first_name(request.getParameter("fname"));
		u.setUser_last_name(request.getParameter("lname"));
		u.setUser_id(Long.parseLong(request.getParameter("id")));
		u.setUser_email(request.getParameter("email"));
		u.setUser_password(request.getParameter("password"));
		u.setUser_is_teacher(Integer.parseInt(request.getParameter("role")));
		u.setUser_section(request.getParameter("section"));
		u.setUser_batch(request.getParameter("batch"));
		GetBatchSectionOfStudentPOJO bs = new GetBatchSectionOfStudentPOJO();
		try {
			bs.setBatchId(Integer.parseInt(request.getParameter("batch")));
			bs.setSectionId(Integer.parseInt(request.getParameter("section")));
		} catch (Exception e) {
			bs.setBatchId(0);
			bs.setSectionId(0);
		}

		System.out.println(u);

		int f = -1;
		VerifyPin verify_pin = new VerifyPin();
		verify_pin.setPin_code(GeneratePinCode.getCode());
		verify_pin.setUser_id(u.getUser_id());
		GEmailSender gEmailSender = new GEmailSender();
		VerifyPinsDao pinsDao = new VerifyPinsDao(ConnectionProvider.main());
		f = pinsDao.saveVerifyCode(verify_pin);

		if (f == 1) {
			UsersDao dao = new UsersDao(ConnectionProvider.main());
			f = dao.saveUser(u, bs);
			if (f == 1) {
				gEmailSender.sendEmail(u.getUser_email().strip(), "rujr2002@gmail.com",
						"Account Verification Code for QuizeManagement",
						"Your varification code is this 6 characters =>  " + verify_pin.getPin_code()
								+ "\n   (This code will expire in 10 minutes.)");
			}
		}
		PrintWriter out = response.getWriter();
		System.out.println(f);
		out.print(f);
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
