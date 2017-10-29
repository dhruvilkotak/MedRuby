<%@page import="com.doa.*"%>
<%@page import="java.io.PrintWriter" %>
<%@page import="com.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
 if(null == session.getAttribute("userId")){ 
  String address = "/wp-content/portal/SessionExpired.jsp?page=Sales/salesLead";
  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(address);
  dispatcher.forward(request,response);
}

 else{}
%> 
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
  
    <title>MedRuby | Sales</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
    
		<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datepicker/datepicker.css">
		<script src="<%=request.getContextPath()%>/js/main.js"></script>
		<script src="<%=request.getContextPath()%>/js/bootstrap.js"></script>
		<script src="<%=request.getContextPath()%>/plugins/datepicker/bootstrap-datepicker.js"></script>
		<script>
			$(function(){
			 $('.datepicker').datepicker();
			});
			$(document).ready(function() {
				$('#ContactPerson').blur(function() {
					
					$.ajax({
						
						type:"POST",
						url : '../../../controller?actionCode=GetDetailsFromCustm',
						data : {
							userName : $('#ContactPerson').val()
						},
						dataType:"json",
						success : function(responseText) {

							var list=responseText;
							 $.each(list, function (index, item) {
								
								 document.getElementById("Country").value=item.country;
								 document.getElementById("State").value=item.state;
								 document.getElementById("City").value=item.city;
								 document.getElementById("Address").value=item.Address;
								 document.getElementById("EmailID").value=item.EmailId;
								 
							 });
						}
					
				});
			});
			});
		</script>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
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
            <small>Lead</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
             <li><a href="<%=request.getContextPath()%>/wp-content/portal/sales.jsp">Sales</a></li>
          	<li class="active"><a href="<%=request.getContextPath()%>/wp-content/portal/salesLead.jsp">Lead</a></li>
           
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
           <div class="container">
           
           <form action="<%=request.getContextPath()%>/controller" method="post">
             <div class="col-xs-11">
            	       	     
											<!-- BEGIN FORM-->
											<!-- ===============  -->
											<%
												if ((request.getParameter("success") + "get").contains("1")) {
											%>
											<div class="alert  alert-dismissable alert-success">
												<i class="fa fa-fw fa-check"></i>&nbsp;Saleslead Added
												successfully.
												<button type="button" class="close" data-dismiss="alert"
													hidden="true">&times;</button>
											</div>
											<%
												} else if ((request.getParameter("failed") + "get").contains("1")) {
											%>
											<div class="alert alert-dismissable alert-danger">
												<i class="fa fa-fw fa-check"></i>&nbsp; Something went Wrong
												Please Try Again.
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
		          	 	   
                        	<div class="col-xs-8"> 
                        		  <input type="text" class="form-control" placeholder="Lead No" name="LeadNo" id="LeadNo" required>
		  					</div>
		  				   
		  				   <div class="col-xs-4">
	<div class="input-group">
		<div class="input-group-addon" >
			<i class="fa fa-calendar"></i>
  		</div>
		<input class="datepicker" type="text" placeholder="Lead Date" style="width:280px" name="LeadDate" id="LeadDate">
  	 </div>
</div>
		 
		       		      
		  				  
		       		    </div>
		           </div>		 
             <div class="form-group">
                  	<div class="row">
             
               
                    <div class="col-xs-8"> 
                    <input type="text" class="form-control" placeholder="Lead Name"  name="LeadName" id="Lead Name">
                    </div>
                  
                      <div class="col-xs-4">
                      <select class="form-control" name="ContactPerson" id="ContactPerson" required>
                        		  <option value="" disabled selected>Contact Person</option>
                      			    <%
                      			   List<String> customerList=(List<String>)session.getAttribute("customerList");
                      			   if(customerList!= null)
                      			   {
                      					for(String customerId:customerList)   
                      					{
                      			   %>
			                       	<option value="<%=customerId%>"><%=customerId%></option>
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
                    
                      
                    <div class="col-xs-8"> 
                         <textarea class="form-control" rows="3" placeholder="Address" name="Address" id="Address" readonly></textarea>
                    </div>
                        
                    <div class="col-xs-4">
                      	<input type="email" class="form-control" rows="1" placeholder="Email ID" name="EmailID" id="EmailID" readonly/>
                    </div>
                    <br><br>
                      
                      <div class="col-xs-4">
                      	<input type="url" class="form-control"  rows="1" placeholder="Website" required name="Website" id="Website"/>
 						                  
                    </div>
                 </div>
             </div>
             <div class="form-group">
		          	<div class="row">
                        	<div class="col-xs-4"> 
                        		<input type="text" class="form-control" placeholder="Country" name="Country" id="Country" readonly>
		  					</div>
		  				   
		  				   <div class="col-xs-4"> 
                    			<input type="text" class="form-control" placeholder="State" name="State" id="State" readonly>
		       		       </div>
		       		       
		  				   <div class="col-xs-4"> 
						 		<input type="text" class="form-control" placeholder="City" name="City" id="City" readonly>
		       		     </div>
		       		    </div>
		           </div>		
		           <div class="form-group">
                  	<div class="row">
                   
                      <div class="col-xs-12" >
                        <textarea class="form-control" rows="1" placeholder="Lead Requirement" name="LeadRequirement" id="LeadRequirement"></textarea>
                      </div>
                      </div>
                    </div>
                    <div class="form-group">
		          	  <div class="row">
		          	 	    
                        	<div class="col-xs-4"> 
                        		  <select class="form-control" name="LeadSource" id="LeadSource">
                        		  <option value="" disabled selected>Lead Source</option>
                      			    <option>Email</option>
			                        <option>News Paper</option>
			                        <option>Television</option>
			                        <option>Person</option>
			                       </select>
		  					</div>
		  				   
		  				   <div class="col-xs-2"> 
                    			 <input type="text" class="form-control" placeholder="Estimated Value"  name="EstimatedValue" id="EstimatedValue">
		       		       </div>
		       		        <div class="col-xs-2" name="UOM" id="UOM">
		       		        	<select class="form-control" name="UOM" id="UOM">
                      			    <option>INR</option>
			                        <option>US Dollar</option>
			                   </select>
		       		        
		       		         </div>
		       		     
		       		      <div class="input-group">
		<div class="input-group-addon" >
			<i class="fa fa-calendar"></i>
  		</div>
		<input class="datepicker" type="text" placeholder="Next Followup Date:" style="width:285px" name="NextFollowupDate" id="NextFollowupDate">
  	 </div>
		           </div>
		           <br>
		           <div class="form-group">
		           <div class="row">
		          	 	   
                        	<div class="col-xs-4"> 
                        		  <select class="form-control" name="GeneratedBy" id="GeneratedBy">
                        		  	  <option value="" disabled selected>Generated By</option>
                      			         <%
                      			   List<String> preparedByList=(List<String>)session.getAttribute("preparedByList");
                      			   if(preparedByList!= null)
                      			   {
                      					for(String customerId:preparedByList)   
                      					{
                      			   %>
			                       	<option value="<%=customerId%>"><%=customerId%></option>
			                       	<%
                      					}
                      			   }
			                       	%>
			                   </select>
		  					</div>
		  				   
		  				   <div class="col-xs-4"> 
                    			<select class="form-control" name="AssignTo" id="AssignTo">
                    				  <option value="" disabled selected>Assign To</option>
                      			         <%
                      			
                      			   if(preparedByList!= null)
                      			   {
                      					for(String customerId:preparedByList)   
                      					{
                      			   %>
			                       	<option value="<%=customerId%>"><%=customerId%></option>
			                       	<%
                      					}
                      			   }
			                       	%>
			                     
			                   </select>
		       		       </div>
		       		     
		  				   <div class="col-xs-4"> 
                    			<select class="form-control" name="Sector" id="Sector">
                    			  <option value="" disabled selected>Sector</option>
                      			    <option value="Automative">Automative</option>
			                        <option value="Chemicals">Chemicals</option>
			                        <option value="Utilities">Utilities</option>
			                   </select>
		       		       </div>
		       		       
		       		     </div>
		       		     <br>
		       		     <div class="row">       	 	    
                        	<div class="col-xs-6"> 
                        		  <select class="form-control" name="PreparedBy" id="PreparedBy">
                        		    <option value="" disabled selected>Prepared By</option>
                      			      <%
                      			   if(preparedByList!= null)
                      			   {
                      					for(String customerId:preparedByList)   
                      					{
                      			   %>
			                       	<option value="<%=customerId%>"><%=customerId%></option>
			                       	<%
                      					}
                      			   }
			                       	%>
			                     
			                   </select>
		  					  </div>
		  				   <div class="col-xs-6"> 
		  				   		<textarea class="form-control" rows="1" placeholder="Remarks" name="Remarks" id="Remarks"></textarea>
              		       </div>
		       		  
		       		     </div>	
		       		
		       		    </div>
	
	           </fieldset>
           	
     		 </div>
            <div class="box-footer">
                     <input type="hidden" value="doAddSalesLead" name="actionCode" />
                     <input type="hidden" value="Sales/salesLead" name="page" />
                     <button type="submit" class="btn btn-primary">Submit Sales Lead</button>
              </div>            
           </div>
           </form>
           </div>
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->
     

      <!-- Control Sidebar -->
     
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->
<jsp:include page="../footer.jsp" />
    <!-- jQuery 2.1.4 -->
    <script src="<%=request.getContextPath()%>/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
      $.widget.bridge('uibutton', $.ui.button);
      $(document).ready(function () {
          $('.salesLead').addClass('active');
          $('.Sales').addClass('active');
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

</body>
</html>