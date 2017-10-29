package com.model;

public class PurchaseItemList {
int id;
String mrvNumber;
String itemId;
String requiredQty;
String requiredByDate;
String amount;
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getMrvNumber() {
	return mrvNumber;
}
public void setMrvNumber(String mrvNumber) {
	this.mrvNumber = mrvNumber;
}
public String getItemId() {
	return itemId;
}
public void setItemId(String itemId) {
	this.itemId = itemId;
}public String getAmount() {
	return amount;
}
public void setAmount(String amount) {
	this.amount = amount;
}
public String getRequiredQty() {
	return requiredQty;
}
public void setRequiredQty(String requiredQty) {
	this.requiredQty = requiredQty;
}
public String getRequiredByDate() {
	return requiredByDate;
}
public void setRequiredByDate(String requiredByDate) {
	this.requiredByDate = requiredByDate;
}

}
