@isTest
private class setCaseContractTest {
    static testMethod void setCaseContractTest() {
    	Account a = new Account(Name = 'Don Bilbo');
    	insert a;
        Contract c = new Contract(AccountId = a.Id, StartDate = date.today());
        insert c;
        Serial_Number_Model_Number__c s = new Serial_Number_Model_Number__c(Name='Don Bilbo', Contract__c = c.Id);
        insert s;
        
        test.startTest();
        
        Case ca = new Case(AccountId = a.Id, Serial_License_No_Lookup__c = s.Id);
        insert ca;
        
        test.stopTest();
        
        ca = [SELECT Contract__c FROM Case WHERE Id =: ca.Id];
        system.assertEquals(ca.Contract__c, c.Id);
    }
}