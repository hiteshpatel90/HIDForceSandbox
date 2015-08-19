trigger opportunityTrigger on Opportunity (before insert, before update, after insert, after update) {
    if(!utilController.isQuoteTriggerExecuted){
        opportunityTriggerHelper.opportunityTriggerHandle(trigger.new, trigger.oldmap);
    }
}