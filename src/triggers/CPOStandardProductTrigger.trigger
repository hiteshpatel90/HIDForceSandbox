trigger CPOStandardProductTrigger on CPO_Standard_Product__c (after insert,after update,after delete,after undelete) {
   
    List<CPO_Standard_Product__c> newTrigger = trigger.New;
    List<CPO_Standard_Product__c> oldTrigger = trigger.Old;
    CPOStandardProductTriggerhandler handleropptrg =new CPOStandardProductTriggerhandler();
    handleropptrg.triggerMethods(newTrigger,oldTrigger);
}