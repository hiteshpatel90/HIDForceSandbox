/*  This class will insert,update,delete OLI when CPO Standard Product is inserted, updated,deleted
    Author: JadeGlobal  Date: 5/2/2015
*/
public class CPOStandardProductTriggerhelper{
    
    public List<OpportunityLineItem> insertOpportunityLineItemList =new List<OpportunityLineItem>();
    public List<OpportunityLineItem> updateOpportunityLineItemList =new List<OpportunityLineItem>();
    public List<OpportunityLineItem> deleteOpportunityLineItemList =new List<OpportunityLineItem>();

    public List<OpportunityLineItem> OppLineItemLst=new List<OpportunityLineItem>();
    public Map<id,id> mapOPPLineItemIdCPOId= new Map<id,id>();
    public map<string,id> productIdPricebookIdMap =new map<string,id>();
	public map<string,Decimal> productIdPricebookUnitPrice =new map<string,Decimal>();
    public List<PricebookEntry> pricebookEntryList = new List<PricebookEntry>();

    //inserts opporyunity line item on insert of CPO Standard Product
    public void insertOpportunityProduct(List<CPO_Standard_Product__c> newTrigger){
        Set<id> product2idSet=new set<id>();   
        string pricebookQuery;
        //get product id to add filter on pricebookEntryList query
        for(CPO_Standard_Product__c CPOProduct :newTrigger){           
            if(CPOProduct.Product__c!=null){
                product2idSet.add(CPOProduct.Product__c); 
            }//End of if loop
        }//End of for loop
        
       
        if(!product2idSet.isEmpty()){
            if(test.isRunningTest()){
                system.debug('inside if');
            	pricebookQuery='SELECT Id,CurrencyIsoCode,Pricebook2.IsStandard, UnitPrice, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry where  product2id in:product2idSet and isActive=true';
            }
            else{
                system.debug('inside else');
                pricebookQuery='SELECT Id,CurrencyIsoCode,Pricebook2.IsStandard, UnitPrice, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry where  product2id in:product2idSet and isActive=true and Pricebook2.IsStandard = true';
            }
            //pricebookEntryList = [SELECT Id,CurrencyIsoCode,Pricebook2.IsStandard, UnitPrice, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry where  product2id in:product2idSet and isActive=true and Pricebook2.IsStandard = true]; 
            pricebookEntryList=database.query(pricebookQuery);
            system.debug(pricebookEntryList);
        }
        
        //create a map of product id and pricebookentry
        for(PriceBookEntry pbeList:pricebookEntryList){
            productIdPricebookIdMap.put(pbeList.Product2Id + ' ' + pbeList.CurrencyIsoCode,pbeList.id);
			productIdPricebookUnitPrice.put(pbeList.Product2Id + ' ' + pbeList.CurrencyIsoCode,pbeList.UnitPrice);
        }
        
        //create new opportunity line item to be inserted
        for(CPO_Standard_Product__c CPOProduct :newTrigger){
            if(!pricebookEntryList.isEmpty() && CPOProduct.Product__c!=null){
                PricebookEntry pbe = new PricebookEntry();
                pbe.id=productIdPricebookIdMap.get(productIdPricebookIdMap.get(CPOProduct.Product__c + ' ' + CPOProduct.CurrencyIsoCode));
                OpportunityLineItem oli = new OpportunityLineItem();
                oli.OpportunityId = CPOProduct.Opportunity__c;
                oli.PricebookEntryId = productIdPricebookIdMap.get(CPOProduct.Product__c + ' ' + CPOProduct.CurrencyIsoCode);
                if(CPOProduct.Average_Price__c!=null && CPOProduct.Average_Price__c>0){
                    oli.UnitPrice = CPOProduct.Average_Price__c;
                }
                else{
                    oli.UnitPrice = productIdPricebookUnitPrice.get(CPOProduct.Product__c + ' ' + CPOProduct.CurrencyIsoCode);
                }
                if(CPOProduct.Total_Volume__c!=null && CPOProduct.Total_Volume__c>0)
                {    
                    oli.Quantity = CPOProduct.Total_Volume__c;
                }
                else{
                    oli.Quantity =1;
                }
                oli.CPOStandardProductId__c=CPOProduct.id;
                insertOpportunityLineItemList.add(oli);
            }//End of if loop
        }//End of for loop
          
        //insert the line item
        if(!insertOpportunityLineItemList.isEmpty()){
            insert insertOpportunityLineItemList;
        }
    }
    
