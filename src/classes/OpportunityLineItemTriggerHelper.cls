public class OpportunityLineItemTriggerHelper {
    public void triggerMethod(List<OpportunityLineItem> newOppLineItem,List<OpportunityLineItem> oldOppLineItem){
        OpportunityLineItemTriggerHandler oLIHandler = new OpportunityLineItemTriggerHandler();    
        if(trigger.isafter){
            if(trigger.isinsert || trigger.isupdate){
                oLIHandler.UpdateProdMarketingandEnggSitemgr(newOppLineItem);
            }
            
            if(trigger.isdelete){
                oLIHandler.deleteCPOStandardProduct(oldOppLineItem);
            }
        }
    }
}