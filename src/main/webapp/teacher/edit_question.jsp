<%@page import="java.io.File"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.Sections"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="dao.BatchSectionDao"%>
<%@page import="entities.Options"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Questions"%>
<%@page import="dao.QuestionsDao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.OptionsDao"%>
<%@page import="helper.Quotes.QuoteCategory"%>
<%@page import="helper.Quotes"%>
<%@include file="top_common.jsp"%>


<%
OptionsDao optDao = new OptionsDao(ConnectionProvider.main());
QuestionsDao qDao = new QuestionsDao(ConnectionProvider.main());
Questions q = qDao.getQuestionById(Integer.parseInt(request.getParameter("q_id")));
ArrayList<Options> wrongOptList = optDao.getAllOptionsByQid(q.getQ_id(), 1, 0);
ArrayList<Options> rightOptList = optDao.getAllOptionsByQid(q.getQ_id(), 0, 1);

out.print(wrongOptList.get(0));

BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
QuestionSetsDao qs = new QuestionSetsDao(ConnectionProvider.main());
Users cu = (Users) session.getAttribute("current_user");
ArrayList<Sections> sectiponList = bs.getAllSection();
ArrayList<BatchClass> classList = bs.getAllClass();
ArrayList<Course> courseList = bs.getAllCourse();
ArrayList<QuestionSets> qsList = qs.getAllQuestionSet(cu.getUser_id());
if (q.getQ_teacher() != cu.getUser_id()) {
	session.setAttribute("q_edit404", "Can't be allowed to edit other teacher's questions! ");
	response.sendRedirect(request.getHeader("referer"));
}
%>


<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-pencil-square"></i> Edit Questions
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.CREATE_QUESTION)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Edit
					Questions</a></li>
		</ul>
	</div>







	<div class="container-fluid">


		<div class="row">
			<div class="call-md-6">

				<%
				if (session.getAttribute("question_update_success") != null) {
				%>
				<div class="alert alert-success" role="alert"><%=session.getAttribute("question_update_success")%></div>
				<%
				session.removeAttribute("question_update_success");
				}
				%>
				<%
				if (session.getAttribute("question_update_fail") != null) {
				%>

				<div class="alert alert-danger" role="alert"><%=session.getAttribute("question_update_fail")%></div>
				<%
				session.removeAttribute("question_update_fail");
				}
				%>

				<div class="form-container">
					<form action="<%=request.getContextPath()%>/UpdateQuestionServlet"
						method="POST" enctype="multipart/form-data">
						<div class="mb-3">
							<label for="q_statement" class="form-label required">Question
								Statement</label>
							<textarea class="form-control" id="q_statement"
								name="q_statement" rows="3" required></textarea>
						</div>
						<div class="mb-3">
							<label for="q_img" class="form-label">Question Image
								(Optional)</label> <input type="file" id="q_img" name="q_img"
								accept="image/*"> <label for="questionImage"><i
								class="bi bi-upload"></i> Upload Question Image (under 2MB)</label>

							<div id="prev_div">
								<a target="_blank"
									href="<%=request.getContextPath() + File.separator + "q_img" + File.separator + q.getQ_img()%>">
									<img width="200" id="q_img_prev" class="image-preview"
									alt="Image Preview"
									src="<%=request.getContextPath() + File.separator + "q_img" + File.separator + q.getQ_img()%>">

								</a> <br />
								<p id='rem_img'
									onclick="document.getElementById('deleteOldImg').value='1';document.getElementById('q_img').value='';document.getElementById('prev_div').style.display='none';"
									style="cursor: pointer; display: inline-block;"
									class=" p-1 btn-danger">Remove Image</p>

							</div>
						</div>
						<div class="mb-3">
							<label for="opt_1" class="form-label required">Wrong
								Option 1</label> <input type="text" class="form-control" id="opt_1"
								name="opt_1" required>
						</div>
						<div class="mb-3">
							<label for="opt_2" class="form-label required">Wrong
								Option 2</label> <input type="text" class="form-control" id="opt_2"
								name="opt_2" required>
						</div>
						<div class="mb-3">
							<label for="opt_3" class="form-label required">Wrong
								Option 3</label> <input type="text" class="form-control" id="opt_3"
								name="opt_3" required>
						</div>
						<div class="mb-3">
							<label for="opt_n" class="form-label">Multiple Wrong
								Options ('///' Triple Forward Slash Separated)<span
								title="To Seperate multiple options use triple slash(/)... example: Dollar///Dirham///Rupe"
								onclick="alert('To Seperate multiple options use triple slash(/)\n example: Dollar///Taka///Rupe')"
								class='how'><i class="ms-1 fa fa-question-circle"
									aria-hidden="true"></i></span>
							</label>
							<textarea class="form-control" id="opt_n" name="opt_n" rows="2"
								placeholder="e.g., Option1/// Option2/// Option3"></textarea>
						</div>
						<div class="mb-3">
							<label for="ans_1" class="form-label required">Correct
								Option</label> <input type="text" class="form-control" id="ans_1"
								name="ans_1" required>
						</div>
						<div class="mb-3">
							<label for="ans_n" class="form-label ">Multiple Correct
								Options ('///' Triple Forward Slash Separated)<span
								title="To Seperate multiple options use triple slash(/)... example: Dollar///Dirham///Rupe"
								onclick="alert('To Seperate multiple options use triple slash(/)\n example: Dollar///Taka///Rupe')"
								class='how'><i class="ms-1 fa fa-question-circle"
									aria-hidden="true"></i></span>
							</label>
							<textarea class="form-control" id="ans_n" name="ans_n" rows="2"
								placeholder="e.g., Option1/// Option2"></textarea>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="batch" class="form-label required">Batch</label> <select
									class="form-control" id="batch" name="batch" required>
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
								<label for="section" class="form-label required">Section</label>
								<select class="form-control" id="section" name="section"
									required>
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
								<label for="q_set" class="form-label ">Question
									Set</label> <select class="form-control" id="q_set" disabled="disabled" name="q_set"
									>
									
									<option selected="selected">Disabled</option>
									
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="course" class="form-label required">Course</label> <select
									class="form-control" id="course" name="course" required>
									<%
									for (Course c : courseList) {
									%>
									<option value="<%=c.getCourse_id()%>"><%=c.getCourse_name()%></option>
									<%
									}
									%>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="privacy" class="form-label required">Privacy</label>
								<select class="form-control" id="privacy" name="privacy"
									required>
									<option selected value="0">Public</option>
									<option value="1">Private</option>
								</select>
							</div>
							<div class="col-md-6 mb-3">
								<label for="difficulty" class="form-label required">Difficulty</label>
								<select class="form-control" id="difficulty" name="difficulty"
									required>
									<option selected value="1">Easy</option>
									<option value="2">Medium</option>
									<option value="3">Hard</option>
								</select>
							</div>
						</div>
						<input name="oldImg" type="hidden" value="<%=q.getQ_img()%>" /> <input
							name="q_id" type="hidden" value="<%=q.getQ_id()%>" /> <input
							id="deleteOldImg" name="deleteOldImg" type="hidden" value="0" />
						<button type="submit" class="btn btn-primary">Update
							Question</button>
					</form>
				</div>
			</div>
		</div>

	</div>
