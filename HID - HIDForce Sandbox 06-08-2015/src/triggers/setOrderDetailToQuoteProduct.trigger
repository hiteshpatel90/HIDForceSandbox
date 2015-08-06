trigger setOrderDetailToQuoteProduct on Order_Detail__c (after insert) {
    set<Id> setOrderHistoryIds = new set<Id>();
    list<Order_Detail__c> lstOrderDetails = new list<Order_Detail__c>();
    
    String strSql = 'SELECT Id, Name, Quote_Number__c, BigMachines__Quote__r.BigMachines__Opportunity__c FROM BigMachines__Quote_Product__c WHERE ';
    for(Order_Detail__c o : trigger.new){
        if(
        	o.Quote_Number__c != null
        	&& o.Quanity__c > 0
        ){
            setOrderHistoryIds.add(o.Order_History_Number__c);
            lstOrderDetails.add(o);
            /* String strOrderedItem = o.Ordered_Item__c.replaceAll('\\\\', '\\\\\\\\');
            strSql += ' (Quote_Number__c = \'' + o.Quote_Number__c + '\' AND Name = \'' + strOrderedItem + '\') OR'; */
            String strQuoteNumber = o.Quote_Number__c;
            String strOrderedItem = o.Ordered_Item__c;
            strSql += ' (Quote_Number__c =: strQuoteNumber AND Name =: strOrderedItem) OR';
        }
    }
    strSql = strSql.substring(0, strSql.length()-3);
    // system.debug(strSql);
    list<BigMachines__Quote_Product__c> lstQuoteProducts = Database.query(strSql);
    
    set<Id> setOpportunityOrderHistoryIds = new set<Id>();
    for(Opportunity_To_Order_History__c o : [
        SELECT
            Order_History__c
        FROM
            Opportunity_To_Order_History__c
        WHERE
            Order_History__c IN :setOrderHistoryIds
    ]){
        setOpportunityOrderHistoryIds.add(o.Order_History__c);
    }
    
    list<Quote_Product_to_Order_Detail__c> lstOrderDetailsQuoteProducts = new list<Quote_Product_to_Order_Detail__c>();
    map<String, Opportunity_to_Order_History__c> mapOpportunityOrderHistory = new map<String, Opportunity_to_Order_History__c>();
    for(Order_Detail__c o : lstOrderDetails){
        for(BigMachines__Quote_Product__c q : lstQuoteProducts){
            if(
                o.Quote_Number__c == q.Quote_Number__c
                && o.Ordered_Item__c == q.Name
            ){
                Quote_Product_to_Order_Detail__c oq = new Quote_Product_to_Order_Detail__c(
                	Order_Detail__c = o.Id,
                	Quote_Product__c = q.Id
                );
                lstOrderDetailsQuoteProducts.add(oq);
                
                String strOpportunityOrderHistory = q.BigMachines__Quote__r.BigMachines__Opportunity__c + '_' + o.Order_History_Number__c;
                if(
                    !mapOpportunityOrderHistory.containsKey(strOpportunityOrderHistory)
                    && !setOpportunityOrderHistoryIds.contains(o.Order_History_Number__c)
                ){
                    Opportunity_to_Order_History__c oh = new Opportunity_to_Order_History__c(
                    	Opportunity__c = q.BigMachines__Quote__r.BigMachines__Opportunity__c,
                    	Order_History__c = o.Order_History_Number__c
                    );
                    mapOpportunityOrderHistory.put(strOpportunityOrderHistory, oh);
                }
            }
        }
    }
    insert lstOrderDetailsQuoteProducts;
    insert mapOpportunityOrderHistory.values();
}