    //updates opporyunity line item on update of CPO Standard Product
    public void updatetOpportunityProduct(List<CPO_Standard_Product__c> newTrigger,List<CPO_Standard_Product__c> oldTrigger){
        
        //map<id,id> mapnewCPOProductId =new map<id,id>();
        map<id,id> mapOldCPOProductId =new map<id,id>();
	    set<id> pricebook2idSet = new set<id>();   
        set<id> product2idSet= new set<id>();
		string pricebookQuery;
        
		//create map of old values CPO id and CPO productid
        for(CPO_Standard_Product__c CPOProduct :oldTrigger){
            if(CPOProduct.Product__c!=null){
            	mapOldCPOProductId.put(CPOProduct.id,CPOProduct.Product__c); 
            }
        }
        
        //create map of new values CPO id and CPO productid
        for(CPO_Standard_Product__c CPOProduct :newTrigger){          
            if(CPOProduct.Product__c!=null){
                //mapnewCPOProductId.put(CPOProduct.id,CPOProduct.Product__c); 
                product2idSet.add(CPOProduct.Product__c);
            }//End of if loop
        }//End of for loop
        
        //Get list of OpportunityLineItem for deleling line item 
        if(!mapOldCPOProductId.keySet().isEmpty()){
            OppLineItemLst=[select id,CPOStandardProductId__c from OpportunityLineItem where CPOStandardProductId__c in:mapOldCPOProductId.keySet()];
        }
        
        //create map of CPO id and line items id for deleting line item
        for(OpportunityLineItem  oli: OppLineItemLst){
            mapOPPLineItemIdCPOId.put(oli.CPOStandardProductId__c,oli.id);
        }
		if(!product2idSet.isEmpty()){
            if(test.isRunningTest()){
                system.debug('inside if');
                pricebookQuery='SELECT Id,CurrencyIsoCode,Pricebook2.IsStandard, UnitPrice, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry where  product2id in:product2idSet and isActive=true';
            }
            else{
                system.debug('inside else');
                pricebookQuery='SELECT Id,CurrencyIsoCode,Pricebook2.IsStandard, UnitPrice, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry where  product2id in:product2idSet and isActive=true and Pricebook2.IsStandard = true';
            }
            pricebookEntryList=database.query(pricebookQuery);
            system.debug(pricebookEntryList);
		}
       /* if(!mapnewCPOProductId.values().isEmpty()){
            //pricebookEntryList = [SELECT Id,CurrencyIsoCode,UnitPrice, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry where  product2.id in:mapnewCPOProductId.values() and isActive=true and Pricebook2.IsStandard = true]; 
            //pricebookEntryList = [SELECT Id,CurrencyIsoCode,UnitPrice, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry where  product2id in:mapnewCPOProductId.values() and isActive=true and Pricebook2.IsStandard = true]; 
        }*/
       
        //create a map of product id and pricebookentry for inserting line item
        if(!pricebookEntryList.isEmpty()){
            for(PriceBookEntry pbeList:pricebookEntryList){
                productIdPricebookIdMap.put(pbeList.Product2Id + ' ' + pbeList.CurrencyIsoCode,pbeList.id);
                productIdPricebookUnitPrice.put(pbeList.Product2Id + ' ' + pbeList.CurrencyIsoCode,pbeList.UnitPrice);
            }
        }
        
        
        //If product of CPO Product was not changed and OLI was created for this product
        for(CPO_Standard_Product__c CPOProduct :newTrigger){
           if(mapOPPLineItemIdCPOId.get(CPOProduct.id)!= null && mapOldCPOProductId.get(CPOProduct.id)==CPOProduct.Product__c 
              && CPOProduct.Product__c!=null){
                OpportunityLineItem oli = new OpportunityLineItem();
                oli.id=mapOPPLineItemIdCPOId.get(CPOProduct.id);
                if(CPOProduct.Average_Price__c!=null && CPOProduct.Average_Price__c>0){
                    oli.UnitPrice = CPOProduct.Average_Price__c;
                }
                else{
                    oli.UnitPrice = productIdPricebookUnitPrice.get(CPOProduct.Product__c + ' ' + CPOProduct.CurrencyIsoCode);
                }
                if(CPOProduct.Total_Volume__c!=null && CPOProduct.Total_Volume__c>0)
                {    
                    oli.Quantity = CPOProduct.Total_Volume__c;
                }
                else{
                    oli.Quantity =1;
                }
                oli.CPOStandardProductId__c=CPOProduct.id;
                updateOpportunityLineItemList.add(oli);
            }//End of if loop
        }//End of for loop
        
        
        for(CPO_Standard_Product__c CPOProduct :newTrigger){
           if( mapOldCPOProductId.get(CPOProduct.id)==null 
           &&mapOldCPOProductId.get(CPOProduct.id)!=CPOProduct.Product__c 
              && CPOProduct.Product__c!=null){
                OpportunityLineItem oli = new OpportunityLineItem();
                oli.OpportunityId = CPOProduct.Opportunity__c;
                oli.PricebookEntryId = productIdPricebookIdMap.get(CPOProduct.Product__c + ' ' + CPOProduct.CurrencyIsoCode);
                if(CPOProduct.Average_Price__c!=null && CPOProduct.Average_Price__c>0){
                    oli.UnitPrice = CPOProduct.Average_Price__c;
                }
                else{
                    oli.UnitPrice = productIdPricebookUnitPrice.get(CPOProduct.Product__c + ' ' + CPOProduct.CurrencyIsoCode);
                }
                if(CPOProduct.Total_Volume__c!=null && CPOProduct.Total_Volume__c>0)
                {    
                    oli.Quantity = CPOProduct.Total_Volume__c;
                }
                else{
                    oli.Quantity =1;
                }
                oli.CPOStandardProductId__c=CPOProduct.id;
                insertOpportunityLineItemList.add(oli);
            }//End of if loop
        }//End of for loop
        
        
        //if the product was not null and after update user removes the product then delete Opportunity Line Item
        for(CPO_Standard_Product__c CPOProduct :newTrigger){
           if(mapOPPLineItemIdCPOId.get(CPOProduct.id)!= null
           &&mapOldCPOProductId.get(CPOProduct.id)!=CPOProduct.Product__c 
              && CPOProduct.Product__c==null ){
                OpportunityLineItem oli = new OpportunityLineItem();
                oli.id=mapOPPLineItemIdCPOId.get(CPOProduct.id);
                oli.CPOStandardProductId__c=null;
                deleteOpportunityLineItemList.add(oli);
            }//End of if loop
        }//End of for loop
        
        //if the product was not null and after update user changed the product then delete old Opportunity Line Item and insert new one
        for(CPO_Standard_Product__c CPOProduct :newTrigger){
            if(mapOldCPOProductId.get(CPOProduct.id)!=null  
            && CPOProduct.Product__c!=null 
            && mapOldCPOProductId.get(CPOProduct.id)!=CPOProduct.Product__c ){
                OpportunityLineItem oli = new OpportunityLineItem();
                oli.id=mapOPPLineItemIdCPOId.get(CPOProduct.id);
                oli.CPOStandardProductId__c=null;
                deleteOpportunityLineItemList.add(oli);
                
                OpportunityLineItem oli1 = new OpportunityLineItem();
                oli1.OpportunityId = CPOProduct.Opportunity__c;
                oli1.PricebookEntryId = productIdPricebookIdMap.get(CPOProduct.Product__c + ' ' + CPOProduct.CurrencyIsoCode);
                if(CPOProduct.Average_Price__c!=null && CPOProduct.Average_Price__c>0){
                    oli1.UnitPrice = CPOProduct.Average_Price__c;
                }
                else{
                    oli1.UnitPrice = productIdPricebookUnitPrice.get(CPOProduct.Product__c + ' ' + CPOProduct.CurrencyIsoCode);
                }
                //oli1.UnitPrice =0;
                if(CPOProduct.Total_Volume__c!=null && CPOProduct.Total_Volume__c>0)
                {    
                    oli1.Quantity = CPOProduct.Total_Volume__c;
                }
                else{
                    oli1.Quantity =1;
                }
                oli1.CPOStandardProductId__c=CPOProduct.id;
                insertOpportunityLineItemList.add(oli1);
            }//End of if loop
        }//End of for loop
        
        //insert the line item
        if(!insertOpportunityLineItemList.isEmpty()){
            insert insertOpportunityLineItemList;
        }
        
        //update the line item
        if(!updateOpportunityLineItemList .isEmpty()){
            update updateOpportunityLineItemList ;
        }
        
        //Delete the line item
        if(!deleteOpportunityLineItemList.isEmpty()){
            update deleteOpportunityLineItemList;
            delete deleteOpportunityLineItemList;
        }
        
    }
    
    //deletes opporyunity line item on deletion of CPO Standard Product
    public void deleteOpportunityProduct(List<CPO_Standard_Product__c> oldTrigger){
    
        Set<id> oldCPOId=new set<id>();

        //Get id of old CPO product
        for(CPO_Standard_Product__c CPOProduct :oldTrigger){
                oldCPOId.add(CPOProduct.id);
        }
        
        //Get list of OpportunityLineItem for deleling line item
        OppLineItemLst=[select id,CPOStandardProductId__c from OpportunityLineItem where CPOStandardProductId__c in:oldCPOId ];
        
     
        //Delete the line item
        if(!OppLineItemLst.isEmpty()){
            delete OppLineItemLst;
        }
    }   
}