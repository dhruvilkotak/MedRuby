<%@ page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
if(request.getSession().getAttribute("itemIdList")==null && request.getSession().getAttribute("reqDateList")==null&& request.getSession().getAttribute("requisitionQtyList")==null)
{
	List<String> itemIdList=new ArrayList<String>();
  	List<String> reqDateList=new ArrayList<String>();
  	List<String> requisitionQtyList=new ArrayList<String>();
	request.getSession(false).setAttribute("itemIdList", itemIdList);
  	request.getSession(false).setAttribute("reqDateList", reqDateList);
  	request.getSession(false).setAttribute("requisitionQtyList", requisitionQtyList);
  	
}

	if(request.getSession().getAttribute("itemId")==null && request.getSession().getAttribute("reqQty")==null&&request.getSession().getAttribute("reqDate")==null &&request.getSession().getAttribute("trId")==null)
	{
		request.getSession(false).setAttribute("itemIdList", null);
		request.getSession(false).setAttribute("reqDateList", null);
		request.getSession(false).setAttribute("requisitionQtyList", null);
	
	}
	else if(request.getSession().getAttribute("itemId")!=null && request.getSession().getAttribute("reqQty")!=null&&request.getSession().getAttribute("reqDate")!=null)
	{
		List<String> itemIdList=(List<String>)request.getSession().getAttribute("itemIdList");
		List<String> reqDateList=(List<String>)request.getSession().getAttribute("reqDateList");
		List<String> requisitionQtyList=(List<String>)request.getSession().getAttribute("requisitionQtyList");
		itemIdList.add((String)request.getSession().getAttribute("itemId"));
		requisitionQtyList.add((String)request.getSession().getAttribute("reqQty"));
		reqDateList.add((String)request.getSession().getAttribute("reqDate"));
		request.getSession(false).setAttribute("itemId", null);
		request.getSession(false).setAttribute("reqQty", null);
		request.getSession(false).setAttribute("reqDate", null);
		request.getSession(false).setAttribute("itemIdList", itemIdList);
		request.getSession(false).setAttribute("reqDateList", reqDateList);
		request.getSession(false).setAttribute("requisitionQtyList", requisitionQtyList);
	}	 
	 else if(request.getSession().getAttribute("trId")!=null )
	{
		 int i=-1;
		i=Integer.parseInt((String)request.getSession().getAttribute("trId"));
		List<String> itemIdList=(List<String>)request.getSession().getAttribute("itemIdList");
		List<String> reqDateList=(List<String>)request.getSession().getAttribute("reqDateList");
		List<String> requisitionQtyList=(List<String>)request.getSession().getAttribute("requisitionQtyList");
		/*   if(i>=0 && i<itemIdList.size) */ 
		itemIdList.remove(i-1);
		reqDateList.remove(i-1);
		requisitionQtyList.remove(i-1);
		request.getSession(false).setAttribute("trId", null);
		request.getSession(false).setAttribute("itemIdList", itemIdList);
		request.getSession(false).setAttribute("reqDateList", reqDateList);
		request.getSession(false).setAttribute("requisitionQtyList", requisitionQtyList);

	} 
	//request.getSession(false).setAttribute("trId", null);
//request.getSession(false).setAttribute("trId", null);
 %>
