<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.model.Supplier" %>
<%@ page import="com.model.Mrv" %>
<%@ page import="com.model.PurchaseOrder" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  
  
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AdminLTE 2 | Dashboard</title>
  
   <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.2.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/normalize.css">
      <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/result-light.css">
      <script type="text/javascript" src="http://mrrio.github.io/jsPDF/dist/jspdf.debug.js"></script>
      <script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>
 
  
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
		  <jsp:include page="inc2.jsp" />
		      <!-- Left side column. contains the logo and sidebar -->
  <jsp:include page="inc.jsp" />

      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <div class="container"  id="canvas">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Purchase
            <small>Order</small>
          </h1>
         <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="<%=request.getContextPath()%>/wp-content/portal/purchase.jsp"> Purchase</a></li>
          	<li class="active"><a href="<%=request.getContextPath()%>/wp-content/portal/purchaseOrder.jsp">Purchase Order</a></li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
           
			<div class="col-xs-11">
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
		           <!-- select -->
            <div class="form-group">
		          	<div class="row">
		          	 	    <div class="col-xs-4"> 
                        		  <input type="text" class="form-control" placeholder="PO Number:" name="poNumber" id="poNumber">
		  					</div>
		                    <div class="col-xs-4"> 
		                    <select class="form-control" name="poStatus" id="poStatus">
		                        <option value="" selected disabled >PO Status:</option>
		                        <option value="open">open</option>
		                        <option value="close">close</option>
		                      </select>
		                      </div>
		                       
			  				 <div class="col-xs-4">
		                      	 <div class="input-group">
		                      		<div class="input-group-addon" >
			                        		<i class="fa fa-calendar"></i>
			                      		</div>
			                      			<input class="datepicker" style="width:275px" type="text"  placeholder="PO Date:" id="poDate" name="poDate">
			                    	 </div>
			                    </div>
		                    
		       		    </div>
		           </div>			 
		    
                 <div class="form-group">
		          	<div class="row">
	                   	 <div class="col-xs-4"> 
	                   	    <select class="form-control" name="quotatioNumber" id="quotationNumber" onchange="getSupplierDetails(this.value)">
		                        <option value="" selected disabled>Quotation Reference Number</option>
		                        <%
		                       	List<String> quotationNumberList=(List<String>)request.getSession().getAttribute("quotationNumberList");
		                     	if(quotationNumberList!=null)
		                     	{
		                     		for(String quotationNumber:quotationNumberList)
		                       		{
		                       %>
		                    	    <option value="<%=quotationNumber%>"><%=quotationNumber %></option>
		                    	<%
		                       		}
		                       	}
		                    	%> 		                      </select>
		                       </div>
							          			
		                    
		          	 		<div class="col-xs-4"> 
                        		  <input type="text"  class="form-control" placeholder="Supplier Name:" name="supplierName" id="supplierName">
		  					</div>
		  					
		  				 <div class="col-xs-4">
		                      	 <div class="input-group">
		                      		<div class="input-group-addon" >
		                        		<i class="fa fa-calendar"></i>
		                      		</div>
		                     			<input class="datepicker" type="text" style="width:275px" placeholder="Delivery Date:" name="deliveryDate" id="deliveryDate">
		                    	 </div>
		                    </div>
                    </div>
		           </div>
		      			 
		    	<div class="form-group">
                  	<div class="row">
                    <div class="col-xs-4"> 
                    <select class="form-control" name="currencyType" id="currencyType">
                        <option  value="" selected disabled>Currency Type:</option>
                        <option value="inr">Indian National Rupees(INR)</option>
                      </select>
                      </div>
                      <div class="col-xs-4"> 
                        		  <input type="text" class="form-control" name="currencyRate" id="currencyRate" placeholder="Currency Rate:">
		  				</div>
		  			  <label class="col-sm-2 control-label">Under Excise:</label>
			                      <div class="radio">
			                        <label class="col-sm-1 control-label">
			                          <input type="radio" name="underExcise" id="yse" value="yes" checked>
			  							Yes
			                        </label>
			                        <label class="col-sm-1 control-label">
			                          <input type="radio" name="underExcise" id="no" value="no">
			                          No
			              </label>
		  				</div>
                    </div>
		    </div>
		   </fieldset>  		
           
	           <fieldset class="fieldset">
	           <legend>Supplier Address Contact Details</legend>
	           	 <table id="supplierDetailsTable" class="table table-bordered table-striped">
			                    <thead>
			                      <tr>
			                      	<th class="col-xs-2">Suppier Name</th>
			                        <th class="col-xs-5">Supplier Address</th>
			                        <th class="col-xs-3">Email Id</th>
			                        <th class="col-xs-2">Phone Number</th>
			                      </tr>
			                    </thead>
					           	<tbody id="supplierData">
					           	
					           	</tbody>
					</table>
	           	
	           </fieldset>
           
     		 <fieldset class="fieldset">
	           <legend>Order Status</legend>
	           	<div class="form-group">
                  	<div class="row">	
                     
                    <div class="col-xs-4"> 
                    <select class="form-control" name="dispatchMode" id="dispatchMode">
                        <option value="" selected disabled>Mode Of Dispatch:</option>
                        <option value="air">Air</option>
                        <option value="railway">Railway</option>
                        <option value="road">Road</option>
                      
                      </select>
                      </div>
                      <div class="col-xs-4"> 
                        		  <input type="text" class="form-control" placeholder="Policy Number:" name="policyNumber" id="policyNumber">
		  					</div>
		  					<label class="col-sm-2 control-label">Insurance By:</label>
                      <div class="radio">
                        <label class="col-sm-1 control-label">
                          <input type="radio" name="insuranceBy" id="us" value="us" checked>
  							By Us
                        </label>
                        <label class="col-sm-1 control-label">
                          <input type="radio" name="insuranceBy" id="party" value="party">
                          Party
                        </label>
                      </div>
		  				</div>
                    </div>
                    
               	<div class="form-group">
                  	<div class="row">
	                     
	                    <div class="col-xs-4"> 
	                    	   <textarea class = "form-control" rows = "2" name="deliveryAt" id="deliveryAt" placeholder="Delivery At:"></textarea>
			  			</div>
	                    <div class="col-xs-8"> 
	                    	  <textarea class = "form-control" placeholder="Remarks" rows = "2" name="remarks" id="remarks"></textarea>
			  			</div>
			  		     
		  		</div>
         	</div>  
		    
	           </fieldset>
           </div> 
           <div class="box-footer">
                    <div class="row">
                    	<div class="col-xs-5">
                    	
                    	</div>
                    	<div class="col-xs-5">
                    		<input type="hidden" value="doSubmitPurchaseOrder" name="actionCode" />
		                   	<button type="submit" class="btn btn-primary">Submit</button>
		                   	<button id="download">Download Pdf</button>
		                  
                    	</div>
                    </div>
                    
              </div>
           	</div>
           	</form>
           </div>	
        </section><!-- /.content -->
        </div>
      </div><!-- /.content-wrapper -->
      <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 2.3.0
        </div>
        <strong>Copyright &copy; 2014-2015 <a href="http://almsaeedstudio.com">Almsaeed Studio</a>.</strong> All rights reserved.
      </footer>

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
    $quotationNumber = $('#quotationNumber');

	$quotationNumber
			.change(function() {
				if ($('#quotationNumber').val()=="" ||$('#quotationNumber').val()==null ) {
					return false;
				}
				$('#spinnerloader').show();
				$('#img-spinner').show();
				 document.getElementById("supplierName").value="";
				 document.getElementById("supplierData").innerHTML="";
			 

				$.ajax({
					type:"POST",
					url : '../../../controller?actionCode=doFetchSupplierDetails',
					data : {
						quotationNumber :$('#quotationNumber').val()
					},
					dataType:"json",
					success : function(responseText) {
						//$('#ajaxGetUserServletResponse').text(responseText);
						//document.getElementById("supplierName").value=responseText;
						var list=responseText;
						 $.each(list, function (index, item) {
							 document.getElementById("supplierName").value=item.supplierName;
							 document.getElementById("supplierName").readOnly = true;
							 document.getElementById("supplierData").innerHTML="<td>"+item.supplierName+"</td><td>"+item.supplierAddress+"</td><td>"+item.emailId+"</td><td>"+item.phoneNumber+"</td>";
						   });
					}
				});				
				$('#img-spinner').hide();


			});
	  $.widget.bridge('uibutton', $.ui.button);
      $(document).ready(function () {
          $('.purchaseOrder').addClass('active');
          $('.Purchase').addClass('active');
          $('#download').click(function()
        		    {       
        		        html2canvas($("#canvas"), {
        		            onrendered: function(canvas) {         
        		                var imgData = canvas.toDataURL(
        		                    'image/png');              
        		                var doc = new jsPDF('p', 'mm', [300, 300]);
        		                doc.addImage(imgData, 'PNG', 10, 10);
        		                doc.save('sample-file.pdf');
        		            }
        		        });
        		    });
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
