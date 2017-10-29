package com.service;

import java.util.List;

import com.model.PurchaseItemList;
import com.model.UserDetails;
import com.doa.DAO;
import com.model.*;


public class Services {

	DAO dao = new DAO();
	/*login*/
	
	public List<Login> doLogin(Login login)
	{
		dao = new DAO();
		return dao.doLogin(login);
		
	}
	/*purchase*/
	public List<Mrv> getMrvList()
	{
		dao = new DAO();
		return dao.getMrvList();
	}
	public int doSubmitPurchaseEnquiry(PurchaseEnquiry obj)
	{
		dao = new DAO();
		return dao.doSubmitPurchaseEnquiry(obj);
	}
	public void doUpdateMrvViewed(String mrvNumber)
	{
		dao = new DAO();
		dao.doUpdateMrvViewed(mrvNumber);
		return;
	}
	public List<PurchaseItemList> getPurchaseItemList() {
		dao = new DAO();
		return dao.getPurchaseItemList();
	}
	
	public List<String> getItemList(Item obj) {
		dao = new DAO();
		return dao.getItemList(obj);
	}
	
	public List<PurchaseItemList> getPurchaseItemList(List<String> itemIdList) {
		dao = new DAO();
		return dao.getPurchaseItemList(itemIdList);
	}
	public List<PurchaseEnquiry> getPurchaseEnquiry(List<String> mrvNumberList, String fromDate, String toDate) {
		dao = new DAO();
		return dao.getPurchaseEnquiry(mrvNumberList,fromDate,toDate);
	}
	public int doSubmitPurchaseQuotation(PurchaseQuotation purchaseQuotation) {
		dao = new DAO();
		return dao.doSubmitPurchaseQuotation(purchaseQuotation);
	}
	public List<PurchaseQuotation> getPurchaseQuotation(List<Integer> idList,
			String fromDate, String toDate) {
		dao = new DAO();
		return dao.getPurchaseQuotation(idList,fromDate,toDate);
	}
	public int doDeletePurchaseQuotation(List<String> quationDeletion) {
		dao = new DAO();
		return dao.doDeletePurchaseQuotation(quationDeletion);
	
	}
	public Supplier doFetchSupplierDetails(String supplierName) {
		dao = new DAO();
		return dao.doFetchSupplierDetails(supplierName);
	}
	public int doSubmitPurchaseOrder(PurchaseOrder purchaseOrder) {
		dao = new DAO();
		return dao.doSubmitPurchaseOrder(purchaseOrder);
	}
	public void doUpdatePurchaseQuotation(String quotationNumber) {
		dao = new DAO();
		dao.doUpdatePurchaseQuotation(quotationNumber);
	}
	public List<String> doGetFollowupBy() {
		dao = new DAO();
		return dao.doGetFollowupBy();
	}
	public List<Object> doGetItemDetails() {
		dao = new DAO();
		return dao.doGetItemDetails();
	}
	public List<String> doGetQuotationNumberList() {
		dao = new DAO();
		return dao.doGetQuotationNumberList();
	}
	public List<String> doGetSupplierId(String quotationNumber) {
		dao = new DAO();
		return dao.doGetSupplierId(quotationNumber);
		
	}
	public List<String> doGetSupplierId() {
		dao = new DAO();
		return dao.doGetSupplierId();
		
	}
	public Object[] doGetPurchaseQuotation(String quotatioNumber) {
		dao = new DAO();
		return dao.doGetPurchaseQuotation(quotatioNumber);
	}
	public Object[] doGetPurchaseItem(String id) {
		dao = new DAO();
		return dao.doGetPurchaseItem(id);

	}
	public Item getItem(String itemId) {
		dao = new DAO();
		return dao.getItem(itemId);

	}
	public int doSubmitPurchaseInvoice(PurchaseInvoice purchaseInvoice) {
		dao = new DAO();
		return dao.doSubmitPurchaseInvoice(purchaseInvoice);

	}
	/*sales*/
	public String doAddSalesLead(SalesLead saleslead) {
		dao = new DAO();
		return dao.doAddSalesLead(saleslead);
	}
	public String doAddCustomerComplaint(CustomerComplaintLog custcomp) {
		dao = new DAO();
		return dao.doAddCustomerComplaint(custcomp);
	}
	public String doAddSalesEnquiry(SalesEnquiry salesenq) {
		dao = new DAO();
		return dao.doAddSalesEnquiry(salesenq);
	}
	public String doAddSalesQuotation(SalesQuotation salesquo) {
		dao = new DAO();
		return dao.doAddSalesQuotation(salesquo);
	}
	public String doAddSalesOrder(SalesOrder salesorder) {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.doAddSalesOrder(salesorder);
	}
	
