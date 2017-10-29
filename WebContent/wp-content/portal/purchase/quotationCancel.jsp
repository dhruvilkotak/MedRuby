<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.model.PurchaseQuotation" %>
<%@ page import="com.model.Item" %>
<%@ page import="com.model.PurchaseItemList" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <% 
 if(null == session.getAttribute("userId")){ 
  String address = "/wp-content/portal/SessionExpired.jsp?page=purchase/quotationCancel";
  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(address);
  dispatcher.forward(request,response);
}

 else{}
%>  
 <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>MedRuby | Quotation Cancel</title>
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
            <small>Quotation Cancel</small>
          </h1>
         <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
           <li><a href="<%=request.getContextPath()%>/wp-content/portal/purchase/purchase.jsp">Purchase</a></li>
            <li class="active"><a href="#"> Quotation Cancel</a></li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
           <div class="container">
             <div class="col-xs-11">
             <%if(request.getParameter("data")!=null &&request.getParameter("data").equals("no"))
				{%>
        	    	<div class="alert alert-dismissable alert-danger">
						<i class="fa fa-fw fa-check"></i>&nbsp;Wrong with some data. Can't delete successfully.
						<button type="button" class="close" data-dismiss="alert" hidden="true">&times;</button>
					</div>
					<%} %>
					
			<%if(request.getParameter("data")!=null &&request.getParameter("data").equals("yes"))
				{%>
					<div class="alert  alert-dismissable alert-success">
						<i class="fa fa-fw fa-check"></i>&nbsp;Purchase Quotation Deleted Successfully.
						<button type="button" class="close" data-dismiss="alert" hidden="true">&times;</button>
					</div>
					
					<%} %>
             <div class="box box-primary">
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
	                      			<input class="datepicker" type="text" style="width:275px" placeholder="From:" name="fromQuotationDate" id="fromQuotationDate">
	                    	 </div>
	                    </div>
				 		 <div class="col-xs-4">
	                      	 <div class="input-group">
	                      		<div class="input-group-addon" >
	                        		<i class="fa fa-calendar"></i>
	                      		</div>
	                      			<input class="datepicker" type="text" style="width:275px" name="toQuotationDate" placeholder="To:" id="toQuotationDate">
	                    	 </div>
	            	     </div>
                 </div>
                 </div> 
            </fieldset>  		
            </div>
	            <div class="box-footer">
	                    <div class="row">
	                    <div class="col-xs-5"></div>
	                    		<input type="hidden" value="dofetchPurchaseQuotation" name="actionCode" />
	                    		<input type="hidden" value="purchase/quotationCancel" name="page" />
	                    		<button type="submit" class="btn btn-primary" style="text-align: center;">Search</button>
	                    	
	                    </div>
	              </div>
            </form>
               </div>
           </div>
           </div>
           
           <div class="row">
           <div class="col-xs-11" style="width:1050px; margin-left:30px">
             <div class="box box-primary">
             <form action="<%=request.getContextPath()%>/controller" method="post">    
            
                <!--  /.box-header --> 
            	 <%List <PurchaseQuotation> puchaseQuotationList= (List) request.getAttribute("purchaseQuotationList");
            		
			 		if (puchaseQuotationList !=null ) 
			        {
			 			%>
			 			<div class="box-header with-border">
				                  <h3 class="box-title">Record Found</h3>
				                </div>
            	 <div class="box-body">
            		
            		<div class="form-group">
            			<input type="hidden" value="doDeletePurchaseQuotation" name="actionCode" />
            			<input type="hidden" value="purchase/quotationCancel" name="page" />
		    	         <button type="submit" style="width:105px"class="btn btn-block btn-danger">Delete</button>             
	                     <br>
	                     <table id="purchaseQuotationTable" class="table table-bordered table-striped">
			                    <thead>
			                      <tr>
			                      	<th><input type="checkbox" id="checkall" name="quationDeletion" value="" /></th>
			                      	<th>Quotation Number</th>
			                        <th>Quotation Date</th>
			                        <th>Enquiry Number</th>
			                        <th>Supplier Id</th>
			                        <th style="width:150px">Show Items</th>
			                        <th>Amount</th>
			                        <th>Prepared By</th>
			                        
			                       </tr>
			                    </thead>
			                    <tbody>
			                      <%int i=1;
		                      		for(PurchaseQuotation obj:puchaseQuotationList )
		                      		{
		                      	        List <PurchaseItemList> purchaseItemList= (List) request.getAttribute("purchaseItemList"); 
						 				if (purchaseItemList !=null) 
						                {
						 	
			                      		for(PurchaseItemList obj2:purchaseItemList )
			                      		{
			                      			if(obj.getId()==(obj2.getId()))
			                      			{
			                      			%>
											 <tr>
											  	<td><input type="checkbox" name="quationDeletion" class="checkthis" value="<%=obj.getQuotationNumber()%>"/></td>
			                      			  	<td><%= obj.getQuotationNumber()%></td>
						                        <td><%= obj.getQuotationDate() %></td>
						                        <td><%= obj.getEnquiryNumber()%></td>
						                        <td><%= obj.getSupplierId()%></td>
						                    	<td>
					                      			  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#<%=i%>" >Show Items</button>
													
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
						                         <td><%=obj.getGrossAmount()%></td>
						                         <td><%=obj.getPreparedBy()%></td>
						                         <td></td>
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
            </form>
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
          $('.quotationCancel').addClass('active');
          $('.Purchase').addClass('active');
          $("#purchaseQuotationTable #checkall").click(function () {
              if ($("#purchaseQuotationTable #checkall").is(':checked')) {
                  $("#purchaseQuotationTable input[type=checkbox]").each(function () {
                      $(this).prop("checked", true);
                  });

              } else {
                  $("#purchaseQuotationTable input[type=checkbox]").each(function () {
                      $(this).prop("checked", false);
                  });
              }
          });
      });
      $(function () {
          $("#purchaseItemListTable").DataTable();
          $('#purchaseQuotationTable').DataTable({
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
