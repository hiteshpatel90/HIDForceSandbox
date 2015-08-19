trigger setQuoteProductToOrderDetail on BigMachines__Quote_Product__c (after insert) {
    String strSql = 'SELECT Id, Quote_Number__c, Ordered_Item__c, Quanity__c FROM Order_Detail__c WHERE (';
    for(BigMachines__Quote_Product__c q : trigger.new){
        // strSql += ' (Quote_Number__c = \'' + q.Quote_Number__c + '\' AND Ordered_Item__c = \'' + q.Name + '\') OR';
        String strQuoteNumber = q.Quote_Number__c;
        String strOrderedItem = q.Name;
        strSql += ' (Quote_Number__c =: strQuoteNumber AND Name =: strOrderedItem) OR';
    }
    strSql = strSql.substring(0, strSql.length()-3);
    strSql += ') AND Quote_Number__c != null AND Ordered_Item__c != null LIMIT 10000';
    // system.debug(strSql);
    list<Order_Detail__c> lstOrderDetails = Database.query(strSql);

    list<Quote_Product_to_Order_Detail__c> lstQuoteProductsOrderDetails = new list<Quote_Product_to_Order_Detail__c>();
    for(BigMachines__Quote_Product__c q : trigger.new){
        for(Order_Detail__c o : lstOrderDetails){
            if(
                q.Quote_Number__c == o.Quote_Number__c
                && q.Name == o.Ordered_Item__c
            ){
                Quote_Product_to_Order_Detail__c oq = new Quote_Product_to_Order_Detail__c(
                	Order_Detail__c = o.Id,
                	Quote_Product__c = q.Id
                );
                lstQuoteProductsOrderDetails.add(oq);
            }
        }
    }
    insert lstQuoteProductsOrderDetails;
}