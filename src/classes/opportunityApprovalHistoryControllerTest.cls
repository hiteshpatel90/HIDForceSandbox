/****************************************************************************
* Type               : Apex Test Class
* Name               : opportunityApprovalHistoryControllerTest
* Created by         : Hitesh Patel
* Created Date       : 14th May 2015
* Last Modified By   : Hitesh Patel 14th May 2015
* Purpose            : This is test class of "opportunityApprovalHistoryController"                  
****************************************************************************/
@isTest

private class opportunityApprovalHistoryControllerTest{

    static testMethod void myTestMethod(){
         // Insert account record
        List<Account> lstAccounts = new List<Account>();
        lstAccounts =TestDataUtility.createAccounts(2);
        insert lstAccounts;
        
        // Insert Account Profile record         
        List<Account_Profile__c> lstAccountProfile = new List<Account_Profile__c>();
        lstAccountProfile = TestDataUtility.createAccountProfile(2, lstAccounts);
        insert lstAccountProfile;
        
        // Insert Opportunity record
        List<Opportunity> lstOpportunity = new List<Opportunity>();
        lstOpportunity = TestDataUtility.createOpportunity(2,lstAccounts);
        lstOpportunity[0].Business_Segment__c = 'Secure Issuance';
        lstOpportunity[1].Engineering_Site_Manager__c = null;
        lstOpportunity[1].Product_Marketing_Manager__c = null;
        
        Id idOpportunityRecordTypeCPO = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('IAM Opportunity').getRecordTypeId();
        lstOpportunity[1].RecordTypeId = idOpportunityRecordTypeCPO;
        insert lstOpportunity;
        
        ApexPages.CurrentPage().getParameters().put('Id', lstOpportunity[0].id);
        ApexPages.StandardController contr = new ApexPages.StandardController(lstOpportunity[0]);
        opportunityApprovalHistoryController objOppHistory = new opportunityApprovalHistoryController(contr);
        
        List<ProcessInstance> lstProcessInstance = objOppHistory.getApprovals();        
        objOppHistory.submitForApproval();
        List<opportunityApprovalHistoryController.approvalWrapper> lstApproverWrapper = objOppHistory.getApprovalHistory();
        objOppHistory.getWorkItem();
        objOppHistory.gotoApprovalPage();
        
        ApexPages.CurrentPage().getParameters().put('Id', lstOpportunity[1].id);
        objOppHistory = new opportunityApprovalHistoryController(contr);
    }
}