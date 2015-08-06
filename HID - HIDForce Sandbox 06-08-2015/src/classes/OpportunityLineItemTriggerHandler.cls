public class OpportunityLineItemTriggerHandler{
    public void UpdateProdMarketingandEnggSitemgr(List<OpportunityLineItem> Opplineitem){
        
        set<String> sBusinessSegment = new set<String>();
        set<String> sProductLine = new set<String>();
        List<Opportunity> lstOpportunityUpdate = new List<Opportunity>();
        List<Product_Team__c> lstProductTeam;
        
        List<OpportunityLineItem> lstOpportunityLineItem = [select id, OpportunityId, Opportunity.Business_Segment__c, Opportunity.Business_Segment_Leader__c, Opportunity.Regional_Segment_Director__c, Opportunity.Region__c, Opportunity.Product_Marketing_Manager__c, Opportunity.Engineering_Site_Manager__c,Product2.Business_Segment__c, Product2.Product_Line__c from OpportunityLineItem where id in: trigger.new];
        for(OpportunityLineItem oLI: lstOpportunityLineItem){
            sBusinessSegment.add(oLI.Opportunity.Business_Segment__c);
            sProductLine.add(oLI.Product2.Product_Line__c);
        }
        if(!sBusinessSegment.isEmpty()){
            lstProductTeam = [select id, Business_Segment__c, Business_Segment_Leader__c, Product_Line__c, Region__c, Regional_Segment_Director__c, Product_Marketing_Manager__c, Engineering_Site_Manager__c from Product_Team__c where Business_Segment__c IN: sBusinessSegment and Product_Line__c IN: sProductLine]; 
            Map<string, ID> mapProductMarketmgr = new Map<string, ID>();
            Map<string, ID> mapengSitemgr = new Map<string, ID>();
            
            
            for(Product_Team__c pt: lstProductTeam){
                mapProductMarketmgr.Put(pt.Business_Segment__c + ' ' +pt.Product_Line__c, pt.Product_Marketing_Manager__c);
                mapengSitemgr.Put(pt.Business_Segment__c + ' ' +pt.Product_Line__c, pt.Engineering_Site_Manager__c);
                
            }
            
            set<Id> sOppExist = new set<Id>();
            for(OpportunityLineItem oli: lstOpportunityLineItem){
                if(!sOppExist.contains(oli.OpportunityId)){
                    sOppExist.add(oli.OpportunityId);
                    if(oli.Opportunity.Product_Marketing_Manager__c == null){
                        oli.Opportunity.Product_Marketing_Manager__c = mapProductMarketmgr.get(oLI.Opportunity.Business_Segment__c + ' ' + oLI.Product2.Product_Line__c);
                    }
                    if(oli.Opportunity.Engineering_Site_Manager__c == null){
                        oli.Opportunity.Engineering_Site_Manager__c = mapengSitemgr.get(oLI.Opportunity.Business_Segment__c + ' ' + oLI.Product2.Product_Line__c);
                    }
                    
                    lstOpportunityUpdate.add(oli.Opportunity);
                }
            }
            if(!lstOpportunityUpdate.isEmpty()){
                update lstOpportunityUpdate;
            }
        } 
    }
    
    public void deleteCPOStandardProduct(List<OpportunityLineItem> oldOppLineItem){
        List<CPO_Standard_Product__c> listDeleteCPOStandardProducts = new List<CPO_Standard_Product__c>();
        List<CPO_Standard_Product__c> listDeleteCPOStandardProducts1 = new List<CPO_Standard_Product__c>();
        Set<id> CPOStandardProductsId = new set<id>();
        CPO_Standard_Product__c objCPOStdProduct;
        
        for(OpportunityLineItem OLI :oldOppLineItem){
            if(OLI.CPOStandardProductId__c!=null){
                CPOStandardProductsId.add(OLI.CPOStandardProductId__c);
            }
        }
        
        listDeleteCPOStandardProducts1=[select id from CPO_Standard_Product__c where id in : CPOStandardProductsId];
        //get CPO Product to be deleted
        for(OpportunityLineItem OLI :oldOppLineItem){
            if(OLI.CPOStandardProductId__c!=null){
                objCPOStdProduct = new CPO_Standard_Product__c(id=OLI.CPOStandardProductId__c);
                listDeleteCPOStandardProducts.add(objCPOStdProduct);
            }
        }
        
        //delete CPO standard products
        if(!listDeleteCPOStandardProducts1.isEmpty()){
            delete listDeleteCPOStandardProducts1;
        }
        
    }
}