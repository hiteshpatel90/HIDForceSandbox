trigger setLeadStage on Lead (before insert, before update) {
	for(Lead l : trigger.new){
		if(l.Status == 'In Progress'){
			l.Lead_Stage__c = 'In Progress';
		}else if(l.Status == 'Dead' || l.Status == 'Unqualified' || l.Status == 'Referred' || l.Status == 'Qualified'){
			l.Lead_Stage__c = 'Closed';
		}
	}
}