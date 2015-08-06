trigger setRequestedByCustomer on Lead (before insert) {
	for(Lead l: Trigger.new){
		if (l.Want_Free_Dell_iCLASS_Card__c == 'Yes'){
			l.Requested_by_Lead__c = 'Free Dell iCLASS Card';
		}
	}
}