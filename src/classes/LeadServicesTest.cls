@isTest
private class LeadServicesTest {
    static Lead_Products__c leadProduct;
    static Lead testLead;
    static User guestUser = PartnerProductConversion.getGuestSiteUser();
    static User sysAdminUser = [SELECT Id FROM User WHERE Profile.Name='System Administrator' AND IsActive=true LIMIT 1];
    
    static testMethod void convertLeadProductsTest() {
        System.runAs(guestUser) {
            setupData();
        
            leadProduct.Approval_Status__c = PartnerProductConversion.APPROVED_STATUS;
            update leadProduct;
        }
        
        Database.LeadConvertResult lcr;
        
        Test.startTest();
        
            Database.LeadConvert lc = new database.LeadConvert();
            lc.setLeadId(testLead.Id);
            lc.setOwnerId( UserInfo.getUserId() );
            lc.setConvertedStatus(PartnerProductConversion.QUALIFIED_STATUS);
            lc.setDoNotCreateOpportunity(true);
            lcr = Database.convertLead(lc);
            
        Test.stopTest();
        
        System.assert(lcr.isSuccess());
        
        Lead_Products__c updateLeadProduct = [SELECT Id, Account__c FROM Lead_Products__c WHERE Id=:leadProduct.Id];
        System.assertEquals(lcr.getAccountId(), updateLeadProduct.Account__c, 'Lead product conversion was not successful');        
    }

    static testMethod void convertNoLeadProductsTest() {
        System.runAs(guestUser) {
            setupData();
        }
        
        Database.LeadConvertResult lcr;
        Test.startTest();
            Database.LeadConvert lc = new database.LeadConvert();
            lc.setLeadId(testLead.Id);
            lc.setOwnerId( UserInfo.getUserId() );
            lc.setConvertedStatus(PartnerProductConversion.QUALIFIED_STATUS);
            lc.setDoNotCreateOpportunity(true);
            lcr = Database.convertLead(lc);
        Test.stopTest();
        
        System.assert(lcr.isSuccess());
        
        Lead_Products__c updateLeadProduct = [SELECT Id, Account__c FROM Lead_Products__c WHERE Id=:leadProduct.Id];
        System.assert(updateLeadProduct.Account__c == null);
    }
    
    static testMethod void convertBulkLeadProductsTest() {
        Integer count = 25;
        List<Lead_Products__c> leadProducts = new List<Lead_Products__c>();
        System.runAs(guestUser) {
            setupData();
            
            for (Integer i=0; i < count; i++) {
                Lead_Products__c iLeadProduct = new Lead_Products__c(Lead__c=testLead.Id, Approval_Status__c=PartnerProductConversion.APPROVED_STATUS);
                leadProducts.add(iLeadProduct);         
            }
            insert leadProducts;
        }
        
        Database.LeadConvertResult lcr;
        Test.startTest();
            Database.LeadConvert lc = new database.LeadConvert();
            lc.setLeadId(testLead.Id);
            lc.setOwnerId( UserInfo.getUserId() );
            lc.setConvertedStatus(PartnerProductConversion.QUALIFIED_STATUS);
            lc.setDoNotCreateOpportunity(true);
            lcr = Database.convertLead(lc);
        Test.stopTest();
        
        List<Lead_Products__c> updateLeadProducts = [SELECT Id, Account__c FROM Lead_Products__c WHERE Account__c = :lcr.getAccountId()];
        System.assertEquals(count, updateLeadProducts.size());
    }

    static void setupData() {
        testLead = new Lead(Company='test company', Terms_and_Conditions__c=true, LastName='TestLName', Business_Segment__c = 'Secure Issuance', Country='United States', State='California');
        insert testLead;
        
        leadProduct = new Lead_Products__c(Lead__c=testLead.Id);
        insert leadProduct; 
    }
}