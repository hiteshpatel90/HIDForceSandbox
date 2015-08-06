trigger setPartnerProgramData on Partner_Program__c (after insert, after update) {
    
    utilController uCtrl = new utilController();
    map<Id,Boolean> mapAccountsERPUpdate = new map<Id,Boolean>();
    set<Id> setInProgressEnrolledAccounts = new set<Id>();
    set<Id> setStandardPricingAccounts = new set<Id>();
    set<Id> setBrazilAccounts = new set<Id>();
    
    for(Partner_Program__c p : trigger.new){
        if(trigger.isUpdate){
            if(p.Partner_Program_Status__c != trigger.oldMap.get(p.Id).Partner_Program_Status__c){
                mapAccountsERPUpdate.put(
                    p.Account__c,
                    true
                );
            }else{
                mapAccountsERPUpdate.put(
                    p.Account__c,
                    false
                );
            }
            if(
                p.Partner_Program_Status__c == 'In Progress'
                || p.Partner_Program_Status__c == 'Enrolled'
            ){
                setInProgressEnrolledAccounts.add(p.Account__c);
            }else if(
                p.Partner_Program_Status_Modifier__c != trigger.oldMap.get(p.Id).Partner_Program_Status_Modifier__c
                && p.Partner_Program_Status_Modifier__c == 'Standard Pricing'
            ){
                setStandardPricingAccounts.add(p.Account__c);
            }
        }else if(trigger.isInsert){
            mapAccountsERPUpdate.put(
                p.Account__c,
                true
            );
            if(
                p.Partner_Program_Status__c == 'In Progress'
                || p.Partner_Program_Status__c == 'Enrolled'
            ){
                setInProgressEnrolledAccounts.add(p.Account__c);
            }else if(p.Partner_Program_Status_Modifier__c == 'Standard Pricing'){
                setStandardPricingAccounts.add(p.Account__c);
            }
        }
    }
    
    map<Id,Account> mapAccounts = uCtrl.getMapAccounts(mapAccountsERPUpdate.keySet());
    if(
        !mapAccountsERPUpdate.isEmpty()
        && !utilController.bolFirstExecution9
    ){
        utilController.bolFirstExecution9 = true;
        
        //Set Account integration update flag, exclude Brazil Accounts from vPAF creation
        list<Account> lstAccountsUpdate = new list<Account>();
        for(Account a : mapAccounts.values()){
            if(
                a.Oracle_Customer_Number__c != null
                && mapAccountsERPUpdate.get(a.Id) == true
            ){
                Account aa = new Account(
                    Id = a.Id,
                    ERP_Update__c = true
                );
                lstAccountsUpdate.add(aa);
            }
            if(a.BillingCountry == 'Brazil'){
                setBrazilAccounts.add(a.Id);
            }
        }
        update lstAccountsUpdate;
        
        setInProgressEnrolledAccounts.removeAll(setBrazilAccounts);
        setStandardPricingAccounts.removeAll(setBrazilAccounts);
    }

    // Add vPAFs for new Partner Program Accounts with approved Assessments 
    if(
        !setInProgressEnrolledAccounts.isEmpty()
        && !utilController.bolFirstExecution10
    ){
        utilController.bolFirstExecution10 = true;
        uCtrl.createProfilevPAFs(setInProgressEnrolledAccounts, null, null);
    }
    
    if(
        !setStandardPricingAccounts.isEmpty()
        && !utilController.bolFirstExecution7
    ){
        utilController.bolFirstExecution7 = true;
        uCtrl.createProfilevPAFs(setStandardPricingAccounts, 'Standard Pricing', null);
    }
}