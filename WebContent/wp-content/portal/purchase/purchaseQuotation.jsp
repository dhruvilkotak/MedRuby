<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
 <% 
 if(null == session.getAttribute("userId")){ 
  String address = "/wp-content/portal/SessionExpired.jsp?page=purchase/pendingApproval";
  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(address);
  dispatcher.forward(request,response);
}

 else{}
%>  
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>MedRuby | Purchase Quotation</title>
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
            Purchase
            <small>Quotation</small>
          </h1>
         <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="<%=request.getContextPath()%>/wp-content/portal/purchase/purchase.jsp"> Purchase</a></li>
            <li class="active"><a href="#"> Purchase Quotation</a></li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
           <div class="container">
			<div class="col-xs-11">   
			<%  if(request.getParameter("data")!=null &&request.getParameter("data").equals("no"))
				{%>
        	    	<div class="alert alert-dismissable alert-danger">
						<i class="fa fa-fw fa-check"></i>&nbsp;Wrong with some data. Can't add successfully.
						<button type="button" class="close" data-dismiss="alert" hidden="true">&times;</button>
					</div>
					<% } %>
					
		
			<form action="<%=request.getContextPath()%>/controller" method="post">          
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
                        		  <input type="text" class="form-control" placeholder="Quotation number" name="quotationNumber" id="quotationNumber" required>
		  					</div>
		  					<% String enquiryNumber = (String)request.getSession().getAttribute("enquiryNumber");%>
		  						<% String id = (String)request.getSession().getAttribute("id");%>
				  			 <div class="col-xs-4"> 
                        		  <input type="text" class="form-control" placeholder="Enquiry number" name="enquiryNumber" id="enquiryNumber" value="<%=enquiryNumber%>" readonly>
		  					</div>
				  				 
			  				<div class="col-xs-4">
	                      	 <div class="input-group">
	                      		<div class="input-group-addon" >
	                        		<i class="fa fa-calendar"></i>
	                      		</div>
	                      			<input class="datepicker" type="text" style="width:275px" placeholder="Quotation Date" name="quotationDate" id="quotationDate" required>
	                    	  </div>
	            		   </div>
					           			 
		           </div>
		           <br>
		           <!-- select -->
                  <div class="form-group">
                  	<div class="row">
                  		
                    	 <div class="col-xs-4"> 
			                    <select class="form-control" name="supplierName" id="supplierName" required>
			                        <option value="" disabled selected>Supplier Name:</option>
			                     <%  
			                     List<String> SupplierIDList=(List<String>)request.getSession().getAttribute("SupplierIDList");
			                     if(SupplierIDList !=null)
		                     	{
		                     		for(String SupplierID:SupplierIDList)
		                       		{
		                       %>
		                    	    <option value="<%=SupplierID%>"><%=SupplierID %></option>
		                    	<%
		                       		}
		                       	}
		                    	%> 
			                      </select>
			                    </div>
			        	
	                 <div class="col-xs-4" name="status" id="status"> 
			                    <select class="form-control" required>
			                    	<option value="" disabled selected >Status</option>
			                        <option>open</option>
			                        <option>close</option>
			                      </select>
			                      </div>
		  				
                    <div class="col-xs-4"> 
                    <select class="form-control" name="currencyType" id="currencyType" required>
                        <option value="" disabled selected>Currency Type:</option>
                        <option value="inr">Indian Rupees(INR)</option>
                      </select>
                      </div>
		       		    </div>
                     </div>
                    </div>
                    
                    <div class="form-group">
                  	<div class="row">
                      <div class="col-xs-4"> 
                        		  <input type="text" class="form-control" placeholder="Currency Rate:" name="currencyRate" id="currencyRate" required>
		  					</div>
		  			     
                    	<div class="col-xs-4"> 
	                  		  <input type="text" class="form-control" placeholder="Net Amount:" name="netAmount" id="netAmount" required>
			  			</div>
			  	          <div class="col-xs-4"> 
	                        		  <input type="text" class="form-control" placeholder="Gross Amount:" name="grossAmount" id="grossAmount" required>
			  			</div>
	                	
	                      
                    </div>
                    </div>
           		</fieldset>  		
           
	           <fieldset class="fieldset">
				<legend></legend>
	         	<div class="form-group">
                  	<div class="row">
                  	<div class="col-xs-4"> 
	                    <select class="form-control" name="preparedBy" id="preparedBy" required>
	                        <option value="" disabled selected>Prepared By:</option>
	                       <%
		                       	List<String> followupByList=(List<String>)request.getSession().getAttribute("followupByList");
		                     	if(followupByList!=null)
		                     	{
		                     		for(String followupBy:followupByList)
		                       		{
		                       %>
		                    	    <option value="<%=followupBy%>"><%=followupBy %></option>
		                    	<%
		                       		}
		                       	}
		                    	%> 
	                      </select>
	                      </div>
                    <div class="col-xs-8 " name="remarks" id="remarks"> 
                         <textarea class = "form-control" rows = "2" placeholder="Remark:"></textarea>
		  					</div>
		  					</div>
                    </div>
		     
	           </fieldset>
           
     		 </div>
            <div class="box-footer">
            		<div class="col-xs-5"></div>
            		<input type="hidden" value="<%=id%>" name="id" />
            		<input type="hidden" value="doSubmitPurchaseQuotation" name="actionCode" />
            		<input type="hidden" value="purchase/pendingApproval" name="page" />
                    <button type="submit" class="btn btn-primary"  style="text-align: center;">Submit</button>
              </div>
           </div>
       </form>
           </div>
           </div>	
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->
    
  <jsp:include page="../footer.jsp" />
  
   <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->


    <!-- jQuery 2.1.4 -->
    <script src="<%=request.getContextPath()%>/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <script>
    $('#currencyType').change(function()
    		{
    			
    			if($('#currencyType').val()=="inr")
    				{
    				document.getElementById("currencyRate").value="1.00";    
    				document.getElementById("currencyRate").readOnly = true;
    				}
    		});
      $.widget.bridge('uibutton', $.ui.button);
      $(document).ready(function () {
          $('.pendingApproval').addClass('active');
          $('.Purchase').addClass('active');
      });
      </script>

    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
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
