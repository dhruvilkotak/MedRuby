package com.model;

public class CustomerComplaintLog {

	String complaintNumber;
	String complaintDate;
	String receivedBy;
	String salesOrderId;
	
	public String getComplaintNumber() {
		return complaintNumber;
	}
	public void setComplaintNumber(String complaintNumber) {
		this.complaintNumber = complaintNumber;
	}
	public String getComplaintDate() {
		return complaintDate;
	}
	public void setComplaintDate(String complaintDate) {
		this.complaintDate = complaintDate;
	}
	
	public String getReceivedBy() {
		return receivedBy;
	}
	public void setReceivedBy(String receivedBy) {
		this.receivedBy = receivedBy;
	}
	public String getSalesOrderId() {
		return salesOrderId;
	}
	public void setSalesOrderId(String salesOrderId) {
		this.salesOrderId = salesOrderId;
	}
	
	
}