	public void doAddSalesInvoice(SalesInvoice salesinv) {
		// TODO Auto-generated method stub
		dao = new DAO();
		dao.doAddSalesInvoice(salesinv);
	}
	public Customer getDetailsFromCust( String contactId) {
		dao = new DAO();
		Customer customer=dao.getDetailsFromCust(contactId);
		return customer;
	}
	public String getDetailsFromLead(String leadNo) {
		dao = new DAO();
		String contactId=dao.getDetailsFromLead(leadNo);
		return contactId;
	}
	public String getDetailsFromEnq(String enquiryNo) {
		dao = new DAO();
		String leadNo=dao.getDetailsFromEnq(enquiryNo);
		return leadNo;
	}
	public String getDetailsFromQuo(String quotationNo) {
		dao = new DAO();
	 return dao.getDetailsFromQuo(quotationNo);
		
	}
	public String populateCustomer() {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.populateCustomer();
	
	}
	public String getItemIdFromEnq(String enquiryNo) {
		dao = new DAO();
		 return dao.getItemIdFromEnq(enquiryNo);
		
	}
	public String getNameFromId(String itemId) {
		dao = new DAO();
		return dao.getNameFromId(itemId);
	}
	public String getDetailsFromOrder(String orderId) {
		dao = new DAO();
		return dao.getDetailsFromOrder(orderId);
	}
	public SalesQuotation getAllDetailsFromQuo(String quotationNo) {
		dao = new DAO();
		return dao.getAllDetailsFromOrder(quotationNo);
	}
	public  java.util.List<String> dogetEnquiryNoList() {
		dao = new DAO();
		return dao.dogetEnquiryNoList();
	}
	public List<Item> getItemList2(Item item) {
		dao = new DAO();
		return dao.getItemList2(item);
}
	public List<SalesEnquiry> getEnquiryNoList(String string) {
		dao = new DAO();
		return dao.getEnquiryNoList(string);
	}
	public String getItemQtyFromEnq(String enquiryNumber) {
		dao = new DAO();
		return dao.getItemQtyFromEnq(enquiryNumber);
	}
	public String checkAvailability(String itemId, String itemQty) {
		dao = new DAO();
		return dao.checkAvailability(itemId,itemQty);
	}
	public List<String> customerList() {
		dao = new DAO();
		return dao.getCustomerList();
	}
	public List<String> PreparedByList() {
		dao = new DAO();
		return dao.PreparedByList();
	}
	public List<String> itemList() {
		dao = new DAO();
		return dao.itemList();
	}
	public List<String> inventoryCategory() {
		dao = new DAO();
		return dao.inventoryCategory();
	}
	public List<String> itemType() {
		dao = new DAO();
		return dao.itemType();
	}
	public List<String> orderList() {
		dao = new DAO();
		return dao.orderList();
	}
	public void changeQuotationStatus(String enquiryNumber) {
		dao = new DAO();
		dao.changeQuotationStatus(enquiryNumber);
		
	}
	public List<SalesEnquiry> getEnquiryList(String itemId) {
		dao = new DAO();
		return dao.getEnquiryList(itemId);
	}
	public String removeEnquiry(String enqNo) {
		dao = new DAO();
		return dao.removeEnquiry(enqNo);
		
	}
	
