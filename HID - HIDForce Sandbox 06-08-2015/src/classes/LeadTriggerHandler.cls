public class LeadTriggerHandler {
    public void OnBeforeInsert(List<Lead> newList, List<Lead> oldList) {
        // Author : Timmus Agersea
        // Purpose: Assign Leads using the Lead Routing data
        LeadAssignment la = new LeadAssignment();
        la.AssignLeads(newList, true);
        
        //Added by Atul Sharma to add email of contact to Lead
        Set<id> AccountIds = new set<id>();
        List<Partner_Program_Category__c> partnerProgramsList = new list<Partner_Program_Category__c >();
        Map<id,id> AcountLead = new Map<id,id>();
        List<lead> leads = new List<lead>();
        for(lead ld : newList){
        	if(ld.PartnerAssignment__c != null)
        	{
	        	AccountIds.add(ld.PartnerAssignment__c);
	            AcountLead.put(ld.id, ld.PartnerAssignment__c);
        	}
        } 
        map<id, string> mpAccountemail = new map<id, string>();
       for(Partner_Program_Category__c p: [select Partner_Program__r.Account__c, Lead_Admin__r.email from Partner_Program_Category__c where Partner_Program_Category__c = 'Secure Issuance' and Partner_Program__r.account__c in :AccountIds and Partner_Program__r.recordtype.developername = 'Advantage_Partner_Program'])
       {
           mpAccountemail.put(p.Partner_Program__r.Account__c, p.Lead_Admin__r.email)    ;
       }
    
      for(lead l: newList)
      {
          if(AcountLead != null && AcountLead.get(l.id) != null && mpAccountemail != null)
          {
              l.Partner_Email__c = mpAccountemail.get(AcountLead.get(l.id));
          }
      }
    }
   
    public void OnBeforeUpdate(List<Lead> newList){
        LeadAssignment la = new LeadAssignment();
        la.AssignLeads(newList, true);
    }
}