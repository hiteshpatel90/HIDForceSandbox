@isTest
private class updateLeadsReadByOwnerTest {
    static testMethod void updateLeadsReadByOwnerTest() {
        String strMyTomorrow = String.valueOf(date.today().addDays(1)) + ' 01:00:00';

        Lead l = new Lead(FirstName = 'Don', LastName = 'Bilbo', Company = 'Don Bilbo Inc.', Status = 'New', IsUnreadByOwner = true);       
        insert l;
        
        Test.startTest();
        
        String jobId = System.schedule('Test Update Leads Read By Owner', '0 0 1 * * ?', new updateLeadsReadByOwnerSchedule());
        CronTrigger ct = [SELECT id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        
        system.assertEquals('0 0 1 * * ?', ct.CronExpression);
        system.assertEquals(0, ct.TimesTriggered);
        //system.assertEquals(strMyTomorrow, String.valueOf(ct.NextFireTime));
        
        updateLeadsReadByOwner l1 = new updateLeadsReadByOwner();
        l = [SELECT IsUnreadByOwner, Lead_Stage__c FROM Lead WHERE Id =: l.Id];
        system.assertEquals(l.Lead_Stage__c, 'New');
        
        l.IsUnreadByOwner = false;
        update l;
        
        updateLeadsReadByOwner l2 = new updateLeadsReadByOwner();
    
        l = [SELECT IsUnreadByOwner, Lead_Stage__c FROM Lead WHERE Id =: l.Id];
        
        system.assertEquals(l.Lead_Stage__c, 'Read');
        
        Test.stopTest();
    }
}