	public void updateStock(String quotationNumber) {
		dao = new DAO();
		dao.updateStock(quotationNumber);
	}
	public List<String> leadNoList() {
		dao = new DAO();
		return dao.leadNoList();
	}
	public void updateOrderGeneratedStatus(String quotationNumber) {
		dao = new DAO();
		dao.updateOrderGeneratedStatus(quotationNumber);
		
	}

	/*warehouse*/
	
	public String doAddVehicleInOutEntry(VehicleInOutEntry vehicleInOutEntry) {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.doAddVehicleInOutEntry(vehicleInOutEntry);
	}



	public List<Item> doFetchDetails(String item) {
		dao = new DAO();
		return dao.doFetchDetails(item);
	}



	public String doAddStockDetails(Item stockDetails) {
		// TODO Auto-generated method stub
		
		dao = new DAO();
		return dao.doAddStockDetails(stockDetails);
	}



	public void doAddGrnDetails(Grn grn) {
		// TODO Auto-generated method stub
		dao = new DAO();
		dao.doAddGrnDetails(grn);
	}



	public String doAddPurchaseReturnDetails(PurchaseReturn purchaseRet) {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.doAddPurchaseReturnDetails(purchaseRet);
	}



	public String doAddSalesReturnDetails(SalesReturn salesRet) {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.doAddSalesReturnDetails(salesRet);
	}



	public String doGetQuotationNumber(String poNumber) {
		// TODO Auto-generated method stub
		String quotationNumber=null;
		dao = new DAO();
		quotationNumber = dao.doGetQuotationNumber(poNumber);
		return quotationNumber;
	}

/*

	public String doGetSupplierId(String quotationNumber) {
		// TODO Auto-generated method stub
		String supplierId=null;
		dao = new DAO();
		supplierId = dao.doGetSupplierId(quotationNumber);
		return supplierId;
	}



	public Supplier doFetchSupplierDetails(String supplierId) {
		// TODO Auto-generated method stub
		Supplier supplier = new Supplier();
		dao = new DAO();
		supplier = dao.doFetchSupplierDetails(supplierId);
		return supplier;
	}*/



	public void doAddMrvDetails(Mrv mrv) {
		// TODO Auto-generated method stub
		dao = new DAO();
		dao.doAddMrvDetails(mrv);
	}



	public Integer doAddPurchaseList(PurchaseItemList list1) {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.doAddMrvDetails(list1);
	}



	public String doGetPoNumber(String invoiceNumber) {
		// TODO Auto-generated method stub
		
		String poNumber=null;
		dao = new DAO();
		poNumber = dao.doGetPoNumber(invoiceNumber);
		return poNumber;
	}



	public String doGetTransportName(String entryNumber) {
		// TODO Auto-generated method stub
		String transportName=null;
		dao = new DAO();
		transportName = dao.doGetTransportName(entryNumber);
		return transportName;
	}



	public String doGetEnquiryNumber(String quotationNumber) {
		// TODO Auto-generated method stub
		String enquiryNumber=null;
		dao = new DAO();
		enquiryNumber = dao.doGetEnquiryNumber(quotationNumber);
		return enquiryNumber;
	}



	public String doGetMrvNumber(String enquiryNumber) {
		// TODO Auto-generated method stub
		String mrvNumber=null;
		dao = new DAO();
		mrvNumber = dao.doGetMrvNumber(enquiryNumber);
		return mrvNumber;
	}



	public List<PurchaseItemList> doGetPurchaseItemList(int id) {
		// TODO Auto-generated method stub
		List<PurchaseItemList> pList = null;
		dao = new DAO();
		pList = dao.doGetPurchaseItemList(id);
		return pList;
	}



	public Integer doUpdateStock(PurchaseItemList list1) {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.doUpdateStock(list1);
	}



	public String doUpdateStockReturn(String itemId, String returnQty, int i) {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.doUpdateStockReturn(itemId,returnQty,i);
	}



	public String doAddCustomerDetails(Customer customer) {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.doAddCustomerDetails(customer);
	}



	public String doAddSupplierDetails(Supplier supplier) {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.doAddSupplierDetails(supplier);
	}



	


