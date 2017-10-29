<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.model.PurchaseEnquiry" %>
<%@ page import="com.model.Item" %>
<%@ page import="com.model.PurchaseItemList" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>


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
    <title>MedRuby | Pending Approval</title>
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
  <body class="hold-transition skin-blue sidebar-mini fixed" >
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
            <small>Pending Approval</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="<%=request.getContextPath()%>/wp-content/portal/purchase/purchase.jsp"> Purchase</a></li>
            <li class="active"><a href="#">PendingApproval</a></li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
           <div class="container">
           <div class="row">
				<div class="col-xs-11">        
					<%if(request.getParameter("data")!=null &&request.getParameter("data").equals("yes"))
				{%>
					<div class="alert  alert-dismissable alert-success">
						<i class="fa fa-fw fa-check"></i>&nbsp;Purchase Quotation Added Successfully.
						<button type="button" class="close" data-dismiss="alert" hidden="true">&times;</button>
					</div>
					
					<%} %>     
             <div class="box box-primary"   style="text-align: center;">
               <!-- <div class="box-header with-border">
                  <h3 class="box-title">Quick Example</h3>
                </div> /.box-header -->
            <form action="<%=request.getContextPath()%>/controller" method="post">    
            	
             <div class="box-body">
                
           <fieldset class="fieldset">
                   <!-- Left col -->
		            <!-- right col (We are only adding the ID to make the widgets sortable)-->
		           <!-- select -->
              <div class="form-group">
                  	<div class="row">
		  		    	  <div class="col-xs-12"> 
                        		  <input type="text" class="form-control" placeholder="Item Name:" name="itemName" id="itemName">
		  		    	</div>
					</div>
                 </div>
                 
                <div class="form-group">
                  	<div class="row"> 
                 
		  		    	 <div class="col-xs-4"> 
                        		  <input type="text" class="form-control" placeholder="Item Code:" name="itemId" id="itemId">
	  					</div>
		  				<div class="col-xs-4"> 
                        		  <input type="text" class="form-control" placeholder="Item Ref Code:" name="itemRefNumber" id="itemRefNumber">
		  				</div>
		  		       <div class="col-xs-4"> 
			                    <select class="form-control" name="itemType" id="itemType">
			                        <option  value="" disabled selected >Item Type:</option>
			                        <%
		                       	List<String> itemTypeList=(List<String>)request.getSession().getAttribute("itemTypeList");
		                     	if(itemTypeList!=null)
		                     	{
		                     		for(String itemType:itemTypeList)
		                       		{
		                       %>
		                    	    <option value="<%=itemType%>"><%=itemType %></option>
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
          		      		<div class="col-xs-4"> 
		                    <select class="form-control" name="inventoryCategory" id=="inventoryCategory">
		                        <option value="" disabled selected>Inventory Category:</option>
		                       <%
		                       	List<String> inventoryCategoryList=(List<String>)request.getSession().getAttribute("inventoryCategoryList");
		                     	if(inventoryCategoryList!=null)
		                     	{
		                     		for(String inventoryCategory:inventoryCategoryList)
		                       		{
		                       %>
		                    	    <option value="<%=inventoryCategory%>"><%=inventoryCategory %></option>
		                    	<%
		                       		}
		                       	}
		                    	%> 
		                      </select>
		                      </div>
                      
				 		 <div class="col-xs-4">
	                      	 <div class="input-group">
	                      		<div class="input-group-addon" >
	                        		<i class="fa fa-calendar"></i>
	                      		</div>
	                      			<input class="datepicker" type="text" style="width:275px" placeholder="From:" name="fromEnquiryDate" id="fromEnquiryDate">
	                    	 </div>
	                    </div>
				 		 <div class="col-xs-4">
	                      	 <div class="input-group">
	                      		<div class="input-group-addon" >
	                        		<i class="fa fa-calendar"></i>
	                      		</div>
	                      			<input class="datepicker" type="text" style="width:275px" name="toEnquiryDate" placeholder="To:" id="toEnquiryDate">
	                    	 </div>
	            	     </div>
                 </div>
                 </div> 
            </fieldset>  		
            </div>
	            <div class="box-footer">
	                    <div class="row">	
	                    		<input type="hidden" value="dofetchPurchaseEnquiry" name="actionCode" />
	                    		<input type="hidden" value="purchase/pendingApproval" name="page" />
	                    		<button type="submit" class="btn btn-primary"  style="text-align: center;">Search</button>
	                    
	                    </div>
	              </div>
            </form>   
           </div>
           </div>
           </div>
           </div>
           <div class="row">
           <div class="col-xs-11" style="width:1075px; margin-left:15px" >
             <div class="box box-primary" >
                <!--  /.box-header --> 
            	 <%List <PurchaseEnquiry> puchaseEnquiryList= (List) request.getAttribute("purchaseEnquiryList");
            		
			 		if (puchaseEnquiryList !=null ) 
			        {
			 			%>
			 			<div class="box-header with-border">
				                  <h3 class="box-title">Record Found</h3>
				                </div>
            	 <div class="box-body">
            		
            		<div class="form-group">
			            
		    	                     
	                     <table id="purchaseEnquiryTable" class="table table-bordered table-striped">
			                    <thead>
			                      <tr>
			                      	<th>Enquiry Number</th>
			                        <th>Enquiry Date</th>
			                        <th>Priority</th>
			                        <th>itemId</th>
			                        <th style="width:150px">Show Items</th>
			                        <th>followup By</th>
			                        <th></th>
			                      </tr>
			                    </thead>
			                    <tbody>
			                      <%int i=1;
		                      		for(PurchaseEnquiry obj:puchaseEnquiryList )
		                      		{
		                      	        List <PurchaseItemList> purchaseItemList= (List) request.getAttribute("purchaseItemList"); 
						 				if (purchaseItemList !=null) 
						                {
						 	
			                      		for(PurchaseItemList obj2:purchaseItemList )
			                      		{
			                      			if(obj.getMrvNumber().equals(obj2.getMrvNumber()))
			                      			{
			                      				String date=obj.getEnquiryDate();
												
			                      			%>
											 <tr>
											 <%
											 try
												{
												 	DateFormat df = new SimpleDateFormat("mm-dd-yyyy");
													DateFormat targetFormat = new SimpleDateFormat("yyyy-mm-dd");
													date=df.format(targetFormat.parse(date));
													date=date.replace("-", "/");
												}
												catch(Exception e)
												{
													
												}
											 %>
			                      			  	<td><%= obj.getEnquiryNumber()%></td>
						                        <td><%= date %></td>
						                        <td><%= obj.getPriority()%></td>
						                    	<td><%=obj2.getItemId() %></td>    
						                    	<td>
					                      			  <button type="button" class="btn btn-primary"  data-toggle="modal" data-target="#<%=i%>" >Show Items</button>
													
													  <!-- Modal -->
													  <div class="modal fade" id="<%=i%>" role="dialog">
													    <div class="modal-dialog">
													    
													      <!-- Modal content-->
													      <div class="modal-content">
													        <div class="modal-header">
													          <button type="button" class="close" data-dismiss="modal">&times;</button>
													          <h4 class="modal-title">Item Number: <%= obj2.getItemId()%></h4>
													        </div>
													        <div class="modal-body">
													              	 <table id="purchaseItemListTable" class="table table-bordered table-striped">
													                    <thead>
													                      <tr>
													                      	<th>Item Id</th>
													                   <!--      <th>Show Item</th> -->
													                        <th>Required Qty</th>
													                        <th>Required By Date</th>
													                      </tr>
													                    </thead>
													                    <tbody>
													                      
			            														<tr>
			            															<td><%=obj2.getItemId()%></td>
								                      	 		  					<td><%=obj2.getRequiredQty()%></td>
															                        <td><%=obj2.getRequiredByDate() %></td>
															                    </tr>    
			            			
		 																	</tbody>
																			</table>
													        <div class="modal-footer">
													         
													          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
													        </div>
													      </div>
													      
													    </div>
													  </div>
							                        
						                       </td>
						                         <td><%=obj.getFollowupBy()%></td>
						                         <td>
						                         	<form action="<%=request.getContextPath()%>/controller?actionCode=doFetchSupplierName&page=purchase/purchaseQuotation&enquiryNumber=<%= obj.getEnquiryNumber()%>&id=<%=obj2.getId()%>" method="post"> 
							                         <%-- 	<input type="hidden" value="<%= obj.getEnquiryNumber()%>" name="enquiryNumber" />
							                         	<input type="hidden" value="<%= obj2.getId()%>" name="id" />
							                        	 --%><button type="submit" class="btn btn-primary">Make Quotation</button>
						                        	</form>
						                         </td>
						                      	</tr>
		                      				
		                      				<% 
			                      		i++;
			                      			}
			                      			}
						                }
			                      		}
		                      %> 
		                      </tbody>
		                  </table>
				         </div>
            		</div>
	            	<%
	                       }
	 				else{
						%>
			 			<div class="box-header with-border">
				                  <h3 class="box-title">Record Not Found</h3>
				                </div>
	 				<% }
 					  %>		 
            	</div>
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
      $.widget.bridge('uibutton', $.ui.button);
      $(document).ready(function () {
          $('.pendingApproval').addClass('active');
          $('.Purchase').addClass('active');
         
      });
      $(function () {
          $("#purchaseItemListTable").DataTable();
          $('#purchaseEnquiryTable').DataTable({
            "paging": true,
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": false,
            "lengthMenu": [[2,3,5,8,10, 25, 50, -1], [2,3,5,8,10, 25, 50, "All"]]
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
  	<!-- DataTables -->
    <script src="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.min.js"></script>
    
  </body>
</html>
