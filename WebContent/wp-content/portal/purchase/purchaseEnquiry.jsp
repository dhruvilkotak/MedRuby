<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.model.PurchaseEnquiry" %>
<%@ page import="com.model.Mrv" %>
<%@ page import="com.model.PurchaseItemList" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<% 
 if(null == session.getAttribute("userId")){ 
  String address = "/wp-content/portal/SessionExpired.jsp?page=purchase/purchaseEnquiry";
  RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(address);
  dispatcher.forward(request,response);
}

 else{}
%>  
 <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>MedRuby | Purchase Enquiry</title>
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
     <!-- DataTables -->
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
		 <!-- Left side column. contains the logo and sidebar -->
  <jsp:include page="../inc.jsp" />
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Purchase
            <small>Enquiry	</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="<%=request.getContextPath()%>/wp-content/portal/purchase/purchase.jsp"> Purchase</a></li>
            <li class="active"><a href="#"> Purchase Enquiry</a></li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
           <div class="container">
			<div class="col-xs-11">        
			<%if(request.getParameter("data")!=null &&request.getParameter("data").equals("no"))
				{%>
        	    	<div class="alert alert-dismissable alert-danger">
						<i class="fa fa-fw fa-check"></i>&nbsp;Wrong with some data. Can't add successfully.
						<button type="button" class="close" data-dismiss="alert" hidden="true">&times;</button>
					</div>
					<%} %>
					
			<%if(request.getParameter("data")!=null &&request.getParameter("data").equals("yes"))
				{%>
					<div class="alert  alert-dismissable alert-success">
						<i class="fa fa-fw fa-check"></i>&nbsp;Purchase Enquiry Added Successfully.
						<button type="button" class="close" data-dismiss="alert" hidden="true">&times;</button>
					</div>
					
					<%} %>
             <div class="box box-primary">
               <!-- <div class="box-header with-border">
                  <h3 class="box-title">Quick Example</h3>
                </div> /.box-header -->
             <div class="box-body">
                
        
           <fieldset class="fieldset">
			           
           <legend>General</legend>
		            <!-- Left col -->
		            <!-- right col (We are only adding the ID to make the widgets sortable)-->
		   	<form action="<%=request.getContextPath()%>/controller" method="post">
		          		
		          <div class="form-group">
		          	<div class="row">
		          	 	    
                        	<div class="col-xs-4"> 
                        		  <input type="text" class="form-control" name="enquiryNumber" placeholder="Enquiry Number:" required>
		  					</div>
		  					
            			
		  				   <div class="col-xs-4">
		                      <select class="form-control" name="priority" id="priority" required>
		                        <option value="" disabled selected>Priority:</option>
		                        <option value="high">High</option>
		                        <option value="medium">medium</option>
		                        <option value="low">Low</option>
		                      </select>
		                      </div>
						
						
				  			<div class="col-xs-3">
		                      	 <div class="input-group">
		                      		<div class="input-group-addon" >
		                        		<i class="fa fa-calendar"></i>
		                      		</div>
		                      			<input class="datepicker" style="width:275px" type="text" name="enquiryDate" id="enquiryDate" placeholder="Enquiry Date:" required>
		                    	 </div>
		                 	   </div> 
		    			 
		           </div>	
		  		 </div>
		          <div class="form-group">
		          	<div class="row">
		                	<div class="col-xs-4"> 
                        		  <input type="text" class="form-control" name="mrvNumber" id="mrvNumber" placeholder="MRV Number:"   required readonly>
		  					</div>
		  	                <div class="col-xs-4">
		                      <select class="form-control" name="followupBy" id="followupBy" required>
		                        <option value="" disabled selected>Followup By:</option>
		                     <%
		                     List<String> followupByList=null;
		                     	if((List<String>)request.getSession().getAttribute("followupByList")!=null)
		                     	{
		                     		followupByList=(List<String>)request.getSession().getAttribute("followupByList");
		                     	}
		                     	else if((List<String>)request.getAttribute("followupByList")!=null)
		                     	{
		                     		followupByList=(List<String>)request.getAttribute("followupByList");
		                     	}
		                     	if(followupByList !=null)
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
			      	 	    
		   
		      	    </div>
		       	</div>
		          
		          <div class="form-group">
		          	<div class="row">
		          			<div class="col-xs-5"></div>
		          				<input type="hidden" value="doSubmitPurchaseEnquiry" name="actionCode" />
		          				<input type="hidden" value="purchase/purchaseEnquiry" name="page" />
		          				<button type="submit" class="btn btn-primary"  style="text-align: center;">Submit enquiry </button>
		          			
		          	</div>
		          </div>
		       </form>
	    </fielset>
         <fieldset class="fieldset">
		           <legend>MRV List</legend>
			
		          <div class="form-group">
		          	<div class="row">
		          			<div class="col-xs-5"></div>
		          			<form action="<%=request.getContextPath()%>/controller" method="post">
		          				<input type="hidden" value="getMrvList" name="actionCode" />
		          				<input type="hidden" value="purchase/purchaseEnquiry" name="page" />
		          				
		          				<button type="submit" class="btn btn-primary"  style="text-align: center;">get MRV List </button>
		          			</form>

		          	</div>
		          </div>
		           <!-- select -->
                  <div class="form-group">
			             <%List <Mrv> list= (List) request.getAttribute("mrvList"); 
			 				if (list !=null) 
			                {
			 			   %>
		    	                     
	                     <table id="mrvTable" class="table table-bordered table-striped">
			                    <thead>
			                      <tr>
			                      	<th style="width:60px"></th>
			                        <th style="width:200px">MRV Number</th>
			                        <th>Mrv Date</th>
			                        <th>Priority</th>
			                        <th style="width:150px">Show Items</th>
			                        <th>Remarks</th>
			                      </tr>
			                    </thead>
			                    <tbody>
			                      <%int i=1;
		                      		for(Mrv obj:list )
		                      		{
		                      			%>
		                      			  <tr>
		                      			  	<td style="width:50px"><input type="radio" id='<%= obj.getMrvNumber()%>' name="selection"></td>
					                        <td style="width:150px"><%= obj.getMrvNumber()%></td>
					                        <td><%= obj.getMrvDate() %></td>
					                        <td><%= obj.getPriority()%></td>
					                        <td style="width:100px">                
							          			 <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#<%=i%>" >Show Items</button>
												
												  <!-- Modal -->
												  <div class="modal fade" id="<%=i%>" role="dialog">
												    <div class="modal-dialog">
												    
												      <!-- Modal content-->
												      <div class="modal-content">
												        <div class="modal-header">
												          <button type="button" class="close" data-dismiss="modal">&times;</button>
												          <h4 class="modal-title">Items of <%= obj.getMrvNumber()%></h4>
												        </div>
												        <div class="modal-body">
												           <%List <PurchaseItemList> list2= (List) request.getAttribute("purchaseItemList"); 
												 				if (list !=null) 
												                {
												 			   %>
												 			   	 <table id="purchaseItemListTable" class="table table-bordered table-striped">
												                    <thead>
												                      <tr>
												                      	<th>Mrv Number</th>
												                        <th>Item Id</th>
												                        <th>Required Qty</th>
												                        <th>Required By Date</th>
												                        <th>amount</th>
												                      </tr>
												                    </thead>
												                    <tbody>
												                      <%
											                      		for(PurchaseItemList obj2:list2 )
											                      		{
											                      			if(obj.getMrvNumber().equals( obj2.getMrvNumber()))
											                      			{
											                      			%>
		            														<tr>
		            															<td><%=obj.getMrvNumber()%></td>
											                      			  	<td><%=obj2.getItemId()%></td>
														                        <td><%=obj2.getRequiredQty()%></td>
														                        <td><%=obj2.getRequiredByDate() %></td>
														                        <td><%=obj2.getAmount()%></td>
														                    </tr>    
		            														
		            													<%
											                      			}
														                }
																		%>
																		</tbody>
																		</table>
																<%
												                }
																%>
												        </div>
												        <div class="modal-footer">
												          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
												        </div>
												      </div>
												      
												    </div>
												  </div>
 					                        
					                       </td>
					                         <td><%=obj.getRemarks()%></td>
					                      </tr>	
		                      			<% 
		                      		i++;
		                      		}
		                      %> 
		                      </tbody>
		                  </table>
				<%
                       }
 				else{}
 				  %>		        

                     </div>
	           </fieldset>
