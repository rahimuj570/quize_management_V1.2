<%@page import="java.util.Map"%>
<%@page import="helper.GetBatchSectionOfStudentPOJO"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.ExamsEvaluation"%>
<%@page import="helper.QuestionToAnswerePOJO"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="entities.Users"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="entities.Options"%>
<%@page import="java.io.File"%>
<%@page import="entities.Questions"%>
<%@page import="entities.Exams"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ExamsDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Exam Name</title>
<style type="text/css">
.grid2cols {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
}
</style>

</head>
<body oncontextmenu="return false" onselectstart="return false"
	onpaste="return false;" onCopy="return false" onCut="return false"
	onDrag="return false" onDrop="return false" autocomplete=off>
	<%
	Connection con = ConnectionProvider.main();
	BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
	ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
	Users cu = (Users) session.getAttribute("current_user");
	GetBatchSectionOfStudentPOJO bs = bsDao.getBatchSectionOfStudent(cu.getUser_id());
	Exams e = eDao.getExamById(request.getParameter("exam_id"));
	if (!eDao.isAlredyPermited(cu.getUser_id(), e.getExam_id()) && e.getExam_privacy() == 1) {
		response.sendRedirect(request.getContextPath() + "/student/my_exams.jsp");
	} else {
		con = ConnectionProvider.main();
		String query2 = "select count(*) from tmp_exam_entry where student_id=" + cu.getUser_id() + " and exam_id="
		+ e.getExam_id();
		PreparedStatement pst2 = con.prepareStatement(query2);
		ResultSet res = pst2.executeQuery();
		int isSecondTimeEntry = res.next() ? res.getInt(1) : 0;

		if (request.getHeader("referer") != null && isSecondTimeEntry == 0 && e.getExam_id() != 0
		&& request.getParameter("exam_id") != null && e != null && cu.getUser_is_teacher() == 0
		&& bs.getBatchId() == (e.getExam_batch())
		&& (bs.getSectionId() == (e.getExam_section()) || e.getExam_section() == 0)) {

			if (!e.getExam_start().before(new Date(new Date().getTime()))) {
		session.setAttribute("exam_early_entry", " Early entry is not allowed!");
		response.sendRedirect("my_exams.jsp");
			} else if (e.getExam_end().before(new Date(new Date().getTime()))) {
		session.setAttribute("exam_over_entry", " Exam is Over!");
		response.sendRedirect("my_exams.jsp");
			} else {
		ExamsEvaluation eev = new ExamsEvaluation();
		eev.setCorrect_answer(0);
		eev.setExam_id(e.getExam_id());
		eev.setIsExpelled(1);
		eev.setPass_question(e.getExam_question_amount());
		eev.setStudent_id(cu.getUser_id());
		eev.setWrong_answer(0);
		eDao.createExamEvaluation(eev);
		con = ConnectionProvider.main();
		String query = "insert into tmp_exam_entry (student_id, exam_id) value (?,?);";
		PreparedStatement pst = con.prepareStatement(query);
		pst.setLong(1, cu.getUser_id());
		pst.setInt(2, e.getExam_id());
		pst.executeUpdate();
			}

		} else {
			session.setAttribute("exam_violation", " You are not allowed entry due to violation of rules!");
			response.sendRedirect("my_exams.jsp");
		}
	%>
	<div id="pdf_body">
		<p
			style="position: fixed; right: 20px; border: 1px solid blue; padding: 10px; background: aquamarine; cursor: no-drop;"
			id="timer">12:22</p>
		<div>
			<h1><%=e.getExam_name()%></h1>
			<p>
				Batch:
				<%=bsDao.getBatchNameById(e.getExam_batch())%></p>
			<p>
				Section:
				<%=bsDao.getSectionNameById(e.getExam_section())%></p>
			<p>
				Course:
				<%=bsDao.getCourseNameById(e.getExam_course())%></p>
			<p>
				Student ID:
				<%=cu.getUser_id()%></p>
			<p>
				<section class="grid2cols">
					<p>
						Exam Mark:
						<%=e.getExam_marks()%></p>
					<p>
						Question Quantity:
						<%=e.getExam_question_amount()%></p>
					<p>
						Exam Duration:
						<%=e.getExam_duration()%>
						Minutes
					</p>
					<p>
						Exam will End:
						<%=e.getExam_end()%></p>
				</section>
			<hr style="width: 100%; border: 1px solid black;" />
			<hr style="width: 100%; border: 1px solid black;" />
		</div>

		<form id="ansForm" action="#">
			<input type="hidden" name="exam_id" value="<%=e.getExam_id()%>" />
			<section
				style="background: gray; padding: 20px 0px; display: flex; flex-direction: column; align-items: center; gap: 20px">
				<%
				ArrayList<Questions> qList = eDao.getAllQuestionOfExam(e.getExam_id(), e.getExam_question_amount());
				int sl = 0;
				ArrayList<QuestionToAnswerePOJO> qaPOJOList = new ArrayList<QuestionToAnswerePOJO>();
				for (Questions q : qList) {
					QuestionToAnswerePOJO qaPOJO = new QuestionToAnswerePOJO();
					qaPOJO.setQuestion_statement(q.getQ_statement());
					qaPOJO.setQuestion_id(q.getQ_id());
					sl++;
				%>
				<div
					style="width: 90%; box-shadow: 2px 2px 6px -2px; padding: 20px 10px; background: white; border-radius: 10px;">
					<div
						style="background: aliceblue; padding: 10px 20px; border-radius: 20px;">
						<h3>
							<span style="font-size: 1.6rem; color: gray"><%=sl%>) </span><%=q.getQ_statement()%>
						</h3>
						<%
						if (!q.getQ_img().isEmpty()) {
							qaPOJO.setQuestion_img(request.getContextPath() + File.separator + "q_img" + File.separator + q.getQ_img());
						%>
						<img style="width: 400px; border: 1px dotted red; padding: 2px;"
							alt=""
							src="<%=request.getContextPath() + File.separator + "q_img" + File.separator + q.getQ_img()%>" />
						<%
						}
						%>
					</div>

					<div class="grid2cols" style="padding-top: 5px; gap: 20px"
						id="options">
						<%
						ArrayList<Options> optList = eDao.get4OptionByExamId(q.getQ_id());
						for (Options opt : optList) {
							if (opt.getIsAnswer() == 1) {
								qaPOJO.setAnswer_id(opt.getOpt_id());
								qaPOJO.setAnswer_statement(opt.getOpt_text());
							}
						%>
						<div
							style="padding: 5px; background: cornsilk; border-radius: 10px; box-shadow: 2px 1px 6px -3px;">
							<input class="dis" type="radio" id="<%=opt.getOpt_id()%>"
								name="<%=q.getQ_id()%>" value="<%=opt.getOpt_id()%>" /> <label
								for="<%=opt.getOpt_id()%>"><%=opt.getOpt_text()%></label>
						</div>
						<%
						}
						%>
						<button onclick="pass(event); return false;" id="pass_select"
							style="grid-column: 1/span 2;">Pass</button>
					</div>
				</div>
				<%
				qaPOJOList.add(qaPOJO);
				}
				%>

			</section>
			<div style="text-align: center; padding: 20px">
				<button id=submitBtn
					style="padding: 10px 20px; background: greenyellow; border-radius: 5px; cursor: pointer;">Submit</button>
			</div>
		</form>
	</div>
	<%
	session.setAttribute("current_exam_selected_options", qaPOJOList);
	}
	%>
