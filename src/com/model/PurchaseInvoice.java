package com.model;

public class PurchaseInvoice {
String invoiceNumber;
String poNumber;
String fileName;
String invoiceDate;

	public String getInvoiceDate() {
	return invoiceDate;
}
public void setInvoiceDate(String invoiceDate) {
	this.invoiceDate = invoiceDate;
}
	public String getInvoiceNumber() {
		return invoiceNumber;
	}
	public void setInvoiceNumber(String invoiceNumber) {
		this.invoiceNumber = invoiceNumber;
	}
	public String getPoNumber() {
		return poNumber;
	}
	public void setPoNumber(String poNumber) {
		this.poNumber = poNumber;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
}
