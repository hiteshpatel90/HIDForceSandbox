trigger setBigMachinesProductName on Product2 (before insert, before update) {
	for(Product2 p:trigger.new){
		p.BigMachines__Part_Number__c = p.Name;
	}
}