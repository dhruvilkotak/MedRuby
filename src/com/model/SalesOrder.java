package com.model;

public class SalesOrder {
String salesOrderId;
String packingListNumber;
String salesOrderDate;
String deliveryDate;
String quotationNumber;
String remarks;
public String getSalesOrderId() {
	return salesOrderId;
}
public void setSalesOrderId(String salesOrderId) {
	this.salesOrderId = salesOrderId;
}
public String getPackingListNumber() {
	return packingListNumber;
}
public void setPackingListNumber(String packingListNumber) {
	this.packingListNumber = packingListNumber;
}
public String getSalesOrderDate() {
	return salesOrderDate;
}
public void setSalesOrderDate(String salesOrderDate) {
	this.salesOrderDate = salesOrderDate;
}
public String getDeliveryDate() {
	return deliveryDate;
}
public void setDeliveryDate(String deliveryDate) {
	this.deliveryDate = deliveryDate;
}
public String getQuotationNumber() {
	return quotationNumber;
}
public void setQuotationNumber(String quotationNumber) {
	this.quotationNumber = quotationNumber;
}
public String getRemarks() {
	return remarks;
}
public void setRemarks(String remarks) {
	this.remarks = remarks;
}

}
