package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import dao.CreateQuestionDao;
import entities.Options;
import entities.Questions;
import entities.Users;
import helper.ConnectionProvider;
import helper.QuestionCommonSession;

/**
 * Servlet implementation class CreateQuestionServlet
 */
@MultipartConfig
public class CreateQuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateQuestionServlet() {
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
		Part file = request.getPart("q_img");
		HttpSession sc = request.getSession();
		String fileName = "";
		if (file.getSize() != 0) {
System.out.println(file.getSize());
			if (file.getSize()>2000000) {
				sc.setAttribute("big_img", "Image size should be less than 2MB");
				response.sendRedirect(request.getHeader("referer"));
			} else {
				String fileFormate = file.getSubmittedFileName().substring(file.getSubmittedFileName().lastIndexOf('.'));
				File dir = new File(getServletContext().getRealPath("/") + "/q_img");
				if (!dir.exists()) {
					dir.mkdir();
				}
				fileName = new Timestamp(new Date().getTime()).toString().replace(' ', '_').replace(':', '_')
						.replace('.', '_') + fileFormate;
				String uploadLocation = getServletContext().getRealPath("/") + File.separator + "q_img" + File.separator
						+ fileName;
				System.out.println(uploadLocation);
				FileOutputStream fos = new FileOutputStream(uploadLocation);
				InputStream is = file.getInputStream();
				byte[] imgBytes = new byte[is.available()];
				is.read(imgBytes);
				fos.write(imgBytes);
				fos.close();

				// Remain Working procedure if image available

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
				
				
				QuestionCommonSession qcs = new QuestionCommonSession();
				qcs.setBatch(request.getParameter("batch"));
				qcs.setCourse(request.getParameter("course"));
				qcs.setDifficulty(request.getParameter("difficulty"));
				qcs.setPrivacy(request.getParameter("privacy"));
				qcs.setQ_set(request.getParameter("q_set"));
				qcs.setSection(request.getParameter("section"));
				sc.setAttribute("common_q", qcs);
				

				int question_set = Integer.parseInt(request.getParameter("q_set"));
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

				CreateQuestionDao qdao = new CreateQuestionDao(ConnectionProvider.main());
				System.out.println("fffffffffffffff");
				System.out.println(questions);
				
				
				int f = qdao.createQuestion(optList, ansList, questions, question_set);

				if (f == 1) {
					sc.setAttribute("question_create_success", "Question Created Successfully!");
				} else {
					sc.setAttribute("question_create_fail", "Something Went Wrong!");
				}
				response.sendRedirect(request.getHeader("referer"));

			}

		} else {

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
			
			
			
			QuestionCommonSession qcs = new QuestionCommonSession();
			qcs.setBatch(request.getParameter("batch"));
			qcs.setCourse(request.getParameter("course"));
			qcs.setDifficulty(request.getParameter("difficulty"));
			qcs.setPrivacy(request.getParameter("privacy"));
			qcs.setQ_set(request.getParameter("q_set"));
			qcs.setSection(request.getParameter("section"));
			sc.setAttribute("common_q", qcs);
			

			int question_set = Integer.parseInt(request.getParameter("q_set"));
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

			CreateQuestionDao qdao = new CreateQuestionDao(ConnectionProvider.main());
			
			
			System.out.println("fffffffffffffff");
			System.out.println(questions);
			
			
			int f = qdao.createQuestion(optList, ansList, questions, question_set);

			if (f == 1) {
				sc.setAttribute("question_create_success", "Question Created Successfully!");
			} else {
				sc.setAttribute("question_create_fail", "Something Went Wrong!");
			}
			response.sendRedirect(request.getHeader("referer"));

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
