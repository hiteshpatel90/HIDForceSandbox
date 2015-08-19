public class helperCPOOpportunityItems {
	public void triggerMethod(List<CPO_Opportunity_Items__c> CPO){
        handlerCpoOpportunityItems hcoi=new handlerCpoOpportunityItems();
        if(trigger.isbefore){
            if(trigger.isinsert){}
            if(trigger.isupdate){}
            if(trigger.isdelete){}
        }
    
        if(trigger.isafter){
            if(trigger.isinsert){
            }
            if(trigger.isupdate){
            }
            if(trigger.isdelete){
                hcoi.deleteOLi(CPO);
            }
            if(trigger.isundelete){
            }
        }
    } 
}