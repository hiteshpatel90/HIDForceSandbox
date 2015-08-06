@IsTest
public class TestSchedulable {

    public static String CRON_XP = '0 0 0 15 3 ? 2022';
    
    static testmethod void test(){
        test.startTest();
        
        String jobId = System.schedule('ScheduleApexClassTest', CRON_XP, new BatchSchedulerTrainingExp());
        
        CronTrigger ct =[SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id=:jobId];
        System.assertEquals(CRON_XP, ct.CronExpression);
         System.assertEquals(0, ct.TimesTriggered);
        System.assertEquals('2022-03-15 00:00:00', String.valueOf(ct.NextFireTime));
        test.stopTest();
    }
}