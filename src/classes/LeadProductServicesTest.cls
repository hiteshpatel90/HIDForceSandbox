@isTest
private class LeadProductServicesTest {
    static Lead_Products__c leadProduct;
    static Lead testLead;
    static User guestUser = [SELECT Id FROM User WHERE IsActive=true AND Profile.Name='HIDTechnology Profile' LIMIT 1];
    
    
    static testMethod void approveLeadProductTest() {
        System.runAs(guestUser) {
            setupData();
        }

        Test.startTest();
            leadProduct.Approval_Status__c = 'Approved';
            
            update leadProduct;
        
            Lead updatedLead = [SELECT Id, At_Least_One_Partner_Product_Approved__c FROM Lead WHERE Id=:testLead.Id];

            System.assert(updatedLead.At_Least_One_Partner_Product_Approved__c);
            
            //then delete
            delete leadProduct;
            
        Test.stopTest();
        
        updatedLead = [SELECT Id, At_Least_One_Partner_Product_Approved__c FROM Lead WHERE Id=:testLead.Id];
        
        System.assert(!updatedLead.At_Least_One_Partner_Product_Approved__c);
        
    }
    
    static testMethod void updateLeadProductToNotApproved() {
        System.runAs(guestUser) {
            setupData();
        }
        
        Test.startTest();
            leadProduct.Approval_Status__c = 'Pending Approval';
            update leadProduct;
        Test.stopTest();
        
        Lead updatedLead = [SELECT Id, At_Least_One_Partner_Product_Approved__c FROM Lead WHERE Id=:testLead.Id];
        
        System.assert(!updatedLead.At_Least_One_Partner_Product_Approved__c);
    }
    
    static testMethod void bulkApprovedLeadProducts() {
        Integer count = 25;
        
        List<Lead> leads = new List<Lead>();
        List<Lead_Products__c> leadProducts = new List<Lead_Products__c>();
        
        System.runAs(guestUser) {
            
            for (Integer i=0; i < count; i++) {
                Lead iLead = new Lead(Company='test company', Terms_and_Conditions__c=true, LastName='TestLName', Country='United States', State='California');
                leads.add(iLead);
            }
            insert leads;
            
            for (Integer i=0; i < count; i++) {
                Lead_Products__c iLeadProduct = new Lead_Products__c(Lead__c=leads[i].Id, Approval_Status__c=PartnerProductConversion.APPROVED_STATUS);
                leadProducts.add(iLeadProduct);         
            }
            Test.startTest();
                insert leadProducts;
            Test.stopTest();
        }
        
        List<Lead> updatedLeads = [SELECT Id, At_Least_One_Partner_Product_Approved__c FROM Lead 
                                    WHERE Id IN :leads
                                    AND At_Least_One_Partner_Product_Approved__c=true];

        System.assertEquals(count, updatedLeads.size());
        
        
    }
    
    static void setupData() {
        testLead = new Lead(Company='test company', Terms_and_Conditions__c=true, LastName='TestLName', Country='United States', State='California');
        insert testLead;
        
        leadProduct = new Lead_Products__c(Lead__c=testLead.Id);
        insert leadProduct; 
    }
}