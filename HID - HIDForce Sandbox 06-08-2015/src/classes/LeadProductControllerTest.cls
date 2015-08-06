@isTest
private class LeadProductControllerTest {
    static Lead newLead;
    static ApexPages.StandardController sc;
    static LeadProductController controller;
    static Campaign camp;
    
    static testMethod void testConstructor()
    {
        setupData();
        
        Test.startTest();       
        System.assertEquals(1, controller.leadProductsList.size());
        Test.stopTest();
    }
    
    static testMethod void testInsertLeadOnly()
    {
        setupData();
        controller.leadRecord.LastName = 'LNAME';
        controller.leadRecord.Company = 'TEST COMPANY';
        
        Test.startTest();
        PageReference generatedPageRef = controller.insertLead();
        Test.stopTest();
        System.assertNotEquals(null, controller.leadRecord.Id);
    }
    
    static testMethod void testMultipleProducts()
    {
        setupData();
        controller.leadRecord.LastName = 'LNAME';
        controller.leadRecord.Company = 'TEST COMPANY';
        
        Lead_Products__c leadProduct = new Lead_Products__c();
        leadProduct.Model_Containing_HID_Component__c = '44 TEST';
        leadProduct.Model_of_Integrated_HID_Component__c = '34 TEST';
        leadProduct.Part_of_Integrated_HID_Component__c = '14 TEST';
        
        //add first lead product
        controller.leadProductsList.get(0).leadProduct = leadProduct;
        
        controller.handleAddMoreRequest();
        System.assertEquals(2, controller.leadProductsList.size());
        
        controller.leadProductsList.get(1).leadProduct = leadProduct.clone();
        
        PageReference generatedPageRef = controller.insertLead();
        
        System.assertEquals(2, controller.leadProductToAdd.size());
        for (Lead_Products__c newLeadProd : controller.leadProductToAdd)
            System.assertNotEquals(null, newLeadProd.Id);
    }
    
    static testMethod void testQueryParameters()
    {
        setupData();
        
        String itLang = 'it';
        String tyUrl = 'http://www.hidglobal.com/italiano/promotionsThankyou.php';
        
        PageReference leadProductsPageRef = Page.LeadProducts;
        leadProductsPageRef.getParameters().put(LeadProductController.LANG, itLang);
        leadProductsPageRef.getParameters().put(LeadProductController.CAMPAIGN_ID_KEY, camp.Id);
        leadProductsPageRef.getParameters().put(LeadProductController.THANKYOU_URL_KEY, tyUrl);
        
        Test.setCurrentPage(leadProductsPageRef);
        
        Test.startTest();
        controller = new LeadProductController(sc);
        
        System.debug(controller.campaignId);
        
        System.debug(camp);
        System.assertNotEquals(null, camp.Id);
        System.assertEquals(camp.Id, controller.campaignId);
        System.assertEquals(tyUrl, controller.thankyouUrl);
        System.assertEquals(itLang, controller.language);
        
        
        controller.leadRecord.LastName = 'LNAME';
        controller.leadRecord.Company = 'TEST COMPANY';
        
        Lead_Products__c leadProduct = new Lead_Products__c();
        leadProduct.Model_Containing_HID_Component__c = '44 TEST';
        leadProduct.Model_of_Integrated_HID_Component__c = '34 TEST';
        leadProduct.Part_of_Integrated_HID_Component__c = '14 TEST';
        
        //add first lead product
        controller.leadProductsList.get(0).leadProduct = leadProduct;
        
        PageReference generatedPageRef = controller.insertLead();
        Test.stopTest();
        
        //System.assertEquals(true, controller.leadSubmitted);
        System.assert(controller.redirectUrl != null);
        
    }
    
    static void setupData()
    {
    	Date datToday = Date.today();
        newLead = new Lead();
        sc = new ApexPages.StandardController(newLead);
        controller = new LeadProductController(sc);
        camp = new Campaign(Name='Test Camp', Type='Online Promo', Status='In Progress', Region__c='EMEA', Business_Segment__c='Corporate', StartDate = datToday, EndDate = datToday.addDays(1));
        insert camp;
    }
    
}