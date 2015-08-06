/*  This class will cover all methods of handlerUpdateProdMarketingandEngSitemgr
    Author: JadeGlobal  Date: 
*/


@isTest
public class OpportunityLineItemTriggerTest{
    
    static testMethod void dummyData(){
        

        
        // Insert account record
        List<Account> lstAccounts = new List<Account>();
        lstAccounts =TestDataUtility.createAccounts(2);
        insert lstAccounts;
        
        // Insert Opportunity record
        List<Opportunity> lstOpportunity = new List<Opportunity>();
        lstOpportunity =TestDataUtility.createOpportunity(2,lstAccounts);
        insert lstOpportunity ;
        
        List<Product_Team__c> lstProducTeam = new List<Product_Team__c>();
        lstProducTeam =TestDataUtility.createProducTeam(2);
        insert lstProducTeam ;
        
         // Insert Product Team record
        Product_Team__c objProdTeam = new Product_Team__c();
        objProdTeam.Business_Segment__c = 'eGovernment';
        objProdTeam.Product_Line__c = 'Glass Tubes';
        objProdTeam.Engineering_Site_Manager__c = system.userinfo.getuserid();
        objProdTeam.Product_Marketing_Manager__c = system.userinfo.getuserid();
        insert objProdTeam;
        
        // Insert Product2 record
        List<Product2> lstProduct2 = new List<Product2>();
        lstProduct2=TestDataUtility.createproducts(2);
        insert lstProduct2 ;
        
        // Insert PricebookEntry record
        List<PriceBookEntry> lstPriceBookEntry = new List<PriceBookEntry>();
        lstPriceBookEntry =TestDataUtility.createPriceBookEntry(2,lstProduct2 );
        insert lstPriceBookEntry ;
        
        //Insert CPO Standard Product
         List<CPO_Standard_Product__c> lstCPOStandardProduct = new List<CPO_Standard_Product__c>();
         lstCPOStandardProduct = TestDataUtility.createCPOStandardProduct(2,lstOpportunity,lstProduct2);
         insert lstCPOStandardProduct ;
        
        //insert OpportunityLineItem
        List<OpportunityLineItem > lstOpportunityLineItem  = new List<OpportunityLineItem >();
        lstOpportunityLineItem  =TestDataUtility.createOpportunityLineItem(200,lstOpportunity ,lstPriceBookEntry );
        for(integer i =0; i<200; i++){
        lstOpportunityLineItem[i].CPOStandardProductId__c=lstCPOStandardProduct[0].id;
        }
        test.StartTest();
        if(!lstOpportunityLineItem  .isEmpty()){
            insert lstOpportunityLineItem  ;
        }
        if(!lstOpportunityLineItem  .isEmpty()){
            delete lstOpportunityLineItem ;
        }
        test.StopTest();
     
    }
}