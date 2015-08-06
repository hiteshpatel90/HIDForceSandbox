trigger setOpportunityData on Opportunity (before insert, before update) {
    private final set<String> setExceptionProfiles = new set<String>{
        'HID Business Administrator',
        'System Administrator',
        'HID Integration User'
    };
    
    if(!utilController.isQuoteTriggerExecuted && !utilController.isSetOppDataTriggerExecuted ){
        utilController.isSetOppDataTriggerExecuted = true;
        utilController uCtrl = new utilController();
        Id idOpportunityRecordTypeIAM = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('IAM Opportunity').getRecordTypeId();
    
        String u = UserInfo.getProfileId();
        String strUserProfileName = [
            SELECT
                Name
            FROM
                Profile
            WHERE
                Id =: u
        ].Name;
    
        map<Id,String> mapOpportunityAccounts = new map<Id,String>();
        for(Opportunity o : trigger.new){
            if(
                o.Business_Segment__c != 'Connect'
                && o.RecordTypeId == idOpportunityRecordTypeIAM
                && !setExceptionProfiles.contains(strUserProfileName)
            ){
                mapOpportunityAccounts.put(
                    o.AccountId,
                    o.Business_Segment__c
                );
            }
        }
        
        list<Account_Profile__c> lstProfiles = uCtrl.getLstAccountProfiles(mapOpportunityAccounts.keySet());
        map<Id,Account_Profile__c> mapOpportunityAccountProfiles = new map<Id, Account_Profile__c>();
        for(Account_Profile__c a : lstProfiles){
            if(a.Business_Segment__c == mapOpportunityAccounts.get(a.Account__c)){
                mapOpportunityAccountProfiles.put(
                    a.Account__c,
                    a
                );
            }
        }
        
        for(Opportunity o : trigger.new){
            if(
                o.Business_Segment__c != 'Connect'
                && o.RecordTypeId == idOpportunityRecordTypeIAM
                && ((trigger.isInsert && o.Created_by_Lead_Conversion__c != 'Yes') || trigger.isUpdate)
                && !setExceptionProfiles.contains(strUserProfileName)
            ){
                if(
                    mapOpportunityAccountProfiles.isEmpty()
                ){
                    o.AccountId.addError('The Account does not have a Profile for the selected Primary Opportunity Business Segment.');
                }else if(
                    o.Business_Segment__c == mapOpportunityAccountProfiles.get(o.AccountId).Business_Segment__c
                    && o.Quote_Type__c != 'Direct End User Sale'
                    && mapOpportunityAccountProfiles.get(o.AccountId).Partner_Type__c != 'End-User'
                    && mapOpportunityAccountProfiles.get(o.AccountId).Partner_Type__c != 'Prospect'
                ){
                    o.AccountId.addError('IAM Ops (ex. HID Connect): Please select an Account Name designated as an End User/Prospect under their Account Type or change the Quote Type to Direct End User Sale. If you do not know the actual end user for this opportunity, select a regional unknown end user accounts (e.g. Unknown End User - NAM).');
                }
            }
        }
    }
}