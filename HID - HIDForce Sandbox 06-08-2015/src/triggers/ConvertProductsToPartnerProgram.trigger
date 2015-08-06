trigger ConvertProductsToPartnerProgram on Partner_Program__c (after delete, after insert, after update) {
	if (trigger.isUpdate || trigger.isInsert) {
		PartnerProgramServices.convertProductsToPartnerProgramProducts(trigger.newMap);
	}
}