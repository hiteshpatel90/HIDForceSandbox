public class LeadServices {
	
	public static void convertLeadProducts(Map<Id, Lead> leadTriggerMap) {
		
		Set<Id> convertedLeadIds = new Set<Id>();
		for (Lead lead : leadTriggerMap.values()) {
			//only want leads coming from W2L form (using site)
			if (lead.IsConverted && lead.CreatedById == PartnerProductConversion.getGuestSiteUser().Id)
				convertedLeadIds.add(lead.Id);
		}
		
		List<Lead_Products__c> leadProductsForUpdate = new List<Lead_Products__c>();
		if (!convertedLeadIds.isEmpty()) {
			
			for(Lead_Products__c leadProduct : [SELECT Id, Lead__c 
												FROM Lead_Products__c 
												WHERE Lead__c IN :convertedLeadIds 
												AND Approval_Status__c = :PartnerProductConversion.APPROVED_STATUS]) 
			{
				Id accountId = leadTriggerMap.get(leadProduct.Lead__c).ConvertedAccountId;
				leadProduct.Account__c = accountId;
				
				leadProductsForUpdate.add(leadProduct);
			}
		}
		
		if (!leadProductsForUpdate.isEmpty()) {
			update leadProductsForUpdate;
		}
	}
}