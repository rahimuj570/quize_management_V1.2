package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import dao.UsersDao;
import dao.VerifyPinsDao;
import entities.Users;
import entities.VerifyPin;
import helper.ConnectionProvider;
import helper.GEmailSender;
import helper.GeneratePinCode;

/**
 * Servlet implementation class ForgotePasswordSentCodeServlet
 */
public class ForgotePasswordSentCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgotePasswordSentCodeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("email");
		System.out.println(email);
		UsersDao dao = new UsersDao(ConnectionProvider.main());
		Users u = dao.getUserByEmail(email);
		VerifyPinsDao pinsDao = new VerifyPinsDao(ConnectionProvider.main());
		
		
		PrintWriter out = response.getWriter();
		if(u.getUser_email()==null) {
			out.print("user404");
		}else if(u.getUser_is_approved()==0) {
			out.print("not_approved");
		}else {
			VerifyPinsDao pinDao = new VerifyPinsDao(ConnectionProvider.main());
			VerifyPin vpin = pinDao.getVerifyCode(u.getUser_id(),1);
			
			if(vpin.getPin_code()==null) {
				//sent pin
				VerifyPin verify_pin = new VerifyPin();
				verify_pin.setPin_code(GeneratePinCode.getCode());
				verify_pin.setUser_id(u.getUser_id());
				verify_pin.setIs_for_reset_password(1);
				GEmailSender gEmailSender = new GEmailSender();
				//boolean f=false;
				//f = gEmailSender.sendEmail(u.getUser_email().strip(), "rujr2002@gmail.com", "Account Verification Code for QuizeManagement", "Your varification code is this 6 characters =>  " + verify_pin.getPin_code()+"\n   (This code will expire in 10 minutes.)");
				pinsDao.saveVerifyCode(verify_pin);
				//if(f) {
					out.print("sent_forgot_pass");
				//}else {
					//out.print("invalid");
				//}
			}else {
				if(!vpin.getExpire_date().before(new Date())) {
					
					out.print("already_sent_forgot_pass");
					
				}
				else{
					if(vpin.getExpire_date().before(new Date())){
						pinsDao.deleteVerifyCode(vpin.getUser_id(), 1);
					}
					//sent pin
					VerifyPin verify_pin = new VerifyPin();
					verify_pin.setPin_code(GeneratePinCode.getCode());
					verify_pin.setUser_id(u.getUser_id());
					verify_pin.setIs_for_reset_password(1);
					GEmailSender gEmailSender = new GEmailSender();
					//boolean f=false;
					//f = gEmailSender.sendEmail(u.getUser_email().strip(), "rujr2002@gmail.com", "Account Verification Code for QuizeManagement", "Your varification code is this 6 characters =>  " + verify_pin.getPin_code()+"\n   (This code will expire in 10 minutes.)");
					pinsDao.saveVerifyCode(verify_pin);
					//if(f) {
						out.print("sent_forgot_pass");
					//}
					//out.print("invalid");
				}
			}
			System.out.println(vpin);
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
