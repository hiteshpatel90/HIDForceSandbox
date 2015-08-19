@isTest
private class deleteTestLeadsSchedule_test {
	static testMethod void myUnitTest(){
		String strMyTomorrow = String.valueOf(date.today().addDays(1)) + ' 01:00:00';
		
		Lead l = new Lead(FirstName = 'Dothetriggertest', LastName = 'Test', Company = 'Testcompany');
		insert l;
		
		Test.startTest();
		
		String jobId = System.schedule('Test Delete Test Leads', '0 0 1 * * ?', new deleteTestLeadsSchedule());
		CronTrigger ct = [SELECT id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
		
		system.assertEquals('0 0 1 * * ?', ct.CronExpression);
		system.assertEquals(0, ct.TimesTriggered);
		system.assertEquals(strMyTomorrow, String.valueOf(ct.NextFireTime));
		
		Test.stopTest();
	}
}