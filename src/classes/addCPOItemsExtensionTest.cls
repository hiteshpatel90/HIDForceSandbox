/*  Test class to cover all methods of addCPOItemsExtension class
    Author: JadeGlobal  Date: 5/2/2015
*/
@isTest
public class addCPOItemsExtensionTest{
    static testMethod void testData(){
        List<Account> insertLstAccounts = new List<Account>();
        List<Opportunity> insertLstOpportunity = new List<Opportunity>();
        List<Product2> insertLstProduct2 = new List<Product2>();
        List<PriceBookEntry> insertLstPriceBookEntry = new List<PriceBookEntry>();
        List<CPO_Standard_Product__c> insertLstCPOStandardProduct = new List<CPO_Standard_Product__c>();
        List<CPO_Opportunity_Items__c> insertLstCPOOpportunityItems = new List<CPO_Opportunity_Items__c>();
        
         // Insert account record
        insertLstAccounts = TestDataUtility.createAccounts(2);
        insert insertLstAccounts;
        
        // Insert Opportunity record       
        insertLstOpportunity = TestDataUtility.createOpportunity(2,insertLstAccounts);
        insert insertLstOpportunity;
        system.assertEquals(insertLstOpportunity[0].AccountId, insertLstAccounts[0].id);
        
        //Insert product record
        insertLstProduct2=TestDataUtility.createproducts(2);
        insert insertLstProduct2;
        
        //insert PriceBookEntry 
        insertLstPriceBookEntry = TestDataUtility.createPriceBookEntry(2,insertLstProduct2);
        insert insertLstPriceBookEntry;
        system.assertEquals(insertLstPriceBookEntry[0].Product2Id, insertLstProduct2[0].id);
        
        //insert CPO_Standard_Product__c       
        insertLstCPOStandardProduct=TestDataUtility.createCPOStandardProduct(2, insertLstOpportunity, insertLstProduct2);
        insert insertLstCPOStandardProduct;
        system.assertEquals(insertLstCPOStandardProduct[0].Opportunity__c, insertLstOpportunity[0].id);
        system.assertEquals(insertLstCPOStandardProduct[0].Product__c, insertLstProduct2[0].id);
        
        //insert CPO Custom product
        insertLstCPOOpportunityItems=TestDataUtility.createCPOOpportunityItems(2, insertLstCPOStandardProduct);
        insert insertLstCPOOpportunityItems;
        system.assertEquals(insertLstCPOOpportunityItems[0].CPO_Standard_Product__c, insertLstCPOStandardProduct[0].id);
        
        //creating class variable
        ApexPAges.StandardController sc = new ApexPages.StandardController(insertLstOpportunity[0]);
        addCPOItemsExtension ace =new addCPOItemsExtension(sc);
        
        //call all the methods of addCPOItemsExtension class
        
        ace.callonPageLoad();
        
        ace.addStandardProduct();
        
        //call addCustomProduct when standard product is saved to database
        String productId =ApexPages.currentPage().getParameters().put('stdProd',insertLstCPOStandardProduct[0].id);
        String cpoRecordIndex = ApexPages.currentPage().getParameters().put('cpoRecordIndex','2');
        ace.addCustomProduct();
        
        //call addCustomProduct when standard product is not saved to database
        String productId1 =ApexPages.currentPage().getParameters().put('stdProd','');
        String cpoRecordIndex8 = ApexPages.currentPage().getParameters().put('cpoRecordIndex','1');
        ace.addCustomProduct();
        
        //call updateStandardProduct to get description of product when standard product is saved to database
        String cpoRecordIndex1= ApexPages.currentPage().getParameters().put('cpoRecordIndex','1');
        ace.updateStandardProduct();
        
        //call updateStandardProduct to get description of product when standard product is not saved to database
        String cpoRecordIndex7= ApexPages.currentPage().getParameters().put('cpoRecordIndex','2');
        ace.updateStandardProduct();
        
        //call updateCustomProduct to calculate value of formul fields
        String cpoRecordIndex2=ApexPages.currentPage().getParameters().put('cpoRecordIndex','1');
        String cpoRecordCustIndex= ApexPages.currentPage().getParameters().put('cpoRecordCustIndex','0');
        ace.updateCustomProduct();
        
        //Method to save both standard as well as customization item
		ace.saveProducts();
        
		//call displayRowVariable when displayVal is none   
        String cpoRecordIndex3=ApexPages.currentPage().getParameters().put('cpoRecordIdIndex','1');
        String cpoRecordCustIndex1= ApexPages.currentPage().getParameters().put('displayVal','none');
        ace.displayRowVariable();
        
        //call displayRowVariable when displayVal is other than none
        String cpoRecordIndex4=ApexPages.currentPage().getParameters().put('cpoRecordIdIndex','1');
        String cpoRecordCustIndex2= ApexPages.currentPage().getParameters().put('displayVal','');
        ace.displayRowVariable();
        
        //This method will delete customiazation CPO Product
        String cpoRecordIndex5=ApexPages.currentPage().getParameters().put('cpoRecordIndex','1');
        String cpoRecordCustIndex3= ApexPages.currentPage().getParameters().put('cpoRecordCustIndex','0');
        ace.deleteCPOcustomProduct();
        
        //This method will delete standard CPO Product       
        String cpoRecordIndex6 = ApexPages.currentPage().getParameters().put('cpoRecordIndex','1');
        ace.deleteCPOStandardProduct();
        
        test.startTest();
        test.stopTest();
    }
}