<html>
  <% 
 if(null == session.getAttribute("userId")){ 
  String address = "/wp-content/portal/SessionExpired.jsp?page=warehouse/requisitionMRV";
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
            Requisition
            <small>MRV</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="<%=request.getContextPath()%>/wp-content/portal/warehouse.jsp">Warehouse</a></li>
          	<li class="active"><a href="<%=request.getContextPath()%>/wp-content/portal/requisitionMRV.jsp">Requisition MRV</a></li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
           <div class="container">
           <form action="<%=request.getContextPath()%>/controller" method="post" name="myform" id="myform">
          	<div class="row">
             <div class="col-xs-11">
             <% if((request.getParameter("success")+"get").contains("1"))
			{
			%>
			<div class="alert alert-dismissable alert-success">
					<i class="fa fa-fw fa-check"></i>&nbsp; Mrv Details added successfully.
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
           
           <legend>MRV Details</legend>
		            <!-- Left col -->
		            <!-- right col (We are only adding the ID to make the widgets sortable)-->
		          <div class="form-group">
		          	<div class="row">
		          	 	  
                        	<div class="col-xs-8"> 
                        		  <input type="text" name="mrvNumber" class="form-control" placeholder="MRV No.">
		  					</div>
		  					<div class="col-xs-4"> 
                    <select name="priority" class="form-control" >
                    	<option value="" selected disabled>Priority</option>
                        <option value="high">High</option>
                        <option value="medium">Medium</option>
                        <option value="low">Low</option>
                        
                      </select>
                      </div>
		  				
		       		    </div>
		           </div>			 
		           <!-- select -->
                  <div class="form-group">
                  	<div class="row">
                 
                      
                    <div class="col-xs-4"> 
                    <select name="fromDept" class="form-control" >
                    	<option value="" selected disabled>From Department</option>
                        <option value="Sales">Sales</option>
                        <option value="Purchase">Purchase</option>
                        
                      </select>
                      </div>
                   
                      
                    <div class="col-xs-4"> 
                    <select name="toDept" class="form-control" >
                    	<option value="" selected disabled>To Department</option>
                         <option value="Sales">Sales</option>
                        <option value="Purchase">Purchase</option>
                      </select>
                      </div>
                      <div class="col-xs-4">
							<div class="input-group">
							<div class="input-group-addon" >
							<i class="fa fa-calendar"></i>
  							</div>
							<input class="datepicker" type="text" name="mrvDate" placeholder="MRV Date" style="width: 275px">
  							 </div>
						</div>
                      </div>
                    </div>
                   
	 		    <div class="form-group">
                  	<div class="row">
                  	<div class="col-xs-4"> 
                    <select name="preparedBy" class="form-control" >
                    	<option value="" selected disabled>Prepared By</option>
                        <option>option 1</option>
                        <option>option 2</option>
                        <option>option 3</option>
                        <option>option 4</option>
                        <option>option 5</option>
                      </select>
                      </div>
                      
                  	<div class="col-xs-8"> 
                        		  <input type="text" name="remarks" id="remarks" class="form-control" placeholder="Remarks" >
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
                        		  <input type="text" name="itemId" id="itemId" class="form-control" placeholder="Item Code" required>
		  					</div>
		  					<div class="col-xs-4"> 
                        		  <input type="text" name="requisitionQty" id="requisitionQty" class="form-control" placeholder="Requisition Qty" required>
		  					</div>
	           				<div class="col-xs-4">
							<div class="input-group">
							<div class="input-group-addon" >
							<i class="fa fa-calendar"></i>
  							</div>
							<input class="datepicker" type="text" name="reqDate" id="reqDate" placeholder="Req By Date" style="width: 275px" required>
  							 </div>
						</div>
		       		    </div></div>
		       		   	</fieldset>
                      </div>
                      
	         <div class="box-footer" >
	         	<div class="col-xs-5"></div>
                    <a id="add_row" class="btn btn-default pull-left">Add Item</a>
              </div>
                      </div>     
		  		</div>
			<div class="col-xs-11">
		     <div class="box box-primary" >
               <!-- <div class="box-header with-border">
                  <h3 class="box-title">Quick Example</h3>
                </div> /.box-header -->
             <div class="box-body">
                
           <fieldset class="fieldset">
           
           <legend>MRV Details</legend>		     
		    		   <table id="itemListTable" class="table table-bordered table-striped">
			                    <thead>
			                      <tr>
			                      	<th style="width:300px">Item Code</th>
			                        <th style="width:250px">Requisition Qty</th>
			                        <th style="width:250px">Required By Date</th>
			                        <th></th>
			                      </tr>
			                    </thead>
					           	<tbody id="supplierData">
					           	
					           	</tbody>
					</table>
	           		<input type="hidden" id="itemIdHidden" name="itemIdHidden" value="">
	           		<input type="hidden" id="requisitionQtyHidden" name="requisitionQtyHidden" value="">
	           		<input type="hidden" id="reqDateHidden" name="reqDateHidden" value="">
	         </fieldset>
	       </div>
	       
	         <div class="box-footer" >
	         	<div class="col-xs-5"></div>
	         		<input type="hidden" name="actionCode" value="doSubmitMrv">
	         		<input type="hidden" value="warehouse/requisitionMRV" name="page" />
                    <button type="submit" class="btn btn-primary" >Submit</button>
              </div>
            </div>	
            </div>
            </div>
            </form>
            </div>
            
        </section><!-- /.content -->
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
    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>        
   <%--  window.onbeforeunload = function() {
        if (true)
        {
        	
            var message = "Are you sure you want to navigate away from this page?\n\nYou have started writing or editing a post.\n\nPress OK to continue or Cancel to stay on the current page.";
            if (confirm(message)) 
            	{
            	
            		return true;
            	}
            else 
            	{
            	document.getElementById("remarks").value="<%=request.getSession(false).getAttribute("itemIdList")%>";
            	alert('hello');
            	<%//solution still remaining should null when page is reloaded
            	//request.getSession(false).setAttribute("itemIdList", null);%>
              	return false;
            	}
        }
    } --%>
      $.widget.bridge('uibutton', $.ui.button);
      $(document).ready(function () {
          $('.requisitionMRV').addClass('active');
          $('.Warehouse').addClass('active');
      
          
      });
      data = new Array();
      $(function () {
          //var i=1;
          $("#add_row").click(function(){
        	  var j=$('#itemListTable tr').length;
              alert("j:"+j);
             
        	  $('#itemListTable').append('<tr id="'+(j)+'"></tr>');
           $('#'+j).html("<td>"+ document.getElementById("itemId").value+"</td><td>"+ document.getElementById("requisitionQty").value+"</td><td>"+ document.getElementById("reqDate").value+"</td><td><INPUT TYPE='Button' CLASS='Button' onClick='delRow()' VALUE='Delete Row'></td>");
           
	       
	       $.ajax({
				url : '../../../controller?actionCode=doFetchTD',
				data : {
					itemId : $('#itemId').val(),
					requisitionQty : $('#requisitionQty').val(),
					reqDate : $('#reqDate').val()
				},
				success : function(responseText) {
				alert(responseText);
				}
			});
          });
          });
      
      function delRow()
      {
        var current = window.event.srcElement;
        var rowCount = $('#itemListTable tr').length -1;
        //here we will delete the line
        while ( (current = current.parentElement)  && current.tagName !="TR");
          $.ajax({
				url : '../../../controller?actionCode=doRemoveTR',
				data : {
					trId :current.id
				},
				success : function(responseText) {
				alert(responseText);
				}
			});  
        
          var i=parseInt(current.id);
         while(i<rowCount)
       		{
        	  current.parentElement.rows[i].id=""+(parseInt(current.parentElement.rows[i].id)-1); 
        	  i++;
        	 }
         current.parentElement.removeChild(current); 
      }
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
