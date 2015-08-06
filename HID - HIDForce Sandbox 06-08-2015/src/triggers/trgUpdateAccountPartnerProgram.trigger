////////////////////////////////////////////////////////////////////
//Type                    : Apex Trigger
//Name                    : trgUpdateAccountPartnerProgram 
//Company                 : Jade Global
//Created By              : Hitesh Patel
//Created Date            : 07/05/2014
//Last Modified By        : xyz
//Last Modified Date      : 07/05/2014
//Description             : update account field to track whenever partner program related list records are getting created or modified.
/////////////////////////////////////////////////////////////////////
trigger trgUpdateAccountPartnerProgram on Partner_Program__c (after insert, after update) {
    //Define list variable of account for update
    List<Account> lstAccountUpdate = new List<Account>();
    //Define set variable of Id to get related account record
    set<Id> sAccId = new set<Id>();
    for(Partner_Program__c pp: trigger.new){
        sAccId.add(pp.Account__c);
    }
    List<Account> lstAccount = [select id from Account where id IN: sAccId];
    for(Account acc: lstAccount){
        //set current date/time value in account field
        acc.Partner_Program_Modified_Date__c = system.now();
        lstAccountUpdate.add(acc);
    }
    //check condition for account update
    if(lstAccountUpdate.size() > 0){
        update lstAccountUpdate;
    }
}