</body>
<script type="text/javascript">
document.title="<%=e.getExam_name()%>";
let ansForm = document.getElementById("ansForm");
	ansForm.addEventListener('submit',async (e)=>{	
	e.preventDefault();
	document.getElementsByTagName('body')[0].setAttribute('onclick','return false');
    var formData = new FormData(ansForm);
    const queryString = new URLSearchParams(formData).toString()
    let diss = document.getElementsByClassName('dis');
    let btnDiss = document.getElementsByTagName('button');
    for(var dis of diss){
    	dis.disabled=true;
    }
    for(var dis of btnDiss){
    	dis.hidden=true;
    }
    console.log(queryString);
   await window.open("<%=request.getContextPath()%>/EvaluateExamServlet?"+queryString,"_blank");
})

let pass=(e)=>{
	e.preventDefault();
	for(let i=0; i<4; i++){
e.target.parentElement.children[i].children[0].checked=false;
	}
	return false;
}




	
	window.onresize = function(){
		 window.close();
		}
	window.onblur = function(){
		 window.close();
		}
	
	
		let end_time = <%=e.getExam_end().getTime()%>		
	let countDown=setInterval(()=>{
		let curr_time = new Date().getTime();
		let remaining = end_time-curr_time;
		if(remaining/1000<20){
			document.getElementById('timer').style.background="#ff8585";
			document.getElementsByTagName('body')[0].style.cursor='no-drop' 
		}
		if(remaining<1){

			console.log('end');
			
		    let diss = document.getElementsByClassName('dis');
		    let btnDiss = document.getElementsByTagName('button');
		    for(var dis of diss){
		    	if(dis.checked==false){		    		
		    		dis.disabled=true;
		    	}
		    }
		    for(var dis of btnDiss){
		    	dis.hidden=true;
		    }
			
			document.getElementById("submitBtn").disabled=false;
			document.getElementById("submitBtn").hidden=false;
			clearInterval(countDown);
			
		}else{
			let minutes = Math.floor((remaining / (1000 * 60)));
			let seconds = Math.floor((remaining  % (1000 * 60)) / 1000);
			document.getElementById('timer').innerText=minutes+' m : '+seconds+' s';
		}
		
	},1000)
</script>
</html>