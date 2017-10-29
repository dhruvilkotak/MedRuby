package com.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;


import org.json.JSONObject;

import com.model.Item;
import com.model.Login;
import com.model.Mrv;
import com.model.PurchaseEnquiry;
import com.model.PurchaseInvoice;
import com.model.PurchaseOrder;
import com.model.PurchaseQuotation;
import com.model.Supplier;
import com.service.Services;
import com.model.PurchaseItemList;
import com.model.*;

public class Controller extends HttpServlet {
	String userId;
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String actionCode = request.getParameter("actionCode");
		PrintWriter out = response.getWriter();
		Services services = new Services();
		String sessionChk = request.getParameter("sessionChk");
		response.setContentType("text/html");
		String page=request.getParameter("page");
		/*login */
		if ((!actionCode.equals("doLogin")) && (sessionChk == null)) {

			HttpSession session = request.getSession();
			
			if (session.getAttribute("userId") == null) {
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/SessionExpired.jsp?userId="+userId+"&page="+page);
				return;
			}
			
		}
		/*login */
		if (actionCode.equals("doLogin")) 
		{
			HttpSession userSession = null;
			Login loggedIn = new Login();
			String userid= request.getParameter("userid");
			String password= request.getParameter("password");
			Login login=new Login();
			login.setUserId(userid);
			login.setPasswd(password);
			List<Login> loginList=services.doLogin(login);
			if (loginList != null & loginList.size() > 0) {
				
				loggedIn = loginList.get(0);
				userSession = request.getSession();
				userSession.setAttribute("userId", loggedIn.getUserId());
				userSession.setAttribute("userType", loggedIn.getRole());
				userSession.setAttribute("serverUrl", request.getContextPath());
				userId=loggedIn.getUserId();
				if(page==null || page.equals("null"))
				{
					response.sendRedirect(request.getContextPath()+ "/wp-content/portal/purchase/purchase.jsp");
				}
				else
				{//check action code
					System.out.println("page="+page);
					response.sendRedirect(request.getContextPath()+ "/wp-content/portal/"+page+".jsp");
				}
			}
			else
			{
				request.setAttribute("failed", "yes");
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/wp-content/portal/login.jsp");
				dispatcher.forward(request, response);
			}
		}  /*purchase*//*purchase*/
		else if(actionCode.equals("getMrvList"))
		{
			List<Mrv> mrvList=services.getMrvList();
			List<PurchaseItemList> purchaseItemList=services.getPurchaseItemList();
			List<String> followupByList=services.doGetFollowupBy();
			 RequestDispatcher rd =request.getRequestDispatcher("/wp-content/portal/purchase/purchaseEnquiry.jsp"); 
		        request.setAttribute("mrvList", mrvList);
		        request.setAttribute("purchaseItemList", purchaseItemList);
		        request.setAttribute("followupByList", followupByList);
		        rd.forward(request, response);
		}
		else if(actionCode.equals("doSubmitPurchaseEnquiry"))
		{
			PurchaseEnquiry purchaseEnquiry=new PurchaseEnquiry();
			String enquiryDate="";
			try
			{
				DateFormat df = new SimpleDateFormat("mm-dd-yyyy");
				DateFormat targetFormat = new SimpleDateFormat("yyyy-mm-dd");
				enquiryDate=targetFormat.format(df.parse((request.getParameter("enquiryDate")).replace("/", "-")));
			}
			catch(Exception e)
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/purchase/purchaseEnquiry.jsp?data=no");
			}
			purchaseEnquiry.setEnquiryDate(enquiryDate);
			purchaseEnquiry.setEnquiryNumber(request.getParameter("enquiryNumber"));
			purchaseEnquiry.setFollowupBy(request.getParameter("followupBy"));
			purchaseEnquiry.setMrvNumber(request.getParameter("mrvNumber"));
			purchaseEnquiry.setPriority(request.getParameter("priority"));
			int i=services.doSubmitPurchaseEnquiry(purchaseEnquiry);
			if(i>0)
			{
				services.doUpdateMrvViewed(request.getParameter("mrvNumber"));
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/purchase/purchaseEnquiry.jsp?data=yes");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/purchase/purchaseEnquiry.jsp?data=no");
			}
		}
		else if(actionCode.equals("dofetchPurchaseEnquiry"))
		{
			Item item=new Item();
			String fromDate=request.getParameter("fromEnquiryDate");
			String toDate=request.getParameter("toEnquiryDate");
			fromDate=fromDate.replace("/", "-");
			toDate=toDate.replace("/", "-");
			 
			try
			{
				DateFormat df = new SimpleDateFormat("mm-dd-yyyy");
				DateFormat targetFormat = new SimpleDateFormat("yyyy-mm-dd");
				fromDate=targetFormat.format(df.parse(fromDate));
				toDate=targetFormat.format(df.parse(toDate));
			}
			catch(Exception e)
			{
				
			}
			item.setItemId(request.getParameter("itemId"));
			item.setItemName(request.getParameter("itemName"));
			item.setItemRefNumber(request.getParameter("itemRefNumber"));
			item.setInventoryCategory(request.getParameter("inventoryCategory"));
			item.setItemType(request.getParameter("itemType"));
			List<String> itemIdList=services.getItemList(item);
			List<PurchaseItemList> purchaseItemList=services.getPurchaseItemList(itemIdList);
			List<String> mrvNumberList=new ArrayList<String>();
			for(PurchaseItemList purchaseItem:purchaseItemList)
			{
				mrvNumberList.add(purchaseItem.getMrvNumber());
			}
			List<PurchaseEnquiry> purchaseEnquiryList=services.getPurchaseEnquiry(mrvNumberList,fromDate,toDate);
			actionCode="doGetItemDetails";
			request.setAttribute("page", "purchase/pendingApproval");
			request.setAttribute("purchaseItemList", purchaseItemList);
		    request.setAttribute("purchaseEnquiryList", purchaseEnquiryList);
		    request.setAttribute("fromMethod", "yes");
		}
		else if(actionCode.equals("doSubmitPurchaseQuotation"))
		{
			PurchaseQuotation purchaseQuotation=new PurchaseQuotation();
			purchaseQuotation.setId(Integer.parseInt(request.getParameter("id")));
			purchaseQuotation.setQuotationNumber(request.getParameter("quotationNumber"));
			purchaseQuotation.setEnquiryNumber(request.getParameter("enquiryNumber"));
			String quotationDate="";
			try
			{
				DateFormat df = new SimpleDateFormat("mm-dd-yyyy");
				DateFormat targetFormat = new SimpleDateFormat("yyyy-mm-dd");
				quotationDate=targetFormat.format(df.parse(request.getParameter("quotationDate").replace("/", "-")));
			}
			catch(Exception e)
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/purchase/purchaseQuotation.jsp?data=no");
			}
			purchaseQuotation.setQuotationDate(quotationDate);
			purchaseQuotation.setSupplierId(request.getParameter("supplierName"));
			purchaseQuotation.setQuotationStatus(request.getParameter("quotationStatus"));
			purchaseQuotation.setCurrencyType(request.getParameter("currencyType"));
			purchaseQuotation.setCurrencyRate(request.getParameter("currencyRate"));
			purchaseQuotation.setNetAmount(request.getParameter("netAmount"));
			purchaseQuotation.setGrossAmount(request.getParameter("grossAmount"));
			purchaseQuotation.setPreparedBy(request.getParameter("preparedBy"));
			purchaseQuotation.setRemarks(request.getParameter("remarks"));
			purchaseQuotation.setOredered("no");
			int i=services.doSubmitPurchaseQuotation(purchaseQuotation);
			if(i>0)
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/purchase/pendingApproval.jsp?data=yes");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/purchase/purchaseQuotation.jsp?data=no");
			}
		}
		else if(actionCode.equals("dofetchPurchaseQuotation"))
		{
			Item item=new Item();
			String fromDate=request.getParameter("fromQuotationDate");
			String toDate=request.getParameter("toQuotationDate");
			fromDate=fromDate.replace("/", "-");
			toDate=toDate.replace("/", "-");
			 
			try
			{
				DateFormat df = new SimpleDateFormat("mm-dd-yyyy");
				DateFormat targetFormat = new SimpleDateFormat("yyyy-mm-dd");
				fromDate=targetFormat.format(df.parse(fromDate));
				toDate=targetFormat.format(df.parse(toDate));
			}
			catch(Exception e)
			{
				
			}
			item.setItemId(request.getParameter("itemId"));
			item.setItemName(request.getParameter("itemName"));
			item.setItemRefNumber(request.getParameter("itemRefNumber"));
			item.setInventoryCategory(request.getParameter("inventoryCategory"));
			item.setItemType(request.getParameter("itemType"));
			List<String> itemIdList=services.getItemList(item);
			List<PurchaseItemList> purchaseItemList=services.getPurchaseItemList(itemIdList);
			List<Integer> idList=new ArrayList<Integer>();
			for(PurchaseItemList purchaseItem:purchaseItemList)
			{
				idList.add(purchaseItem.getId());
			}
			List<PurchaseQuotation> purchaseQuotationList=services.getPurchaseQuotation(idList,fromDate,toDate);
			     actionCode="doGetItemDetails";
				request.setAttribute("page", "purchase/pendingApproval");
				request.setAttribute("purchaseItemList", purchaseItemList);
			    request.setAttribute("purchaseQuotationList", purchaseQuotationList);
			    request.setAttribute("fromMethod", "yes");
				
			 	}
		else if(actionCode.equals("doDeletePurchaseQuotation"))
		{
			List<String> quationDeletion=new ArrayList<String>(Arrays.asList(request.getParameterValues("quationDeletion")));
			int i=services.doDeletePurchaseQuotation(quationDeletion);
			if(i>0)
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/purchase/quotationCancel.jsp?data=yes");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/purchase/quotationCancel.jsp?data=no");
			}
		}
		else if(actionCode.equals("doFetchSupplierDetails"))
		{
			String quotationNumber=request.getParameter("quotationNumber");
			
			List<String> supplierId=services.doGetSupplierId(quotationNumber);
			System.out.println("sss:"+quotationNumber+" ds:"+supplierId);
			Supplier supplier=services.doFetchSupplierDetails(supplierId.get(0));
			System.out.println("ss:"+supplier);
			try
			{
				JSONObject json      = new JSONObject();
				//JSONArray  supplierDetails = new JSONArray();
				JSONObject supllierJson= new JSONObject();
				supllierJson.put("supplierName",supplier.getSupplierName());
				supllierJson.put("supplierAddress",supplier.getAddress());
				supllierJson.put("emailId", supplier.getEmailId());
				supllierJson.put("phoneNumber",supplier.getPhoneNumber());
				json.put("supplierDetails",supllierJson);
				response.setContentType("application/json");
				response.getWriter().write(json.toString());
				
			}
			catch(Exception e)
			{}
		}
		else if(actionCode.equals("doSubmitPurchaseOrder"))
		{
			PurchaseOrder purchaseOrder=new PurchaseOrder();
			String orderDate="";
			try
			{
				DateFormat df = new SimpleDateFormat("mm-dd-yyyy");
				DateFormat targetFormat = new SimpleDateFormat("yyyy-mm-dd");
				orderDate=targetFormat.format(df.parse(request.getParameter("poDate").replace("/", "-")));
			}
			catch(Exception e)
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/purchase/purchaseOrder.jsp?data=no");
			}
			String poNumber=request.getParameter("poNumber");
			String deliveryDate=request.getParameter("deliveryDate");
			String quotatioNumber=request.getParameter("quotatioNumber");
			purchaseOrder.setPoNumber(poNumber);
			purchaseOrder.setOrderDate(orderDate);
			purchaseOrder.setOrderStatus(request.getParameter("poStatus"));
			purchaseOrder.setDeliveryDate(deliveryDate);
			purchaseOrder.setQuotationNumber(quotatioNumber);
			int i=services.doSubmitPurchaseOrder(purchaseOrder);
			if(i<=0)
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/purchase/purchaseOrder.jsp?data=no");
			}
			else
			{
			    services.doUpdatePurchaseQuotation(purchaseOrder.getQuotationNumber());
				
				List<String> supplierId=services.doGetSupplierId(quotatioNumber);
				Supplier supplier=services.doFetchSupplierDetails(supplierId.get(0));
				Object[] quotationDetails = (Object[])services.doGetPurchaseQuotation(quotatioNumber);
				String netAmount=(String)quotationDetails[0];
				String grossAmount=(String)quotationDetails[1];
				String id=(String)quotationDetails[2].toString();
				String currencyType=request.getParameter("currencyType");
				String currencyRate=request.getParameter("currencyRate");
				String modeOfDispatch=request.getParameter("dispatchMode");
				Object[] purchaseItem = (Object[])services.doGetPurchaseItem(id);
				String itemId=(String)purchaseItem[0];
				String reqQty=(String)purchaseItem[1];
				Item item=services.getItem(itemId);
				request.getSession().setAttribute("supplier", supplier);
			    request.getSession().setAttribute("poNumber", poNumber);
			    request.getSession().setAttribute("orderDate", orderDate);
			    request.getSession().setAttribute("deliveryDate", deliveryDate);
			    request.getSession().setAttribute("netAmount", netAmount);
			    request.getSession().setAttribute("grossAmount", grossAmount);
			    request.getSession().setAttribute("currencyType", currencyType);
			    request.getSession().setAttribute("currencyRate", currencyRate);
			    request.getSession().setAttribute("modeOfDispatch", modeOfDispatch);
			    request.getSession().setAttribute("reqQty", reqQty);
			    request.getSession().setAttribute("item", item);
			    response.sendRedirect(request.getContextPath()+"/wp-content/portal/purchase/purchaseInvoice.jsp");
			}
		}
		else if(actionCode.equals("doSubmitPurchaseInvoice"))
		{
			String invoiceNumber= request.getParameter("invoiceNumber");
			String invoiceDate =request.getParameter("invoiceDate");
			String poNumber=request.getParameter("poNumber");
			PurchaseInvoice purchaseInvoice=new PurchaseInvoice();
			purchaseInvoice.setInvoiceDate(invoiceDate);
			purchaseInvoice.setInvoiceNumber(invoiceNumber);
			purchaseInvoice.setPoNumber(poNumber);
			int i=services.doSubmitPurchaseInvoice(purchaseInvoice);
			if(i>0)
			{
				out.println(request.getSession().getAttribute("supplier"));
				out.println(request.getSession().getAttribute("item"));
				out.println(request.getSession().getAttribute("netAmount"));
				out.println(request.getSession().getAttribute("grossAmount"));
				request.getSession().setAttribute("poNumber",poNumber);
				request.getSession().setAttribute("invoiceNumber",invoiceNumber);
				request.getSession().setAttribute("invoiceDate",invoiceDate);
				request.getSession().setAttribute("modeOfDispatch",request.getParameter("modeOfDispatch"));
				request.getSession().setAttribute("deliveryDate",request.getParameter("deliveryDate"));
				request.getSession().setAttribute("currencyRate",request.getParameter("currencyRate"));
				request.getSession().setAttribute("currencyType",request.getParameter("currencyType"));
				request.getSession().setAttribute("amountWord",request.getParameter("amountWord"));
				request.getSession().setAttribute("paymentMode", request.getParameter("paymentMode"));
				request.getSession().setAttribute("remarks",request.getParameter("remarks"));
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/purchase/invoicePrint.jsp");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/purchase/purchaseInvoice.jsp?data=no");
			}
		}
	/*	else if(actionCode.equals("doFetchTD"))
		{
			String itemId = request.getParameter("itemId").trim();
			String reqQty = request.getParameter("requisitionQty").trim();
			String reqDate = request.getParameter("reqDate").trim();
			
			request.getSession(false).setAttribute("itemId", itemId);
			request.getSession(false).setAttribute("reqQty", reqQty);
			request.getSession(false).setAttribute("reqDate", reqDate);
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/warehouse/requisitionMRV.jsp"); 
		    
		}
		else if(actionCode.equals("doRemoveTR"))
		{
			String trId = request.getParameter("trId").trim();
			request.getSession(false).setAttribute("trId", trId);
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/warehouse/requisitionMRV.jsp"); 
		
		}
		
		else if(actionCode.equals("doSubmitMrv"))
		{
			out.println(request.getSession(false).getAttribute("itemIdList"));
			out.println(request.getSession(false).getAttribute("reqDateList"));
			out.println(request.getSession(false).getAttribute("requisitionQtyList"));
		}
		*/
		if(actionCode.equals("doGetFollowupBy"))
		{
			List<String> followupByList=services.doGetFollowupBy();
			System.out.println(followupByList);
			request.getSession(false).setAttribute("followupByList", followupByList);
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/"+request.getParameter("page")+".jsp"); 
		}
		if(actionCode.equals("doGetItemDetails"))
		{
			List<Object> itemDetailsList=services.doGetItemDetails();
			Iterator it=itemDetailsList.iterator();
			 List<String> itemTypeList=new ArrayList<String>();
			 List<String> inventoryCategoryList=new ArrayList<String>();
			while(it.hasNext())
			{
				Object ob[] = (Object[])it.next();
				inventoryCategoryList.add((String)ob[0]);
				itemTypeList.add((String)ob[1]);
			}
			request.getSession(false).setAttribute("itemTypeList", itemTypeList);
			request.getSession(false).setAttribute("inventoryCategoryList", inventoryCategoryList);
			String fromMethod=(String)request.getAttribute("fromMethod");
			request.setAttribute("fromMethod","no");
			if(fromMethod=="yes")
			{
				RequestDispatcher rd =request.getRequestDispatcher("/wp-content/portal/"+request.getParameter("page")+".jsp"); 
				rd.forward(request, response);
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/"+request.getParameter("page")+".jsp"); 
			}
		}
		if(actionCode.equals("doGetQuotationNumberList"))
		{
			List<String> quotationNumberList=services.doGetQuotationNumberList();
			request.getSession(false).setAttribute("quotationNumberList", quotationNumberList);
			response.sendRedirect(request.getContextPath()+ "/wp-content/portal/"+request.getParameter("page")+".jsp");
		}
		if(actionCode.equals("doFetchSupplierName"))
		{	
			List<String> SupplierIDList=services.doGetSupplierId();
			String enquiryNumber=request.getParameter("enquiryNumber");
			String id=request.getParameter("id");
			List<String> followupByList=services.doGetFollowupBy();
			System.out.println(followupByList);
			request.getSession(false).setAttribute("followupByList", followupByList);
			request.getSession(false).setAttribute("SupplierIDList", SupplierIDList);
			request.getSession(false).setAttribute("enquiryNumber", enquiryNumber);
			request.getSession(false).setAttribute("id", id);
			response.sendRedirect(request.getContextPath()+ "/wp-content/portal/"+request.getParameter("page")+".jsp");
		
		}
		/*SALES*/
		if (actionCode.equals("doAddSalesLead")) {
			
			String leadNumber = request.getParameter("LeadNo");
			String leadName = request.getParameter("LeadName");
			String leadDate = request.getParameter("LeadDate");
			String contactPerson = request.getParameter("ContactPerson");
			String leadRequirement = request.getParameter("LeadRequirement");
			String leadSource = request.getParameter("LeadSource");
			String estimatedValue = request.getParameter("EstimatedValue") + request.getParameter("UOM");
			String nextFollowupDate = request.getParameter("NextFollowupDate");
			String generatedBy = request.getParameter("GeneratedBy");
			String sector = request.getParameter("Sector");
			String preparedBy = request.getParameter("PreparedBy");
			String remarks = request.getParameter("Remarks");
			
			SalesLead saleslead = new SalesLead();
			saleslead.setLeadNumber(leadNumber);
			saleslead.setLeadName(leadName);
			saleslead.setLeadDate(leadDate);
			saleslead.setCustomerId(contactPerson);
			saleslead.setLeadRequirement(leadRequirement);
			saleslead.setLeadSource(leadSource);
			saleslead.setEstimatedValue(estimatedValue);
			saleslead.setNextFollowUpDate(nextFollowupDate);
			saleslead.setGeneratedBy(generatedBy);
			saleslead.setSector(sector);
			saleslead.setPreparedBy(preparedBy);
			saleslead.setRemarks(remarks);
		    String leadNo=services.doAddSalesLead(saleslead);
		    if(!leadNo.equals("0"))
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/salesLead.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/salesLead.jsp?failed=1");
			}
		}
		else if(actionCode.equals("doAddCustomerComplaint"))
		{
			
			String complaintNumber=request.getParameter("Complaint No");
			String complaintDate=request.getParameter("Complaint Received Date");
			
			String receivedBy=request.getParameter("Complaint Received By");
		
			String salesOrderId=request.getParameter("SalesOrderNo");
			CustomerComplaintLog custcomplaint = new CustomerComplaintLog();
			custcomplaint.setComplaintNumber(complaintNumber);
			custcomplaint.setComplaintDate(complaintDate);
			custcomplaint.setReceivedBy(receivedBy);
			custcomplaint.setSalesOrderId(salesOrderId);
			String cust=services.doAddCustomerComplaint(custcomplaint);
			if(!cust.equals("0"))
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/customerComplaintLog.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/customerComplaintLog.jsp?failed=1");
			}
		}
		else if(actionCode.equals("doAddSalesOrder"))
		{
			
			String salesOrderNumber=request.getParameter("Sales Order No");
			String salesOrderDate=request.getParameter("Sales Order Date");
			String quotationNumber=request.getParameter("QuotationNo");
			String packingListNumber=request.getParameter("Packing List No");
			String deliveryDate=request.getParameter("Delivery Date");
			String remarks=request.getParameter("Remarks");
			List<String> preparedByList=services.PreparedByList();
			request.getSession(false).setAttribute("preparedByList", preparedByList);
			SalesOrder salesorder = new SalesOrder();
			salesorder.setDeliveryDate(deliveryDate);
			salesorder.setPackingListNumber(packingListNumber);
			salesorder.setQuotationNumber(quotationNumber);
			salesorder.setRemarks(remarks);
			salesorder.setSalesOrderDate(salesOrderDate);
			salesorder.setSalesOrderId(salesOrderNumber);
			String orderN=services.doAddSalesOrder(salesorder);
			services.updateOrderGeneratedStatus(quotationNumber);
			services.updateStock(quotationNumber);
			if(!orderN.equals("0"))
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/salesProformaInvoice.jsp?son="+salesOrderNumber+"&success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/salesOrder.jsp?son="+salesOrderNumber+"&failed=1");
			}
		}
		else if(actionCode.equals("doAddSalesEnquiry"))
		{
			String leadNumber;
			String enquiryNumber=request.getParameter("EnquiryNo");
			String enquiryDate=request.getParameter("EnquiryDate");
			String enquiryStatus=request.getParameter("EnquiryStatus");
			String enquiryType=request.getParameter("EnquiryType");
			String source=request.getParameter("EnquirySource");
			String sector=request.getParameter("EnquirySector");
			String enquiryGeneratedBy=request.getParameter("EnquiryGeneratedBy");
			Integer loginId = Integer.valueOf(0);
			String enquiryDueDate=request.getParameter("EnquiryDueDate");
			String description=request.getParameter("Description");
			String preparedBy=request.getParameter("PreparedBy");
			String remarks=request.getParameter("Remarks");
			String customerId=request.getParameter("CustomerID");
			String itemId=request.getParameter("ItemID");
			String userId=request.getParameter("EmployeeName");
			String requiredQty=request.getParameter("ItemQty");
			String temp=request.getParameter("LeadNo");
			String quoGenerated="N";
			if(temp==null)
			{
				leadNumber="dummy";
				System.out.println("dummy"+leadNumber);
			}
			else
			{
				leadNumber=temp;
				System.out.println("lead"+leadNumber);
				
			}
			
			SalesEnquiry salesenq= new SalesEnquiry();
			salesenq.setCustomerId(customerId);
			salesenq.setDescription(description);
			salesenq.setEnquiryDate(enquiryDate);
			salesenq.setEnquiryGeneratedBy(enquiryGeneratedBy);
			salesenq.setEnquiryDueDate(enquiryDueDate);
			salesenq.setEnquiryNumber(enquiryNumber);
			salesenq.setEnquiryStatus(enquiryStatus);
			salesenq.setEnquiryType(enquiryType);
			salesenq.setUserId(userId);
			salesenq.setItemId(itemId);
			salesenq.setLeadNumber(leadNumber);
			salesenq.setPreparedBy(preparedBy);
			salesenq.setRemarks(remarks);
			salesenq.setRequiredQty(requiredQty);
			salesenq.setSector(sector);
			salesenq.setSource(source);
			salesenq.setQuoGenerated(quoGenerated);
			String enqNo=services.doAddSalesEnquiry(salesenq);
			
			if(!enqNo.equals("0"))
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/salesEnquiry.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/salesEnquiry.jsp?failed=1");
			}
			
		}
		else if(actionCode.equals("doAddSalesInvoice"))
		{
		
			String invoiceNumber=request.getParameter("InvoiceNo");
			String invoiceDate=request.getParameter("InvoiceDate");
			String preparedBy=request.getParameter("PreparedBy");
			String remarks=request.getParameter("Remarks");
			String salesOrderId=request.getParameter("SalesOrder");
			SalesInvoice salesinv= new SalesInvoice();
			salesinv.setInvoiceDate(invoiceDate);
			salesinv.setInvoiceNumber(invoiceNumber);
			salesinv.setPreparedBy(preparedBy);
			salesinv.setRemarks(remarks);
			salesinv.setSalesOrderId(salesOrderId);
			services.doAddSalesInvoice(salesinv);
		}
		else if(actionCode.equals("doAddSalesQuotation"))
		{
			
			String quotationNumber=request.getParameter("QuotationNo");
			String enquiryNumber=request.getParameter("EnquiryNo");
			String quotationStatus=request.getParameter("Status");
			String quotationValidity=request.getParameter("QuotationValidity")+request.getParameter("UOT");
			String priority=request.getParameter("Priority");
			String salesRepresentative=request.getParameter("SalesRepresntative");
			String partyRefNumber=request.getParameter("PartyRefNo");
			String quotationDate=request.getParameter("QuotationDate");
			String dispatchMode=request.getParameter("DispatchMode");
			String partyRefDate=request.getParameter("PartyRefDate");
			String sector=request.getParameter("Sector");
			String preparedBy=request.getParameter("PreparedBy");
			String remarks=request.getParameter("Remarks");
			String amount=request.getParameter("NetAmount");
			SalesQuotation salesquo= new SalesQuotation();
			salesquo.setAmount(amount);
			salesquo.setDispatchMode(dispatchMode);
			salesquo.setEnquiryNumber(enquiryNumber);
			salesquo.setPartyRefDate(partyRefDate);
			salesquo.setPartyRefNumber(partyRefNumber);
			salesquo.setPreparedBy(preparedBy);
			salesquo.setPriority(priority);
			salesquo.setQuotationDate(quotationDate);
			salesquo.setQuotationNumber(quotationNumber);
			salesquo.setQuotationStatus(quotationStatus);
			salesquo.setQuotationValidity(quotationValidity);
			salesquo.setRemarks(remarks);
			salesquo.setSalesRepresentative(salesRepresentative);
			salesquo.setSector(sector);
			String salequo=services.doAddSalesQuotation(salesquo);
			services.changeQuotationStatus(enquiryNumber);
			String itemId=services.getItemIdFromEnq(enquiryNumber);
			String itemQty=services.getItemQtyFromEnq(enquiryNumber);
			String ava=services.checkAvailability(itemId,itemQty);
			System.out.println("avability:"+ava);
			if(ava.equals("Y"))
			{
				
				if(!salequo.equals("null"))
				{
					response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/salesOrder.jsp?qn="+quotationNumber+"&success=1");
			
				}
				else
				{
					response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/salesOrder.jsp?qn="+quotationNumber+"&failed=1");
				}
			}
			else
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/salesQuotation.jsp?failed=3");
			}
			
		}
		else if(actionCode.equals("GetDetailsFromCustm"))
		{
	
			try
			{
			JSONObject json      = new JSONObject();
			String contactId = request.getParameter("userName");
			
			Customer customer=services.getDetailsFromCust(contactId);
	
			JSONObject customerJson= new JSONObject();
			customerJson.put("customerName",customer.getCustomerName());
			customerJson.put("country",customer.getCountry());
			customerJson.put("state", customer.getState());
			customerJson.put("city",customer.getCity());
			customerJson.put("Address",customer.getAddress());
			customerJson.put("EmailId",customer.getEmailId());
			json.put("customerDetails",customerJson);
			response.setContentType("application/json");
			response.getWriter().write(json.toString());
			}
			catch(Exception e)
			{
			}
		}
		else if(actionCode.equals("GetDetailsFromLead"))
		{	
			String leadNo = request.getParameter("leadNo");
		    String contactId=services.getDetailsFromLead(leadNo);
			response.setContentType("text/plain");
			response.getWriter().write(contactId);
		}
		else if(actionCode.equals("GetDetailsFromEnq"))
		{	
			String enquiryNo = request.getParameter("enquiryNo");
			String contactId=services.getDetailsFromEnq(enquiryNo);
			
			response.setContentType("text/plain");
			response.getWriter().write(contactId);
			System.out.println(contactId);
		}
		else if(actionCode.equals("GetDetailsFromQuo"))
		{	
			String quotationNo = request.getParameter("quotationNo");
			System.out.println(quotationNo);
			String enquiryNo=services.getDetailsFromQuo(quotationNo);
			System.out.println(enquiryNo);
			String customerId=services.getDetailsFromEnq(enquiryNo);
			Customer customer=services.getDetailsFromCust(customerId);
			String name=customer.getCustomerName();
			
			String itemId=services.getItemIdFromEnq(enquiryNo);
			String itemName=services.getNameFromId(itemId);
	     	try
			{
			JSONObject json      = new JSONObject();
			JSONObject OrderDetails= new JSONObject();
			OrderDetails.put("customerName",name);
			OrderDetails.put("itemName",itemName);
			json.put("OrderDetails",OrderDetails);
			response.setContentType("application/json");
			response.getWriter().write(json.toString());
			}
			catch(Exception e)
			{
			}
		
		}
		else if(actionCode.equals("GetDetailsFromOrder"))
		{	
			String orderNo = request.getParameter("orderNo");
			System.out.println(orderNo);
			String quotationNo = services.getDetailsFromOrder(orderNo);
			String enquiryNo=services.getDetailsFromQuo(quotationNo);
	        System.out.println(enquiryNo);
			String itemId=services.getItemIdFromEnq(enquiryNo);
	     	String itemName=services.getNameFromId(itemId);
	     	String customerId=services.getItemIdFromEnq(enquiryNo);
	     	try
			{
			JSONObject json      = new JSONObject();
			JSONObject customerCompJson= new JSONObject();
			customerCompJson.put("customerId",customerId);
			customerCompJson.put("itemName",itemName);
			
			json.put("customerCompDetails",customerCompJson);
			response.setContentType("application/json");
			response.getWriter().write(json.toString());
			}
			catch(Exception e)
			{
			}
			
		}
		else if(actionCode.equals("GetDetailsFromOrEnq"))
		{	
			System.out.println("Entered");
			String orderNo = request.getParameter("orderNo");
			System.out.println(orderNo);
			String quotationNo = services.getDetailsFromOrder(orderNo);
			SalesQuotation salesquo=services.getAllDetailsFromQuo(quotationNo);
	     	String customerId=services.getItemIdFromEnq(salesquo.getEnquiryNumber());
	     	System.out.println(customerId);
	     	try
			{
			JSONObject json      = new JSONObject();
			JSONObject customerInvJson= new JSONObject();
			customerInvJson.put("customerId",customerId);
			customerInvJson.put("quotationDate",salesquo.getQuotationDate());
			customerInvJson.put("quotationNo",salesquo.getQuotationNumber());
			customerInvJson.put("status",salesquo.getQuotationStatus());
			customerInvJson.put("quotationValidity",salesquo.getQuotationValidity());
			customerInvJson.put("priority",salesquo.getPriority());
			customerInvJson.put("salesRepresentative",salesquo.getSalesRepresentative());
			customerInvJson.put("partyRefNo",salesquo.getPartyRefNumber());
			customerInvJson.put("partyRefDate",salesquo.getPartyRefDate());
			customerInvJson.put("dispatchMode",salesquo.getDispatchMode());
			customerInvJson.put("sector",salesquo.getSector());
			customerInvJson.put("amount",salesquo.getAmount());
			json.put("customerInvDetails",customerInvJson);
			response.setContentType("application/json");
			response.getWriter().write(json.toString());
			}
			catch(Exception e)
			{
			}
		}
		else if(actionCode.equals("FetchEnquiry"))
		{
			String itemType = request.getParameter("ItemType");
			String inventoryCategory = request.getParameter("InventoryCategory");
			String itemCode = request.getParameter("ItemCode");
			String itemRefCode = request.getParameter("ItemRefCode");
			String itemName = request.getParameter("ItemName");
			Item item=new Item();
			item.setItemType(itemType);
			item.setInventoryCategory(inventoryCategory);
			item.setItemId(itemCode);
			item.setItemRefNumber(itemRefCode);
			item.setItemName(itemName);
			List<Item> items=services.getItemList2(item);
			List<SalesEnquiry> fList=new ArrayList<SalesEnquiry>();
			for(Item eachItem:items)
			{
				List<SalesEnquiry> enquiryList=services.getEnquiryList(eachItem.getItemId());
				fList.addAll(enquiryList);
			}	
		   request.setAttribute("fList",fList);
			RequestDispatcher rd=request.getRequestDispatcher("/wp-content/portal/Sales/salesEnquiryCancellation.jsp");
			rd.forward(request, response);
			
		}
		else if(actionCode.equals("searchPendningQuotation"))
		{	
			String itemType = request.getParameter("ItemType");
			String inventoryCategory = request.getParameter("InventoryCategory");
			String itemCode = request.getParameter("ItemCode");
			String itemRefCode = request.getParameter("ItemRefCode");
			String itemName = request.getParameter("ItemName");
			List<JSONObject> listJSON=new ArrayList<JSONObject>();
			Item item=new Item();
			item.setItemType(itemType);
			item.setInventoryCategory(inventoryCategory);
			item.setItemId(itemCode);
			item.setItemRefNumber(itemRefCode);
			item.setItemName(itemName);
			List<Item> items=services.getItemList2(item);
			
		    for(Item eachItem:items)
			{
				List<SalesEnquiry> enquiryList=services.getEnquiryNoList(eachItem.getItemId());
				for(SalesEnquiry salenq:enquiryList)
				{ 
					try
					{
					JSONObject json      = new JSONObject();
					JSONObject dispObject=new JSONObject();
					dispObject.put("itemId",eachItem.getItemId());
					dispObject.put("itemName",eachItem.getItemName());
					dispObject.put("itemQty",salenq.getRequiredQty());
					dispObject.put("enquiryNo",salenq.getEnquiryNumber());
					dispObject.put("rate",eachItem.getRate());
					json.put("dispobj", dispObject);
					listJSON.add(dispObject);
					}
					catch(Exception e)
					{
					}
					
				}
				
			}
		  request.setAttribute("listJSON", listJSON);
	      System.out.println(listJSON);
			
			RequestDispatcher rd=request.getRequestDispatcher("/wp-content/portal/Sales/salesPendingQuotation.jsp?actionCode=doGetPendingData");
			rd.forward(request, response);
		}
		else if(actionCode.equals("cancelEnquiry"))
			
		{
			String enqNo=request.getParameter("eno");
			String status=services.removeEnquiry(enqNo);
			if(!status.equals("No"))
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/salesEnquiryCancellation.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/salesEnquiryCancellation.jsp?failed=1");
			}
			
		}
		if(actionCode.equals("doGetEnquiryNoList"))
		{	
		
			List<String> enquiryNoList=services.dogetEnquiryNoList();
			request.getSession(false).setAttribute("enquiryNoList", enquiryNoList);
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/"+request.getParameter("page")+".jsp");
			
		}
		if(actionCode.equals("doGetQuotaData"))
		{	
			List<String> enquiryNoList=new ArrayList<String>();
			String eno=request.getParameter("eno");
			System.out.println(request.getParameter("eno"));
			enquiryNoList.add(eno);
			request.getSession(false).setAttribute("enquiryNoList", enquiryNoList);
			int a=Integer.parseInt(request.getParameter("itemQty"));
			int b=Integer.parseInt(request.getParameter("itemRate"));
			String result=Integer.toString(a*b);
			System.out.println("Net Amount:"+result);
			request.getSession(false).setAttribute("netAmount",result);
			List<String> preparedByList=services.PreparedByList();
			request.getSession(false).setAttribute("preparedByList", preparedByList);
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/Sales/"+request.getParameter("page")+".jsp");
			
		}
		if(actionCode.equals("doGetLeadData"))
		{
			List<String> customerList=services.customerList();
			request.getSession(false).setAttribute("customerList", customerList);
			List<String> preparedByList=services.PreparedByList();
			request.getSession(false).setAttribute("preparedByList", preparedByList);
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/"+request.getParameter("page")+".jsp");
			
		}
		if(actionCode.equals("doGetEnquiryData"))
		{
			List<String> itemList=services.itemList();
			request.getSession(false).setAttribute("itemList",itemList);
			List<String> leadNoList=services.leadNoList();
			request.getSession(false).setAttribute("leadNoList",leadNoList);
			List<String> customerList=services.customerList();
			request.getSession(false).setAttribute("customerList", customerList);
			List<String> preparedByList=services.PreparedByList();
			request.getSession(false).setAttribute("preparedByList", preparedByList);
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/"+request.getParameter("page")+".jsp");
		
		}
		if(actionCode.equals("doGetPendingData"))
		{
			List<String> itemType=services.itemType();
			request.getSession(false).setAttribute("itemType",itemType);
			List<String> inventorycategory=services.inventoryCategory();
			request.getSession(false).setAttribute("inventoryCategory",inventorycategory);
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/"+request.getParameter("page")+".jsp");
		}
		if(actionCode.equals("doGetComplaintData"))
		{
			List<String> orderList=services.orderList();
			request.getSession(false).setAttribute("orderList",orderList);
			List<String> preparedByList=services.PreparedByList();
			request.getSession(false).setAttribute("preparedByList", preparedByList);
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/"+request.getParameter("page")+".jsp");
		}
		
		/*warehouse*/
		if (actionCode.equals("doAddEntry")) {

			String entryNumber = request.getParameter("entryNumber");
			String entryDate = request.getParameter("entryDate");
			String gatePassNumber = request.getParameter("gatePassNumber");
			String gatePassDate = request.getParameter("gatePassDate");
			String vehicleNumber = request.getParameter("vehicleNumber");
			String transportName = request.getParameter("transportName");
			String toDepartment = request.getParameter("toDepartment");
			String refDocumentNumber = request.getParameter("refDocumentNumber");
			String enteredBy = request.getParameter("enteredBy");
			String remarks = request.getParameter("remarks");
			String vehicleStatus=null;
			
			if(toDepartment.equals("Sales"))
			{
				vehicleStatus = "Out";
			}
			else if(toDepartment.equals("Purchase"))
			{
				vehicleStatus = "In";
			}
			
			VehicleInOutEntry vehicleInOutEntry = new VehicleInOutEntry();
			vehicleInOutEntry.setEntryNumber(entryNumber);
			vehicleInOutEntry.setEntryDate(entryDate);
			vehicleInOutEntry.setGatePassNumber(gatePassNumber);
			vehicleInOutEntry.setGatePassDate(gatePassDate);
			vehicleInOutEntry.setTransportName(transportName);
			vehicleInOutEntry.setToDepartment(toDepartment);
			vehicleInOutEntry.setRefDocumentNumber(refDocumentNumber);
			vehicleInOutEntry.setVehicleNumber(vehicleNumber);
			vehicleInOutEntry.setVehicleStatus(vehicleStatus);
			vehicleInOutEntry.setEnteredBy(enteredBy);
			vehicleInOutEntry.setRemarks(remarks);
			
			String vehicle = services.doAddVehicleInOutEntry(vehicleInOutEntry);
			if(!vehicle.equals("0"))
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/vehicleInOutEntry.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/vehicleInOutEntry.jsp?failed=1");
			}
			
		}
		
		else if (actionCode.equals("doFetchDetails")) {
			String item="id001";
		//	String item = request.getParameter("itemId");
 			List<Item> itemList=services.doFetchDetails(item);
			out.println(itemList);	
		}
		
		else if (actionCode.equals("doAddStockDetails")){
			
			Item stockDetails = new Item();
	
			String itemId = request.getParameter("itemId");
			String itemName = request.getParameter("itemName");
			String itemType = request.getParameter("itemType");
			String itemRefNumber = request.getParameter("itemRefNumber");
			String brand = request.getParameter("brand");
			String uom = request.getParameter("uom");
			String inventoryCategory = request.getParameter("inventoryCategory");
			String openingStock = request.getParameter("openingStock");
			String currentStock = request.getParameter("currentStock");
			String rate = request.getParameter("rate");
			String rejectedStock = request.getParameter("rejectedStock");
			String reserveStock = request.getParameter("reserveStock");
			String minimumOrderQty = request.getParameter("minimumOrderQty");
			String itemRemarks = request.getParameter("itemRemarks");
			
			stockDetails.setItemId(itemId);
			stockDetails.setItemName(itemName);
			stockDetails.setItemType(itemType);
			stockDetails.setItemRefNumber(itemRefNumber);
			stockDetails.setBrand(brand);
			stockDetails.setInventoryCategory(inventoryCategory);
			stockDetails.setUom(uom);
			stockDetails.setOpeningStock(openingStock);
			stockDetails.setCurrentStock(currentStock);
			stockDetails.setRate(rate);
			stockDetails.setRejectedStock(rejectedStock);
			stockDetails.setReserveStock(reserveStock);
			stockDetails.setMinimumOrderQty(minimumOrderQty);
			stockDetails.setItemRemarks(itemRemarks);
			
			String success = services.doAddStockDetails(stockDetails);
			if(!success.equals("0"))
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/stockDetails.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/stockDetails.jsp?failed=1");
			}
			
		}
		
		else if (actionCode.equals("doAddSupplierDetails")){
			
			Supplier supplier = new Supplier();
	
			String supplierId = request.getParameter("supplierId");
			String supplierName = request.getParameter("supplierName");
			String address = request.getParameter("address");
			String emailId = request.getParameter("emailId");
			String phoneNumber = request.getParameter("phoneNumber");
			
			supplier.setAddress(address);
			supplier.setEmailId(emailId);
			supplier.setPhoneNumber(phoneNumber);
			supplier.setSupplierId(supplierId);
			supplier.setSupplierName(supplierName);
			
			String success = services.doAddSupplierDetails(supplier);
			if(!success.equals("0"))
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/supplier.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/supplier.jsp?failed=1");
			}
		
			
		}
		
		else if (actionCode.equals("doAddCustomerDetails")){
			
			Customer customer = new Customer();
		
			String customerId = request.getParameter("customerId") ;
			String customerName = request.getParameter("customerName");
			String city = request.getParameter("city");
			String state = request.getParameter("state");
			String country = request.getParameter("country");
			String address = request.getParameter("address");
			String emailId = request.getParameter("emailId");
			String contactNumber = request.getParameter("contactNumber");
			
			customer.setAddress(address);
			customer.setCity(city);
			customer.setContactNumber(contactNumber);
			customer.setCountry(country);
			customer.setCustomerId(customerId);
			customer.setCustomerName(customerName);
			customer.setEmailId(emailId);
			customer.setState(state);
			
			
			String success= services.doAddCustomerDetails(customer);
			if(!success.equals("0"))
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/customer.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/customer.jsp?failed=1");
			}
			
			
		}
		
		else if (actionCode.equals("doCheckReturnQtyPurchase"))
		{
			String returnQty= request.getParameter("returnQty");
			String itemId = request.getParameter("itemId");
			String requiredQty = services.doGetRequiredQty(itemId);
			
			Integer returnQty1 = Integer.parseInt(returnQty);
			
			Integer requiredQty1 = Integer.parseInt(requiredQty);
			if((returnQty1 < requiredQty1 ) || (returnQty1 == requiredQty1 ))
			{
				//System.out.println("Valid");
				out.println(returnQty);
			}
			else
			{
				//System.out.println("Not Valid");
				out.println("Not valid.	Re-Enter.");
			}
			
		}
		else if (actionCode.equals("doCheckReturnQtySales"))
		{
			String returnQty= request.getParameter("returnQty");
			//System.out.println(returnQty);
			String itemId = request.getParameter("itemId");
			//System.out.println(itemId);
			String requiredQty = services.doGetItemQty(itemId);
			//System.out.println(requiredQty);
			Integer returnQty1 = Integer.parseInt(returnQty);
			//System.out.println(returnQty1);
			Integer requiredQty1 = Integer.parseInt(requiredQty);
			//System.out.println(requiredQty1);
			if((returnQty1 < requiredQty1 ) || (returnQty1 == requiredQty1 ))
			{
				//System.out.println("Valid");
				out.println(returnQty);
			}
			else
			{
				//System.out.println("Not Valid");
				out.println("Not valid.	Re-Enter.");
			}
		}
		
		else if (actionCode.equals("doCalculateAmountSales"))
		{
			String returnQty= request.getParameter("returnQty");
			//System.out.println(returnQty);
			String itemId = request.getParameter("itemId");
			//System.out.println(itemId);
			String amount = services.doCalculateAmountSales(itemId);
			Integer temp = (Integer.parseInt(amount) * Integer.parseInt(returnQty));
			out.println(temp.toString());
			
		}
		
		else if (actionCode.equals("doCalculateAmountPurchase"))
		{
			String returnQty= request.getParameter("returnQty");
			//System.out.println(returnQty);
			String itemId = request.getParameter("itemId");
			//System.out.println(itemId);
			String amount = services.doCalculateAmountPurchase(itemId);
			String requiredQty = services.doGetRequiredQty(itemId);
			Integer temp1 = Integer.parseInt(amount) / Integer.parseInt(requiredQty);
			Integer temp = (temp1 * Integer.parseInt(returnQty));
			out.println(temp.toString());
			
		}
		
		else if (actionCode.equals("doFetchCurrentStock"))
		{
			String itemId = request.getParameter("itemId");
			System.out.println("it:"+itemId);
			String currentStock = services.doFetchCurrentStock(itemId);
			out.print(currentStock);
		}
		
		
		else if (actionCode.equals("doFetchItemList"))
		{
		/*	String poNumber = request.getParameter("poNumber");
			String quotationNumber=services.doGetQuotationNumber(poNumber);
			System.out.println("quotationNumber: "+ quotationNumber);
			String enquiryNumber=services.doGetEnquiryNumber(quotationNumber);
			System.out.println("enquiryNumber: "+ enquiryNumber);
			String mrvNumber=services.doGetMrvNumber(enquiryNumber);
			System.out.println("mrvNumber: "+ mrvNumber);
			
			List<PurchaseItemList> pList = null;
			
			pList = services.doGetPurchaseItemList(mrvNumber);
			System.out.println("pList: "+ pList.toString());
			request.getSession(false).setAttribute("itemList", pList);;
		*/}
		
		else if (actionCode.equals("doAddGrnDetails")){
			
			Grn grn = new Grn();
			
			String grnNumber = request.getParameter("grnNumber");
			String grnDate = request.getParameter("grnDate");
			String invoiceNumber = request.getParameter("invoiceNumber");
			String entryNumber = request.getParameter("entryNumber");
			String grnFor = request.getParameter("grnFor");
			
			grn.setEntryNumber(entryNumber);
			grn.setGrnDate(grnDate);
			grn.setGrnFor(grnFor);
			grn.setGrnNumber(grnNumber);
			grn.setInvoiceNumber(invoiceNumber);
			
			services.doAddGrnDetails(grn);
			
			
			System.out.println("invoiceNumber: "+ invoiceNumber);
			String poNumber=services.doGetPoNumber(invoiceNumber);
			System.out.println("poNumber: "+ poNumber);
			String quotationNumber=services.doGetQuotationNumber(poNumber);
			System.out.println("quotationNumber: "+ quotationNumber);
			int id=services.doGetIdNumber(quotationNumber);
			String amount=services.doGetGrossAmount(quotationNumber);
			if(amount!=null)
			{
				int suc=services.doUpdatePurchaseAmount(amount,id);
			}
			List<PurchaseItemList> pList = null;
			pList = services.doGetPurchaseItemList(id);
			int success=0;
			if(pList.size()>0)
			{
				success = services.doUpdateStock(pList.get(0));
			//response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/materialInwardGRN.jsp?success=1");
			}
			
			if(success>0)
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/materialInwardGRN.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/materialInwardGRN.jsp?failed=1");
			}
			
		}
		
		else if (actionCode.equals("doAddPurchaseReturnDetails")){
			
			PurchaseReturn purchaseRet = new PurchaseReturn();
			
			String returnNumber=request.getParameter("returnNumber");
			String itemId=request.getParameter("itemId");
			String returnDate=request.getParameter("returnDate");
			String returnQty=request.getParameter("returnQty");
			String totalAmount=request.getParameter("totalAmount");
			String preparedBy=request.getParameter("preparedBy");
			String remarks=request.getParameter("remarks");
			String poNumber=request.getParameter("poNumber");
			String id=request.getParameter("id");
			
			purchaseRet.setPoNumber(poNumber);
			purchaseRet.setItemId(itemId);
			purchaseRet.setReturnDate(returnDate);
			purchaseRet.setReturnQty(returnQty);
			purchaseRet.setTotalAmount(totalAmount);
			purchaseRet.setPreparedBy(preparedBy);
			purchaseRet.setRemarks(remarks);
			purchaseRet.setReturnNumber(returnNumber);
						
			String success1 = services.doAddPurchaseReturnDetails(purchaseRet);
			
			String success2 = services.doUpdateStockReturn(itemId,returnQty,0);
			
			String success3 = services.doUpdateStockReturnPurchaseItemList(id,returnQty);
		
			if(success1.equals("1") && success2.equals("1") && success3.equals("1") )
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/directPurchaseReturn.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/directPurchaseReturn.jsp?failed=1");
			}
		}
		else if(actionCode.equals("doFetchTD"))
		{
			String itemId = request.getParameter("itemId").trim();
			String reqQty = request.getParameter("requisitionQty").trim();
			String reqDate = request.getParameter("reqDate").trim();
			
			request.getSession(false).setAttribute("itemId", itemId);
			request.getSession(false).setAttribute("reqQty", reqQty);
			request.getSession(false).setAttribute("reqDate", reqDate);
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/warehouse/requisitionMRV.jsp"); 
		    
			
		}
		else if(actionCode.equals("doRemoveTR"))
		{
			String trId = request.getParameter("trId").trim();
			request.getSession(false).setAttribute("trId", trId);
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/warehouse/requisitionMRV.jsp"); 
		
		}
		else if(actionCode.equals("doSubmitMrv"))
		{
			out.println(request.getSession(false).getAttribute("itemIdList"));
			out.println(request.getSession(false).getAttribute("reqDateList"));
			out.println(request.getSession(false).getAttribute("requisitionQtyList"));
			
			Mrv mrv = new Mrv();
			
			String mrvNumber=request.getParameter("mrvNumber");
			String mrvDate=request.getParameter("mrvDate");
			String priority=request.getParameter("priority");
			String fromDept=request.getParameter("fromDept");
			String toDept=request.getParameter("toDept");
			String remarks=request.getParameter("remarks");
			String preparedBy=request.getParameter("preparedBy");
			String viewed="no";
			String toDate=request.getParameter("toQuotationDate");
			
			
			mrv.setMrvNumber(mrvNumber);
			mrv.setMrvDate(mrvDate);
			mrv.setFromDept(fromDept);
			mrv.setToDept(toDept);
			mrv.setPriority(priority);
			mrv.setRemarks(remarks);
			mrv.setViewed(viewed);
			mrv.setPreparedBy(preparedBy);
			services.doAddMrvDetails(mrv);
			
			PurchaseItemList list1 = new PurchaseItemList();
			
			Integer id = Integer.valueOf(0);
			List<String> itemIdList = new ArrayList<String>();
			List<String> reqDateList = new ArrayList<String>();
			List<String> requisitionQtyList = new ArrayList<String>();
			itemIdList = (List<String>) request.getSession(false).getAttribute("itemIdList");
			reqDateList = (List<String>) request.getSession(false).getAttribute("reqDateList");
			requisitionQtyList = (List<String>) request.getSession(false).getAttribute("requisitionQtyList");
			
			Integer len = itemIdList.size();
			System.out.println(len);
			Integer i = 0;
			String itemId;
			String requiredQty;
			String requiredByDate;
			String amount = ""+0;
			int success=0;
			for(i=0;i<len;i++)
			{
				itemId = itemIdList.get(i);
				requiredQty = requisitionQtyList.get(i);
				requiredByDate = reqDateList.get(i);
				
				
				list1.setAmount(amount);
				list1.setId(id);
				list1.setItemId(itemId);
				list1.setMrvNumber(mrvNumber);
				list1.setRequiredByDate(requiredByDate);
				list1.setRequiredQty(requiredQty);
				
				success = services.doAddPurchaseList(list1);
			}
			
			
			
			if(success>0)
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/requisitionMRV.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/requisitionMRV.jsp?failed=1");
			}
			
		}
		

		else if (actionCode.equals("doAddSalesReturnDetails")){
			
			SalesReturn salesRet = new SalesReturn();
			
			String returnNumber=request.getParameter("returnNumber");
			String itemId=request.getParameter("itemId");
			String returnDate=request.getParameter("returnDate");
			String returnQty=request.getParameter("returnQty");
			String totalAmount=request.getParameter("totalAmount");
			String preparedBy=request.getParameter("preparedBy");
			String remarks=request.getParameter("remarks");
			String salesOrderId=request.getParameter("salesOrderId");
			
			
			
			salesRet.setSalesOrderId(salesOrderId);
			salesRet.setItemId(itemId);
			salesRet.setReturnDate(returnDate);
			salesRet.setReturnQty(returnQty);
			salesRet.setTotalAmount(totalAmount);
			salesRet.setPreparedBy(preparedBy);
			salesRet.setRemarks(remarks);
			salesRet.setReturnNumber(returnNumber);
						
			String success1 = services.doAddSalesReturnDetails(salesRet);
			String success2 = services.doUpdateStockReturn(itemId,returnQty,1);
			
			
			if(success1.equals("1") && success2.equals("1"))
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/directSalesReturn.jsp?success=1");
			}
			else
			{
				response.sendRedirect(request.getContextPath()+ "/wp-content/portal/warehouse/directSalesReturn.jsp?failed=1");
			}
		}

		else if(actionCode.equals("doFetchCustomerDetails"))
			{
				String salesOrderId=request.getParameter("salesOrderId");
				System.out.println(salesOrderId);
				String quotationNumber=services.doGetQuotationNumberSales(salesOrderId);
				System.out.println(quotationNumber);
				String enquiryNumber=services.doGetEnquiryNumberSales(quotationNumber);
				System.out.println(enquiryNumber);
				String customerId=services.doFetchCustomerId(enquiryNumber);
				System.out.println(customerId);
				Customer customer = services.doFetchCustomerDetails(customerId);
				
				System.out.println(customer.getCustomerName());
				System.out.println(customer.getAddress());

				try
				{
					JSONObject json      = new JSONObject();
					//JSONArray  supplierDetails = new JSONArray();
					JSONObject customerJson= new JSONObject();
					customerJson.put("customerName",customer.getCustomerName());
					customerJson.put("address",customer.getAddress());
					json.put("customerDetails",customerJson);
					response.setContentType("application/json");
					response.getWriter().write(json.toString());
					System.out.println(json.toString());
				}
				catch(Exception e)
				{}
			}
			
		
		else if(actionCode.equals("doFetchGrnDetails"))
		{
			
			
			String invoiceNumber=request.getParameter("invoiceNumber");
			//System.out.println(poNumber);
			
			String poNumber=services.doGetPoNumber(invoiceNumber);

			String quotationNumber=services.doGetQuotationNumber(poNumber);
			//System.out.println(quotationNumber);
			List<String> supplierId1=services.doGetSupplierId(quotationNumber);
			String supplierId=supplierId1.get(0);
			//System.out.println(supplierId);
			Supplier supplier=services.doFetchSupplierDetails(supplierId);
			System.out.println(supplier.getSupplierName());
			//System.out.println(supplier.getAddress());

			try
			{
				JSONObject json      = new JSONObject();
				//JSONArray  supplierDetails = new JSONArray();
				JSONObject supplierJson= new JSONObject();
				supplierJson.put("supplierName",supplier.getSupplierName());
				supplierJson.put("supplierAddress",supplier.getAddress());
				json.put("supplierDetails",supplierJson);
				response.setContentType("application/json");
				response.getWriter().write(json.toString());
				//System.out.println(json.toString());
			}
			catch(Exception e)
			{}
		}
		
		else if(actionCode.equals("doFetchGrnDetails1"))
		{
			
			String entryNumber=request.getParameter("entryNumber");
			//System.out.println(poNumber);
			
			String transportName=services.doGetTransportName(entryNumber);

			try
			{
				
				response.getWriter().write(transportName);
				//System.out.println(json.toString());
			}
			catch(Exception e)
			{}
		}
		else if(actionCode.equals("doFetchItemIdPurchase"))
		{
			String poNumber = request.getParameter("poNumber");
			String quotationNumber=services.doGetQuotationNumber(poNumber);
			int id=services.doGetIdNumber(quotationNumber);
			String itemId = services.doFetchItemIdPurchase(id);
			
			
				try
				{
					JSONObject json      = new JSONObject();
					//JSONArray  supplierDetails = new JSONArray();
					JSONObject itemDetails= new JSONObject();
					itemDetails.put("itemId",itemId);
					itemDetails.put("id",id);
					json.put("itemDetails",itemDetails);
					response.setContentType("application/json");
					response.getWriter().write(json.toString());

					System.out.println(json.toString());
				}
				catch(Exception e)
				{
					
				}
		}
		else if(actionCode.equals("doFetchItemIdSales"))
		{
			String salesOrderId=request.getParameter("salesOrderId");
			System.out.println(salesOrderId);
			String quotationNumber=services.doGetQuotationNumberSales(salesOrderId);
			System.out.println(quotationNumber);
			String enquiryNumber=services.doGetEnquiryNumberSales(quotationNumber);
			System.out.println(enquiryNumber);
			String itemId = services.doFetchItemIdSales(enquiryNumber);
			try
			{
				response.getWriter().write(itemId);
			}
			catch(Exception e)
			{}
		}
		if(actionCode.equals("doNothing"))
		{
			response.sendRedirect(request.getContextPath()+"/wp-content/portal/"+request.getParameter("page")+".jsp");
		}
		if(actionCode.equals("dofetchQuotationNumberPoNumber"))
		{
			String poNumber=request.getParameter("poNumber");
			String quotationNumber=services.doGetQuotationNumber(poNumber);
			out.print(quotationNumber);
			
		}

	}
}
