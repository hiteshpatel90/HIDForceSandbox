////////////////////////////////////////////////////////////////////
//Type                    : Test Class
//Name                    : trgUpdateAccountPartnerProgramTest
//Company                 : Jade Global
//Created By              : Hitesh Patel
//Created Date            : 27/05/2014
//Last Modified By        : xyz
//Last Modified Date      : 07/05/2014
//Description             : Test Class for trigger :- trgUpdateAccountPartnerProgram
/////////////////////////////////////////////////////////////////////
@isTest
private class trgUpdateAccountPartnerProgramTest{
    private static testmethod void trgUpdateAccountPartnerProgram_Test() {
        Account objAcc = new Account();
        objAcc.Name = 'Test Account';        
        objAcc.BillingCountry = 'Germany';
        insert objAcc;
        
        Contact objCon = new Contact();
        objCon.LastName = 'Test Con';
        objCon.AccountId = objAcc.id;
        objCon.Status__c = 'Active';
        insert objCon;
        
        Partner_Program__c objPartnerPrg = new Partner_Program__c();
        objPartnerPrg.Account__c = objAcc.id;
        objPartnerPrg.Primary_Contact__c = objCon.id;
        insert objPartnerPrg;
    }
}