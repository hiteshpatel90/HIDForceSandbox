global class updateTrainingExpiration implements Schedulable {

    global void execute(SchedulableContext ctx){
    CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :ctx.getTriggerId()];
    system.debug(ct.CronExpression);
    system.debug(ct.TimesTriggered);
    }

}