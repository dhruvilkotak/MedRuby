<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
  <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
          <!-- Sidebar user panel -->
          <div class="user-panel">
            <div class="pull-left image">
              <img src="<%=request.getContextPath()%>/img/user2-160x160.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
              <p>user</p>
              <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
          </div>
          <!-- search form -->
          <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
              <input type="text" name="q" class="form-control" placeholder="Search...">
              <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i></button>
              </span>
            </div>
          </form>
          <!-- /.search form -->
          <!-- sidebar menu: : style can be found in sidebar.less -->
          <ul class="sidebar-menu">
            <li class="header">MAIN NAVIGATION</li>
            <li class="Sales"> 
           <!-- <li class="active treeview"> --> 
              <a href="<%=request.getContextPath()%>/index2.jsp">
                <i class="fa fa-dashboard"></i> <span>Sales</span> <i class="fa fa-angle-left pull-right"></i>
              </a>
               <ul class="treeview-menu">
               <li class="salesLead"><a href="<%=request.getContextPath()%>/controller?actionCode=doGetLeadData&&page=Sales/salesLead"><i class="fa fa-circle-o"></i>Sales Lead</a></li>
                 <li class="salesEnquiry"><a href="<%=request.getContextPath()%>/controller?actionCode=doGetEnquiryData&&page=Sales/salesEnquiry"><i class="fa fa-circle-o"></i>Sales Enquiry</a></li>
				 <li class="salesEnquiryCancellation"><a href="<%=request.getContextPath()%>/controller?actionCode=doGetPendingData&&page=Sales/salesEnquiryCancellation"><i class="fa fa-circle-o"></i>Sales Enquiry Cancellation</a></li>
     			 <li class="salesPendingQuotation"><a href="<%=request.getContextPath()%>/controller?actionCode=doGetPendingData&&page=Sales/salesPendingQuotation"><i class="fa fa-circle-o"></i>Sales Pending Quation</a></li>
     			 <li class="customerComplaintLog"><a href="<%=request.getContextPath()%>/controller?actionCode=doGetComplaintData&page=Sales/customerComplaintLog"><i class="fa fa-circle-o"></i>Customer Complaint Log</a></li> 
     		  </ul>
            </li>
            <li class="Purchase">
            <!-- <li class="active treeview">-->
              <a href="../../index2.jsp">
                <i class="fa fa-dashboard"></i> <span>Purchase</span> <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li class="purchaseEnquiry"><a href="<%=request.getContextPath()%>/controller?actionCode=doGetFollowupBy&page=purchase/purchaseEnquiry"><i class="fa fa-circle-o"></i> Purchase Enquiry</a></li>
                <%-- <li class="purchaseQuotation"><a href="<%=request.getContextPath()%>/controller?actionCode=doGetFollowupBy&page=purchase/purchaseQuotation"><i class="fa fa-circle-o"></i> Purchase Quotation</a></li>
			--%><li class="pendingApproval"><a href="<%=request.getContextPath()%>/controller?actionCode=doGetItemDetails&page=purchase/pendingApproval"><i class="fa fa-circle-o"></i> Make Quotation</a></li>
				<li class="quotationCancel"><a href="<%=request.getContextPath()%>/controller?actionCode=doGetItemDetails&page=purchase/quotationCancel"><i class="fa fa-circle-o"></i> Quotation Cancel</a></li>
				<li class="purchaseOrder"><a href="<%=request.getContextPath()%>/controller?actionCode=doGetQuotationNumberList&page=purchase/purchaseOrder"><i class="fa fa-circle-o"></i> Purchase Order</a></li>
			<%-- 	<li class="purchaseInvoice"><a href="<%=request.getContextPath()%>/wp-content/portal/purchase/purchaseInvoice.jsp"><i class="fa fa-circle-o"></i> Purchase Invoice</a></li>
              --%> </ul>
            </li>
            <li class="Warehouse">
            <!--<li class="active treeview">-->
              <a href="#">
                <i class="fa fa-dashboard"></i> <span>Warehouse</span> <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li class="stockDetails"><a href="<%=request.getContextPath()%>/controller?actionCode=doNothing&page=warehouse/stockDetails"><i class="fa fa-circle-o"></i> Stock Details</a></li>
				<li class="vehicleInOutEntry"><a href="<%=request.getContextPath()%>/controller?actionCode=doNothing&page=warehouse/vehicleInOutEntry"><i class="fa fa-circle-o"></i> Vehicle In Out Entry</a></li>
				<li class="requisitionMRV"><a href="<%=request.getContextPath()%>/controller?actionCode=doNothing&page=warehouse/requisitionMRV"><i class="fa fa-circle-o"></i> Requisition MRV</a></li>
				<li class="materialInwardGRN"><a href="<%=request.getContextPath()%>/controller?actionCode=doNothing&page=warehouse/materialInwardGRN"><i class="fa fa-circle-o"></i> Material Inward GRN</a></li>
				<li class="directPurchaseReturn"><a href="<%=request.getContextPath()%>/controller?actionCode=doNothing&page=warehouse/directPurchaseReturn"><i class="fa fa-circle-o"></i> Direct Purchase Return</a></li>
				<li class="directSalesReturn"><a href="<%=request.getContextPath()%>/controller?actionCode=doNothing&page=warehouse/directSalesReturn"><i class="fa fa-circle-o"></i> Direct Sales Return</a></li>
				<li class="customerDetails"><a href="<%=request.getContextPath()%>/controller?actionCode=doNothing&page=warehouse/customer"><i class="fa fa-circle-o"></i> Customer Details</a></li>
				<li class="supplierDetails"><a href="<%=request.getContextPath()%>/controller?actionCode=doNothing&page=warehouse/supplier"><i class="fa fa-circle-o"></i> Supplier Details</a></li>				
			   </ul>
           
            </li>
            </ul>
            
                    </section>
        <!-- /.sidebar -->
      </aside>


</body>
</html>