////////////////////////////////////////////////////////////////////
//Type                    : Apex Trigger
//Name                    : trgAccountMergeValidation
//Company                 : Jade Global
//Created By              : Hitesh Patel
//Created Date            : 25/09/2014
//Last Modified By        : 26/06/2015
//Last Modified Date      : 
//Description             : Used to validate Account merge functionality
/////////////////////////////////////////////////////////////////////
trigger trgAccountMergeValidation on Account (before delete, after delete) {
    
    if(trigger.isBefore){
        AccountTriggerhandler.accountMergeValidationDelete(trigger.oldmap);
        AccountTriggerhandler.accountBeforetrigger(trigger.oldmap.keyset());
        
    }else if(trigger.isAfter){
        
        
        List<Account> lstAccount = [select id, MasterRecordId from Account where id in: trigger.oldmap.keyset() ALL ROWS];
        set<Id> sMasterId = new set<Id>();
        for(Account acc: lstAccount){
            sMasterId.add(acc.MasterRecordId);
        }
        
        //Account Tier Discount       
        set<String> sAllexistBussSeg = new set<String>();
        List<Account_Tier_Discount__c> lstExistingATD = [select id, Tier_Discount__r.Business_Segment__c from Account_Tier_Discount__c where account__c in: sMasterId and id NOT IN: AccountTriggerhandler.sTierDiscountId];
        for(Account_Tier_Discount__c atD: lstExistingATD ){
            sAllexistBussSeg.add(atD.Tier_Discount__r.Business_Segment__c);
        }
        
        List<Account_Tier_Discount__c> lstAccTD = new List<Account_Tier_Discount__c>();
        List<Account_Tier_Discount__c> lstExistingATDNew = [select id, Tier_Discount__r.Business_Segment__c from Account_Tier_Discount__c where id in: AccountTriggerhandler.sTierDiscountId];
        for(Account_Tier_Discount__c atD: lstExistingATDNew){
            if(sAllexistBussSeg.contains(atD.Tier_Discount__r.Business_Segment__c)){
                lstAccTD.add(atD);
            }
            
        }
        if(lstAccTD.size() > 0){
            delete lstAccTD;
        }
        
        //Account Profile 
        set<String> sAllexistBussSegAP = new set<String>();
        List<Account_Profile__c> lstAccpuntProfileExist = [select id, Business_Segment__c from Account_Profile__c where Account__c in: sMasterId and id NOT IN: AccountTriggerhandler.sAccProfileId];
        for(Account_Profile__c ap: lstAccpuntProfileExist){
            sAllexistBussSegAP.add(ap.Business_Segment__c);
        }
        
        List<Account_Profile__c> lstAccProfiledel = new List<Account_Profile__c>();
        List<Account_Profile__c> lstExistingAPNew = [select id, Business_Segment__c from Account_Profile__c where id in: AccountTriggerhandler.sAccProfileId];
        for(Account_Profile__c atD: lstExistingAPNew){
            if(sAllexistBussSegAP.contains(atD.Business_Segment__c)){
                lstAccProfiledel.add(atD);
            }            
        }
        if(lstAccProfiledel.size() > 0){
            delete lstAccProfiledel;
        }
        
        //Partner Program
        set<String> sAllexistPartProg = new set<String>();
        List<Partner_Program__c> lstAccpuntProgramExist = [select id, Recordtype.developername from Partner_Program__c where Account__c in: sMasterId and id NOT IN: AccountTriggerhandler.sPartnerProgId];
        for(Partner_Program__c app: lstAccpuntProgramExist){
            sAllexistPartProg.add(app.Recordtype.developername);
        }
        
        List<Partner_Program__c> lstAccPartProgramdel = new List<Partner_Program__c>();
        List<Partner_Program__c> lstExistingPPNew = [select id, Recordtype.developername from Partner_Program__c where id in: AccountTriggerhandler.sPartnerProgId];
        for(Partner_Program__c atD: lstExistingPPNew){
            if(sAllexistPartProg.contains(atD.Recordtype.developername)){
                lstAccPartProgramdel.add(atD);
            }            
        }
        if(lstAccPartProgramdel.size() > 0){
            delete lstAccPartProgramdel;
        }
    }
}