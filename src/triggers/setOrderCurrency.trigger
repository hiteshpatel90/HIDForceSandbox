trigger setOrderCurrency on Order_History__c (after insert) {
	map<String, String> accMap = new map<String, String>();
	for(Order_History__c o: trigger.new){
		accMap.put(o.Account__c, o.Currency__c);
	}
	list<Account> objAcc = [SELECT Id, Order_Currency__c FROM Account WHERE Id IN :accMap.keySet()];
	for(Account a:objAcc){
		a.Order_Currency__c = accMap.get(a.Id);
	}
	update objAcc;
}