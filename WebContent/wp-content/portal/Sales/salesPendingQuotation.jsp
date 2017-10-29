<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.model.Item" %>
<%@page import="java.util.*" %>
<%@page import="org.json.JSONObject"%>;
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
 if(null == session.getAttribute("userId")){ 
  String address = "/wp-content/portal/SessionExpired.jsp?page=sales/salesPendingQuotation";
  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(address);
  dispatcher.forward(request,response);
}

 else{}
%> 
<head>
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
			
		</script>
     <!-- DataTables -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.css">
    
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.css">
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
     	<jsp:include page="../inc.jsp" />
      	<div class="content-wrapper">
    	    <section class="content-header">
          	<h1>
          	    Sales 
            	<small>Pending Quotation</small>
         	 </h1>
	         <ol class="breadcrumb">
	            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	             <li><a href="<%=request.getContextPath()%>/wp-content/portal/sales.jsp">Sales</a></li>
		          	<li class="active"><a href="<%=request.getContextPath()%>/wp-content/portal/salesPendingQuotation.jsp"> Pending Quotation</a></li>
		
	          </ol>
        	</section>
        	<section class="content">
         	  <div class="container">
              <form action="<%=request.getContextPath()%>/controller?actionCode=searchPendningQuotation" method="post">
		           <div class="row">
		             	<div class="col-xs-11">
		             	<div class="box box-primary">
		            	 <div class="box-body">
		        	     	<fieldset class="fieldset">
           
           					<legend>General</legend>
		          
						       <div class="form-group">
						       		 <div class="row">
						       	   		<div class="col-xs-4">
										<div class="input-group">
											<div class="input-group-addon" >
												<i class="fa fa-calendar"></i>
								  			</div>
										<input class="datepicker" type="text"  placeholder="From" style="width:285px" name="From" id="From">
								  	     </div>
								        </div>
				
								     
							              <div class="col-xs-4">
												<div class="input-group">
													<div class="input-group-addon" >
														<i class="fa fa-calendar"></i>
											  		</div>
													<input class="datepicker" type="text" placeholder="To:" style="width:285px" name="To" id="To">
											  	 </div>
											</div>
				                    </div>  
					                      
					            </div>
					                    
					                    
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
					                    
					                      <div class="col-xs-6" >
					                         <select class="form-control" name="InventoryCategory" id="InventoryCategory">
					                         		<option value="" disabled selected>Inventory Category</option>
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
					                    <div class="col-xs-6" > 
					                    <input type="text" class="form-control" placeholder="Item Code" name="ItemCode" id="ItemCode">
					                      </div>
					                      <div class="col-xs-6" >
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
					                   
					          </fieldset>
					       </div>
					                    
	                      <div class="box-footer">
	                      	  <input type="hidden" value="Sales/salesPendingQuotation" name="page" />
                  			  <button type="submit" class="btn btn-primary">Search</button>
            		      </div> 
            			</div>
           			  </div>  
           			  </div>
                    </form>
				<div class="row">  
				<div class="col-xs-11">     
             		<div class="box box-primary">
           			   <div class="box-body">
		     		 <%
		     		 	List<JSONObject> disp=(List)request.getAttribute("listJSON");
		     		 if(disp!=null)
		     		 {
		     		 %>
		     		   <legend> Record Found</legend>
		               <table id="pendingItems" class="table table-bordered table-striped">
				                    <thead>
				                      <tr>
				                        <th>Enquiry No</th>
				                        <th>Item Id</th>
				                        <th>Item Name</th>
				                        <th>Item Qty</th>
				                        <th></th>
				                      </tr>
				                    </thead>
				                    <tbody>
				                    <% for(JSONObject item:disp)
				                    {
				                    %>
				                      <tr>
				                        <td><%=item.get("enquiryNo") %></td>
				                        <td><%=item.get("itemId") %></td>
				                        <td><%=item.get("itemName")%> </td>
				                        <td><%=item.get("itemQty") %></td>
				              		    <td><form action="<%=request.getContextPath()%>/controller?actionCode=doGetQuotaData&eno=<%=item.get("enquiryNo")%>&itemQty=<%=item.get("itemQty")%>&itemRate=<%=item.get("rate")%>&page=salesQuotation" method="post">
				              		     <input type="hidden" value="Sales/salesPendingQuotation" name="page" />
				              		     <button TYPE="submit" CLASS="btn btn-primary"  VALUE="Make Quotation">Make Quotation</button></form>
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
          $('.salesPendingQuotation').addClass('active');
          $('.Sales').addClass('active');
            
      });
      
      $(function () {
          $("#example1").DataTable();
          $('#pendingItems').DataTable({
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
  <!-- DataTables -->
    <script src="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.min.js"></script>


</body>

</html>