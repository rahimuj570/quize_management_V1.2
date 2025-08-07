package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import dao.ExamsDao;
import entities.Exams;
import entities.Users;
import helper.ConnectionProvider;
import helper.TempExamCreateSessionPOJO;

/**
 * Servlet implementation class CreateExamServlet
 */
public class CreateExamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateExamServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Exams exm = new Exams();
		HttpSession sc = request.getSession();
		Users cu = (Users) sc.getAttribute("current_user");
		String question_sets[] = request.getParameterValues("mark[]");
		if (question_sets == null) {
			sc.setAttribute("no_qs_select", "Select at least one question set!");
			response.sendRedirect(request.getHeader("referer"));
		} else if (sc.getAttribute("temp_exam_create") == null) {
			response.sendRedirect(request.getContextPath() + "/teacher/create_exam.jsp");
		} else {
			TempExamCreateSessionPOJO texm = (TempExamCreateSessionPOJO) sc.getAttribute("temp_exam_create");
			exm.setExam_batch(Integer.parseInt(texm.getExam_batch()));
			exm.setExam_course(Integer.parseInt(texm.getExam_course()));
			exm.setExam_duration(Integer.parseInt(texm.getExam_duration()));
			exm.setExam_marks(Integer.parseInt(texm.getExam_total_mark()));
			exm.setExam_name(texm.getExam_name());
			exm.setExam_privacy(Integer.parseInt(texm.getExam_privacy()));
			exm.setExam_question_amount(Integer.parseInt(texm.getExam_question_amount()));
			exm.setExam_section(Integer.parseInt(texm.getExam_section()));

			String d = texm.getExam_date() + " " + texm.getExam_time();
			SimpleDateFormat dfor = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			try {
				Date date = dfor.parse(d);
				exm.setExam_start(date);
				exm.setExam_end(new Date(date.getTime() + Integer.parseInt(texm.getExam_duration()) * 60000));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			if (exm.getExam_end().before(new Date())) {
				exm.setExam_isOver(1);
			} else {
				exm.setExam_isOver(0);
			}
			if(Integer.parseInt(texm.getExam_privacy())==0) {
				if(texm.getExam_name().contains("Mid") || texm.getExam_name().contains("Final")) {					
					exm.setExam_isApproved(0);				
				}else {					
					exm.setExam_isApproved(1);
				}
			}else {
				exm.setExam_isApproved(0);				
			}
			exm.setExam_teacher(cu.getUser_id());

			ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
			int f = eDao.createExam(exm, question_sets);
			sc.removeAttribute("temp_exam_create");
			if(f==0) {
				sc.setAttribute("create_exam_BAD", "Something Went Wrong!");
				response.sendRedirect(request.getContextPath()+"/teacher/create_exam.jsp");
			}else {
				sc.setAttribute("create_exam_OK", "Successfully Exam Created!");				
				response.sendRedirect(request.getContextPath()+"/teacher/show_exams.jsp");
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
