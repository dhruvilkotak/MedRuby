package com.doa;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import com.model.*;
import com.sun.mail.imap.Utility;
import com.utility.Connection;


public class DAO {

	private SessionFactory sessionFactory = Connection.getSessionFactory();
	String status = "failed";
	/*purchase*/

	public Customer getCustomerDetails(String mi)
	{
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Object cust=session.load(Customer.class,mi);
			tx.commit();
			Customer cust2=(Customer)cust;
			System.out.println(cust2.getAddress());
			return (Customer)cust;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}

		
	}
	public List<Login> doLogin(Login login2)
	{

		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Login loggedIn = new Login();
			
			List<Login> loginList = session.createCriteria(Login.class)
					.add(Restrictions.eq("userId", login2.getUserId()))
					.add(Restrictions.eq("passwd", login2.getPasswd()))
					.list();
			tx.commit();
			return (List<Login>)loginList;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}

	}
	public List<Mrv> getMrvList()
	{
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(Mrv.class);
			cr.add(Restrictions.eq("viewed","no").ignoreCase());
			cr.add(Restrictions.eq("toDept","purchase").ignoreCase());
			List<Mrv> mrvList=cr.list();
			tx.commit();
			return mrvList;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}
	public int doSubmitPurchaseEnquiry(PurchaseEnquiry purchaseEnquiry)
	{
		Session session = null;
		Transaction tx = null;
		int i = 0;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			session.save(purchaseEnquiry);
			tx.commit();
			return 1;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return 0;
		} finally {
			session.close();
		}
	}
	public void doUpdateMrvViewed(String mrvNumber)
	{
		Session session = null;
		Transaction tx = null;
		Integer cityId = 0;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Mrv mrv= (Mrv)session.load(Mrv.class,new String(mrvNumber));
			mrv.setViewed("yes");
			session.update(mrv);
			tx.commit();
			return ;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return ;
		} finally {
			session.close();
		}
	}
	public List<String> getItemList(Item item)
	{
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(Item.class);
			if(!item.getItemId().equals(""))
			{
				cr.add(Restrictions.eq("itemId",item.getItemId()).ignoreCase());
			}
			if(!item.getItemName().equals(""))
			{
				cr.add(Restrictions.eq("itemName",item.getItemName()).ignoreCase());
			}
			if(!item.getItemRefNumber().equals(""))
			{
				cr.add(Restrictions.eq("itemRefNumber",item.getItemRefNumber()).ignoreCase());
			}
			if(item.getItemType()!=null)
			{
				cr.add(Restrictions.eq("itemType",item.getItemType()).ignoreCase());
			}
			if( item.getInventoryCategory()!=null)
			{
				cr.add(Restrictions.eq("inventoryCategory",item.getInventoryCategory()).ignoreCase());
			}
			cr.setProjection(Projections.property("itemId"));
			List<String> itemList=cr.list();
			System.out.println(itemList);
			tx.commit();
			return itemList;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}

	}
	public List<PurchaseItemList> getPurchaseItemList() {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(PurchaseItemList.class);
			List<PurchaseItemList> purchaseItemList=cr.list();
			tx.commit();
			return purchaseItemList;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}

	
	public List<PurchaseItemList> getPurchaseItemList(List<String> itemIdList) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(PurchaseItemList.class);
			cr.add(Restrictions.in("itemId", itemIdList));
			List<PurchaseItemList> purchaseItemList=cr.list();
			tx.commit();
			return purchaseItemList;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}

	public List<PurchaseEnquiry> getPurchaseEnquiry(List<String> mrvNumberList, String fromDate, String toDate) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(PurchaseEnquiry.class);
			cr.add(Restrictions.in("mrvNumber", mrvNumberList));
			
			if(!fromDate.equals("")&& !toDate.equals(""))
			{	
				System.out.println(" "+fromDate+" "+toDate);
				cr.add(Restrictions.ge("enquiryDate", fromDate));
				cr.add(Restrictions.le("enquiryDate", toDate));
			}
			List<PurchaseEnquiry> purchaseEnquiryList=cr.list();
			tx.commit();
			return purchaseEnquiryList;
						
			} catch (Exception e) {
				tx.rollback();
				e.printStackTrace();
				return null;
			} finally {
				session.close();
			}
	}
	public int doSubmitPurchaseQuotation(PurchaseQuotation purchaseQuotation) 
	{
		Session session = null;
		Transaction tx = null;
		int i = 0;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			session.save(purchaseQuotation);
			tx.commit();
			return 1;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return 0;
		} finally {
			session.close();
		}	
		
	}
	public List<PurchaseQuotation> getPurchaseQuotation(List<Integer> idList, String fromDate,
			String toDate) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(PurchaseQuotation.class);
			cr.add(Restrictions.in("id", idList));
			cr.add(Restrictions.eq("oredered","no"));
			if(!fromDate.equals("")&& !toDate.equals(""))
			{
				cr.add(Restrictions.between("quotationDate", fromDate, toDate));
			}
			List<PurchaseQuotation> purchaseQuotationList=cr.list();
			tx.commit();
			return purchaseQuotationList;
						
			} catch (Exception e) {
				tx.rollback();
				e.printStackTrace();
				return null;
			} finally {
				session.close();
			}
	}
	public int doDeletePurchaseQuotation(List<String> quationDeletion) {
		Session session = null;
		Transaction tx = null;
		Integer cityId = 0;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(PurchaseQuotation.class);
			cr.add(Restrictions.in("quotationNumber", quationDeletion));
			List<PurchaseQuotation> purchaseQuotationList=cr.list();
			for(PurchaseQuotation purchaseQuotation:purchaseQuotationList)
			{
				session.delete(purchaseQuotation);
			}
			tx.commit();
			return 1;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return 0;
		} finally {
			session.close();
		}
	}
	public Supplier doFetchSupplierDetails(String supplierId) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(Supplier.class);
			cr.add(Restrictions.eq("supplierId", supplierId));
			List<Supplier> supplierList=cr.list();
			Supplier supplier=supplierList.get(0);
			tx.commit();
			return supplier;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}
	public int doSubmitPurchaseOrder(PurchaseOrder purchaseOrder) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			session.save(purchaseOrder);
			tx.commit();
			return 1;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return 0;
		} finally {
			session.close();
		}	
	}
	public void doUpdatePurchaseQuotation(String quotationNumber) {
		Session session = null;
		Transaction tx = null;
		Integer cityId = 0;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			PurchaseQuotation purchaseQuotation= (PurchaseQuotation)session.load(PurchaseQuotation.class,new String(quotationNumber));
			purchaseQuotation.setOredered("yes");
			session.update(purchaseQuotation);
			tx.commit();
			return ;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return ;
		} finally {
			session.close();
		}
	}
	public List<String> doGetFollowupBy() {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(UserDetails.class);
			cr.setProjection(Projections.property("userId"));
			List<String> followupByList=cr.list();
			tx.commit();
			return followupByList;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}
	public List<Object> doGetItemDetails() {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(Item.class);
			ProjectionList p1=Projections.projectionList();
	         p1.add(Projections.property("inventoryCategory"));
	         p1.add(Projections.property("itemType"));
	         cr.setProjection(p1);
			List itemDetailsList=cr.list();
			tx.commit();
			return itemDetailsList;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}
	public List<String> doGetQuotationNumberList() {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(PurchaseQuotation.class);
			cr.add(Restrictions.eq("oredered", "no"));
			cr.setProjection(Projections.property("quotationNumber"));
			List<String> purchaseQuotationNumberList=cr.list();
			tx.commit();
			return purchaseQuotationNumberList;
						
			} catch (Exception e) {
				tx.rollback();
				e.printStackTrace();
				return null;
			} finally {
				session.close();
			}
	}
	public List<String> doGetSupplierId(String quotationNumber) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(PurchaseQuotation.class);
			cr.add(Restrictions.eq("quotationNumber", quotationNumber));
			cr.setProjection(Projections.property("supplierId"));
			List<String> supplierIdList=cr.list();
			tx.commit();
			return supplierIdList;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}
	public List<String> doGetSupplierId() 
	{
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(Supplier.class);
			cr.setProjection(Projections.property("supplierId"));
			List<String> supplierIdList=cr.list();
			tx.commit();
			return supplierIdList;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}
	public Object[] doGetPurchaseQuotation(String quotationNumber) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(PurchaseQuotation.class);
			cr.add(Restrictions.eq("quotationNumber",quotationNumber));
			ProjectionList p1=Projections.projectionList();
	         p1.add(Projections.property("netAmount"));
	         p1.add(Projections.property("grossAmount"));
	         p1.add(Projections.property("id"));
	         cr.setProjection(p1);
			List<Object> quotationDetailsList=cr.list();
			tx.commit();
			Object[] quotationDetails=(Object[])quotationDetailsList.get(0);
			return quotationDetails;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}
	public Object[] doGetPurchaseItem(String id) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(PurchaseItemList.class);
			cr.add(Restrictions.eq("id", Integer.parseInt(id)));
			ProjectionList p1=Projections.projectionList();
	         p1.add(Projections.property("itemId"));
	         p1.add(Projections.property("requiredQty"));
	         cr.setProjection(p1);
			List<Object> purchaseItemList=cr.list();
			tx.commit();
			Object[] purchaseItem=(Object[]) purchaseItemList.get(0);
			return purchaseItem;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}
	public Item getItem(String itemId) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr = session.createCriteria(Item.class);
			cr.add(Restrictions.eq("itemId", itemId));
			List<Item> itemList=cr.list();
			tx.commit();
			Item item=itemList.get(0);
			return item;
					
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}
	public int doSubmitPurchaseInvoice(PurchaseInvoice purchaseInvoice) {
		Session session = null;
		Transaction tx = null;
		int i = 0;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			session.save(purchaseInvoice);
			tx.commit();
			return 1;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return i;
		} finally {
			session.close();
		}	
	}
	
	/*sales*/
	Session session = null;
	Transaction tx = null;

	public String doAddSalesLead(SalesLead saleslead) 
	{

		Session session = null;
		String leadNo = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
		    leadNo=(String) session.save(saleslead);
			tx.commit();
			return leadNo;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} 
		finally {
			session.close();
		}
	}
	
	public String doAddSalesEnquiry(SalesEnquiry salesenq) 
	{
		Session session = null;
		Transaction tx = null;
		String enquiryNo = null;
		try {
		
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			enquiryNo= (String)session.save(salesenq);
			tx.commit();
			return enquiryNo;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} 
		finally {
			session.close();
		}
	}
	public String doAddSalesQuotation(SalesQuotation salesquo) 
	{

		String enqNo;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
		    enqNo=(String)session.save(salesquo);
			tx.commit();
			return enqNo;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} 
		finally {
			session.close();
		}
	}
	public String doAddCustomerComplaint(CustomerComplaintLog custcomp) 
	{
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
		    String cust=(String)session.save(custcomp);
			tx.commit();
			return cust;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} 
		finally {
			session.close();
		}
	}
	public String doAddSalesOrder(SalesOrder salesorder) {
		// TODO Auto-generated method stub
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
		    String orderN=(String)session.save(salesorder);
			tx.commit();
			
			return orderN;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} 
		finally {
			session.close();
		}
	}
	public void doAddSalesInvoice(SalesInvoice salesinv) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
		    session.save(salesinv);
			tx.commit();
			
			return ;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return ;
		} 
		finally {
			session.close();
		}
		
	}
	public Customer getDetailsFromCust(String contactId) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			
			Criteria cr=session.createCriteria(Customer.class);
		    cr.add(Restrictions.eq("customerId", contactId));
			List<Customer> results = cr.list();   
			Customer customer=results.get(0);
			System.out.println(customer.getAddress());
			tx.commit();
			return customer;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
		
	}

	public String getDetailsFromLead(String leadNo) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			System.out.println(leadNo);
			Criteria cr=session.createCriteria(SalesLead.class);
			cr.add(Restrictions.eq("leadNumber", leadNo));
			cr.setProjection(Projections.property("customerId"));
			List results = cr.list();   
			String id=results.get(0).toString();
			tx.commit();
			return id;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
		
	}

	public String getDetailsFromEnq(String enquiryNo) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(SalesEnquiry.class);
			cr.add(Restrictions.eq("enquiryNumber", enquiryNo));
			cr.setProjection(Projections.property("customerId"));
		   
			List results = cr.list();   
			String id=results.get(0).toString();
			
			tx.commit();
			return id;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	
	}
	public String getDetailsFromQuo(String quotationNo) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(SalesQuotation.class);
			cr.add(Restrictions.eq("quotationNumber", quotationNo));
			cr.setProjection(Projections.property("enquiryNumber"));
		   
			List results = cr.list();   
			String id=results.get(0).toString();
			
			tx.commit();
			return id;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	
	}

	public String populateCustomer() {
		Session session = sessionFactory.openSession();
		try {
			List<String> List = session.createCriteria(Customer.class).setProjection(Projections.property("customerId")).list();
			String Options = "<option value=''>--select--</option>";
			String section = null;
			for (int count = 0; count<List.size(); count++) {
				section = List.get(count);
				Options = Options + "<option value='"
						+ section + "'>"
						+ section + "</option>";
			}
			return Options;
		} finally {
			session.close();
		}

		
	}

	public String getItemIdFromEnq(String enquiryNo) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(SalesEnquiry.class);
			cr.add(Restrictions.eq("enquiryNumber", enquiryNo));
			cr.setProjection(Projections.property("itemId"));
			
			List results = cr.list();   
			String itemId=results.get(0).toString();
			System.out.println(itemId);
		    tx.commit();
			return itemId;
		} 
		catch (Exception e) {
			System.out.println("ERROR");
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	
	}

	public String getNameFromId(String itemId) {
		try {
			System.out.println("final"+itemId);
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(Item.class);
			cr.add(Restrictions.eq("itemId", itemId));
			cr.setProjection(Projections.property("itemName"));
			
			List results = cr.list();   
			String itemName=results.get(0).toString();
			System.out.println(itemName);
		    tx.commit();
			return itemName;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	
	}

	public String getDetailsFromOrder(String orderId) {
		try {
	
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(SalesOrder.class);
			cr.add(Restrictions.eq("salesOrderId", orderId));
			cr.setProjection(Projections.property("quotationNumber"));
			
			List results = cr.list();   
			String quo=results.get(0).toString();
			System.out.println("final"+quo);
		    tx.commit();
			return quo;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}

	public SalesQuotation getAllDetailsFromOrder(String quotationNo) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(SalesQuotation.class);
			cr.add(Restrictions.eq("quotationNumber", quotationNo));
			List<SalesQuotation> results = cr.list();   
			SalesQuotation sq=results.get(0);
			System.out.println("quotation amount:"+sq.getAmount());
			tx.commit();
			return sq;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	
	}

	public List<String> dogetEnquiryNoList() {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(SalesEnquiry.class);
			cr.setProjection(Projections.property("enquiryNumber"));
			List<String> results = cr.list(); 
			
			tx.commit();
			return results;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	
	}

	public List<Item> getItemList2(Item item) {
		try {
			System.out.println("yes"+item.getItemId());
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(Item.class);
			
			if(item.getInventoryCategory()!=null)
			{
				cr.add(Restrictions.eq("inventoryCategory",item.getInventoryCategory()));
			}
			
			if(item.getItemType()!=null)
			{
				cr.add(Restrictions.eq("itemType",item.getItemType()));
			}
		
			
				if(item.getItemId()!="")
				{
				System.out.println("ItemId not null");
				cr.add(Restrictions.eq("itemId",item.getItemId()));
				}
				
			if(item.getItemRefNumber()!="")
			{
				
				cr.add(Restrictions.eq("itemRefNumber",item.getItemRefNumber()));
			}
			
			if(item.getItemName()!="")
			{
				cr.add(Restrictions.eq("itemName",item.getItemName()));
			}
			List<Item> results = cr.list(); 
			
			tx.commit();
			return results;
		} 
		catch (Exception e) {
		//	tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}

	public List<SalesEnquiry> getEnquiryNoList(String itemId) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			String bool="N";
			Criteria cr=session.createCriteria(SalesEnquiry.class);
			cr.add(Restrictions.eq("itemId",itemId));
			cr.add(Restrictions.eq("quoGenerated", bool));
			List<SalesEnquiry> result = cr.list(); 
			tx.commit();
			return result;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}

	public String getItemQtyFromEnq(String enquiryNo) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(SalesEnquiry.class);
			cr.add(Restrictions.eq("enquiryNumber", enquiryNo));
			cr.setProjection(Projections.property("requiredQty"));
			
			List results = cr.list();   
			String itemQty=results.get(0).toString();
			
		    tx.commit();
			return itemQty;
		} 
		catch (Exception e) {
			System.out.println("ERROR");
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	
	}

	public String checkAvailability(String itemId, String itemQty) {
		try {
			System.out.println("Checking Availability");
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(Item.class);
			cr.add(Restrictions.eq("itemId", itemId));
			//cr.setProjection(Projections.property("currentStock"));
			String ava;
			List results = cr.list();   
			Item stock=(Item) results.get(0);
			if(Integer.parseInt(itemQty)>Integer.parseInt(stock.getCurrentStock()))
			{
				System.out.println("Quantity Not Available");
				ava="N";
				
			}
			else
			{
				System.out.println("Quantity Available");
				ava="Y";
			}
		    tx.commit();
		    return ava;
		    
			
		} 
		catch (Exception e) {
			System.out.println("ERROR");
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}

	public List<String> getCustomerList() {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();	
			Criteria cr=session.createCriteria(Customer.class);
			cr.setProjection(Projections.property("customerId"));   
			List<String> result = cr.list(); 
			tx.commit();
			return result;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}

	public List<String> PreparedByList() {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();	
			Criteria cr=session.createCriteria(Login.class);
			cr.setProjection(Projections.property("userId"));   
			List<String> result = cr.list(); 
			tx.commit();
			return result;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}

	public List<String> itemList() {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();	
			Criteria cr=session.createCriteria(Item.class);
			cr.setProjection(Projections.property("itemId"));   
			List<String> result = cr.list(); 
			tx.commit();
			return result;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}
	public List<String> inventoryCategory() {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();	
			Criteria cr=session.createCriteria(Item.class);
			cr.setProjection( Projections.distinct(Projections.property("inventoryCategory")));   
			List<String> result = cr.list(); 
			tx.commit();
			return result;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}
	public List<String> itemType() {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();	
			Criteria cr=session.createCriteria(Item.class);
			cr.setProjection(Projections.distinct(Projections.property("itemType")));   
			List<String> result = cr.list(); 
			tx.commit();
			return result;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}

	public List<String> orderList() {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();	
			Criteria cr=session.createCriteria(SalesOrder.class);
			cr.setProjection(Projections.property("salesOrderId"));   
			List<String> result = cr.list(); 
			tx.commit();
			return result;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}

	public void changeQuotationStatus(String enquiryNo) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();	
			Criteria cr=session.createCriteria(SalesEnquiry.class);
			cr.add(Restrictions.eq("enquiryNumber", enquiryNo));
			List results = cr.list();   
			SalesEnquiry obj=(SalesEnquiry) results.get(0);
			obj.setQuoGenerated("Y");
			session.update(obj);
			tx.commit();
			
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
		} 
		finally {
			session.close();
		}
		
	}

	public List<SalesEnquiry> getEnquiryList(String itemId) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			
			Criteria cr=session.createCriteria(SalesEnquiry.class);
			cr.add(Restrictions.eq("itemId",itemId));
		
			List<SalesEnquiry> result = cr.list(); 
			tx.commit();
			return result;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
		
	}

	public String removeEnquiry(String enqNo) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();	
			Criteria cr=session.createCriteria(SalesEnquiry.class);
			cr.add(Restrictions.eq("enquiryNumber", enqNo));
			List results = cr.list();   
			SalesEnquiry obj=(SalesEnquiry) results.get(0);
			if(obj.getQuoGenerated().equals("Y"))
			{
				System.out.println("qutaiipn che");
				Criteria cr1=session.createCriteria(SalesQuotation.class);
				cr1.add(Restrictions.eq("enquiryNumber", obj.getEnquiryNumber()));
				List results1 = cr1.list();   
				SalesQuotation obj1=(SalesQuotation) results1.get(0);
				if(obj1.getOrderGenerated().equals("N"))
				{
					session.delete(obj1);
					session.delete(obj);
					status="Yes";
				}
				else
				{
					status="No";
							
				}
				
			}
			
			tx.commit();
			
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
		return status;
		
		
	}

	public List<Login> getLoginList(Login login) {
		try {
			
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(Login.class);
			cr.add(Restrictions.eq("userId", login.getUserId()));
			List results = cr.list(); 
		    tx.commit();
			return results;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
			
		}
	}

	public void updateStock(String quotationNumber) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(SalesQuotation.class);
			cr.add(Restrictions.eq("quotationNumber", quotationNumber));
			cr.setProjection(Projections.property("enquiryNumber"));
			List results = cr.list();   
			String enqNo=results.get(0).toString();
			System.out.println("Enquiry No in Updation:"+enqNo);
			Criteria cr1=session.createCriteria(SalesEnquiry.class);
			cr1.add(Restrictions.eq("enquiryNumber", enqNo));
		    List results1 = cr1.list();   
			SalesEnquiry salesEnq=(SalesEnquiry) results1.get(0);
			System.out.println("item id in Updation:"+salesEnq.getItemId());
			Criteria cr2=session.createCriteria(Item.class);
			cr2.add(Restrictions.eq("itemId", salesEnq.getItemId()));
		    List results2 = cr2.list();   
			Item stock=(Item) results2.get(0);
			Integer newval=Integer.parseInt(stock.getCurrentStock())-Integer.parseInt(salesEnq.getRequiredQty());
			stock.setCurrentStock(newval.toString());
			session.update(stock);
			tx.commit();
			
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return ;
		} 
		finally {
			session.close();
		}
	
		
	}

	public List<String> leadNoList() {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(SalesLead.class);
			cr.setProjection(Projections.property("leadNumber"));
			List<String> results = cr.list(); 
			
			tx.commit();
			return results;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}

	public void updateOrderGeneratedStatus(String quotationNumber) {
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			Criteria cr=session.createCriteria(SalesQuotation.class);
			cr.add(Restrictions.eq("quotationNumber",quotationNumber));
			List results = cr.list();   
			SalesQuotation obj=(SalesQuotation) results.get(0);
			obj.setOrderGenerated("Y");
			session.update(obj);
			tx.commit();
			return ;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return ;
		} 
		finally {
			session.close();
		}
		
	}

	
	
	/*warehouse*/
	public String doAddVehicleInOutEntry(VehicleInOutEntry vehicleInOutEntry) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			String abc = (String) session.save(vehicleInOutEntry);
			tx.commit();
			return abc;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} finally {
			session.close();
		}
	}

	public List<Item> doFetchDetails(String item) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			 Criteria cr=session.createCriteria(Item.class);
			 cr.add(Restrictions.eq("itemId", item));
			 List<Item> itemList=cr.list();
			tx.commit();
			return itemList;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}

	public String doAddStockDetails(Item stockDetails) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			String stock = (String) session.save(stockDetails);
			tx.commit();
			return stock;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} finally {
			session.close();
		}
	}

	public void doAddGrnDetails(Grn grn) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			 session.save(grn);
			tx.commit();
			return;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return ;
		} finally {
			session.close();
		}
	}

	public String doAddPurchaseReturnDetails(PurchaseReturn purchaseRet) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			 session.save(purchaseRet);
			tx.commit();
			return "1";
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} finally {
			session.close();
		}
	}

	public String doAddSalesReturnDetails(SalesReturn salesRet) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			 session.save(salesRet);
			tx.commit();
			return "1";
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} finally {
			session.close();
		}
	}

	public String doGetQuotationNumber(String poNumber) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx=null;
		try {
			session = sessionFactory.openSession();
			tx=session.beginTransaction();
		//	System.out.println("Dao start"+poNumber); 
			Criteria crit = session.createCriteria(PurchaseOrder.class);
			crit.add(Restrictions.eq("poNumber", poNumber));
			crit.setProjection(Projections.property("quotationNumber"));
			List l=crit.list();
			String quotationNo=l.get(0).toString();
			//System.out.println("Dao"+quotationNo);
			tx.commit();
			return quotationNo;
		}
		catch(Exception e)
		{
			tx.rollback();
			e.printStackTrace();
			return null;
		}
		finally {	
		session.close();
		
		}
	
	
	}

	/*public String doGetSupplierId(String quotationNumber) {
		// TODO Auto-generated method stub
			Session session = null;
			Transaction tx=null;
		
		try {
			session = sessionFactory.openSession();
			tx=session.beginTransaction();
			Criteria crit = session.createCriteria(PurchaseQuotation.class);
			crit.add(Restrictions.eq("quotationNumber", quotationNumber));
			crit.setProjection(Projections.property("supplierId"));
			List l=crit.list();
			String supplierId=l.get(0).toString();
			//System.out.println("Dao"+supplierId);
			tx.commit();
			return supplierId;
		}
		catch(Exception e)
		{
			tx.rollback();
			e.printStackTrace();
			return null;
		}
		
		finally {	
		session.close();
		}
		
		
	}
*/
	/*public Supplier doFetchSupplierDetailsWarehouse(String supplierId) {
		// TODO Auto-generated method stub
			Session session = null;
			Transaction tx=null;	
			Supplier supplier1 = new Supplier();
				try {
					session = sessionFactory.openSession();
					tx=session.beginTransaction();
					Criteria crit = session.createCriteria(Supplier.class);
					crit.add(Restrictions.eq("supplierId", supplierId));
		
					ProjectionList p1=Projections.projectionList();
			         p1.add(Projections.property("supplierName"));
			         p1.add(Projections.property("address"));	
			         crit.setProjection(p1);
			         
					List l=crit.list();
					Iterator it=l.iterator();
					
					
					while(it.hasNext())
					{
						Object ob[] = (Object[])it.next();
						supplier1.setSupplierName(ob[0].toString());
						supplier1.setAddress(ob[1].toString());
						supplier1.setEmailId(null);
						supplier1.setPhoneNumber(null);
						supplier1.setSupplierId(supplierId);
			}
					return supplier1;
				}
				catch(Exception e)
				{
					System.out.println("hello");
		
					tx.rollback();
					e.printStackTrace();
					return supplier1;
		
				}
				
				finally {	
				session.close();
				}
		
		
	}

*/	public void doAddMrvDetails(Mrv mrv) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			 session.save(mrv);
			tx.commit();
			return;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return ;
		} finally {
			session.close();
		}
	}

	public Integer doAddMrvDetails(PurchaseItemList list1) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			session.save(list1);
			tx.commit();
			return 1;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return 0 ;
		} finally {
			session.close();
		}
	}

	public String doGetPoNumber(String invoiceNumber) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx=null;
	
	try {
		session = sessionFactory.openSession();
		tx=session.beginTransaction();
		Criteria crit = session.createCriteria(PurchaseInvoice.class);
		crit.add(Restrictions.eq("invoiceNumber", invoiceNumber));
		crit.setProjection(Projections.property("poNumber"));
		List l=crit.list();
		String poNumber=l.get(0).toString();
		//System.out.println("Dao"+supplierId);
		tx.commit();
		return poNumber;
	}
	catch(Exception e)
	{
		tx.rollback();
		e.printStackTrace();
		return null;
	}
	
	finally {	
	session.close();
	}
	
	}

	public String doGetTransportName(String entryNumber) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx=null;
	
	try {
		session = sessionFactory.openSession();
		tx=session.beginTransaction();
		Criteria crit = session.createCriteria(VehicleInOutEntry.class);
		crit.add(Restrictions.eq("entryNumber", entryNumber));
		crit.setProjection(Projections.property("transportName"));
		List l=crit.list();
		String transportName=l.get(0).toString();
		//System.out.println("Dao"+supplierId);
		tx.commit();
		return transportName;
	}
	catch(Exception e)
	{
		tx.rollback();
		e.printStackTrace();
		return null;
	}
	
	finally {	
	session.close();
	}
	
	}

	public String doGetEnquiryNumber(String quotationNumber) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx=null;
	
	try {
		session = sessionFactory.openSession();
		tx=session.beginTransaction();
		Criteria crit = session.createCriteria(PurchaseQuotation.class);
		crit.add(Restrictions.eq("quotationNumber", quotationNumber));
		crit.setProjection(Projections.property("enquiryNumber"));
		List l=crit.list();
		String enquiryNumber=l.get(0).toString();
		//System.out.println("Dao"+supplierId);
		tx.commit();
		return enquiryNumber;
	}
	catch(Exception e)
	{
		tx.rollback();
		e.printStackTrace();
		return null;
	}
	
	finally {	
	session.close();
	}
	}

	public String doGetMrvNumber(String enquiryNumber) {
		// TODO Auto-generated method stub
			Session session = null;
			Transaction tx=null;
		
		try {
			session = sessionFactory.openSession();
			tx=session.beginTransaction();
			Criteria crit = session.createCriteria(PurchaseEnquiry.class);
			crit.add(Restrictions.eq("enquiryNumber", enquiryNumber));
			crit.setProjection(Projections.property("mrvNumber"));
			List l=crit.list();
			String mrvNumber=l.get(0).toString();
			//System.out.println("Dao"+supplierId);
			tx.commit();
			return mrvNumber;
		}
		catch(Exception e)
		{
			tx.rollback();
			e.printStackTrace();
			return null;
		}
		
		finally {	
		session.close();
		}
	}

	public List<PurchaseItemList> doGetPurchaseItemList(int id) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx=null;	
		//List<PurchaseItemList> pList = null;
		
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				Criteria crit = session.createCriteria(PurchaseItemList.class);
				//Criteria crit2 = session.createCriteria(Item.class);
				crit.add(Restrictions.eq("id", id));
				List<PurchaseItemList> pList=new ArrayList<PurchaseItemList>();
				pList=crit.list();
				System.out.println(pList);
				return pList;
			}
			catch(Exception e)
			{
				System.out.println("ok");

				tx.rollback();
				e.printStackTrace();
				return null;
				
			}
			
			finally {	
			session.close();
			}
	}

	public Integer doUpdateStock(PurchaseItemList list1) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx=null;	
		Item item1 = new Item();
		String itemId = list1.getItemId();
		System.out.println(itemId);
		
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				Criteria crit = session.createCriteria(Item.class);
				
				crit.add(Restrictions.eq("itemId", itemId));
			
				crit.setProjection(Projections.property("currentStock"));
				List l=crit.list();
				String currentStock=l.get(0).toString();
				Integer a = Integer.parseInt(currentStock);
				Integer b = Integer.parseInt(list1.getRequiredQty());
				a = a+b;
				currentStock = a.toString();
				Item items = (Item) session.get(Item.class, itemId);
				items.setCurrentStock(currentStock);
				session.update(items);
				
				tx.commit();
				return 1;
				
			}
			catch(Exception e)
			{
				System.out.println("hello");

				tx.rollback();
				e.printStackTrace();
				return 0;
				
			}
			
			finally {	
			session.close();
			}
		
		
	}

	public String doUpdateStockReturn(String itemId, String returnQty, int i) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx=null;	
	
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				
				Item items = (Item) session.get(Item.class, itemId);
				Integer currentStock = Integer.parseInt(items.getCurrentStock());
				Integer retQty = Integer.parseInt(returnQty);
				if(i==0)
				{	
					currentStock = currentStock - retQty;
					items.setCurrentStock(currentStock.toString());
				}
				else if(i==1)
				{
					currentStock = currentStock + retQty;
					items.setCurrentStock(currentStock.toString());
				}
					
				session.update(items);
				
				tx.commit();
				return "1";
				
			}
			catch(Exception e)
			{
				System.out.println("hello");

				tx.rollback();
				e.printStackTrace();
				return "0";
			}
			
			finally {	
			session.close();
			}
		
	}

	public String doAddCustomerDetails(Customer customer) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			String abc = (String) session.save(customer);
			tx.commit();
			return abc;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} finally {
			session.close();
		}
	}

	public String doAddSupplierDetails(Supplier supplier) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			String abc = (String) session.save(supplier);
			tx.commit();
			return abc;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} finally {
			session.close();
		}
	}


	public String doFetchItemIdSales(String enquiryNumber) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx=null;
	
	try {
		session = sessionFactory.openSession();
		tx=session.beginTransaction();
		Criteria crit = session.createCriteria(SalesEnquiry.class);
		crit.add(Restrictions.eq("enquiryNumber", enquiryNumber));
		crit.setProjection(Projections.property("itemId"));
		List l=crit.list();
		String itemId=l.get(0).toString();
		//System.out.println("Dao"+supplierId);
		tx.commit();
		return itemId;
	}
	catch(Exception e)
	{
		tx.rollback();
		e.printStackTrace();
		return null;
	}
	
	finally {	
	session.close();
	}
	}
	

	public String doGetQuotationNumberSales(String salesOrderId) {
		// TODO Auto-generated method stub
				Session session = null;
				Transaction tx=null;
			
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				Criteria crit = session.createCriteria(SalesOrder.class);
				crit.add(Restrictions.eq("salesOrderId", salesOrderId));
				crit.setProjection(Projections.property("quotationNumber"));
				List l=crit.list();
				String quotationNumber=l.get(0).toString();
				//System.out.println("Dao"+supplierId);
				tx.commit();
				return quotationNumber;
			}
			catch(Exception e)
			{
				tx.rollback();
				e.printStackTrace();
				return null;
			}
			
			finally {	
			session.close();
			}
	}

	public String doGetEnquiryNumberSales(String quotationNumber) {
		// TODO Auto-generated method stub
				Session session = null;
				Transaction tx=null;
			
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				Criteria crit = session.createCriteria(SalesQuotation.class);
				crit.add(Restrictions.eq("quotationNumber", quotationNumber));
				crit.setProjection(Projections.property("enquiryNumber"));
				List l=crit.list();
				String enquiryNumber=l.get(0).toString();
				
				tx.commit();
				return enquiryNumber;
			}
			catch(Exception e)
			{
				tx.rollback();
				e.printStackTrace();
				return null;
			}
			
			finally {	
			session.close();
			}
	}

	public String doFetchCustomerId(String enquiryNumber) {
		// TODO Auto-generated method stub
				Session session = null;
				Transaction tx=null;
			
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				Criteria crit = session.createCriteria(SalesEnquiry.class);
				crit.add(Restrictions.eq("enquiryNumber", enquiryNumber));
				crit.setProjection(Projections.property("customerId"));
				List l=crit.list();
				String customerId=l.get(0).toString();
				
				tx.commit();
				return customerId;
			}
			catch(Exception e)
			{
				tx.rollback();
				e.printStackTrace();
				return null;
			}
			
			finally {	
			session.close();
			}
	}

	public Customer doFetchCustomerDetails(String customerId) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx=null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			
			Criteria cr=session.createCriteria(Customer.class);
		    cr.add(Restrictions.eq("customerId", customerId));
			List<Customer> results = cr.list();   
			Customer customer=results.get(0);
			System.out.println(customer.getAddress());
			tx.commit();
			return customer;
		} 
		catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return null;
		} 
		finally {
			session.close();
		}
	}

	public String doGetRequiredQty(String itemId) {
		// TODO Auto-generated method stub
				Session session = null;
				Transaction tx=null;
			
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				Criteria crit = session.createCriteria(PurchaseItemList.class);
				crit.add(Restrictions.eq("itemId", itemId));
				crit.setProjection(Projections.property("requiredQty"));
				List l=crit.list();
				String requiredQty=l.get(0).toString();
				
				tx.commit();
				return requiredQty;
			}
			catch(Exception e)
			{
				tx.rollback();
				e.printStackTrace();
				return null;
			}
			
			finally {	
			session.close();
			}
	}

	public String doGetItemQty(String itemId) {
		// TODO Auto-generated method stub
				Session session = null;
				Transaction tx=null;
			
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				Criteria crit = session.createCriteria(SalesEnquiry.class);
				crit.add(Restrictions.eq("itemId", itemId));
				crit.setProjection(Projections.property("requiredQty"));
				List l=crit.list();
				String requiredQty=l.get(0).toString();
				
				tx.commit();
				return requiredQty;
			}
			catch(Exception e)
			{
				tx.rollback();
				e.printStackTrace();
				return null;
			}
			
			finally {	
			session.close();
			}
	}

	public String doCalculateAmountSales(String itemId) {
		// TODO Auto-generated method stub
				Session session = null;
				Transaction tx=null;
			
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				Criteria crit = session.createCriteria(Item.class);
				crit.add(Restrictions.eq("itemId", itemId));
				crit.setProjection(Projections.property("rate"));
				List l=crit.list();
				String rate=l.get(0).toString();
				
				tx.commit();
				return rate;
			}
			catch(Exception e)
			{
				tx.rollback();
				e.printStackTrace();
				return null;
			}
			
			finally {	
			session.close();
			}
	}

	public String doGetEnquiryNumberMrv(String mrvNumber) {
		// TODO Auto-generated method stub
			Session session = null;
			Transaction tx=null;
		
		try {
			session = sessionFactory.openSession();
			tx=session.beginTransaction();
			Criteria crit = session.createCriteria(SalesEnquiry.class);
			crit.add(Restrictions.eq("mrvNumber", mrvNumber));
			crit.setProjection(Projections.property("enquiryNumber"));
			List l=crit.list();
			String enquiryNumber=l.get(0).toString();
			
			tx.commit();
			return enquiryNumber;
		}
		catch(Exception e)
		{
			tx.rollback();
			e.printStackTrace();
			return null;
		}
		
		finally {	
		session.close();
		}
	}

	public String doFetchItemAmount(String enquiryNumber) {
		// TODO Auto-generated method stub
				Session session = null;
				Transaction tx=null;
			
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				Criteria crit = session.createCriteria(SalesQuotation.class);
				crit.add(Restrictions.eq("enquiryNumber", enquiryNumber));
				crit.setProjection(Projections.property("grossAmount"));
				List l=crit.list();
				String grossAmount=l.get(0).toString();
				
				tx.commit();
				return grossAmount;
			}
			catch(Exception e)
			{
				tx.rollback();
				e.printStackTrace();
				return null;
			}
			
			finally {	
			session.close();
			}
	}

	public String doCalculateAmountPurchase(String itemId) {
		// TODO Auto-generated method stub
					Session session = null;
					Transaction tx=null;
				
				try {
					session = sessionFactory.openSession();
					tx=session.beginTransaction();
					Criteria crit = session.createCriteria(PurchaseItemList.class);
					crit.add(Restrictions.eq("itemId", itemId));
					crit.setProjection(Projections.property("amount"));
					List l=crit.list();
					String amount=l.get(0).toString();
					
					tx.commit();
					return amount;
				}
				catch(Exception e)
				{
					tx.rollback();
					e.printStackTrace();
					return null;
				}
				
				finally {	
				session.close();
				}
			}

	public String doFetchCurrentStock(String itemId) {
		// TODO Auto-generated method stub
					Session session = null;
					Transaction tx=null;
				
				try {
					session = sessionFactory.openSession();
					tx=session.beginTransaction();
					Criteria crit = session.createCriteria(Item.class);
					crit.add(Restrictions.eq("itemId", itemId));
					crit.setProjection(Projections.property("currentStock"));
					List l=crit.list();
					String currentStock=l.get(0).toString();
					
					tx.commit();
					return currentStock;
				}
				catch(Exception e)
				{
					tx.rollback();
					e.printStackTrace();
					return null;
				}
				
				finally {	
				session.close();
				}
	}

	public int doGetIdNumber(String quotationNumber) {
		Session session = null;
		Transaction tx=null;
		try {
		session = sessionFactory.openSession();
		tx=session.beginTransaction();
		Criteria crit = session.createCriteria(PurchaseQuotation.class);
		crit.add(Restrictions.eq("quotationNumber", quotationNumber));
		crit.setProjection(Projections.property("id"));
		List l=crit.list();
		int id=(int)l.get(0);
		
		tx.commit();
		return id;
	}
	catch(Exception e)
	{
		tx.rollback();
		e.printStackTrace();
		return -1;
	}
	
	finally {	
	session.close();
	}
	}

	public String doGetGrossAmount(String quotationNumber) {
		Session session = null;
		Transaction tx=null;
		try {
		session = sessionFactory.openSession();
		tx=session.beginTransaction();
		Criteria crit = session.createCriteria(PurchaseQuotation.class);
		crit.add(Restrictions.eq("quotationNumber", quotationNumber));
		crit.setProjection(Projections.property("grossAmount"));
		List l=crit.list();
		String amount=(String)l.get(0);
		
		tx.commit();
		return amount;
	}
	catch(Exception e)
	{
		tx.rollback();
		e.printStackTrace();
		return null;
	}
	
	finally {	
	session.close();
	}
	
	}

	public int doUpdatePurchaseAmount(String amount, int id) {
		Session session = null;
		Transaction tx=null;	
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				PurchaseItemList purchaseItemList = (PurchaseItemList) session.get(PurchaseItemList.class, id);
				purchaseItemList.setAmount(amount);
				session.update(purchaseItemList);
				tx.commit();
				return 1;
				
			}
			catch(Exception e)
			{
				tx.rollback();
				e.printStackTrace();
				return 0;
				
			}
			
			finally {	
			session.close();
			}

	}

	public String doFetchItemIdPurchase(int id) {
		// TODO Auto-generated method stub
		Session session = null;
		Transaction tx=null;
		try {
		session = sessionFactory.openSession();
		tx=session.beginTransaction();
		Criteria crit = session.createCriteria(PurchaseItemList.class);
		crit.add(Restrictions.eq("id", id));
		crit.setProjection(Projections.property("itemId"));
		List l=crit.list();
		String itemId=(String)l.get(0);
		
		tx.commit();
		return itemId;
	}
	catch(Exception e)
	{
		tx.rollback();
		e.printStackTrace();
		return null;
	}
	
	finally {	
	session.close();
	}
	}

	public String doUpdateStockReturnPurchaseItemList(String id,
			String returnQty) {
		Session session = null;
		Transaction tx=null;	
	
			try {
				session = sessionFactory.openSession();
				tx=session.beginTransaction();
				
				PurchaseItemList purchaseItemList = (PurchaseItemList) session.get(PurchaseItemList.class, Integer.parseInt(id));
				Integer reqQty = Integer.parseInt(purchaseItemList.getRequiredQty());
				Integer retQty = Integer.parseInt(returnQty);
				reqQty = reqQty - retQty;
				purchaseItemList.setRequiredQty(reqQty.toString());
					
				session.update(purchaseItemList);
				
				tx.commit();
				return "1";
				
			}
			catch(Exception e)
			{
				System.out.println("hello");

				tx.rollback();
				e.printStackTrace();
				return "0";
			}
			
			finally {	
			session.close();
			}
		
	}
	public String doAddLogin(Login login) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			String abc = (String) session.save(login);
			System.out.println("Login Added");
			tx.commit();
			return abc;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} finally {
			session.close();
		}
	}
	public String doAddUserDetails(UserDetails ud) {
		Session session = null;
		Transaction tx = null;
		try {
			session = sessionFactory.openSession();
			tx = session.beginTransaction();
			String abc = (String) session.save(ud);
			System.out.println("UserDetails Added");
			tx.commit();
			return abc;
		} catch (Exception e) {
			tx.rollback();
			e.printStackTrace();
			return "0";
		} finally {
			session.close();
		}
	}

}
