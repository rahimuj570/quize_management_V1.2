<!DOCTYPE html>
<%@page import="entities.Options"%>
<%@page import="java.io.File"%>
<%@page import="helper.QuestionToAnswerePOJO"%>
<%@page import="entities.Questions"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="entities.ExamsEvaluation"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="entities.Exams"%>
<%@page import="helper.GetBatchSectionOfStudentPOJO"%>
<%@page import="entities.Users"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.ExamsDao"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="java.sql.Connection"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Exam</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.question-card {
	margin-bottom: 20px;
}

.counter {
	position: fixed;
	top: 15px;
	right: 20px;
	background: #0d6efd;
	color: white;
	padding: 10px 15px;
	border-radius: 50px;
	font-weight: bold;
}

.question-img {
	max-height: 200px;
	object-fit: contain;
	margin-bottom: 15px;
}
</style>
<link rel="stylesheet" type="text/css" href="main.css">

</head>
<!-- <body class="bg-light" oncontextmenu="return false"
	onselectstart="return false" onpaste="return false;"
	onCopy="return false" onCut="return false" onDrag="return false"
	onDrop="return false" autocomplete=off>
-->
<body>



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
		String query = "insert into tmp_exam_entry (student_id, exam_id) values (?,?)";
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






	<!-- Answer Counter -->
	<div class="counter bg-primary"
		style="z-index: 2; border: 1px solid white">
		Answered: <span id="answeredCount">0</span> / <span
			id="totalQuestions">0</span>
	</div>
		<div class="mt-2 counter bg-warning"
		style="z-index: 2; border: 1px solid white; top:55px">
		End Within: <span id="timer">0</span>
	</div>

	<div class="container mt-4 bg-primary py-3 mb-4">

		<!-- Exam Info -->
		<div style="background: #1abc9c"
			class="text-white card shadow-sm mb-4">
			<div class="card-body">
				<h3 id="examName"><%=e.getExam_name() %></h3>
				<p>
					<strong>Batch:</strong> <%=bsDao.getBatchNameById(e.getExam_batch()) %> | <strong>Section:</strong> <%=bsDao.getSectionNameById(e.getExam_section()) %> | <strong>Course:</strong>
					<%=bsDao.getCourseNameById(e.getExam_course()) %>
				</p>
				<p>
					<strong>Total Marks:</strong> <%=e.getExam_marks() %> | <strong>Duration:</strong> <%=e.getExam_duration() %>
					min | <strong>Questions:</strong> <%=e.getExam_question_amount() %> | <strong>Deadline:</strong>
					<%=e.getExam_end() %>
				</p>
				<p>
					<strong>Student ID:</strong> <%=cu.getUser_id() %>
				</p>
			</div>
		</div>

		<!-- Questions -->
	<form id="ansForm" action="#">
			<input type="hidden" name="exam_id" value="<%=e.getExam_id()%>" />
			<!-- Question 1 -->
			
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
			
			
			
			
			<div class="card question-card shadow-sm">
				<div class="card-body">
					<h5><%=sl %>. <%=q.getQ_statement() %></h5>
					<%
						if (q.getQ_img()!=null) {
							if(!((q.getQ_img().strip()).equals("null"))){
							qaPOJO.setQuestion_img(request.getContextPath() + File.separator + "q_img" + File.separator + q.getQ_img());
						%>
						<img class="img-fluid question-img" style="width: 400px; border: 1px dotted red; padding: 2px;"
							alt=""
							src="<%=request.getContextPath() + File.separator + "q_img" + File.separator + q.getQ_img()%>" />
						<%}
						}
						%>

					<div>
						<%
						ArrayList<Options> optList = eDao.get4OptionByExamId(q.getQ_id());
						for (Options opt : optList) {
							if (opt.getIsAnswer() == 1) {
								qaPOJO.setAnswer_id(opt.getOpt_id());
								qaPOJO.setAnswer_statement(opt.getOpt_text());
							}
						%>
					
						<div class="form-check">
							<input id="<%=opt.getOpt_id() %>" class="dis form-check-input answer-option" type="radio"
								name="<%=q.getQ_id()%>" value="<%=opt.getOpt_id()%>"> <label class="form-check-label"><%=opt.getOpt_text() %></label>
						</div>
						
						<%} %>
						<div class="text-end">
						<button class="btn btn-danger text-white mt-2" onclick="pass(event); return false;" id="pass_select"
							style="padding: 3px 5px">Pass</button>
						</div>
						
					</div>
				</div>
			</div>
			
						<%
				qaPOJOList.add(qaPOJO);
				}
				%>

		

		<!-- Submit Button -->
		<div class="text-center my-4">
			<button type="submit" id="submitBtn" class="btn btn-info btn-lg">Submit Quiz</button>
		</div>
		</form>


	</div>
	
		<%
	session.setAttribute("current_exam_selected_options", qaPOJOList);
	}
	%>

	<script>
	


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




		
		window.onresize = function(){
			 window.close();
			}
		window.onblur = function(){
			 window.close();
			}
	
	
	
	
	
	
	
	
	
        // Update total questions count
        document.getElementById('totalQuestions').innerText = document.querySelectorAll('.question-card').length;

        // Track answered questions
        let answeredSet = new Set();
        document.querySelectorAll('.answer-option').forEach(input => {
            input.addEventListener('change', () => {
                answeredSet.add(input.name); // each name is unique per question
                document.getElementById('answeredCount').innerText = answeredSet.size;
            });
        });
        
        
        
        
        
        
        
        
        
        
    	let pass=(e)=>{
    		e.preventDefault();
    		for(let i=0; i<4; i++){
    	e.target.parentElement.parentElement.children[i].children[0].checked=false;
    		}
    		
    		
    		let myArray = Array.from(answeredSet);

    		// Remove the first element from the Array
    		myArray.shift();

    		// Convert Array back to Set
    		answeredSet = new Set(myArray);
    		 document.getElementById('answeredCount').innerText = answeredSet.size;
    		return false;
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

</body>
</html>
