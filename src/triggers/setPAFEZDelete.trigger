trigger setPAFEZDelete on Price_Authorization_Form__c (before insert, before update) {
	set<Id> setAccounts = new set<Id>();
	for(Price_Authorization_Form__c p : trigger.new){
		if(p.EZ_EasyLobby__c == 'EZ Delete'){
			setAccounts.add(p.Account__c);
		}
	}
	
	map<Id, Account> mapAccounts = new map<Id, Account>([
		SELECT
			Id,
			EZ_EasyLobby__c
		FROM
			Account
		WHERE
			Id IN : setAccounts
	]);
	for(Price_Authorization_Form__c p : trigger.new){
		if(p.EZ_EasyLobby__c == 'EZ Delete'){
			p.EZ_EasyLobby__c = mapAccounts.get(p.Account__c).EZ_EasyLobby__c + ' Delete';
		}
	}
}