@isTest
private class setAccountProfileTest {
	static{
    	Currencies__c curr = new Currencies__c(Name = 'N. America USD', Sub_Region__c = 'N. America', Currency__c = 'USD', Default__c = true);
    	insert curr;
	}
    static testMethod void setAccountProfileTest () {
        Countries__c objCountry = new Countries__c();
        objCountry.Name = 'Test country';
        objCountry.Country__c = 'United States';
        insert objCountry;
        List<lead> lstLead = new List<Lead>();
        Lead objLead = new Lead();
        objLead.firstName = 'Test FirstName';
        objLead.LastName = 'Test LastName';
        objLead.Company = 'Test Company';
        
        /*objLead.Address_Country__c = 'United States';
        objLead.Address_State__c = 'AA';*/
        
        objLead.Country = 'United States';
        objLead.State = 'California';
        
        objLead.Business_Segment__c = 'Connect';
        objLead.Industry_Role__c = 'Consultant';
        objLead.Use_Application__c = 'Access Control';
        objLead.Areas_of_Interest__c = 'Other';
        objLead.City = 'Irvine';
        objLead.PostalCode = '99999';
        objLead.Street = 'Hobo Lane';
        lstLead.add(objLead);
       
        Lead objLead1 = new Lead();
        objLead1.firstName = 'Test FirstName';
        objLead1.LastName = 'Test LastName';
        objLead1.Company = 'Test Company';
        
        /*objLead1.Address_Country__c = 'United States';
        objLead1.Address_State__c = 'AA';*/
        
        objLead1.Country = 'United States';
        objLead1.State = 'California';
        
        objLead1.Business_Segment__c = 'PACS';
        objLead1.Industry_Role__c = 'Consultant';
        objLead1.Areas_of_Interest__c = 'Other';
        objLead1.City = 'Irvine';
        objLead1.PostalCode = '99999';
        objLead1.Street = 'Hobo Lane';
        lstLead.add(objLead1);   
        
               
        insert lstLead;
        for(Lead lc: lstLead){
            Database.LeadConvert lc1 = new database.LeadConvert();
            lc1.setLeadId(lc.id);
            lc1.setDoNotCreateOpportunity(true);
            lc1.setOwnerId(system.userinfo.getuserid());
            lc1.setConvertedStatus('Qualified');
            
            Database.LeadConvertResult lcr1 = Database.convertLead(lc1);
            System.assert(lcr1.isSuccess());
        }
    }
}