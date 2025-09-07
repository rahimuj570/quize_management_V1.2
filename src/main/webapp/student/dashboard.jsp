<%@page import="entities.Exams"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ExamsDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="top_common.jsp" %>
    <main class="app-content">
      <div class="app-title">
        <div>
          <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
          <p>Student Dashboard for OEMS - Online Exam Management System</p>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item"><a href="#">Dashboard</a></li>
        </ul>
      </div>
      <%
      Connection con = ConnectionProvider.main();
        		  PreparedStatement pst = con.prepareStatement("select * from batch_section_user_relation where user_id='"+me.getUser_id()+"'");
				ResultSet res = pst.executeQuery();
				int batch=0;
				int section=0;
				if(res.next()){
					batch = res.getInt(2);
					section = res.getInt(3);
				}
        		  
      ExamsDao edao = new ExamsDao(ConnectionProvider.main());
      ArrayList<Exams>participated = edao.getAllParticipatedExamById(me.getUser_id());
        		  
      ArrayList<Exams>up = edao.getAllStudentExamById(batch, section, "");
      %>
      <div class="row">
        <div class="col-md-6">
          <div class="widget-small primary coloured-icon"><i class="icon fa fa-calendar-check-o fa-3x"></i>
            <div class="info">
              <h4>Total Upcoming Exams</h4>
              <p><b>
             <%=up.size() %>
              </b></p>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="widget-small info coloured-icon"><i class="icon fa fa-check-square-o" fa-3x"></i>
            <div class="info">
              <h4>Total Participated</h4>
              <p><b>
                <%=participated.size() %>
              
              </b></p>
            </div>
          </div>
        </div>


      </div>
      
    </main>
   <%@include file="bottom_common.jsp"%>