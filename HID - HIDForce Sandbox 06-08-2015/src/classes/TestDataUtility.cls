/*  Test Data for testing trigger and controller related to CPO Standard Product object
    Author: JadeGlobal  Date: 24/2/2015
*/
public class TestDataUtility{
    
    // User creation
    public static User createUser(){
        /* Get any profile for the given type.*/
      
        Profile p = [select id from profile where Name = 'HID Sales Manager - IAM'];        
        String testemail = 'puser000@example.com';
        User objUser = new User(profileId = p.id, username = testemail, email = testemail, 
                           emailencodingkey = 'UTF-8', localesidkey = 'en_US', 
                           languagelocalekey = 'en_US', timezonesidkey = 'America/Los_Angeles', 
                           alias='cspu', lastname='lastname');     
        return objUser;
    }       
    //Account creation
    public static List<Account> createAccounts( Integer numberOfAccounts) {
        List<Account> lstAccounts = new List<Account>();
        for ( Integer i = 0 ; i < numberOfAccounts ; i++ ) {
             
            Account newAccount = new Account( Name = 'Account' + Math.random());
            lstAccounts.add(newAccount);
        }
        return lstAccounts; 
    }
    
    public static List<Opportunity> createOpportunity( Integer numberOfOpportunityPerAccount ,List<account> acctList) {
        Id idOpportunityRecordTypeCPO = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('CPO Opportunity').getRecordTypeId();
        List<Opportunity> lstOpportunity = new List<Opportunity>();
        for(Integer j=0;j<numberOfOpportunityPerAccount;j++){
            //for ( Integer i = 0 ; i < numberOfOpportunityPerAccount ; i++ ) {
                Opportunity newOpportunity = new Opportunity( Name='Test Opportunity',AccountId=acctList[j].id, Region__c='EMEA', Opportunity_Type__c='Custom Product Opportunity (CPO)', ForecastCategoryName='Omitted', Commitment_Level__c='Non-Committed', Business_Segment__c='eGovernment', StageName='Discovery',CloseDate=Date.today(), RecordTypeId = idOpportunityRecordTypeCPO,
                            Product_Marketing_Manager__c = system.userinfo.getuserid(),
                            Engineering_Site_Manager__c = system.userinfo.getuserid(),
                            Project_Manager__c = system.userinfo.getuserid()                            
                           
                            );
                lstOpportunity.add(newOpportunity);
            //}
        }
        return lstOpportunity; 
    }
    
    public static List<Product2> createproducts( Integer numberOfproduct ) {
        List<Product2> lstProduct2 = new List<Product2>();
        for ( Integer i = 0 ; i < numberOfproduct ; i++ ) {
            Product2 newProduct2 = new Product2( Name='Test Product Entry '+ Math.random(),Description='Test Product Entry ',isactive=true, Product_Line__c = 'Glass Tubes');
            lstProduct2.add(newProduct2);
        }
        return lstProduct2; 
    }
    
    // Insert PricebookEntry record   
    public static List<PriceBookEntry> createPriceBookEntry( Integer numberOfPriceBookEntry , List<Product2> lstProduct2) {
        List<PriceBookEntry> lstPriceBookEntry = new List<PriceBookEntry>();
        for ( Integer i = 0 ; i < numberOfPriceBookEntry ; i++ ) {
            PriceBookEntry newPriceBookEntry = new PriceBookEntry(UnitPrice = 100,Product2Id = lstProduct2[i].Id,Pricebook2Id = Test.getStandardPricebookId(),IsActive = true);
            lstPriceBookEntry.add(newPriceBookEntry);
        }
        return lstPriceBookEntry; 
    }
    
    public static List<Product_Team__c> createProducTeam( Integer numberOfProducTeam ) {
        List<Product_Team__c> lstProducTeam = new List<Product_Team__c>();
        for ( Integer i = 0 ; i < numberOfProducTeam ; i++ ) {
            Product_Team__c newProducTeam = new Product_Team__c(Business_Segment__c = 'eGovernment',Product_Line__c = 'Glass Tubes',Engineering_Site_Manager__c = system.userinfo.getuserid(),Product_Marketing_Manager__c = system.userinfo.getuserid(), Business_Segment_Leader__c = system.userinfo.getuserid(), Regional_Segment_Director__c = system.userinfo.getuserid());
            lstProducTeam.add(newProducTeam);
        }
        return lstProducTeam; 
    }
    
    public static List<Account_Profile__c> createAccountProfile(Integer numberOfProducTeam, List<Account> acctList) {
        List<Account_Profile__c> lstAccountProfile = new List<Account_Profile__c>();
        for ( Integer i = 0 ; i < numberOfProducTeam ; i++ ) {
            Account_Profile__c newAccountProfile = new Account_Profile__c(Business_Segment__c = 'eGovernment', Account__c = acctList[i].id);
            lstAccountProfile.add(newAccountProfile);
        }
        return lstAccountProfile; 
    }
    
    public static List<OpportunityLineItem > createOpportunityLineItem( Integer numberOfOpportunityLineItem ,List<Opportunity> lstOpportunity,List<PriceBookEntry> lstPriceBookEntry ) {
        List<OpportunityLineItem > lstOpportunityLineItem  = new List<OpportunityLineItem >();
        for ( Integer i = 0 ; i < numberOfOpportunityLineItem  ; i++ ) {
            OpportunityLineItem  newOpportunityLineItem  = new OpportunityLineItem (OpportunityID=lstOpportunity[0].id,PriceBookEntryID=lstPriceBookEntry[0].id,quantity=4,totalprice=200 );
            lstOpportunityLineItem .add(newOpportunityLineItem );
        }
        return lstOpportunityLineItem ; 
    }
    
    
    public static List<CPO_Standard_Product__c> createCPOStandardProduct( Integer numberOfCPOStandardProduct , List<Opportunity> lstOpportunity, List<Product2> lstProduct2) {
        List<CPO_Standard_Product__c> lstCPOStandardProduct = new List<CPO_Standard_Product__c>();
        for ( Integer i = 0 ; i < numberOfCPOStandardProduct ; i++ ) {
            CPO_Standard_Product__c newCPOStandardProduct = new CPO_Standard_Product__c(Opportunity__c=lstOpportunity[0].id,Product__c=lstProduct2[0].id,Y1Q1_Price__c=1,Y1Q1_Volume__c=1,Y1Q2_Price__c=1,Y1Q2_Volume__c=1,Y1Q3_Price__c=1,Y1Q3_Volume__c=1,Y1Q4_Price__c=1,Y1Q4_Volume__c=1,Year2_Price__c=1,Year2_Volume__c=1,Year3_Price__c=1,Year3_Volume__c=1);
            lstCPOStandardProduct.add(newCPOStandardProduct);
        }
        return lstCPOStandardProduct; 
    }
    
    public static List<CPO_Opportunity_Items__c> createCPOOpportunityItems( Integer numberOfCPOOpportunityItems , List<CPO_Standard_Product__c> lstCPOStandardProduct) {
        List<CPO_Opportunity_Items__c> lstCPOOpportunityItems = new List<CPO_Opportunity_Items__c>();
        for ( Integer i = 0 ; i < numberOfCPOOpportunityItems ; i++ ) {
            CPO_Opportunity_Items__c newCPOOpportunityItems = new CPO_Opportunity_Items__c(CPO_Standard_Product__c=lstCPOStandardProduct[i].id);
            lstCPOOpportunityItems.add(newCPOOpportunityItems);
        }
        return lstCPOOpportunityItems; 
    }
}