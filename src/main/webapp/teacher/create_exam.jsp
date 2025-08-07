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
				<i class="fa fa-plus-circle"></i> Create Exams
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.CREATE_EXAM)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Create Exams</a></li>
		</ul>
	</div>
	<div class="container-fluid">






		<%
		BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
		QuestionSetsDao qs = new QuestionSetsDao(ConnectionProvider.main());
		Users cu = (Users) session.getAttribute("current_user");
		ArrayList<Sections> sectiponList = bs.getAllSection();
		ArrayList<BatchClass> classList = bs.getAllClass();
		ArrayList<Course> courseList = bs.getAllCourse();
		ArrayList<QuestionSets> qsList = qs.getAllQuestionSet(cu.getUser_id());
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

				<div class="form-container">
					<form action="select_question_set.jsp" method='get'
						id="question_form">


						<div>
							<label for="id">Exam Name</label><br /> <select
								class="form-control" name="exam_name" id="section">
								<option
									value="Final_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%>">Final_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
								<option
									value="Mid_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%>">Mid_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
								<option
									value="CT_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%>">CT_Fall-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
								<option
									value="Final_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%>">Final_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
								<option
									value="Mid_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%>">Mid_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
								<option
									value="CT_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%>">CT_Spring-<%=Integer.parseInt(Year.now().toString()) % 100%></option>
							</select>
						</div>
						<hr style="width: 100vh" />


						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="exam_question_amount">Exam's Question Amount
									<span class='required'></span>
								</label><br /> <input class="form-control"
									onchange="document.getElementById('per_mark').innerText=document.getElementById('exam_mark').value/document.getElementById('exam_question_amount').value"
									min='5' value='5' required name="exam_question_amount"
									id="exam_question_amount" type="number" />
							</div>
							<div class="col-md-6 mb-3">
								<label for="exam_mark">Exam's Total Mark <span
									class='required'></span></label><br /> <input class="form-control"
									onchange="document.getElementById('per_mark').innerText=document.getElementById('exam_mark').value/document.getElementById('exam_question_amount').value"
									min='5' value='5' required name="exam_mark" id="exam_mark"
									type="number" />
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

						<input  hidden="true" required="required"
							id="datetime_prev" type="datetime-local" name="date_prev" />
						<div>
							<label for="exam_duration">Exam Duration (in minutes) <span
								class='required'></span></label><br /> <input class=" form-control"
								value='10' min="10" required name="exam_duration"
								id="exam_duration" type="number" />
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
									class="form-control" name="privacy" id="batch">
									<option selected value="0">Public</option>
									<option value="1">Private</option>
								</select>

							</div>




						</div>
						<div class="mb-10 text-end">
							<button class=" btn btn-primary" style="width: 100px; padding: 5px 8px"
								name="btn" id="btn" type="submit" >Next</button>
						</div>
					</form>
				</div>
			</div>
		</div>





	</div>
</main>


<script type="text/javascript">
	let d = new Date();
	let date = d.getDate();
	let month = d.getMonth() + 1;
	date = date.toString().length == 1 ? '0' + date : date;
	month = month.toString().length == 1 ? '0' + month : month;
	const year = d.getFullYear();

	let currentDate = new Date();
	let hours = currentDate.getHours();
	let minutes = currentDate.getMinutes();
	let meridiem = hours >= 12 ? 'PM' : 'AM';
	
	document.getElementById('datetime_prev').min=year+"-"+month+"-"+date+"T"+hours+":"+minutes;
	const datepick=document.getElementById('exam_start');
	const timepick= document.getElementById('exam_time');
	
	
	datepick.addEventListener('change',(e)=>{		
	document.getElementById('datetime_prev').value = datepick.value+"T"+timepick.value;
	console.log(document.getElementById('exam_start').value+"T"+document.getElementById('exam_time').value);
	})
	timepick.addEventListener('change',(e)=>{		
	document.getElementById('datetime_prev').value = datepick.value+"T"+timepick.value;
	console.log(document.getElementById('exam_start').value+"T"+document.getElementById('exam_time').value);
	})
	
	
	document.getElementById('btn').addEventListener('click',(e)=>{
		const selectedDate = new Date(document.getElementById('datetime_prev').value);
		if(selectedDate<new Date()){			
		alert("Invalid Date/Time!")
		e.preventDefault();
		}
	})

</script>

<%@include file="bottom_common.jsp"%>