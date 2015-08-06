/*  Test class to cover all methods of CPOStandardProductTriggerhelper class
    Author: JadeGlobal  Date: 5/2/2015
*/
@isTest
public class CPOStandardProductTriggerhelperTest{
    static List<CPO_Standard_Product__c> insertLstCPOStandardProduct = new List<CPO_Standard_Product__c>();
    static List<Opportunity> insertLstOpportunity = new List<Opportunity>();
    static List<Account> insertLstAccounts = new List<Account>();
    static List<Product2> insertLstProduct2 = new List<Product2>();
    static testMethod void testData(){
        
        
        
        List<PriceBookEntry> insertLstPriceBookEntry = new List<PriceBookEntry>();
        
        List<CPO_Opportunity_Items__c> insertLstCPOOpportunityItems = new List<CPO_Opportunity_Items__c>();
        
        
        // Insert account record
        insertLstAccounts = TestDataUtility.createAccounts(1);
        if(!insertLstAccounts.isEmpty()){
            insert insertLstAccounts;
        }
        
        // Insert Opportunity record       
        insertLstOpportunity = TestDataUtility.createOpportunity(1,insertLstAccounts);
        insertLstOpportunity[0].pricebook2id=Test.getStandardPricebookId();
        if(!insertLstOpportunity.isEmpty()){
            insert insertLstOpportunity;
        }
        system.assertEquals(insertLstOpportunity[0].AccountId, insertLstAccounts[0].id);
        
        //Insert product record
        insertLstProduct2=TestDataUtility.createproducts(2);
        if(!insertLstProduct2.isEmpty()){
            insert insertLstProduct2;
        }
        
        //insert PriceBookEntry 
        insertLstPriceBookEntry = TestDataUtility.createPriceBookEntry(2,insertLstProduct2);
        if(!insertLstPriceBookEntry.isEmpty()){
            insert insertLstPriceBookEntry;
        }
        system.assertEquals(insertLstPriceBookEntry[0].Product2Id, insertLstProduct2[0].id);
        List<pricebookentry> pbLIst =new List<pricebookentry>();
        //pbLIst=[select id,CurrencyIsoCode,UnitPrice,Pricebook2.IsStandard, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry];
        
        //system.debug('pbLIst'+pbLIst);
        //insert CPO Standard Product when Average_Price__c and Total_Volume__c are 0 and greater than 0   
        insertLstCPOStandardProduct=TestDataUtility.createCPOStandardProduct(200, insertLstOpportunity, insertLstProduct2);
        insertLstCPOStandardProduct[1].Y1Q1_Price__c=0;
        insertLstCPOStandardProduct[1].Y1Q1_Volume__c=0;
        insertLstCPOStandardProduct[1].Y1Q2_Price__c=0;
        insertLstCPOStandardProduct[1].Y1Q2_Volume__c=0;
        insertLstCPOStandardProduct[1].Y1Q3_Price__c=0;
        insertLstCPOStandardProduct[1].Y1Q3_Volume__c=0;
        insertLstCPOStandardProduct[1].Y1Q4_Price__c=0;
        insertLstCPOStandardProduct[1].Y1Q4_Volume__c=0;
        insertLstCPOStandardProduct[1].Year2_Price__c=0;
        insertLstCPOStandardProduct[1].Year2_Volume__c=0;
        insertLstCPOStandardProduct[1].Year3_Price__c=0;
        insertLstCPOStandardProduct[1].Year3_Volume__c=0;
        insertLstCPOStandardProduct[5].Product__c=null;
        
        //call after insert trigger with Average_Price__c and Total_Volume__c are 0 & >0 
        if(!insertLstCPOStandardProduct.isEmpty()){
            insert insertLstCPOStandardProduct;
        }
        system.assertEquals(insertLstCPOStandardProduct[0].Opportunity__c, insertLstOpportunity[0].id);
        system.assertEquals(insertLstCPOStandardProduct[0].Product__c, insertLstProduct2[0].id);   
        
        //Check if opportunity line item are inserted when CPO Standard Product is inserted
        List<OpportunityLineItem> insertedInTrigger = new List<OpportunityLineItem>();
        insertedInTrigger = [select id from OpportunityLineItem where opportunityId=:insertLstOpportunity[0].id];
        system.assertEquals(199, insertedInTrigger.size());
        system.debug('insertedInTrigger'+insertedInTrigger.size());
    
        //call Update method when product was not changed with Average_Price__c and Total_Volume__c are 0 & >0 
        //And product was removed with Average_Price__c and Total_Volume__c!= 0
        insertLstCPOStandardProduct[0].Product__c=null;
        insertLstCPOStandardProduct[2].Product__c=insertLstProduct2[1].id;
        if(!insertLstCPOStandardProduct.isEmpty()){
            update insertLstCPOStandardProduct;
        }
        system.assertEquals(insertLstCPOStandardProduct[0].Product__c, null);
        system.assertEquals(insertLstCPOStandardProduct[2].Product__c, insertLstProduct2[1].id);
        system.assertEquals(insertLstCPOStandardProduct[1].Product__c, insertLstProduct2[0].id);
       
        test.startTest();
        //call Update method when product was removed with Average_Price__c and Total_Volume__c are 0
        //product was changed from null with Average_Price__c and Total_Volume__c != 0
        insertLstCPOStandardProduct[0].Product__c=insertLstProduct2[1].id;
        insertLstCPOStandardProduct[2].Product__c=insertLstProduct2[0].id;
        insertLstCPOStandardProduct[1].Product__c=null;
        
        if(!insertLstCPOStandardProduct.isEmpty()){
            update insertLstCPOStandardProduct;
        }
        
        
        system.assertEquals(insertLstCPOStandardProduct[0].Product__c, insertLstProduct2[1].id);
        system.assertEquals(insertLstCPOStandardProduct[1].Product__c, null);
        
        //call Update method when product was changed from null with Average_Price__c and Total_Volume__c are 0 
        insertLstCPOStandardProduct[1].Product__c=insertLstProduct2[0].id;
        if(!insertLstCPOStandardProduct.isEmpty()){
            update insertLstCPOStandardProduct;
        }
        
        system.assertEquals(insertLstCPOStandardProduct[1].Product__c, insertLstProduct2[0].id);
        insertLstCPOStandardProduct[3].Product__c=null;
        insertLstCPOStandardProduct[2].Product__c=null;
        insertLstCPOStandardProduct[1].Product__c=insertLstProduct2[1].id;
        if(!insertLstCPOStandardProduct.isEmpty()){
           update insertLstCPOStandardProduct;
        }
        test.stopTest(); 
        //Call after delete trigger 
        /*if(!insertLstCPOStandardProduct.isEmpty()){
            delete insertLstCPOStandardProduct;
        }        
        
        //Check if OpportunityLineItem are deleted when CPOStandardProduct is deleted
        List<OpportunityLineItem> deletedFromTrigger = new List<OpportunityLineItem>();
        deletedFromTrigger = [select id from OpportunityLineItem where opportunityId=:insertLstOpportunity[0].id];
        system.assertEquals(0, deletedFromTrigger.size());*/
                      
    }
    
