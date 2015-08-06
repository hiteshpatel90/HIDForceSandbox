////////////////////////////////////////////////////////////////////
//Type                    : Test Class
//Name                    : trgUpdateAccountProfileTest
//Company                 : Jade Global
//Created By              : Hitesh Patel
//Created Date            : 27/05/2014
//Last Modified By        : xyz
//Last Modified Date      : 07/05/2014
//Description             : Test Class for trigger :- trgUpdateAccountProfile
/////////////////////////////////////////////////////////////////////
@isTest
private class trgUpdateAccountProfileTest{
    private static testmethod void trgUpdateAccountProfile_Test() {
        Account objAcc = new Account();
        objAcc.Name = 'Test Account';        
        insert objAcc;
        
        Account_Profile__c objAccProfile = new Account_Profile__c();
        objAccProfile.Account__c = objAcc.id;
        insert objAccProfile;
    }
}