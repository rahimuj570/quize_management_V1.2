package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Scanner;

import dao.ExamsDao;
import entities.Exams;
import helper.ConnectionProvider;

/**
 * Servlet implementation class ApprovedExamServlet
 */
@MultipartConfig
public class ApprovedExamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ApprovedExamServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String exam_id = request.getParameter("exam_id");
		String idList = request.getParameter("id_list");
		Part csvFile = request.getPart("csv_file");
		HttpSession sc = request.getSession();
		ArrayList<Long> ids = new ArrayList<Long>();
		if (idList.isBlank() && csvFile.getSize() == 0) {
			sc.setAttribute("no_list_added", "Need to provide IDs");
			response.sendRedirect(request.getHeader("referer"));
		} else {
			if (idList.isBlank()) {
				InputStream fis = csvFile.getInputStream();
				byte[] csvByte = new byte[fis.available()];
				fis.read(csvByte);
				String s = new String(csvByte);
				String[] s2 = s.split("\n");
				for (int i = 1; i < s2.length; i++) {
					s2[i] = s2[i].strip();
					s2[i] = s2[i].replace("\"", "");
					s2[i] = s2[i].replace(",", "");
					s2[i] = s2[i].replace("\n", "");
					if (!s2[i].isBlank() && s2[i].length() != 0 && !s2[i].isEmpty())
						ids.add(Long.parseLong(s2[i]));
				}
			} else {
				String[] s2 = idList.split("[,\n]");
				for (int i = 0; i < s2.length; i++) {
					s2[i] = s2[i].strip();
					s2[i] = s2[i].replace("\"", "");
					s2[i] = s2[i].replace(",", "");
					s2[i] = s2[i].replace("\n", "");
					if (!s2[i].isBlank() && s2[i].length() != 0 && !s2[i].isEmpty())
						ids.add(Long.parseLong(s2[i]));
				}
			}

			ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
			Exams e = eDao.getExamById(exam_id);
			int f = eDao.addStudentPermission(e, ids);
			if(f==0) {
				sc.setAttribute("permission_BAD", "Something went wrong!");
				response.sendRedirect(request.getHeader("referer"));
			}else {
				sc.setAttribute("permission_OK", "Exam is approved!");				
				response.sendRedirect(request.getContextPath()+"/admin/show_permitted_exams.jsp");
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