     @isTest static void testData1(){
        // Insert account record
        insertLstAccounts = TestDataUtility.createAccounts(1);
        if(!insertLstAccounts.isEmpty()){
            insert insertLstAccounts;
        }
        
        // Insert Opportunity record       
        insertLstOpportunity = TestDataUtility.createOpportunity(1,insertLstAccounts);
        insertLstOpportunity[0].pricebook2id=Test.getStandardPricebookId();
        if(!insertLstOpportunity.isEmpty()){
            insert insertLstOpportunity;
        }
        
        system.assertEquals(insertLstOpportunity[0].AccountId, insertLstAccounts[0].id);
        
        //Insert product record
        insertLstProduct2=TestDataUtility.createproducts(2);
        if(!insertLstProduct2.isEmpty()){
            insert insertLstProduct2;
        }
        
        //insert CPO Standard Product when Average_Price__c and Total_Volume__c are 0 and greater than 0   
        insertLstCPOStandardProduct=TestDataUtility.createCPOStandardProduct(200, insertLstOpportunity, insertLstProduct2);
        insertLstCPOStandardProduct[1].Y1Q1_Price__c=0;
        insertLstCPOStandardProduct[1].Y1Q1_Volume__c=0;
        insertLstCPOStandardProduct[1].Y1Q2_Price__c=0;
        insertLstCPOStandardProduct[1].Y1Q2_Volume__c=0;
        insertLstCPOStandardProduct[1].Y1Q3_Price__c=0;
        insertLstCPOStandardProduct[1].Y1Q3_Volume__c=0;
        insertLstCPOStandardProduct[1].Y1Q4_Price__c=0;
        insertLstCPOStandardProduct[1].Y1Q4_Volume__c=0;
        insertLstCPOStandardProduct[1].Year2_Price__c=0;
        insertLstCPOStandardProduct[1].Year2_Volume__c=0;
        insertLstCPOStandardProduct[1].Year3_Price__c=0;
        insertLstCPOStandardProduct[1].Year3_Volume__c=0;
        insertLstCPOStandardProduct[5].Product__c=null;
        
        //call after insert trigger with Average_Price__c and Total_Volume__c are 0 & >0 
        if(!insertLstCPOStandardProduct.isEmpty()){
            insert insertLstCPOStandardProduct;
        }
        
        if(!insertLstCPOStandardProduct.isEmpty()){
            delete insertLstCPOStandardProduct;
        }        
        
        //Check if OpportunityLineItem are deleted when CPOStandardProduct is deleted
        List<OpportunityLineItem> deletedFromTrigger = new List<OpportunityLineItem>();
        deletedFromTrigger = [select id from OpportunityLineItem where opportunityId=:insertLstOpportunity[0].id];
        system.assertEquals(0, deletedFromTrigger.size());
    
    }
}