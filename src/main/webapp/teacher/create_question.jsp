<%@page import="helper.Quotes.QuoteCategory"%>
<%@page import="helper.Quotes"%>
<%@page import="helper.QuestionCommonSession"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.Sections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Users"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.BatchSectionDao"%>
<%@include file="top_common.jsp"%>


<%
BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
QuestionSetsDao qs = new QuestionSetsDao(ConnectionProvider.main());
Users cu = (Users) session.getAttribute("current_user");
ArrayList<Sections> sectiponList = bs.getAllSection();
ArrayList<BatchClass> classList = bs.getAllClass();
ArrayList<Course> courseList = bs.getAllCourse();
ArrayList<QuestionSets> qsList = qs.getAllQuestionSet(cu.getUser_id());
%>


<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-plus-square"></i> Create Question
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.CREATE_QUESTION) %></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Create
					Question</a></li>
		</ul>
	</div>

	<!-- Header -->
	<%
	if (session.getAttribute("question_create_success") != null) {
	%>

	<div class="alert alert-success" role="alert"><%=session.getAttribute("question_create_success")%></div>
	<%
	session.removeAttribute("question_create_success");
	}
	%>
	<%
	if (session.getAttribute("question_create_fail") != null) {
	%>
	<div class="alert alert-danger" role="alert">
		<%=session.getAttribute("question_create_fail")%><
	</div>
	<%
	session.removeAttribute("question_create_fail");
	}
	%>

	<%
	if (session.getAttribute("big_img") != null) {
	%>
	<div class="alert alert-danger" role="alert">
		<%=session.getAttribute("big_img")%><
	</div>
	<%
	session.removeAttribute("big_img");
	}
	%>



	<!-- Form Container -->
	<div class="row">
		<div class="call-md-6">
		
		<div class="form-container">
			<form action="<%=request.getContextPath()%>/CreateQuestionServlet"
				method="POST" enctype="multipart/form-data">
				<div class="mb-3">
					<label for="questionStatement" class="form-label required">Question
						Statement</label>
					<textarea class="form-control" id="questionStatement"
						name="q_statement" rows="3" required></textarea>
				</div>
				<div class="mb-3">
					<label for="questionImage" class="form-label">Question
						Image (Optional)</label>
					<div class="">
						<input type="file" id="questionImage" name="q_img"
							accept="image/*"> <label for="questionImage"><i
							class="bi bi-upload"></i> Upload Question Image</label>
					</div>
					<img width="200" id="imagePreview" class="image-preview"
						alt="Image Preview">
					<p id='rem_img' onclick="removeImg()"
						style="cursor: pointer; display: inline-block;"
						class=" p-1 btn-danger">Remove Image</p>
				</div>
				<div class="mb-3">
					<label for="wrongOption1" class="form-label required">Wrong
						Option 1</label> <input type="text" class="form-control" id="wrongOption1"
						name="opt_1" required>
				</div>
				<div class="mb-3">
					<label for="wrongOption2" class="form-label required">Wrong
						Option 2</label> <input type="text" class="form-control" id="wrongOption2"
						name="opt_2" required>
				</div>
				<div class="mb-3">
					<label for="wrongOption3" class="form-label required">Wrong
						Option 3</label> <input type="text" class="form-control" id="wrongOption3"
						name="opt_3" required>
				</div>
				<div class="mb-3">
					<label for="multipleWrongOptions" class="form-label">Multiple
						Wrong Options ('///' Triple Forward Slash Separated)<span
						title="To Seperate multiple options use triple slash(/)... example: Dollar///Dirham///Rupe"
						onclick="alert('To Seperate multiple options use triple slash(/)\n example: Dollar///Taka///Rupe')"
						class='how'><i class="ms-1 fa fa-question-circle"
							aria-hidden="true"></i></span>
					</label>
					<textarea class="form-control" id="multipleWrongOptions"
						name="opt_n" rows="2"
						placeholder="e.g., Option1/// Option2/// Option3"></textarea>
				</div>
				<div class="mb-3">
					<label for="correctOption" class="form-label required">Correct
						Option</label> <input type="text" class="form-control" id="correctOption"
						name="ans_1" required>
				</div>
				<div class="mb-3">
					<label for="multipleCorrectOptions" class="form-label ">Multiple
						Correct Options ('///' Triple Forward Slash Separated)<span
						title="To Seperate multiple options use triple slash(/)... example: Dollar///Dirham///Rupe"
						onclick="alert('To Seperate multiple options use triple slash(/)\n example: Dollar///Taka///Rupe')"
						class='how'><i class="ms-1 fa fa-question-circle"
							aria-hidden="true"></i></span>
					</label>
					<textarea class="form-control" id="multipleCorrectOptions"
						name="ans_n" rows="2" placeholder="e.g., Option1/// Option2"></textarea>
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
						<label for="section" class="form-label required">Section</label> <select
							class="form-control" id="section" name="section" required>
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
						<label for="questionSet" class="form-label required">Question
							Set</label> <select class="form-control" id="questionSet" name="q_set"
							required>
							<option selected="selected" value="0">Default</option>
							<%
							for (QuestionSets qset : qsList) {
							%>
							<option value="<%=qset.getQs_id()%>"><%=qset.getQs_name()%></option>
							<%
							}
							%>
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
						<label for="privacy" class="form-label required">Privacy</label> <select
							class="form-control" id="privacy" name="privacy" required>
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
				<button type="submit" class="btn btn-primary">Create
					Question</button>
			</form>
		</div>
		</div>
	</div>

</main>

<script>

<%QuestionCommonSession qsc = (QuestionCommonSession) session.getAttribute("common_q");
if (qsc != null) {%>

document.getElementById('difficulty').value='<%=qsc.getDifficulty()%>' ;
document.getElementById('privacy').value='<%=qsc.getPrivacy()%>';
document.getElementById('course').value='<%=qsc.getCourse()%>';
document.getElementById('section').value='<%=qsc.getSection()%>';
document.getElementById('questionSet').value='<%=qsc.getQ_set()%>';
document.getElementById('batch').value='<%=qsc.getBatch()%>' ;
<%}%>




    const preview = document.getElementById('imagePreview');
    const ri = document.getElementById('rem_img');
    preview.style.display = 'none';
    ri.style.display = 'none';
    
    let removeImg=()=>{
    	document.getElementById('questionImage').value=''
    		document.getElementById('imagePreview').src='' 
    	        preview.style.display = 'none';
        ri.style.display = 'none';
    }
    removeImg();
   

        document.getElementById('questionImage').addEventListener('change', function(e) {
            const file = e.target.files[0];

            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    ri.style.display = 'inline-block';
                };
                reader.readAsDataURL(file);
            } else {
                preview.style.display = 'none';
                ri.style.display = 'none';
            }
        });
    </script>

<%@include file="bottom_common.jsp"%>