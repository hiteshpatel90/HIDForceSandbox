trigger SetLeadApproval on Lead_Products__c (after delete, after insert, after update) {
	if (trigger.isUpdate || trigger.isInsert) {
		LeadProductServices.setLeadApproval(trigger.newMap);
	}
	else {
		LeadProductServices.setLeadApproval(trigger.oldMap);
	}
}