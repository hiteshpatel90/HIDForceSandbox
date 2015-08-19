@isTest
private class emailCaseReminderTest {
    static testMethod void emailCaseReminderTest() {
    	Date datToday = date.today();
    	String strMyTomorrow = String.valueOf(datToday.addDays(1)) + ' 01:00:00';

    	map<String, Date> mapDate = new map<String, Date>{
			'today' => datToday,
			'add15' => datToday.addDays(-15),
			'add30' => datToday.addDays(-30),
			'add45' => datToday.addDays(-45),
			'add60' => datToday.addDays(-60)
		};

		String strQPrinterReceivingId = [SELECT QueueId FROM QueueSobject WHERE SobjectType = 'Case' AND Queue.Name = 'Q: Printer RECEIVING' LIMIT 1].QueueId;

		Contact co = new Contact(FirstName = 'Test', LastName = 'Dothetriggertest', Email = 'test@dothetriggertest.com');
		insert co;

		list<Case> lstCase = new list<Case>{
			new Case(ContactId = co.Id, RMA_Type__c = '39-Loaner Printer', RMA_Expiration_Date__c = datToday, RMA_Date_Out__c = mapDate.get('add30'), Region__c = 'NAM'),
			new Case(ContactId = co.Id, RMA_Type__c = '39-Loaner Printer', RMA_Expiration_Date__c = mapDate.get('add15'), RMA_Date_Out__c = mapDate.get('add30'), Region__c = 'NAM'),
			new Case(ContactId = co.Id, RMA_Type__c = '39-Loaner Printer', RMA_Expiration_Date__c = mapDate.get('add30'), RMA_Date_Out__c = mapDate.get('add30'), Region__c = 'NAM'),
			new Case(ContactId = co.Id, RMA_Type__c = '32-Warranty cross-ship', RMA_Expiration_Date__c = datToday, RMA_Date_Out__c = mapDate.get('add30'), Region__c = 'NAM'),
			new Case(ContactId = co.Id, RMA_Type__c = '32-Warranty cross-ship', RMA_Expiration_Date__c = mapDate.get('add30'), RMA_Date_Out__c = mapDate.get('add30'), Region__c = 'NAM'),
			new Case(ContactId = co.Id, RMA_Type__c = '50-Non-warranty repair', RMA_Expiration_Date__c = datToday, RMA_Date_Out__c = mapDate.get('add30'), Region__c = 'NAM'),
			new Case(ContactId = co.Id, RMA_Type__c = '202-Sales product evaluation', RMA_Expiration_Date__c = datToday, RMA_Date_Out__c = mapDate.get('add30'), Region__c = 'NAM'),
			new Case(ContactId = co.Id, RMA_Type__c = '202-Sales product evaluation', RMA_Expiration_Date__c = mapDate.get('add15'), RMA_Date_Out__c = mapDate.get('add30'), Region__c = 'NAM'),
			new Case(ContactId = co.Id, RMA_Type__c = '202-Sales product evaluation', RMA_Expiration_Date__c = mapDate.get('add30'), RMA_Date_Out__c = mapDate.get('add30'), Region__c = 'NAM'),
			new Case(ContactId = co.Id, RMA_Type__c = '202-Sales product evaluation', RMA_Expiration_Date__c = mapDate.get('add45'), RMA_Date_Out__c = mapDate.get('add30'), Region__c = 'NAM'),
			new Case(ContactId = co.Id, RMA_Type__c = '202-Sales product evaluation', RMA_Expiration_Date__c = datToday.addDays(10), RMA_Date_Out__c = mapDate.get('add30'), Region__c = 'NAM', OwnerId = strQPrinterReceivingId)
		};
		insert lstCase;
 		
		Test.startTest();
		
		String jobId = System.schedule('Test Email Case Reminder', '0 0 1 * * ?', new emailCaseReminderSchedule());
		CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobId];
		
		system.assertEquals('0 0 1 * * ?', ct.CronExpression);
		system.assertEquals(0, ct.TimesTriggered);
		system.assertEquals(strMyTomorrow, String.valueOf(ct.NextFireTime));
		
		emailCaseReminder e = new emailCaseReminder();
		
		Test.stopTest();
    }
}