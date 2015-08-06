trigger ConvertLeadProducts on Lead (after update) {
	LeadServices.convertLeadProducts(trigger.newMap);
}