<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.model.Supplier" %>
<%@ page import="com.model.Item" %>
<%@ page import="java.util.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Purchase Order | Print Invoice</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.2.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/jquery-ui.js"></script>
      <script type="text/javascript" src="http://mrrio.github.io/jsPDF/dist/jspdf.debug.js"></script>
      <script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>
 
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

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body >
  	<div  style="width:1050px">
    <div class="wrapper"  id="canvas">
      <!-- Main content -->
      <section class="invoice">
        <!-- title row -->
        <div class="row">
          <div class="col-xs-12">
            <div class="page-header">
              <h2 style="float: left; width:35%;"><i class="fa fa-globe"></i> <strong>Med</strong>Ruby</h2> 
              <!-- <h1 style="text-align:center">PURCHASE INVOICE</h1> -->
              		<h1 style="float:center">	<b>PURCHASE INVOICE</b></h1>
              </div>
           
          </div><!-- /.col -->
        </div>
        <!-- info row -->
        <div class="row invoice-info">
        	<div class="col-sm-4 invoice-col">
	            Supplier: 
	            <address>
			
    		     <%Supplier supplier=(Supplier)request.getSession().getAttribute("supplier");
			  	 if(supplier!=null)
			        {	%>
				              <strong><%=supplier.getSupplierName() %></strong><br>
				              <%=supplier.getAddress() %><br>
				              Phone: <%=supplier.getPhoneNumber()%><br>
				              Email:<%=supplier.getEmailId() %>
				<% }%>
				</address>
			</div><!-- /.col -->
          <div class="col-sm-4 invoice-col">
            To
            <address>
              <strong>Dhruvil Kotak</strong><br>
              Address1<br>
              Address2<br>
              Phone: (555) 539-1037<br>
              Email: dhruvil.doe@MedRuby.com
            </address>
          </div><!-- /.col -->
          
          <div class="col-sm-4 invoice-col">
            <b>Invoice Number:&nbsp;&nbsp; #<%=request.getSession().getAttribute("invoiceNumber")%></b><br>
            <b>Invoice Date:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=request.getSession().getAttribute("invoiceDate")%>
            <br>
            <b>Order Number:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b> <%=request.getSession().getAttribute("poNumber")%><br>
            <b>Delivery Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b><%=request.getSession().getAttribute("deliveryDate")%><br>
           </div><!-- /.col -->
        </div><!-- /.row -->
		       <fieldset class="fieldset">
	           <legend>Item Details</legend>
	           
	           		<table id="itemDetailsTable" class="table " style="text-align:center" >
			                    <thead>
			                      <tr>
			                      	<th class="col-xs-2" >Item ID</th>
			                      	<th class="col-xs-2" >Item Name</th>
			                        <th class="col-xs-2" >Item Type</th>
			                        <th class="col-xs-2" >Brand</th>
			                        <th class="col-xs-2" > UOM</th>
			                        <th class="col-xs-2" >Qty</th>
			                      </tr>
			                    </thead>
			                     <%Item item=(Item)request.getSession().getAttribute("item");
			                     
			                    if(item!=null)
			                    {%>
					           	<tbody id="supplierData">
						           	<tr>
						           		<td><%= item.getItemId() %></td>
						           		<td><%= item.getItemName() %></td>
						           		<td><%= item.getItemType() %></td>
						           		<td><%= item.getBrand() %></td>
						           		<td><%=item.getUom() %></td>
						           		<td><%=request.getSession().getAttribute("reqQty") %></td>
					       			</tr>
					      			<tr>
					       				<td colspan="4" style="visibility: hidden"></td>
					       				<th style="text-align:center">Currency Type:</th>
					           			<td><%=request.getSession().getAttribute("currencyType") %></td>
					           		</tr>
					           		<tr>
					       				<td colspan="4" style="visibility: hidden"></td>
					       				<th style="text-align:center">Currency Rate:</th>
					           			<td><%=request.getSession().getAttribute("currencyRate") %></td>
				
					           		</tr>
					     			<tr>
					       				<td colspan="4" style="visibility: hidden"></td>
					       				<th style="text-align:center">Net Amount:</th>
					           			<td><%=request.getSession().getAttribute("netAmount") %></td>
					           		</tr>
					           		<tr>
					       				<td colspan="4" style="visibility: hidden"></td>
					       				<th style="text-align:center">Gross Amount:</th>
					           			<td><%=request.getSession().getAttribute("grossAmount") %></td>
					           		</tr>
					
					           	</tbody>
					           	<%} %>
					            
					</table>
	        	</fieldset>
	           	
	           	<div class="form-group">
                  	<div class="row">
                 			<label class="col-sm-2 control-label">Dispatch Through:</label>
                        	<div class="col-xs-9"> 
                        		<%=request.getSession().getAttribute("modeOfDispatch") %>
		  					</div>
	       					
                      </div>
                    </div>
	           	<div class="form-group">
                  	<div class="row">
                  		<label class="col-sm-2 control-label">Payment Mode:</label>
                       <div class="col-xs-9"> 
                          		<%=request.getSession().getAttribute("paymentMode") %>
		  					</div>
                      </div>
                    </div>
            	<div class="form-group">
                  	<div class="row">
                  		<label class="col-sm-2 control-label">Amount In Words:</label>
                  		<div class="col-xs-9"> 
                            	  <%=request.getSession().getAttribute("amountWord") %>
		  					</div>
                      </div>
                    </div>
            	<div class="form-group">
                  	<div class="row">
                  		<label class="col-sm-2 control-label">Remarks:</label>
                       <div class="col-xs-9">
                           		 <%=request.getSession().getAttribute("remarks") %>
			  			</div>
                      </div>
                    </div>
           <br><br>
            	<div class="form-group">
                  	<div class="row">
                  		<label class="col-sm-7 control-label">Purchase Order Approved By:&nbsp;&nbsp;&nbsp;&nbsp;_______________________________</label>
                      </div>
                  </div>
                  	
                     
      </section><!-- /.content -->
    </div><!-- ./wrapper -->
    <div class="form-group">
                  		<div class="row">
                  				<div class="col-xs-5"></div>
                              	<button id="download" >Download Pdf</button>
 						</div>
 					</div>
	</div><!-- col-->
    <!-- AdminLTE App -->
    <script src="<%=request.getContextPath()%>/js/app.min.js"></script>
    	<!-- DataTables -->
    <script src="<%=request.getContextPath()%>/plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="<%=request.getContextPath()%>/plugins/datatables/dataTables.bootstrap.min.js"></script>
  	<script>
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
    
  	</script>
  </body>
</html>