</main>





<script>
document.getElementById('q_statement').value=`<%=q.getQ_statement()%>`;
document.getElementById('opt_1').value=`<%=wrongOptList.get(0).getOpt_text()%>`;
document.getElementById('opt_2').value=`<%=wrongOptList.get(1).getOpt_text()%>`;
document.getElementById('opt_3').value=`<%=wrongOptList.get(2).getOpt_text()%>`;
document.getElementById('ans_1').value=`<%=rightOptList.get(0).getOpt_text()%>`;
document.getElementById('opt_n').value=`<%for (int i = 3; i < wrongOptList.size(); i++) {%><%=wrongOptList.get(i).getOpt_text().strip()%>///<%}%>`;
document.getElementById('ans_n').value=`<%for (int i = 1; i < rightOptList.size(); i++) {%><%=rightOptList.get(i).getOpt_text().strip().replace("\n", "")%>///<%}%>`;
document.getElementById('batch').value=`<%=q.getQ_batch()%>` 
document.getElementById('section').value=`<%=q.getQ_section()%>`
document.getElementById('course').value=`<%=q.getQ_subject()%>`
document.getElementById('privacy').value=`<%=q.getQ_privacy()%>`
document.getElementById('difficulty').value=`<%=q.getQ_difficulty()%>`
const file = document.getElementById('q_img');
file.value=``;
<%
if (q.getQ_img() == null) {%>
document.getElementById('prev_div').style.display='none';
<%}%>

<%if (q.getQ_img() != null) {
	if (q.getQ_img().equals("null")) {%>
	
document.getElementById('prev_div').style.display='none';


<%}
}%>

file.addEventListener('change',(e)=>{
	document.getElementById('prev_div').style.display='block';
	const reader= new FileReader();
	if(file.files[0].type=='image/jpeg' || file.files[0].type=='image/png');
	else {
		alert("Only jpg, jpeg and png file allowed!")
		file.value='';
		document.getElementById('q_img_prev').src='';
		document.getElementById('prev_div').style.display='none';
	}
	reader.readAsDataURL(file.files[0]);
	reader.onload = () => {
		document.getElementById('q_img_prev').src=reader.result;      
  };
	
})
</script>

<%@include file="bottom_common.jsp"%>