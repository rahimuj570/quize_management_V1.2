<%@page import="java.util.Date"%>
<%@page import="entities.Exams"%>
<%@page import="dao.ExamsDao"%>
<%@page import="java.time.Year"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.Sections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="helper.Quotes.QuoteCategory"%>
<%@page import="helper.Quotes"%>
<%@include file="top_common.jsp"%>




<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-pencil-square"></i> Edit Exam
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.CREATE_EXAM)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Edit Exam</a></li>
		</ul>
	</div>
	<div class="container-fluid">






		<%
		BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
		QuestionSetsDao qs = new QuestionSetsDao(ConnectionProvider.main());
		ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
		Users cu = (Users) session.getAttribute("current_user");
		Exams e = eDao.getExamById(request.getParameter("exam_id"));
		ArrayList<Sections> sectiponList = bs.getAllSection();
		ArrayList<BatchClass> classList = bs.getAllClass();
		ArrayList<Course> courseList = bs.getAllCourse();
		ArrayList<QuestionSets> qsList = qs.getAllQuestionSet(cu.getUser_id());

		if (e.getExam_start().before(new Date(new Date().getTime() + 10 * 60000))) {
			session.setAttribute("update_exam_401", "Can't Modify Exam Now, Please Contact with Admin!");
			response.sendRedirect(request.getContextPath() + "/teacher/show_exams.jsp");
		}
		%>
		<%
		if (session.getAttribute("create_exam_BAD") != null) {
		%>
		<p class="center_txt required"><%=session.getAttribute("create_exam_BAD")%></p>
		<%
		session.removeAttribute("create_exam_BAD");
		}
		%>
		<div class="row">
			<div class="call-md-6">


				<%
				/////////////////
				if (e.getExam_teacher().equals(cu.getUser_id())) {
				%>

				<%
				if (session.getAttribute("update_exam_BAD") != null) {
				%>
				<div class="alert alert-success" role="alert"><%=session.getAttribute("update_exam_BAD")%></div>

				<%
				session.removeAttribute("update_exam_BAD");
				}
				%>


				<div class="form-container">
					<form action="<%=request.getContextPath()%>/EditExamServlet" method='get'
						id="question_form"  >

						<div class="mb-3">
							<label for="exam_name">Exam ID</label><br /> <input name=""
								value="<%=e.getExam_id()%>" disabled="disabled" type="number" />
							<input name="exam_id" value="<%=e.getExam_id()%>" hidden=true
								type="number" />
						</div>


						<div>
							<label for="id">Exam Name</label><br /> <input
								class="form-control" name="exam_name" id="exam_name"
								value="<%=e.getExam_name()%>">
						</div>
						<hr style="width: 100vh" />


						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="exam_question_amount">Exam's Question Amount
									<span class='required'></span>
								</label><br /> <input class="form-control"
									onchange="document.getElementById('per_mark').innerText=document.getElementById('exam_mark').value/document.getElementById('exam_question_amount').value"
									min='5' required name="exam_question_amount"
									id="exam_question_amount" type="number"
									value="<%=e.getExam_question_amount()%>" />
							</div>
							<div class="col-md-6 mb-3">
								<label for="exam_mark">Exam's Total Mark <span
									class='required'></span></label><br /> <input class="form-control"
									onchange="document.getElementById('per_mark').innerText=document.getElementById('exam_mark').value/document.getElementById('exam_question_amount').value"
									min='5' value='<%=e.getExam_marks()%>' required
									name="exam_mark" id="exam_mark" type="number" />
								<p>
									(Per question's mark will be: <span id='per_mark'>1</span>)
								</p>

							</div>
						</div>




						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="exam_start">Exam Date <span class='required'></span></label><br />
								<input class=" form-control" min="2024-06-21" required
									name="exam_start" id="exam_start" type="date" />

							</div>
							<div class="col-md-6 mb-3">
								<label for="exam_time">Exam Time <span class='required'></span></label><br />
								<input class=" form-control" required name="exam_time"
									id="exam_time" type="time" />

							</div>
						</div>



						<hr style="width: 100vh" />

						<div>
							<label for="exam_duration">Exam Duration (in minutes) <span
								class='required'></span></label><br /> <input class=" form-control"
								value='<%=e.getExam_duration()%>' min="10" required
								name="exam_duration" id="exam_duration" type="number" />
						</div>

						<hr style="width: 100vh" />

						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="id">Batch/Class</label><br /> <select
									class="form-control" name="batch" id="batch">
									<%
									for (BatchClass bc : classList) {
									%>
									<option value="<%=bc.getId()%>"><%=bc.getBatchClass()%></option>
									<%
									}
									%>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="id">Section</label><br /> <select
									class="form-control" name="section" id="section">
									<%
									for (Sections s : sectiponList) {
									%>
									<option value="<%=s.getId()%>"><%=s.getSection()%></option>
									<%
									}
									%>
								</select>
							</div>


						</div>





						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="id">Course</label><br /> <select
									class="form-control" name="course" id="course">
									<%
									for (Course c : courseList) {
									%>
									<option value="<%=c.getCourse_id()%>"><%=c.getCourse_name()%></option>
									<%
									}
									%>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="id">Privacy</label><br /> <select
									class="form-control" name="privacy" id="privacy">
									<option selected value="0">Public</option>
									<option value="1">Private</option>
								</select>

							</div>

						</div>



						<hr class="mx-auto bg-primary" style="width: 100vh; height: 1px" />
						<div class="text-center">
						
						<button class="btn btn-secondary"
							onclick="document.getElementsByName('mark[]').forEach(e=>e.checked=false); return false;">Clear
							All Checked Set</button>
						</div>
						<div style="display: flex; gap: 30px">

							<%
							if (session.getAttribute("no_qs_select") != null) {
							%>
							<p class="center_txt danger_txt"><%=session.getAttribute("no_qs_select")%></p>
							<%
							session.removeAttribute("no_qs_select");
							}
							%>

							<table class="table table-hover table-bordered" id="sampleTable"
								style="overflow-y: scroll; overflow-x: scroll; max-height: 400px;">
								<thead>
									<tr>
										<th>MARK</th>
										<th>Exam ID</th>
										<th>Exam Name</th>
										<th>Questions Quantity</th>
										<th>Section</th>
									</tr>
								</thead>

								<%
								ArrayList<Integer> prevSetID = eDao.getAllQuestionSetById(request.getParameter("exam_id"));
								for (var q : qsList) {
								%>
								<tr>
									<td><input class="checkboxes" name="mark[]" type="checkbox"
										value="<%=q.getQs_id()%>"
										<%=prevSetID.indexOf(q.getQs_id()) != -1 ? "checked" : ""%> />
										
										<%=prevSetID.indexOf(q.getQs_id()) != -1 ? "Selected" : ""%>
										
										</td>
									<td><%=q.getQs_id()%></td>
									<td><%=q.getQs_name()%></td>
									<td><%=qs.getTotalQuestionAmount(q.getQs_id())%></td>
									<td><%=bs.getSectionNameById(q.getQs_section())%></td>
								</tr>
								<%
								}
								%>
							</table>


						</div>



						<div class="mb-10 text-center">
							<button class=" btn btn-primary"
								style="width: 100px; padding: 5px 8px" name="btn" id="addSet"
								type="submit">Update</button>
						</div>
					</form>
				</div>
				<%
				} else {
				%>
				<div class="alert alert-danger" role="alert">Authorization
					Required!</div>


				<%
				}
				%>
			</div>
		</div>





	</div>
</main>


<script type="text/javascript">


let q_count=0;
let q_amount=<%=e.getExam_question_amount()%>
document.getElementById('exam_question_amount').addEventListener('change',e=>{
	q_amount=e.target.value-'0';
	checkAmount();
})
	
	Array.from(document.getElementsByClassName("checkboxes")).forEach((d,index)=>{
		d.addEventListener('change',(e)=>{
			let parent = e.target.parentElement.parentElement.children[3];
			if(e.target.checked==true){					
			q_count+=parent.innerText-'0';
			}else{
			q_count-=parent.innerText-'0';					
			}
			console.log(q_count);
			const btn = document.getElementById("addSet");
			if(q_count<q_amount){
				btn.disabled=true;
			}else{
				btn.disabled=false;
			}
		})
	})
	
	
	let a=0
	let checkAmount=()=>{
	 a=0;
		Array.from(document.getElementsByClassName("checkboxes")).forEach((e,index)=>{
			
			let parent = e.parentElement.parentElement.children[3];
			if(e.checked==true){					
			a+=parent.innerText-'0';
			}
			console.log(q_count);
			const btn = document.getElementById("addSet");
			if(a<q_amount){
				btn.disabled=true;
			}else{
				btn.disabled=false;
			}
	
	})
	
	q_count=a;
	
	}
	

	checkAmount();






	document.getElementById('batch').value=`<%=e.getExam_batch()%>` 
	document.getElementById('section').value=`<%=e.getExam_section()%>`
	document.getElementById('course').value=`<%=e.getExam_course()%>`
	document.getElementById('privacy').value='<%=e.getExam_privacy()%>'

	let d = new Date();
	let date = d.getDate();
	let month = d.getMonth() + 1;
	date = date.toString().length == 1 ? '0' + date : date;
	month = month.toString().length == 1 ? '0' + month : month;
	const year = d.getFullYear();
	document.getElementById('exam_start').min = year + '-' + month + '-' + date;
	const currentDate = new Date();
	let hours = currentDate.getHours();
	let minutes = currentDate.getMinutes();
	let meridiem = hours >= 12 ? 'PM' : 'AM';

	//document.getElementById('exam_time').min = d.getHours() + ':'	+ d.getMinutes();
</script>


<!-- Essential javascripts for application to work-->
<script src="../assets/jquery-3.2.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
<script src="../assets/main.js"></script>

<!-- Data table plugin-->
<script type="text/javascript" src="../assets/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../assets/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">
	$('#sampleTable').DataTable();
</script>
</body>
</html>