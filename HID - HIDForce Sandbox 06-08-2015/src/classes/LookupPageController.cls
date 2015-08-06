//
// Custom controller for lookup example popup page
//
public with sharing class LookupPageController 
{
    public String query {get; set;}
    //public List<Account> accounts {get; set;}
    public List<BigMachines__Quote_Product__c> lstQuoteProduct {get; set;}
    public set<String> sSelQuote;
    
    public LookupPageController(){
        sSelQuote = new set<String>();
        string strSelQuotevalue = apexpages.currentpage().getparameters().get('selQuotevalue');
        if(strSelQuotevalue != null){
            string[] arrSelQuotevalue = strSelQuotevalue.split(',');
            for(String sq: arrSelQuotevalue){
                sSelQuote.add(sq);
            }
            
            string strSearch = apexpages.currentpage().getparameters().get('namevalue');
            if(strSearch != '' ){
                query = strSearch;
                string strSearchTemp = '%' + strSearch + '%';
                lstQuoteProduct = [select id,name, BigMachines__Product__c, BigMachines__Quantity__c, BigMachines__Quote__r.BigMachines__Opportunity__c, BigMachines__Quote__r.BigMachines__Opportunity__r.Name  from BigMachines__Quote_Product__c where Name Like: strSearchTemp and BigMachines__Quote__r.Name IN: sSelQuote Limit 10000];
            }else{
                lstQuoteProduct = [select id,name, BigMachines__Product__c, BigMachines__Quantity__c, BigMachines__Quote__r.BigMachines__Opportunity__c, BigMachines__Quote__r.BigMachines__Opportunity__r.Name  from BigMachines__Quote_Product__c where BigMachines__Quote__r.Name IN: sSelQuote Limit 1000];
            }
        }
    }
    public PageReference runQuery(){
        string strSearchTemp = '%' + query + '%';        
        lstQuoteProduct = [select id,name, BigMachines__Product__c, BigMachines__Quantity__c, BigMachines__Quote__r.BigMachines__Opportunity__c, BigMachines__Quote__r.BigMachines__Opportunity__r.Name from BigMachines__Quote_Product__c where Name Like: strSearchTemp and BigMachines__Quote__r.Name IN: sSelQuote Limit 10000];
        return null;
    }
}