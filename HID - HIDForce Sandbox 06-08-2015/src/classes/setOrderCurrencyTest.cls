@isTest
private class setOrderCurrencyTest {
    static testMethod void TEST_setOrderCurrencyTest() {
        Account a = new Account(Name='New Account');
    	insert a;
    	List<Order_History__c> objOH = new List<Order_History__c>();
    	for(Integer i=0;i<200;i++){
    		Order_History__c oh = new Order_History__c(
    			Account__c = a.Id,
    			Currency__c = 'EUR'
    		);
    		objOH.add(oh);
    	}
    	insert objOH;
    	Order_History__c o = new Order_History__c(Account__c = a.Id, Currency__c = 'USD');
		insert o;
		Account a2 = [SELECT Order_Currency__c FROM Account WHERE Id = :a.Id];
		System.assertEquals(a2.Order_Currency__c, 'USD');
    }
}