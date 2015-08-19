trigger setReferralContactOnLeadConversion on Lead (after update) {
	//if(!utilController.bolSetReferralContactOnLeadConversion){
		utilController.bolSetReferralContactOnLeadConversion = true;

		map<Id,Id> mapLeadContact = new map<Id,Id>();
		list<Lead_Referral__c> lstReferral= new list<Lead_Referral__c>();
		
		for(Lead l : trigger.new){
			if(l.IsConverted){
				mapLeadContact.put(l.Id,l.ConvertedContactId);
			}
		}
		
		for(Lead_Referral__c r : [SELECT Id, Referred_Contact__c, Lead_Name__c FROM Lead_Referral__c WHERE Lead_Name__c IN : mapLeadContact.keySet()]){
			r.Referred_Contact__c = mapLeadContact.get(r.Lead_Name__c);
			lstReferral.add(r);
		}
		
		update lstReferral;
	//}
}