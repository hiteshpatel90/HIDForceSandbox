trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert,after update,after delete) {
    if(!utilController.isQuoteTriggerExecuted){
        List<OpportunityLineItem> newOppLineItem=trigger.new;
        List<OpportunityLineItem> oldOppLineItem=trigger.old;
        OpportunityLineItemTriggerHelper oLIHelper = new OpportunityLineItemTriggerHelper();
        oLIHelper.triggerMethod(newOppLineItem,oldOppLineItem);
    }
}