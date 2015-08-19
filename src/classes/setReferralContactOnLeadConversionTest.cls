@isTest
private class setReferralContactOnLeadConversionTest {

    static testMethod void setReferralContactOnLeadConversionTest() {
    	Account a = new Account(Name = 'Don Vogel GmbH', BillingCountry = 'Germany');
		insert a;
    	Contact c = new Contact(FirstName = 'Don', LastName = 'Vogel', AccountId = a.Id);
    	insert c;
        Lead l = new Lead(
        	FirstName = 'Don',
        	LastName = 'Bilbo',
        	Company = 'Don Bilbo GmbH',
        	Street = 'Street',
        	PostalCode = '12345',
        	City = 'Buxtehude',
        	Country = 'Germany',
        	Business_Segment__c = 'PACS',
        	Areas_of_Interest__c = 'Physical Access'
        );
        insert l;
        Lead_Referral__c r = new Lead_Referral__c(Lead_Name__c = l.Id, Contact_Name__c = c.Id);
        insert r;
       	
       	Database.LeadConvert lc = new Database.LeadConvert();
       	lc.setLeadId(l.Id);
       	
       	LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
		lc.setConvertedStatus(convertStatus.MasterLabel);
		lc.setDoNotCreateOpportunity(true);
		
       	Database.LeadConvertResult lcr = Database.convertLead(lc);
       	system.assert(lcr.isSuccess());

       	r = [SELECT Id, Referred_Contact__c, Lead_Name__c FROM Lead_Referral__c WHERE Id =: r.Id];
  		system.assertEquals(r.Referred_Contact__c,lcr.getContactId());
    }
}