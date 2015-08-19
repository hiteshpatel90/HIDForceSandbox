trigger setBidDeadlineFromQuote on BigMachines__Quote__c (before insert, before update) {
   
    utilController.isQuoteTriggerExecuted = true;
    
    if(!utilController.bolSetBidDeadlineFromQuote){
        utilController.bolSetBidDeadlineFromQuote = true;
        
        map<Id,Date> mapOpportunityDate = new map<Id,Date>();
        for(BigMachines__Quote__c b : trigger.new){
            if(b.BigMachines__Is_Primary__c == true){
                mapOpportunityDate.put(b.BigMachines__Opportunity__c, b.Bid_Deadline__c);
            }
        }
        if(!mapOpportunityDate.isEmpty()){
            list<Opportunity> lstOpportunity = new list<Opportunity>();
            for(Opportunity o : [
                SELECT
                    Bid_Deadline__c
                FROM
                    Opportunity
                WHERE
                    Id IN : mapOpportunityDate.keyset()
            ]){
                o.Bid_Deadline__c = mapOpportunityDate.get(o.Id);
                lstOpportunity.add(o);
            }
            try{
                update lstOpportunity;
            }catch(Exception e){
            }
        }
        
    }
}