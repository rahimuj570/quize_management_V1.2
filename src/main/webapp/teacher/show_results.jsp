
<%@page import="entities.ExamsEvaluation"%>
<%@page import="java.util.Date"%>
<%@page import="entities.Exams"%>
<%@page import="dao.ExamsDao"%>
<%@page import="helper.Quotes.QuoteCategory"%>
<%@page import="helper.Quotes"%>
<%@page import="entities.QuestionSets"%>
<%@page import="entities.Users"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.QuestionSetsDao"%>
<%@page import="entities.Course"%>
<%@page import="entities.BatchClass"%>
<%@page import="entities.Sections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.BatchSectionDao"%>
<%@include file="top_common.jsp"%>

<main class="app-content">
	<div class="app-title">
		<div>
			<h1>
				<i class="fa fa-th-list"></i> Result
			</h1>
			<p><%=Quotes.getQ(QuoteCategory.CREATE_EXAM)%></p>
		</div>
		<ul class="app-breadcrumb breadcrumb side">
			<li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
			<li class="breadcrumb-item">Dashboard</li>
			<li class="breadcrumb-item active"><a href="#">Show Result</a></li>
		</ul>
	</div>



<%
BatchSectionDao bs = new BatchSectionDao(ConnectionProvider.main());
ArrayList<Sections> sectiponList = bs.getAllSection();
ArrayList<BatchClass> classList = bs.getAllClass();
ArrayList<Course> courseList = bs.getAllCourse();

ExamsDao eDao = new ExamsDao(ConnectionProvider.main());
Users cu = (Users) session.getAttribute("current_user");
Exams e = eDao.getExamById(request.getParameter("exam_id"));
BatchSectionDao bsDao = new BatchSectionDao(ConnectionProvider.main());
ArrayList<ExamsEvaluation> evaluationList = eDao
		.getAllExamEvaluation(Integer.parseInt(request.getParameter("exam_id")));
%>


	<div class="row">
		<div class="col-md-12">
		
		<div style="width: fit-content;
  margin: 0 auto;
}" class="card mb-3">
            <div class="bg-primary card-header text-white">Exam Information</div>

        <div class="details-container">
            <div class="details-item"><span>ID:</span><span class="value"><%=e.getExam_id()%></span></div>
            <div class="details-item"><span>Exam Name:</span><span class="value"><%=e.getExam_name()%></span></div>
            <div class="details-item"><span>Course:</span><span class="value"><%=bsDao.getCourseNameById(e.getExam_course())%></span></div>
            <div class="details-item"><span>Section:</span><span class="value"><%=bsDao.getSectionNameById(e.getExam_section())%></span></div>
            <div class="details-item"><span>Batch:</span><span class="value"><%=bsDao.getBatchNameById(e.getExam_batch())%></span></div>
            <div class="details-item"><span>Total Questions:</span><span class="value"><%=e.getExam_question_amount()%></span></div>
            <div class="details-item"><span>Exam Marks:</span><span class="value"><%=e.getExam_marks()%></span></div>
        </div>
        
        </div>
		
			<div class="tile">
				<div class="tile-body">
					<table class="table table-hover table-bordered" id="sampleTable">
						<thead>
							<tr>
								<tr>
				<th>Student ID</th>
				<th>Correct Answers</th>
				<th>Wrong Answers</th>
				<th>Skipped Questions</th>
				<th>Expelled Status</th>
				<th>Obtained Marks</th>
				<th>Verdict</th>
			</tr>
							</tr>
						</thead>
						<tbody>



			<%
			for (ExamsEvaluation ev : evaluationList) {
			%>
			<tr>
				
				<td><%=ev.getStudent_id()%></td>
				<td><%=ev.getCorrect_answer()%></td>
				<td><%=ev.getWrong_answer()%></td>
				<td><%=ev.getPass_question()%></td>
				<td><%=ev.getIsExpelled() == 0 ? "FALSE" : "TRUE"%></td>
				<td><%=(e.getExam_marks() / e.getExam_question_amount()) * ev.getCorrect_answer()%></td>
				<td><%=(ev.getCorrect_answer() * 100) / e.getExam_marks()%>%</td>
			</tr>
			<%
			}
			%>




						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</main>

<style>
        body {
            background-color: #f4f7fc;
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .header {
            background-color: #2c3e50;
            color: #ecf0f1;
            padding: 10px 15px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
        }
        .container-fluid {
            padding-top: 50px;
            padding-bottom: 10px;
        }
        .details-container {
            max-width: 600px;
            margin: 10px auto;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            padding: 10px;
        }
        .details-item {
            display: flex;
            align-items: center;
            padding: 5px 0;
            font-size: 0.9rem;
        }
        .details-item span {
            font-weight: 500;
            color: #2c3e50;
            width: 120px;
            margin-right: 10px;
        }
        .details-item .value {
            color: #333;
        }
        @media (max-width: 768px) {
            .header {
                padding: 8px 10px;
            }
            .details-container {
                margin: 5px;
                padding: 8px;
            }
            .details-item {
                flex-direction: column;
                align-items: flex-start;
                font-size: 0.85rem;
            }
            .details-item span {
                width: auto;
                margin-right: 0;
                margin-bottom: 2px;
            }
        }
    </style>

<!-- Essential javascripts for application to work-->
<script src="jquery-3.2.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
<script src="main.js"></script>

<!-- Data table plugin-->
<script type="text/javascript" src="plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">
	$('#sampleTable').DataTable();
</script>
</body>
</html>
