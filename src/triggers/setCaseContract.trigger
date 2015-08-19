trigger setCaseContract on Case (before insert, before update) {
	set<Id> setSerials = new set<Id>();
	for(Case c : trigger.new){
		setSerials.add(c.Serial_License_No_Lookup__c);
	}
	map<Id, Serial_Number_Model_Number__c> mapContracts = new map<Id, Serial_Number_Model_Number__c>([SELECT Contract__c FROM Serial_Number_Model_Number__c WHERE Id IN : setSerials]);
	for(Case c : trigger.new){
		if(c.Serial_License_No_Lookup__c != null){
			c.Contract__c = mapContracts.get(c.Serial_License_No_Lookup__c).Contract__c;
		}
	}
}