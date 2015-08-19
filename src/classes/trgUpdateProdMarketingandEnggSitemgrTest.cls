@isTest
private class trgUpdateProdMarketingandEnggSitemgrTest {

    static testMethod void insertOppLineItems() {
        
        // Insert account record
        Account acc = new Account(Name = 'Test Account for HID');
        insert acc;        
       
        // Insert Product2 record
        Product2 prd1 = new Product2 (Name='Test Product Entry 1',Description='Test Product Entry 1',productCode = 'FARGO_PROF DTC_FP_PHAR_DC Test', Product_Line__c = 'Glass Tubes', Business_Segment__c = 'eGovernment', isActive = true);
        insert prd1;
        
        // Insert PricebookEntry record
        PricebookEntry pbe1 = new PricebookEntry (Product2ID=prd1.id,Pricebook2ID=Test.getStandardPricebookId(),UnitPrice=50, isActive=true,UseStandardPrice=false);
        insert pbe1;
        
        // Insert Opportunity record
        Opportunity opp1 = new Opportunity (Name='Opp1',StageName='Stage 0 - Lead Handed Off',CloseDate=Date.today(),Pricebook2Id = pbe1.Pricebook2Id, AccountId = acc.id);
        insert opp1;
        
        // Insert Product Team record
        Product_Team__c objProdTeam = new Product_Team__c();
        objProdTeam.Business_Segment__c = 'eGovernment';
        objProdTeam.Product_Line__c = 'Glass Tubes';
        objProdTeam.Engineering_Site_Manager__c = system.userinfo.getuserid();
        objProdTeam.Product_Marketing_Manager__c = system.userinfo.getuserid();
        insert objProdTeam;
    
        Test.startTest();
        
        // Insert OpportunityLineItem record
        OpportunityLineItem lineItem1 = new OpportunityLineItem (OpportunityID=opp1.id,PriceBookEntryID=pbe1.id, quantity=4, totalprice=200);
        insert lineItem1;
        
        Test.stopTest(); 
    }

}