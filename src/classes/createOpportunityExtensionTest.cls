/****************************************************************************
* Type               : Apex Test Class
* Name               : createOpportunityExtensionTest
* Created by         : Hitesh Patel
* Created Date       : 27th May 2015
* Last Modified By   : Hitesh Patel 27th May 2015
* Purpose            : This is test class of "createOpportunityExtension"                  
****************************************************************************/
@isTest

private class createOpportunityExtensionTest{
    static testMethod void myTestMethod(){
        // Insert account record
        List<Account> lstAccounts = new List<Account>();
        lstAccounts =TestDataUtility.createAccounts(2);
        lstAccounts[0].Region__c = 'NAM';
        insert lstAccounts;
        
        // Insert Opportunity record
        List<Opportunity> lstOpportunity = new List<Opportunity>();
        lstOpportunity = TestDataUtility.createOpportunity(2,lstAccounts);
        lstOpportunity[0].Business_Segment__c = 'Secure Issuance';
        lstOpportunity[1].Engineering_Site_Manager__c = null;
        lstOpportunity[1].Product_Marketing_Manager__c = null;
        
        Id idOpportunityRecordTypeCPO = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('IAM Opportunity').getRecordTypeId();
        lstOpportunity[1].RecordTypeId = idOpportunityRecordTypeCPO;
        insert lstOpportunity;
        
        apexpages.currentPage().getParameters().put('accid', lstAccounts[0].id);
        apexpages.standardcontroller stdConOpp = new apexpages.standardcontroller(lstOpportunity[0]);
        createOpportunityExtension objcreateOppExt = new createOpportunityExtension(stdConOpp);
    }
}