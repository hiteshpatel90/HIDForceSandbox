@isTest
private class findProgramCodeTest {
    static void testController(Id accountId, String myType){
        findProgramCode controller = new findProgramCode();
        controller.setMyId(accountId);
        controller.setMyType(myType);
        controller.getMyId();
        controller.getMyType();
        controller.getPcode();
        controller.getPlevel();
        controller.getPurl();
    }
    static Partner_Program__c testPartnerProgram(Id accountId, Id recordTypeId, Id contactId){
        Partner_Program__c p = new Partner_Program__c(Account__c = accountId, RecordTypeId = recordTypeId, Primary_Contact__c = contactId);
        insert p;
        return [SELECT Id, Account__c, RecordTypeId, Participation_Code__c FROM Partner_Program__c WHERE ID = :p.id];
    }
    static testMethod void TEST_findProgramCode() {
        Account acct = new Account(Name='New Account', BillingCountry = 'Germany');
        insert acct;
        Contact cont = new Contact(LastName='Test', Email='Test@force.com', Status__c='Active');
        insert cont;
        Partner_Program__c p = new Partner_Program__c();
        
        testController(acct.id, 'Advantage Connect Partner - Legacy');
        
        /*
        p = testPartnerProgram(acct.Id, PartnerProductConversion.advPrCRt, cont.Id);
        System.assertEquals(p.RecordTypeId, PartnerProductConversion.advPrCRt);
        */
        testController(acct.id, 'Advantage Connect Partner - Legacy');
        
        p = testPartnerProgram(acct.Id, PartnerProductConversion.advPrgRt, cont.Id);
        System.assertEquals(p.RecordTypeId, PartnerProductConversion.advPrgRt);
        
        try{
            p = testPartnerProgram(acct.Id, PartnerProductConversion.advPrgRt, cont.Id);
            System.assertEquals(p.RecordTypeId, PartnerProductConversion.advPrgRt);
        }catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains('A program of this type already exists!') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        } 
        
        testController(acct.id, 'Advantage Partner');
        
        p = testPartnerProgram(acct.Id, PartnerProductConversion.genHIDRt, cont.Id);
        System.assertEquals(p.RecordTypeId, PartnerProductConversion.genHIDRt);
        testController(acct.id, 'Genuine HID Technology');
        
        /*
        p = testPartnerProgram(acct.Id, PartnerProductConversion.ideAssRt, cont.Id);
        System.assertEquals(p.RecordTypeId, PartnerProductConversion.ideAssRt);
        testController(acct.id, 'Identity Assurance Partner');
        */
    }
}