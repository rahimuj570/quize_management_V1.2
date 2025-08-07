package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

import dao.ExamsDao;
import entities.Exams;
import helper.ConnectionProvider;

/**
 * Servlet implementation class DeleteExamServlet
 */
public class DeleteExamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteExamServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
		Exams  e = eDao.getExamById(request.getParameter("exam_id"));
		HttpSession sc = request.getSession();
		if(e.getExam_start().before(new Date(new Date().getTime()+10*60000))) {
			sc.setAttribute("update_exam_401", "Can't Modify Exam Now, Please Contact with Admin!");
			response.sendRedirect(request.getHeader("referer"));
		}else {			
			int f=0;
			if(e.getExam_start().before(new Date(new Date().getTime()+10*60000))) {
				sc.setAttribute("update_exam_401", "Can't Modify Exam Now, Please Contact with Admin!");
				response.sendRedirect(request.getHeader("referer"));
			}else {				
				f = eDao.deleteExam(e.getExam_id());
				if (f == 0) {
					sc.setAttribute("update_exam_BAD", "Something Went Wrong!");
					response.sendRedirect(request.getHeader("referer"));
				} else {
					sc.setAttribute("delete_exam_OK", "Successfully Exam Deleted!");
					response.sendRedirect(request.getHeader("referer"));
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
