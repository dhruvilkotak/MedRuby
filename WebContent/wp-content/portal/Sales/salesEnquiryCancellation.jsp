<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="com.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
 if(null == session.getAttribute("userId")){ 
  String address = "/wp-content/portal/SessionExpired.jsp?page=Sales/salesEnquiryCancellation";
  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(address);
  dispatcher.forward(request,response);
}

 else{}
%> 
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AdminLTE 2 | Dashboard</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datepicker/datepicker.css">
		<script src="<%=request.getContextPath()%>/js/main.js"></script>
		<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
		<script src="<%=request.getContextPath()%>/plugins/datepicker/bootstrap-datepicker.js"></script>
		<script>
			$(function(){
			 $('.datepicker').datepicker();
			});
		</script>
     <!-- DataTables -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.css">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/skins/_all-skins.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/iCheck/flat/blue.css">
    <!-- Morris chart -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/morris/morris.css">
    <!-- jvectormap -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
    <!-- Date Picker -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datepicker/datepicker3.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/daterangepicker/daterangepicker-bs3.css">
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
	<!-- calendar icon -->
	<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body class="hold-transition skin-blue sidebar-mini fixed">
<div class="wrapper">

  
		  <jsp:include page="../inc2.jsp" />
	   
      <!-- Left side column. contains the logo and sidebar -->
	  <jsp:include page="../inc.jsp" />
    <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Sales 
            <small>Enquiry Cancellation</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="<%=request.getContextPath()%>/wp-content/portal/purchase.jsp">Sales</a></li>
	          	<li class="active"><a href="<%=request.getContextPath()%>/wp-content/portal/salesEnquiryCancellation.jsp"> Enquiry Cancellation</a></li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
           <div class="container">
           <div class="portlet-body form">
           <form action="<%=request.getContextPath()%>/controller?actionCode=FetchEnquiry" method="post">
             <div class="row">
             <div class="col-xs-11">
             <!-- BEGIN FORM-->
											<!-- ===============  -->
											
											<%
											if ((request.getParameter("success") + "get").contains("1")) {
											%>
											<div class="alert  alert-dismissable alert-success">
												<i class="fa fa-fw fa-check"></i>&nbsp;Enquiry Cancelled
												successfully.
												<button type="button" class="close" data-dismiss="alert" hidden="true">&times;</button>
											</div>
											<%
												} else if ((request.getParameter("failed") + "get").contains("1")) {
											%>
											<div class="alert alert-dismissable alert-danger">
												<i class="fa fa-fw fa-check"></i>&nbsp; Order Placed.
												Enquiry Can't be Cancelled..
												<button type="button" class="close" data-dismiss="alert"
													hidden="true">&times;</button>
											</div>

											<%
												}
											%>
											<!-- ===============  -->
             <div class="box box-primary">
               <!-- <div class="box-header with-border">
                  <h3 class="box-title">Quick Example</h3>
                </div> /.box-header -->
             <div class="box-body">
                
		           <fieldset class="fieldset">
		           
		           <legend>General</legend>
				            <!-- Left col -->
				            <!-- right col (We are only adding the ID to make the widgets sortable)-->
				       
				       <div class="form-group">
				       	   <div class="row">
				       	 
			                     <div class="col-xs-4">
									<div class="input-group">
										<div class="input-group-addon" >
											<i class="fa fa-calendar"></i>
								  		</div>
										<input class="datepicker" type="text" name="date" placeholder="From" style="width:285px">
								  	 </div>
								</div>
			                     <div class="col-xs-4">
								<div class="input-group">
										<div class="input-group-addon" >
											<i class="fa fa-calendar"></i>
								  		</div>
										<input class="datepicker" type="text" name="date" placeholder="To" style="width:285px">
								  	 </div>
								</div>      
	                      </div>
	                    <br>       
		             <div class="form-group">
		                  	<div class="row">
		                     
		                    <div class="col-xs-6"> 
		                    <select class="form-control" name="ItemType" id="ItemType">
		                    			<option value="" disabled selected>Item Type</option>
	                      			     <%
	                      			   List<String> itemType=(List<String>)session.getAttribute("itemType");
	                      			   if(itemType!= null)
	                      			   {
	                      					for(String type:itemType)   
	                      					{
	                      			   %>
				                       <option value="<%=type%>"><%=type%></option>
				                       <%
	                      				 }
	                      			   }
				                       	%>
				                       
				                   </select>
		                      </div>
		                      <div class="col-xs-6">
		                         <select class="form-control" name="InventoryCategory" id="InventoryCategory">
		                         		<option value="" disabled selected>Item Category</option>
	                      			     <%
	                      			   List<String> inventoryCategory=(List<String>)session.getAttribute("inventoryCategory");
	                      			   if(inventoryCategory!= null)
	                      			   {
	                      					for(String inv:inventoryCategory)   
	                      					{
	                      			   %>
				                       	<option value="<%=inv%>"><%=inv%></option>
				                       	<%
	                      					}
	                      			   }
				                       	%>
				       </select>
				   
				               
		                      </div>
		                      </div>
		                    </div>
	            <div class="form-group">
	                  	<div class="row">
	                     
	                    <div class="col-xs-6"> 
	                  <input type="text" class="form-control" placeholder="Item Code" name="ItemCode" id="ItemCode">
	                   </div>
	      
	                      <div class="col-xs-6">
	                        <input type="text" class="form-control" placeholder="Item Ref Code" name="ItemRefCode" id="ItemRefCode">
	                      </div>
	                      </div>
	                    </div>
	            <div class="form-group">
	                  	<div class="row">
	                    <div class="col-xs-12"> 
	                    <input type="text" class="form-control" placeholder="Item Name" name="ItemName" id="ItemName">
	                      </div>
	                      </div>
	                    </div> 
	                     
           </div>
           	
     		 </div>
             <div class="box-footer">
                    <button type="submit" class="btn btn-primary">Search</button>
                    <input type="hidden" value="Sales/salesEnquiryCancellation" name="page" />
              </div>          
           </div>
           </div>
           </div>
           </form>
          
               <div class="row">
             <div class="col-xs-11">
           <div class="box box-primary">
             <div class="box box-body">
     		 <%
     		 	List<SalesEnquiry> disp=(List)request.getAttribute("fList");
     		 if(disp!=null)
     		 {
     		 %>
     		   <legend> Record Found</legend>
               <table id="enquiryItems" class="table table-bordered table-striped">
		                    <thead>
		                      <tr>
		                        <th>Enquiry No</th>
		                        <th>Item Id</th>
		                        <th>Enquiry Type</th>
		                        <th>Enquiry Status</th>
		                        <th></th>
		                      </tr>
		                    </thead>
		                    <tbody>
		                    <% for(SalesEnquiry enq:disp)
		                    {
		                    %>
		                      <tr>
		                    
		                        <td><%=enq.getEnquiryNumber() %></td>
		                        <td><%=enq.getItemId()%></td>
		                        <td><%=enq.getEnquiryType()%> </td>
		                        <td><%=enq.getEnquiryStatus() %></td>
		              		    <td><form action="<%=request.getContextPath()%>/controller?actionCode=cancelEnquiry&eno=<%=enq.getEnquiryNumber()%>" method="post">
		              		    <input type="hidden" value="Sales/salesEnquiryCancellation" name="page" />
		              		     <button TYPE="submit" CLASS="btn btn-primary"  VALUE="CancelEnquiry">Cancel Enquiry</button></form>
		              		    </td>
		                      </tr>
		                <%} %>
		                  </table> 
		                  <%} %>
		                  </div>
		                  </div>
		                  </div>
		                 
          </div>
           </div>	
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->
      <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 2.3.0
        </div>
        <strong>Copyright &copy; 2014-2015 <a href="http://almsaeedstudio.com">Almsaeed Studio</a>.</strong> All rights reserved.
      </footer>

      <!-- Control Sidebar -->
      <aside class="control-sidebar control-sidebar-dark">
        <!-- Create the tabs -->
        <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
          <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
          <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
          <!-- Home tab content -->
          <div class="tab-pane" id="control-sidebar-home-tab">
            <h3 class="control-sidebar-heading">Recent Activity</h3>
            <ul class="control-sidebar-menu">
              <li>
                <a href="javascript::;">
                  <i class="menu-icon fa fa-birthday-cake bg-red"></i>
                  <div class="menu-info">
                    <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>
                    <p>Will be 23 on April 24th</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="javascript::;">
                  <i class="menu-icon fa fa-user bg-yellow"></i>
                  <div class="menu-info">
                    <h4 class="control-sidebar-subheading">Frodo Updated His Profile</h4>
                    <p>New phone +1(800)555-1234</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="javascript::;">
                  <i class="menu-icon fa fa-envelope-o bg-light-blue"></i>
                  <div class="menu-info">
                    <h4 class="control-sidebar-subheading">Nora Joined Mailing List</h4>
                    <p>nora@example.com</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="javascript::;">
                  <i class="menu-icon fa fa-file-code-o bg-green"></i>
                  <div class="menu-info">
                    <h4 class="control-sidebar-subheading">Cron Job 254 Executed</h4>
                    <p>Execution time 5 seconds</p>
                  </div>
                </a>
              </li>
            </ul><!-- /.control-sidebar-menu -->

            <h3 class="control-sidebar-heading">Tasks Progress</h3>
            <ul class="control-sidebar-menu">
              <li>
                <a href="javascript::;">
                  <h4 class="control-sidebar-subheading">
                    Custom Template Design
                    <span class="label label-danger pull-right">70%</span>
                  </h4>
                  <div class="progress progress-xxs">
                    <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
                  </div>
                </a>
              </li>
              <li>
                <a href="javascript::;">
                  <h4 class="control-sidebar-subheading">
                    Update Resume
                    <span class="label label-success pull-right">95%</span>
                  </h4>
                  <div class="progress progress-xxs">
                    <div class="progress-bar progress-bar-success" style="width: 95%"></div>
                  </div>
                </a>
              </li>
              <li>
                <a href="javascript::;">
                  <h4 class="control-sidebar-subheading">
                    Laravel Integration
                    <span class="label label-warning pull-right">50%</span>
                  </h4>
                  <div class="progress progress-xxs">
                    <div class="progress-bar progress-bar-warning" style="width: 50%"></div>
                  </div>
                </a>
              </li>
              <li>
                <a href="javascript::;">
                  <h4 class="control-sidebar-subheading">
                    Back End Framework
                    <span class="label label-primary pull-right">68%</span>
                  </h4>
                  <div class="progress progress-xxs">
                    <div class="progress-bar progress-bar-primary" style="width: 68%"></div>
                  </div>
                </a>
              </li>
            </ul><!-- /.control-sidebar-menu -->

          </div><!-- /.tab-pane -->
          <!-- Stats tab content -->
          <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div><!-- /.tab-pane -->
          <!-- Settings tab content -->
          <div class="tab-pane" id="control-sidebar-settings-tab">
            <form method="post">
              <h3 class="control-sidebar-heading">General Settings</h3>
              <div class="form-group">
                <label class="control-sidebar-subheading">
                  Report panel usage
                  <input type="checkbox" class="pull-right" checked>
                </label>
                <p>
                  Some information about this general settings option
                </p>
              </div><!-- /.form-group -->

              <div class="form-group">
                <label class="control-sidebar-subheading">
                  Allow mail redirect
                  <input type="checkbox" class="pull-right" checked>
                </label>
                <p>
                  Other sets of options are available
                </p>
              </div><!-- /.form-group -->

              <div class="form-group">
                <label class="control-sidebar-subheading">
                  Expose author name in posts
                  <input type="checkbox" class="pull-right" checked>
                </label>
                <p>
                  Allow the user to show his name in blog posts
                </p>
              </div><!-- /.form-group -->

              <h3 class="control-sidebar-heading">Chat Settings</h3>

              <div class="form-group">
                <label class="control-sidebar-subheading">
                  Show me as online
                  <input type="checkbox" class="pull-right" checked>
                </label>
              </div><!-- /.form-group -->

              <div class="form-group">
                <label class="control-sidebar-subheading">
                  Turn off notifications
                  <input type="checkbox" class="pull-right">
                </label>
              </div><!-- /.form-group -->

              <div class="form-group">
                <label class="control-sidebar-subheading">
                  Delete chat history
                  <a href="javascript::;" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>
                </label>
              </div><!-- /.form-group -->
            </form>
          </div><!-- /.tab-pane -->
        </div>
      </aside><!-- /.control-sidebar -->
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->

    <!-- jQuery 2.1.4 -->
    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
      $.widget.bridge('uibutton', $.ui.button);
      $(document).ready(function () {
          $('.salesEnquiryCancellation').addClass('active');
          $('.Sales').addClass('active');
      });
      $(function () {
          $("#example1").DataTable();
          $('#enquiryItems').DataTable({
            "paging": true,
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": false
          });
      });
    </script>
    <!-- Bootstrap 3.3.5 -->
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <!-- Morris.js charts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="<%=request.getContextPath()%>/plugins/morris/morris.min.js"></script>
    <!-- Sparkline -->
    <script src="<%=request.getContextPath()%>/plugins/sparkline/jquery.sparkline.min.js"></script>
    <!-- jvectormap -->
    <script src="<%=request.getContextPath()%>/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="<%=request.getContextPath()%>/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <!-- jQuery Knob Chart -->
    <script src="<%=request.getContextPath()%>/plugins/knob/jquery.knob.js"></script>
    <!-- daterangepicker -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
    <script src="<%=request.getContextPath()%>/plugins/daterangepicker/daterangepicker.js"></script>
    <!-- datepicker -->
    <script src="<%=request.getContextPath()%>/plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- Bootstrap WYSIHTML5 -->
    <script src="<%=request.getContextPath()%>/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <!-- Slimscroll -->
    <script src="<%=request.getContextPath()%>/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="<%=request.getContextPath()%>/plugins/fastclick/fastclick.min.js"></script>
    <!-- AdminLTE App -->
    <script src="<%=request.getContextPath()%>/js/app.min.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <script src="<%=request.getContextPath()%>/js/dashboard.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="<%=request.getContextPath()%>/js/demo.js"></script>
    <script src="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.min.js"></script>


</body>

</html>