<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <% 
 if(null == session.getAttribute("userId")){ 
  String address = "/wp-content/portal/SessionExpired.jsp?page=warehouse/directSalesReturn";
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

     <f:subview id="sidebar">
		  <jsp:include page="../inc2.jsp" />
		</f:subview>
     
      <!-- Left side column. contains the logo and sidebar -->
<f:subview id="sidebar">
  <jsp:include page="../inc.jsp" />
</f:subview>
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Direct Sales
            <small>Return</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="<%=request.getContextPath()%>/wp-content/portal/warehouse.jsp">Warehouse</a></li>
          	<li class="active"><a href="<%=request.getContextPath()%>/wp-content/portal/directSalesReturn.jsp">Direct Sales Return</a></li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
           <div class="container">
           <form action="<%=request.getContextPath()%>/controller" method="post">
             <div class="col-xs-11">
             
              <% if((request.getParameter("success")+"get").contains("1"))
			{
			%>
			<div class="alert alert-dismissable alert-success">
					<i class="fa fa-fw fa-check"></i>&nbsp; Return Details added successfully.
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				</div>
			<%} else if((request.getParameter("failed")+"get").contains("1")) 
			{%>
			<div class="alert alert-dismissable alert-danger">
					<i class="fa fa-fw fa-check"></i>&nbsp; Something went Wrong Please Try Again.
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				</div>
				<%}%>
             
             <div class="box box-primary">
               <!-- <div class="box-header with-border">
                  <h3 class="box-title">Quick Example</h3>
                </div> /.box-header -->
             <div class="box-body">
                
           <fieldset class="fieldset">
           
           <legend>Sales Return Details</legend>
		            <!-- Left col -->
		            <!-- right col (We are only adding the ID to make the widgets sortable)-->
		           <div class="form-group">
		          	<div class="row">
		          	 	   
                        	<div class="col-xs-4"> 
                        		  <input type="text" id="returnNumber" name="returnNumber" class="form-control" placeholder="Sales Return No.">
		  					</div>
		  					
		  					<div class="col-xs-4"> 
                        		  <input type="text" id="salesOrderId" name="salesOrderId" class="form-control" placeholder="Sales Order No.">
		  					</div>
		  				
		  				<div class="col-xs-4">
							<div class="input-group">
							<div class="input-group-addon" >
							<i class="fa fa-calendar"></i>
  							</div>
							<input class="datepicker" id="returnDate" type="text" name="returnDate" placeholder="Sales Return Date" style="width: 275px">
  							 </div>
						</div>
		       		    </div>
		           </div>			 
		          		
                  <div class="form-group">
                  	<div class="row">
                  	
                        	<div class="col-xs-6"> 
                        		  <input type="text" id="customerName" name="customerName" class="form-control" placeholder="Customer Name">
		  					</div>
		  				
                        	<div class="col-xs-6"> 
                        		  <input type="text" id="address" name="address" class="form-control" placeholder="Customer Address">
		  					</div>
                      </div>
                    </div>
                  </fieldset>  		
           
	          
     		 <fieldset class="fieldset">
	         
	        		<legend>Item Details</legend>
		            <!-- Left col -->
		            <!-- right col (We are only adding the ID to make the widgets sortable)-->
		          <div class="form-group">
		          	<div class="row">
		          	 	 	<div class="col-xs-4"> 
                        		  <input type="text" id="itemId" name="itemId" class="form-control" placeholder="Item Code">
		  					</div>
		  				 	
                        	<div class="col-xs-4"> 
                        		  <input type="text" id="returnQty" name="returnQty" class="form-control" placeholder="Return Qty">
		  					</div>
		  				 
                        	
                        	<div class="col-xs-4"> 
                        		  <input type="text" id="totalAmount" name="totalAmount" class="form-control" placeholder="Total Amt">
		  					</div>
		             	
		       		    </div>
		           </div>			 
		 	<div class="form-group">
                  	<div class="row">
                    
                        	<div class="col-xs-4"> 
                        		  <input type="text" id="currentStock" name="currentStock" class="form-control" placeholder="Stock Bal Qty">
		  					</div>
		  					
		  					 <div class="col-xs-4"> 
                    <select id="preparedBy" name="preparedBy" class="form-control" >
                    	<option value="" selected disabled>Prepared By</option>
                        <option>option 1</option>
                        <option>option 2</option>
                        <option>option 3</option>
                        <option>option 4</option>
                        <option>option 5</option>
                      </select>
                      </div>
		  					
                        	<div class="col-xs-4"> 
                        		  <input type="text" id="remarks" name="remarks"  class="form-control" placeholder="Remark">
		  					</div>
		  					
                     
                      </div>
                      </div>
	        </fieldset>
	         <div class="box-footer">
	         		<input type="hidden" value="doAddSalesReturnDetails" name="actionCode" />
	         		<input type="hidden" value="warehouse/directSalesReturn" name="page" />
		                   
                    <button type="submit" class="btn btn-primary">Submit</button>
                    
              </div>
           </div>
            
                
           </div>
           </div>	</form>
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->
      <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 2.3.0
        </div>
        <strong>Copyright &copy; 2014-2015 <a href="http://almsaeedstudio.com">Almsaeed Studio</a>.</strong> All rights reserved.
      </footer>

      <!-- Control Sidebar -->
   
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->

   <!-- jQuery 2.1.4 -->
    <script src="<%=request.getContextPath()%>/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <script>
      $.widget.bridge('uibutton', $.ui.button);
      $(document).ready(function () {
          $('.directSalesReturn').addClass('active');
          $('.Warehouse').addClass('active');
        
      alert("hello");
      $('#salesOrderId').blur(function() {
      $.ajax({
			
			type:"POST",
			url : '../../../controller?actionCode=doFetchCustomerDetails',
			data : {
				salesOrderId : $('#salesOrderId').val()
			},
			dataType:"json",
			success : function(responseText) {
				var list=responseText;
				 $.each(list, function (index, item) {
					 document.getElementById("customerName").value=item.customerName;
					 document.getElementById("address").value= item.address;
				 
				  });
				}
			});
  });
      $('#salesOrderId').change(function() {
			if ($('#salesOrderId').val()=="" ||$('#salesOrderId').val()==null ) {
				return false;
			}
			$.ajax({
				type:"POST",
				url : '../../../controller?actionCode=doFetchItemIdSales',
				data : {
					salesOrderId :$('#salesOrderId').val()
				}, 
				
				success : function(responseText) {
					
					document.getElementById("itemId").value=responseText;
					$.ajax({
						type:"POST",
						url : '../../../controller?actionCode=doFetchCurrentStock',
						data : {
							
							itemId:responseText
						}, 
						
						success : function(responseText) {
							
							document.getElementById("currentStock").value=responseText;		
							
					}
					});	
			}
			});
		 });
    

      $('#returnQty').change(function() {
			if ($('#returnQty').val()=="" ||$('#returnQty').val()==null ) {
				return false;
			}
			$.ajax({
				type:"POST",
				url : '../../../controller?actionCode=doCheckReturnQtySales',
				data : {
					returnQty :$('#returnQty').val(),
					itemId:$('#itemId').val()
				}, 
				
				success : function(responseText) {
					
					document.getElementById("returnQty").value=responseText;		
					
			}
			});
		 });

      $('#returnQty').change(function() {
			if ($('#returnQty').val()=="" ||$('#returnQty').val()==null ) {
				return false;
			}
			$.ajax({
				type:"POST",
				url : '../../../controller?actionCode=doCalculateAmountSales',
				data : {
					returnQty :$('#returnQty').val(),
					itemId:$('#itemId').val()
				}, 
				
				success : function(responseText) {
					
					document.getElementById("totalAmount").value=responseText;		
					
			}
			});
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
  </body>
</html>