	public String doFetchItemIdSales(String salesOrderId) {
		// TODO Auto-generated method stub
		String itemId=null;
		dao = new DAO();
		itemId = dao.doFetchItemIdSales(salesOrderId);
		return itemId;
	}



	public String doGetQuotationNumberSales(String salesOrderId) {
		// TODO Auto-generated method stub
		String quotationNumber=null;
		dao = new DAO();
		quotationNumber = dao.doGetQuotationNumberSales(salesOrderId);
		return quotationNumber;
	}



	public String doGetEnquiryNumberSales(String quotationNumber) {
		// TODO Auto-generated method stub
		String enquiryNumber=null;
		dao = new DAO();
		enquiryNumber = dao.doGetEnquiryNumberSales(quotationNumber);
		return enquiryNumber;
	}



	public String doFetchCustomerId(String enquiryNumber) {
		// TODO Auto-generated method stub
		String customerId=null;
		dao = new DAO();
		customerId = dao.doFetchCustomerId(enquiryNumber);
		return customerId;
	}



	public Customer doFetchCustomerDetails(String customerId) {
		// TODO Auto-generated method stub
		Customer customer = new Customer();
		dao = new DAO();
		customer = dao.doFetchCustomerDetails(customerId);
		return customer;
	}



	public String doGetRequiredQty(String itemId) {
		// TODO Auto-generated method stub
		String requiredQty=null;
		dao = new DAO();
		requiredQty = dao.doGetRequiredQty(itemId);
		return requiredQty;
	}



	public String doGetItemQty(String itemId) {
		// TODO Auto-generated method stub
		String requiredQty=null;
		dao = new DAO();
		requiredQty = dao.doGetItemQty(itemId);
		return requiredQty;
	}



	public String doCalculateAmountSales(String itemId) {
		// TODO Auto-generated method stub
		String amount=null;
		dao = new DAO();
		amount = dao.doCalculateAmountSales(itemId);
		return amount;
	}



	public String doGetEnquiryNumberMrv(String mrvNumber) {
		// TODO Auto-generated method stub
		String enquiryNumber=null;
		dao = new DAO();
		enquiryNumber = dao.doGetEnquiryNumberMrv(mrvNumber);
		return enquiryNumber;
	}



	public String doFetchItemAmount(String enquiryNumber) {
		// TODO Auto-generated method stub
		String amount=null;
		dao = new DAO();
		amount = dao.doFetchItemAmount(enquiryNumber);
		return amount;
	}



	public String doCalculateAmountPurchase(String itemId) {
		// TODO Auto-generated method stub
		String amount=null;
		dao = new DAO();
		amount = dao.doCalculateAmountPurchase(itemId);
		return amount;
	}



	public String doFetchCurrentStock(String itemId) {
		// TODO Auto-generated method stub
		String currentStock=null;
		dao = new DAO();
		currentStock = dao.doFetchCurrentStock(itemId);
		return currentStock;
	}



	public int doGetIdNumber(String quotationNumber) {
		dao = new DAO();
		return dao.doGetIdNumber(quotationNumber);
	}



	public String doGetGrossAmount(String quotationNumber) {
		dao = new DAO();
		return dao.doGetGrossAmount(quotationNumber);
	}



	public int doUpdatePurchaseAmount(String amount, int id) {
		dao = new DAO();
		return dao.doUpdatePurchaseAmount(amount,id);
		}



	public String doFetchItemIdPurchase(int id) {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.doFetchItemIdPurchase(id);
	}



	public String doUpdateStockReturnPurchaseItemList(String id,
			String returnQty) {
		dao = new DAO();
		return dao.doUpdateStockReturnPurchaseItemList(id,returnQty);
	}
	public String doAddLogin(Login login) {
		// TODO Auto-generated method stub
		dao = new DAO();
		return dao.doAddLogin(login);
	}
	public String doAddUserDetails(UserDetails ud) {
		dao = new DAO();
		return dao.doAddUserDetails(ud);
	}

	
}
