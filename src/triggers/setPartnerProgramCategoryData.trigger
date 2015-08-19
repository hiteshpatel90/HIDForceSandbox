trigger setPartnerProgramCategoryData on Partner_Program_Category__c (before insert) {

	set<Id> setPartnerPrograms = new set<Id>();
	for(Partner_Program_Category__c p : trigger.new){
		setPartnerPrograms.add(p.Partner_Program__c);
	}

	if(trigger.isInsert){
		//Check for duplicate Partner Program Categories
		for(Partner_Program_Category__c p : [
			SELECT
				Id,
				Partner_Program__c,
				Partner_Program_Category__c
			FROM
				Partner_Program_Category__c
			WHERE
				Partner_Program__c IN : setPartnerPrograms
		]){
			for(Partner_Program_Category__c t : trigger.new){
				if(
					p.Partner_Program__c == t.Partner_Program__c
					&& p.Partner_Program_Category__c == t.Partner_Program_Category__c
				){
					t.Partner_Program_Category__c.addError('A record with this Partner Program Category already exists');
					setPartnerPrograms.remove(t.Id);
				}
			}
		}
	}
}