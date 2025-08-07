<%@page import="java.sql.ResultSet"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="top_common.jsp" %>
    <main class="app-content">
      <div class="app-title">
        <div>
          <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
          <p>Teacher Dashboard for OEMS - Online Exam Management System</p>
        </div>
        <ul class="app-breadcrumb breadcrumb">
          <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
          <li class="breadcrumb-item"><a href="#">Dashboard</a></li>
        </ul>
      </div>
      <%
      Connection con = ConnectionProvider.main();
      %>
      <div class="row">
        <div class="col-md-6">
          <div class="widget-small primary coloured-icon"><i class="icon fa fa-users fa-3x"></i>
            <div class="info">
              <h4>Total Question Created</h4>
              <p><b>
              
                                         <%
              
              	PreparedStatement pst3 = con.prepareStatement("select count(*) from questions where q_teacher='"+me.getUser_id()+"'");
        		ResultSet res3 = pst3.executeQuery();
        		if(res3.next())
        				out.print(res3.getInt(1));
        		else out.print(0);
              %>
              
              </b></p>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="widget-small info coloured-icon"><i class="icon fa fa-thumbs-o-up fa-3x"></i>
            <div class="info">
              <h4>Total Question Set Created</h4>
              <p><b>
              
                            <%
              
              	PreparedStatement pst2 = con.prepareStatement("select count(*) from question_sets where qs_teacher='"+me.getUser_id()+"'");
        		ResultSet res2 = pst2.executeQuery();
        		if(res2.next())
        				out.print(res2.getInt(1));
        		else out.print(0);
              %>
              
              
              </b></p>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="widget-small warning coloured-icon"><i class="icon fa fa-files-o fa-3x"></i>
            <div class="info">
              <h4>Total Exam Created</h4>
              <p><b>
              
              
              <%
              
              	PreparedStatement pst = con.prepareStatement("select count(*) from exams where exam_teacher='"+me.getUser_id()+"'");
        		ResultSet res = pst.executeQuery();
        		if(res.next())
        				out.print(res.getInt(1));
        		else out.print(0);
              %>
              
              
              
              
              
              </b></p>
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="widget-small danger coloured-icon"><i class="icon fa fa-star fa-3x"></i>
            <div class="info">
              <h4>Upcoming Exam Date</h4>
              <p><b>
              
                                                       <%
              
              	PreparedStatement pst4 = con.prepareStatement("select count(*) from exams where exam_teacher='"+me.getUser_id()+"' and sysdate<exam_end");
        		ResultSet res4 = pst4.executeQuery();
        		if(res4.next())
        				out.print(res4.getInt(1));
        		else out.print(0);
              %>
              
              </b></p>
            </div>
          </div>
        </div>
      </div>
      
    </main>
   <%@include file="bottom_common.jsp"%>