</fieldset>
	           </div>
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
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
      $.widget.bridge('uibutton', $.ui.button);
      $(document).ready(function () {
          $('.purchaseEnquiry').addClass('active');
          $('.Purchase').addClass('active');
      });
      $('.table tbody tr').click(function(event) {
    	  if (event.target.type !== 'radio') {
    	    $(':radio', this).trigger('click');
    	    var currentRow = $(this).parent().children().index($(this));
    	    document.getElementById("mrvNumber").value=document.getElementById("mrvTable").rows[currentRow+1].cells[1].innerHTML;
    	    document.getElementById("priority").value=document.getElementById("mrvTable").rows[currentRow+1].cells[3].innerHTML;
    	  }
    	});
      
      $(function () {
          $("#purchaseItemListTable").DataTable();
          $('#mrvTable').DataTable({
            "paging": true,
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "info": true,
            "autoWidth": false,
            "lengthMenu": [[2,3,5,8,10, 25, 50, -1], [2,3,5,8,10, 25, 50, "All"]]
		});
/*           var i=1;
          $("#add_row").click(function(){
           $('#addr'+i).html("<td>"+ (i+1) +"</td><td><input name='name"+i+"' type='text' placeholder='Name' class='form-control input-md'  /> </td><td><input type='text' placeholder='Name' class='form-control input-md'/> </td><td><input  name='mail"+i+"' type='text' placeholder='Mail'  class='form-control input-md'></td><td><INPUT TYPE='Button' CLASS='Button' onClick='delRow()' VALUE='Delete Row'></td>");

           $('#tblPets').append('<tr id="addr'+(i+1)+'"></tr>');
           i++; 
       });
 */
 	});
/*       function delRow()
      {
        var current = window.event.srcElement;
        //here we will delete the line
        while ( (current = current.parentElement)  && current.tagName !="TR");
             current.parentElement.removeChild(current);
      }
 */
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
