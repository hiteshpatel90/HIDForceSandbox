@isTest
private class PartnerProgramServicesTest {
    static Lead_Products__c leadProduct;
    static Lead testLead;
    static User guestUser = PartnerProductConversion.getGuestSiteUser();
    static User sysAdminUser = [SELECT Id FROM User WHERE Profile.Name='System Administrator' AND IsActive=true LIMIT 1];
    static Account newAccount;
    static Contact newContact;
    static Partner_Program__c partnerProgram;
    
    static testMethod void createPartnerProgramTest() {
        setupData();
        
        Test.startTest();
            partnerProgram = createPartnerProgram(newAccount.Id, newContact.Id, PartnerProductConversion.genHIDRt);
            insert partnerProgram;
            System.debug(partnerProgram);
        Test.stopTest();
        
        Lead_Products__c updatedProduct = [SELECT Id, Account__c FROM Lead_Products__c WHERE Partner_Program__c=:partnerProgram.Id];
        System.assertEquals(null, updatedProduct.Account__c);
    }

    /*
    static testMethod void createPartnerProgramTestBadType() {
        setupData();
        
        Test.startTest();
            partnerProgram = createPartnerProgram(newAccount.Id, newContact.Id, PartnerProductConversion.advPrgRt);
            insert partnerProgram;
            System.debug(partnerProgram);
        Test.stopTest();
        
        List<Lead_Products__c> updatedProducts = [SELECT Id, Account__c FROM Lead_Products__c WHERE Partner_Program__c=:partnerProgram.Id];
        System.assertEquals(0, updatedProducts.size());
    }
    */
    
    static testMethod void createPartnerProgramTestNotApprovede() {
        setupData();
        
        leadProduct.Approval_Status__c = 'Pending';
        update leadProduct;
        
        Test.startTest();
            partnerProgram = createPartnerProgram(newAccount.Id, newContact.Id, PartnerProductConversion.genHIDRt);
            insert partnerProgram;
            System.debug(partnerProgram);
        Test.stopTest();
        
        List<Lead_Products__c> updatedProducts = [SELECT Id, Account__c FROM Lead_Products__c WHERE Partner_Program__c=:partnerProgram.Id];
        System.assertEquals(0, updatedProducts.size());
    }
    
    static testMethod void createMultiplePartnerPrograms() {
        setupData();
        
        List<Partner_Program__c> partnerPrograms = new List<Partner_Program__c>();      
        
        Partner_Program__c otherPartnerProgram = createPartnerProgram(newAccount.Id, newContact.Id, PartnerProductConversion.advPrgRt);
        partnerPrograms.add(otherPartnerProgram);
        
        /*
        Partner_Program__c otherPartnerProgram2 = createPartnerProgram(newAccount.Id, newContact.Id, PartnerProductConversion.ideAssRt);
        partnerPrograms.add(otherPartnerProgram2);
        */
        
        partnerProgram = createPartnerProgram(newAccount.Id, newContact.Id, PartnerProductConversion.genHIDRt);
        partnerPrograms.add(partnerProgram);
        
                
        Test.startTest();
            insert partnerPrograms;
        Test.stopTest();
        
        List<Lead_Products__c> updatedProducts = [SELECT Id, Account__c FROM Lead_Products__c WHERE Partner_Program__c IN :partnerPrograms];
        System.assertEquals(2, updatedProducts.size());
        
        /*
        List<Lead_Products__c> nonUpdatedProducts = [SELECT Id, Account__c FROM Lead_Products__c WHERE Partner_Program__c=:otherPartnerProgram2.Id];
        System.assertEquals(0, nonUpdatedProducts.size());
        */
    }

    static void setupData() {
        Id genuineHID_RT = [SELECT Id FROM RecordType WHERE SobjectType = 'Lead_Products__c' AND Name = :PartnerProductConversion.GENUINE_HID_TYPE].Id;
        Id advantage_RT = [SELECT Id FROM RecordType WHERE SobjectType = 'Lead_Products__c' AND Name = :PartnerProductConversion.ADVANTAGE_PARTNER_TYPE].Id;

        //Leads must be inserted as guest user to activate triggers
        System.runAs(guestUser) {
            testLead = new Lead(Company='test company', Terms_and_Conditions__c=true, LastName='TestLName', Country = 'United States' , State='California' );
            insert testLead;
            
            leadProduct = createLeadProduct(testLead.Id, genuineHID_RT, PartnerProductConversion.APPROVED_STATUS);
            insert leadProduct;
            
            /*Used in the multiple partner products test, note the record type is different from the above leadproduct*/
            Lead_Products__c newLeadProduct1 = createLeadProduct(testLead.Id, advantage_RT, PartnerProductConversion.APPROVED_STATUS);
            insert newLeadProduct1;
            
            Lead_Products__c newLeadProduct2 = createLeadProduct(testLead.Id, advantage_RT, 'Pending');
            insert newLeadProduct2;
        } 
        
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(testLead.Id);
        lc.setOwnerId( UserInfo.getUserId() );
        lc.setConvertedStatus(PartnerProductConversion.QUALIFIED_STATUS);
        lc.setDoNotCreateOpportunity(true);
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        
        newAccount = [SELECT Id FROM Account WHERE Id=:lcr.getAccountId()]; 
        newContact = [SELECT Id FROM Contact WHERE AccountId=:newAccount.Id];
        newContact.Status__c = 'Active';
        update newContact;  
    }
    
    static List<Partner_Program__c> createPartnerPrograms(Id accountId, Id contactId, Id recordTypeId, Integer size) {
        List<Partner_Program__c> partnerPrograms = new List<Partner_Program__c>();
        for(Integer i = 0; i < size; i++) {
            Partner_Program__c newPartnerProgram = new Partner_Program__c(RecordTypeId=recordTypeId, Primary_Contact__c=contactId, Account__c=accountId, Partner_Program_Status__c = 'Active');
            partnerPrograms.add(newPartnerProgram);
        }
        return partnerPrograms;
    }
    
    static Partner_Program__c createPartnerProgram(Id accountId, Id contactId, Id recordTypeId) {
        return createPartnerPrograms(accountId, contactId, recordTypeId, 1)[0];
    }
    
    static List<Lead_Products__c> createLeadProducts(Id leadId, Id recordTypeId, String status, Integer size) {
        List<Lead_Products__c> leadProducts = new List<Lead_Products__c>();
        for(Integer i = 0; i < size; i++) {
            Lead_Products__c newleadProduct = new Lead_Products__c(Lead__c=leadId, Approval_Status__c=status, RecordTypeId=recordTypeId);
            leadProducts.add(newleadProduct);
        }
        return leadProducts;
    }
    
    static Lead_Products__c createLeadProduct(Id leadId, Id recordTypeId, String status) {
        return createLeadProducts(leadId, recordTypeId, status, 1)[0];
    }
}