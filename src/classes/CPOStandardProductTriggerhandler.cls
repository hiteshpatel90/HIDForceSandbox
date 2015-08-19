public class CPOStandardProductTriggerhandler{

    //This method will cover all trigger events for OpportunityTrigger
    public void triggerMethods(List<CPO_Standard_Product__c> newTrigger,List<CPO_Standard_Product__c> oldTrigger){
    
    //Create instance of helper class to call its methods
    CPOStandardProductTriggerhelper helperopptrg = new CPOStandardProductTriggerhelper();
        
        if(trigger.isafter){
            if(trigger.isinsert || trigger.isundelete){
                helperopptrg.insertOpportunityProduct(newTrigger);
            }
            if(trigger.isupdate){
                helperopptrg.updatetOpportunityProduct(newTrigger,oldTrigger);
            }
            if(trigger.isdelete){
                helperopptrg.deleteOpportunityProduct(oldTrigger);
            }
            
        }
    }
}