trigger trigUpdateProdMarketingandEnggSitemgr on CPO_Opportunity_Items__c (before insert,before update,before delete,after insert,after update,after delete,after undelete) 
{
List<CPO_Opportunity_Items__c> CPO=trigger.new;
helperUpdateProdMarketingandEnggSitemgr hupme = new helperUpdateProdMarketingandEnggSitemgr();
hupme.triggerMethod(CPO);
}