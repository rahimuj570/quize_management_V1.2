package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.Date;

import dao.CreateQuestionDao;
import dao.QuestionsDao;
import entities.Questions;
import entities.Users;
import helper.ConnectionProvider;

/**
 * Servlet implementation class UpdateQuestionServlet
 */
@MultipartConfig
public class UpdateQuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateQuestionServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String oldImgName = request.getParameter("oldImg");
		String deleteOldImg = request.getParameter("deleteOldImg");
		if(deleteOldImg.equals("1")) {
			File oldImg = new File(getServletConfig().getServletContext().getRealPath("/") +File.separator + "q_img" + File.separator + oldImgName);
			oldImg.delete();
			oldImgName="";
		}
		
		Part file = request.getPart("q_img");
		String fileName = "";
		if (file.getSize() != 0) {
			String fileFormate = file.getSubmittedFileName().substring(file.getSubmittedFileName().indexOf('.'));
			File dir = new File(getServletContext().getRealPath("/") + "/q_img");
			if (!dir.exists()) {
				dir.mkdir();
			}
			fileName = new Timestamp(new Date().getTime()).toString().replace(' ', '_').replace(':', '_').replace('.',
					'_') + fileFormate;
			String uploadLocation = getServletContext().getRealPath("/") + File.separator + "q_img" + File.separator
					+ fileName;
			System.out.println(uploadLocation);
			FileOutputStream fos = new FileOutputStream(uploadLocation);
			InputStream is = file.getInputStream();
			byte[] imgBytes = new byte[is.available()];
			is.read(imgBytes);
			fos.write(imgBytes);
			fos.close();
			oldImgName="";
			System.out.println(oldImgName);
			if (!oldImgName.isBlank()) {
				File oldImg = new File(getServletConfig().getServletContext().getRealPath("/") +File.separator + "q_img" + File.separator + oldImgName);
				oldImg.delete();
				fileName = "";
				
			}
		}else {
			fileName = oldImgName;
		}

		HttpSession sc = request.getSession();
		Users cu = (Users) sc.getAttribute("current_user");
		Questions questions = new Questions();
		questions.setQ_img(fileName);
		questions.setQ_teacher(cu.getUser_id());
		questions.setQ_batch(Integer.parseInt(request.getParameter("batch")));
		questions.setQ_difficulty(Integer.parseInt(request.getParameter("difficulty")));
		questions.setQ_privacy(Integer.parseInt(request.getParameter("privacy")));
		questions.setQ_section(Integer.parseInt(request.getParameter("section")));
		questions.setQ_statement(request.getParameter("q_statement"));
		questions.setQ_subject(Integer.parseInt(request.getParameter("course")));

		String opt_1 = request.getParameter("opt_1");
		String opt_2 = request.getParameter("opt_2");
		String opt_3 = request.getParameter("opt_3");
		String opt_n = request.getParameter("opt_n");
		String allWrongOpt = opt_n.isBlank() ? (opt_1 + "///" + opt_2 + "///" + opt_3)
				: (opt_n + "///" + opt_1 + "///" + opt_2 + "///" + opt_3);
		String optList[] = allWrongOpt.split("///");
		String ans_1 = request.getParameter("ans_1");
		String ans_n = request.getParameter("ans_n");
		String allAnswer = ans_n.isBlank() ? (ans_1) : (ans_n + "///" + ans_1);
		String ansList[] = allAnswer.split("///");

		QuestionsDao qDao = new QuestionsDao(ConnectionProvider.main());
		int f = qDao.updateQuestion(optList, ansList, questions, Integer.parseInt(request.getParameter("q_id")));

		if (f == 1) {
			sc.setAttribute("question_update_success", "Question Updated Successfully!");
		} else {
			sc.setAttribute("question_update_fail", "Something Went Wrong!");
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
