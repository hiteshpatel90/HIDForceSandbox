public class LeadProductServices {
	 
	public static void setLeadApproval(Map<Id, Lead_Products__c> leadProductsTriggerMap) {
		
		Set<Id> leadIds = new Set<Id>();
		for (Lead_Products__c leadProduct : leadProductsTriggerMap.values()) {
			
			leadIds.add(leadProduct.Lead__c);
		}
		
		List<Lead> leadsForUpdate = new List<Lead>(); 
		Id siteUserId = PartnerProductConversion.getGuestSiteUser().Id;
		
		for (Lead siteLead :[SELECT Id, CreatedById,
							(SELECT Id FROM Lead_Products__r WHERE Approval_Status__c = :PartnerProductConversion.APPROVED_STATUS)
							FROM Lead
							WHERE Id IN :leadIds
							AND IsConverted=false
							AND CreatedById = :siteUserId]) 
		{
			Boolean hasApprovedLeadProducts = !siteLead.Lead_Products__r.isEmpty();
			if (hasApprovedLeadProducts) {
				siteLead.At_Least_One_Partner_Product_Approved__c = true;
			}
			else {
				siteLead.At_Least_One_Partner_Product_Approved__c = false;
			}
			 
			leadsForUpdate.add(siteLead);
		}
		
		if (!leadsForUpdate.isEmpty()) {
			update leadsForUpdate;
		}
	}
}