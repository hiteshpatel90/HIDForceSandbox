////////////////////////////////////////////////////////////////////
//Type                    : Apex Class
//Name                    : AccountTriggerhandler
//Company                 : Jade Global
//Created By              : Hitesh Patel
//Created Date            : 25/09/2014
//Last Modified By        : 26/06/2015
//Last Modified Date      : 
//Description             : This is the handler class of "trgAccountMergeValidation" trigger.
/////////////////////////////////////////////////////////////////////
Public class AccountTriggerhandler{
    Public static set<Id> sTierDiscountId;
    Public static set<Id> sAccProfileId;
    Public static set<Id> sPartnerProgId;
    //Public static set<Id> sTierDiscountId;
    public static void accountBeforetrigger(set<Id> sAccId){
        List<Account> lstAccount = [select id, MasterRecordId, (select id from Partner_Programs__r), (select id from Channel_Engagements__r), (select id from Account_Spending__r), (select id, Tier_Discount__r.Business_Segment__c from Account_Tier_Discounts__r) from Account where id in: sAccId];
        set<ID> sWinningaccIds = new set<ID>();
        sTierDiscountId = new set<Id>();
        sAccProfileId = new set<Id>();
        sPartnerProgId = new set<Id>();
        set<Id> sAccSpendingId = new set<Id>();
        for(Account acc: lstAccount ){
            for(Account_Tier_Discount__c atD: acc.Account_Tier_Discounts__r){
                sTierDiscountId.add(atD.id);
            }
            for(Account_Spending__c accSpend: acc.Account_Spending__r){
                sAccSpendingId.add(accSpend.id);
            }
            for(Account_Profile__c ap: acc.Channel_Engagements__r){
                sAccProfileId.add(ap.id);
            }
            for(Partner_Program__c partProg: acc.Partner_Programs__r){
                sPartnerProgId.add(partProg.id);
            }    
        }
        
        List<Account_Spending__c> lstAccSpending = [select id from Account_Spending__c where id in: sAccSpendingId];
        if(lstAccSpending.size() > 0){
            delete lstAccSpending;
        }
    }
    
    public static void accountMergeValidationDelete(Map<Id, Account> mapAccountOld){
        for(Account acc: mapAccountOld.values()){
            
            if(acc.Oracle_Customer_Number__c != null){
                acc.addError('You cant Merge the Account if both has Oracle Customer Number. Make the Master record which has Oracle Customer Number available.');
            }
        }
    }
}