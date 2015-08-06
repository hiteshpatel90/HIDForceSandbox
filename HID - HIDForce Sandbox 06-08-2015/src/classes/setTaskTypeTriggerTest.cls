@isTest
private class setTaskTypeTriggerTest {

    static testMethod void classes() {
		Account a = new Account(Name = 'Don Bilbo');
		insert a;
		Account u = [SELECT OwnerId FROM Account WHERE Id =: a.Id];
		Task t = new Task(WhatId = a.Id, Status = 'Completed', Subject = 'Email: Blablabla', Description = 'Additional To:\nDon Bilbo', OwnerId = u.OwnerId, ActivityDate = date.today());
		insert t;
		t = [SELECT Type FROM Task WHERE Id =: t.Id];
		system.assertEquals(t.Type, 'Email');
    }
}