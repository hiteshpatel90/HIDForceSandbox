trigger setContactTrainingAccountCertifications on Contact (after delete, after undelete, after update) {
	set<Id> setAccounts = new set<Id>();
	
	if(trigger.isDelete){
		for(Contact c : trigger.old){
			setAccounts.add(c.AccountId);
		}
	}else{
		for(Contact c : trigger.new){
			setAccounts.add(c.AccountId);
		}
	}
	
	if(trigger.isUpdate){
		map<Id,Id> mapContacts = new map<Id,Id>();
		set<Id> setOldAccounts = new set<Id>();
		
		for(Contact c : trigger.new){
			Id oldAccountId = trigger.oldMap.get(c.Id).AccountId;
			Id newAccountId = trigger.newMap.get(c.Id).AccountId;
			
			if(oldAccountId != newAccountId){
				mapContacts.put(c.Id,c.AccountId);
				setOldAccounts.add(oldAccountId);
			}
		}
		
		if(!mapContacts.isEmpty()){
			list<Training__c> lstTrainings = new list<Training__c>([
				SELECT
					Id,
					Attendee__c,
					Account__c
				FROM
					Training__c
				WHERE
					Attendee__c IN : mapContacts.keySet()
			]);
			Integer i = 0;
		
			for(Training__c t : lstTrainings){
				lstTrainings[i].Account__c = mapContacts.get(t.Attendee__c);
			}
			
			update lstTrainings;
		}
		if(!setOldAccounts.isEmpty()){
			accountCertifications accountCertifications = new accountCertifications();
			accountCertifications.setAccountCertifications(setOldAccounts);
		}
	}
	
	if(!setAccounts.isEmpty()){
		accountCertifications accountCertifications = new accountCertifications();
		accountCertifications.setAccountCertifications(setAccounts);
	}
}