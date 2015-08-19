trigger setTrainingAccountId on Training__c (before insert, before update, after insert, after update, after delete, after undelete) {
    set<Id> setAttendees = new set<Id>();
    set<Id> setCourses = new set<Id>();

	set<Id> setUnknownAccounts = new set<Id>();
	
	for(Account a : [
		SELECT
			Id
		FROM
			Account
		WHERE
			Name LIKE '%End%User%'
			OR Name LIKe '%User%End'
	]){
		setUnknownAccounts.add(a.Id);
	}
    
    if(trigger.isDelete){
        for(Training__c t : trigger.old){
            setAttendees.add(t.Attendee__c);
            setCourses.add(t.Course_or_Module__c);
        }
    }else{
        for(Training__c t : trigger.new){
            setAttendees.add(t.Attendee__c);
            setCourses.add(t.Course_or_Module__c);
        }
    }
    
    map<Id,Contact> mapContactAccount = new map<Id,Contact>([
		SELECT
            Id,
            AccountId
        FROM
            Contact
        WHERE
            Id IN : setAttendees
    ]);
    
    //map<Id, Course__c> mapCourses = new map<Id, Course__c>([SELECT Name, Duration_Hours__c FROM Course__c WHERE Id IN : setCourses]);
    map<Id,Course__c> mapCourses = new map<Id,Course__c>([
        SELECT
            Id,
            Name
        FROM
            Course__c
        WHERE
            Id IN : setCourses
    ]);
    
    //Jade Update : Account field update with current contact's account
    if(trigger.isBefore){
        for(Training__c t : trigger.new){
        	if(setUnknownAccounts!=null && mapContactAccount!=null && setUnknownAccounts.contains(mapContactAccount.get(t.Attendee__c).AccountId)){
    			t.addError('Assigning Training to a Contact associated with an Unknown End User Account is not allowed. Pleae assign the Contact to an existing Account or create a new one first.');
    		}
            t.Account__c = mapContactAccount.get(t.Attendee__c).AccountId;
        }
    }
    /* if(trigger.isBefore){
        for(Training__c t : trigger.new){
            t.Account__c = mapContactAccount.get(t.Attendee__c).AccountId;
            if(t.Duration_Hours__c == null && trigger.isInsert){
                t.Duration_Hours__c = mapCourses.get(t.Course_or_Module__c).Duration_Hours__c;
            }
        }
    } */
    
    if(trigger.isAfter){
        set<Id> setAccounts = new set<Id>();
        
       if(trigger.isDelete){
            for(Training__c t : trigger.old){
                if(t.Course_or_Module__c != null){
                    if(
                        mapCourses.get(t.Course_or_Module__c).Name.startsWithIgnoreCase('pivCLASS Advanced Training')
                        || mapCourses.get(t.Course_or_Module__c).Name.startsWithIgnoreCase('pivCLASS PKI @ the Door Training')
                        || mapCourses.get(t.Course_or_Module__c).Name.startsWithIgnoreCase('pivCLASS Software Training')
                    ){
                        setAccounts.add(mapContactAccount.get(t.Attendee__c).AccountId);
                    }
                }
            }
        }else{
            for(Training__c t : trigger.new){
                if(t.Course_or_Module__c != null){
                    if(
                        mapCourses.get(t.Course_or_Module__c).Name.startsWithIgnoreCase('pivCLASS Advanced Training')
                        || mapCourses.get(t.Course_or_Module__c).Name.startsWithIgnoreCase('pivCLASS PKI @ the Door Training')
                        || mapCourses.get(t.Course_or_Module__c).Name.startsWithIgnoreCase('pivCLASS Software Training')
                    ){
                        setAccounts.add(mapContactAccount.get(t.Attendee__c).AccountId);
                    }
                }
            }
        }
        
        if(!setAccounts.isEmpty()){
            accountCertifications accountCertifications = new accountCertifications();
            accountCertifications.setAccountCertifications(setAccounts);
        }
    }
}