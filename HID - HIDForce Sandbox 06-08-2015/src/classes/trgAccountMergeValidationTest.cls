////////////////////////////////////////////////////////////////////
//Type                    : Test Class
//Name                    : trgAccountMergeValidationTest
//Company                 : Jade Global
//Created By              : Hitesh Patel
//Created Date            : 25/09/2014
//Last Modified By        : Hitesh Patel
//Last Modified Date      : 26/06/2015
//Description             : Test Class for trigger :- trgAccountMergeValidation
/////////////////////////////////////////////////////////////////////
@isTest
private class trgAccountMergeValidationTest{
    private static testmethod void testtrgMergeValidation() {
        Test.startTest();
        
        //Test Account Insert
        Account objacc = new account();
        objacc.Name = 'Test account';
        insert objacc;
        
        //Test Account Profile Insert
        list<Account_Profile__c> lstAccountProfile = new list<Account_Profile__c>{
            new Account_Profile__c(Account__c = objacc.Id, Business_Segment__c = 'PACS'),
            new Account_Profile__c(Account__c = objacc.Id, Business_Segment__c = 'Secure Issuance'),
            new Account_Profile__c(Account__c = objacc.Id, Business_Segment__c = 'Identity Assurance')
            
        };
        insert lstAccountProfile;
        
        //Test Tier Discount Insert
        Tier_Discount__c objTD = new Tier_Discount__c();
        objTD.Business_Segment__c = 'Secure Issuance';
        insert objTD;
        
        //Test Account Tier Discount Insert
        Account_Tier_Discount__c objATD = new Account_Tier_Discount__c();
        objATD.Account__c = objacc.id;
        objATD.Tier_Discount__c = objTD.id;
        insert objATD;
        
        //Test Contact Insert
        Contact objCon = new Contact();
        objCon.LastName = 'Test cont';
        objCon.status__c = 'Active';
        objCon.accountid = objacc.id;
        insert objCon;
        
        //Test Partner Program Insert 
        Partner_Program__c objPartnerProg = new Partner_Program__c();
        objPartnerProg.Account__c = objacc.id;
        objPartnerProg.Business_Segment__c = 'IDS';
        objPartnerProg.Use_Application__c = 'Access Control Locks';
        objPartnerProg.Primary_Contact__c = objCon.id;
        insert objPartnerProg;
        
        //Test Account Spending Insert 
        Account_Spending__c objAS = new Account_Spending__c();
        objAS.Account__c = objacc.id;
        insert objAS;
        
        //Test Account Insert
        Account objacc1 = new account();
        objacc1.Name = 'Test account';
        insert objacc1;
        
        //Test Account Profile Insert
        lstAccountProfile = new list<Account_Profile__c>{
            new Account_Profile__c(Account__c = objacc1.Id, Business_Segment__c = 'PACS'),
            new Account_Profile__c(Account__c = objacc1.Id, Business_Segment__c = 'Secure Issuance'),
            new Account_Profile__c(Account__c = objacc1.Id, Business_Segment__c = 'Identity Assurance')
            
        };
        insert lstAccountProfile;
        
        //Test Account Tier Discount Insert
        Account_Tier_Discount__c objATD1 = new Account_Tier_Discount__c();
        objATD1.Account__c = objacc1.id;
        objATD1.Tier_Discount__c = objTD.id;
        insert objATD1;
        
        //Test Partner Program Insert 
        Partner_Program__c objPartnerProg1 = new Partner_Program__c();
        objPartnerProg1.Account__c = objacc1.id;
        objPartnerProg1.Business_Segment__c = 'IDS';
        objPartnerProg1.Use_Application__c = 'Access Control Locks';
        objPartnerProg1.Primary_Contact__c = objCon.id;
        insert objPartnerProg1;
        
        //Test Account Spending Insert 
        Account_Spending__c objAS1 = new Account_Spending__c();
        objAS1.Account__c = objacc1.id;
        insert objAS1;
        
        //Delete Account
        delete objacc1;
        
        Test.stopTest();
    }
}