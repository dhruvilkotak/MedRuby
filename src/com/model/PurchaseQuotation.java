package com.model;

public class PurchaseQuotation {
	String quotationNumber;
	String quotationDate;
	String quotationStatus;
	String supplierId;
	String enquiryNumber;
	String currencyType;
	String currencyRate;
	String netAmount;
	String grossAmount;
	String associates;
	String preparedBy;
	String remarks;
	int id;
	String oredered;
	
	public String getOredered() {
		return oredered;
	}
	public void setOredered(String oredered) {
		this.oredered = oredered;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getQuotationNumber() {
		return quotationNumber;
	}
	public void setQuotationNumber(String quotationNumber) {
		this.quotationNumber = quotationNumber;
	}
	public String getQuotationDate() {
		return quotationDate;
	}
	public void setQuotationDate(String quotationDate) {
		this.quotationDate = quotationDate;
	}
	
	public String getQuotationStatus() {
		return quotationStatus;
	}
	public void setQuotationStatus(String quotationStatus) {
		this.quotationStatus = quotationStatus;
	}
	public String getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(String supplierId) {
		this.supplierId = supplierId;
	}
	public String getEnquiryNumber() {
		return enquiryNumber;
	}
	public void setEnquiryNumber(String enquiryNumber) {
		this.enquiryNumber = enquiryNumber;
	}
	public String getCurrencyType() {
		return currencyType;
	}
	public void setCurrencyType(String currencyType) {
		this.currencyType = currencyType;
	}
	public String getCurrencyRate() {
		return currencyRate;
	}
	public void setCurrencyRate(String currencyRate) {
		this.currencyRate = currencyRate;
	}
	public String getNetAmount() {
		return netAmount;
	}
	public void setNetAmount(String netAmount) {
		this.netAmount = netAmount;
	}
	public String getGrossAmount() {
		return grossAmount;
	}
	public void setGrossAmount(String grossAmount) {
		this.grossAmount = grossAmount;
	}
	public String getAssociates() {
		return associates;
	}
	public void setAssociates(String associates) {
		this.associates = associates;
	}
	public String getPreparedBy() {
		return preparedBy;
	}
	public void setPreparedBy(String preparedBy) {
		this.preparedBy = preparedBy;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
}
