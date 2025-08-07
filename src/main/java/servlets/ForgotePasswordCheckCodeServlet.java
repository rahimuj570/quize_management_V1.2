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

/**
 * Servlet implementation class ForgotePasswordCheckCodeServlet
 */
public class ForgotePasswordCheckCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgotePasswordCheckCodeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String code = request.getParameter("code");
		String email = request.getParameter("email");
		String newPassword = request.getParameter("password");
		String newRePassword = request.getParameter("re_password");
		HttpSession sc =request.getSession();
		VerifyPinsDao pinDao = new VerifyPinsDao(ConnectionProvider.main());
		UsersDao uDao = new UsersDao(ConnectionProvider.main());
		Users u = uDao.getUserByEmail(email);
		VerifyPin vpin = new VerifyPin();
		if(!newPassword.equals(newRePassword)) {
			sc.setAttribute("pass_mismatch", "Passwords is not matched with each other!");
			response.sendRedirect("set_new_password.jsp");
		}
		else if(code.length()!=6) {
			sc.setAttribute("invalid_pin", "Invalid Pin!");
			response.sendRedirect("set_new_password.jsp");
		}else {			
			if(u.getUser_email()==null) {
				sc.setAttribute("user4042", "User Not Found!");
				response.sendRedirect("set_new_password.jsp");
			}else {
				vpin = pinDao.getVerifyCode(u.getUser_id(), 1);

				//==================		
				if(vpin.getPin_code()==null) {
						sc.setAttribute("pin404", "Request for a new Pin!");
						response.sendRedirect("set_new_password.jsp");
					}else {
						if(vpin.getUser_id()==u.getUser_id()) {
							//================
							if(vpin.getExpire_date().before(new Date())) {
								pinDao.deleteVerifyCode(u.getUser_id(),1);
								sc.setAttribute("expire_forgot_pass", "Your Pin Is Expired!");
								response.sendRedirect("set_new_password.jsp");
							}else {
								//==============
								if(vpin.getPin_code().equals(code)) {
									int f = uDao.editPassword(u.getUser_id(), newPassword);
									if(f==1) {
										pinDao.deleteVerifyCode(u.getUser_id(),1);
										sc.setAttribute("success_change_pass", "Successfully Password Changed!");
										response.sendRedirect("login.jsp");
									}else {
										sc.setAttribute("failed_change_pass", "Something went wrong in the server!");
										response.sendRedirect("set_new_password.jsp");
									}
								}else {
									sc.setAttribute("pin_mismatch", "Incorrect Pin Code!");
									response.sendRedirect("set_new_password.jsp");
								}
								//================
							}
							//==============
						}else {
							sc.setAttribute("verify404", "Account and PIN is not matched!");
							response.sendRedirect("set_new_password.jsp");
						}
					}
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
