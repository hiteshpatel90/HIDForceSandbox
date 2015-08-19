trigger LeadTriggers on Lead (before insert, before update) {
    // Author : Timmus Agersea
    // Purpose: Assign Leads using the Lead Routing data
	if(!utilController.bolLeadTriggers){
		utilController.bolLeadTriggers = true;

	    if (Trigger.isBefore && Trigger.isInsert)
	    {
	        LeadTriggerHandler handler = new LeadTriggerHandler();
	        handler.OnBeforeInsert(Trigger.new, Trigger.old);    
	    }
	    
	    if(Trigger.isBefore && Trigger.isUpdate)
	    {   
	        List<Lead> unassignedLeads = new List<Lead>();
	        for (Lead ld : Trigger.new){             
	            string str = (ld.Other_Role__c != null) ? ld.Other_Role__c.toLowerCase() : '';  
	            if(ld.Business_Segment__c !='Secure Issuance' || ld.Role__c == 'Partner' || ld.Role__c == 'Consultant' || (ld.Role__c == 'Other' && (str == 'partner' || str == 'consultant' ))) {
	                  
	                   ld.LeadRouting__c = null;
	                   ld.OriginalRank__c = null;
	                   ld.CurrentRank__c = null;
	                   ld.PartnerAssignment__c = null;
	                   ld.OriginalAssignmentDate__c = null;
	                   ld.CurrentAssignmentDate__c = null; 
	                   
	                   continue;
	               }
	            
	            if(ld.LeadRouting__c == null && ld.isConverted == false){
	                unassignedLeads.add(ld);   
	            }
	        }
	        LeadTriggerHandler handler = new LeadTriggerHandler();
	        handler.OnBeforeUpdate(unassignedLeads);    
	        
	        //Added by Atul Sharma to add email of contact to Lead
	       set<id> stAccountIds = new set<id>();
	        List<Partner_Program_Category__c> partnerProgramsList = new list<Partner_Program_Category__c >();
	        Map<id,id> AcountLead = new Map<id,id>();
	        List<lead> leads = new List<lead>();
	        for(lead ld : Trigger.new){
	        	if(ld.PartnerAssignment__c != null && ld.PartnerAssignment__c != trigger.oldmap.get(ld.id).PartnerAssignment__c)
	        	{
	        		stAccountIds.add(ld.PartnerAssignment__c);
	            	AcountLead.put(ld.id, ld.PartnerAssignment__c);
	        	}
	        } 
	        map<id, string> mpAccountemail = new map<id, string>();
	       for(Partner_Program_Category__c p: [select Partner_Program__r.Account__c, Lead_Admin__r.email from Partner_Program_Category__c where Partner_Program_Category__c = 'Secure Issuance' and Partner_Program__r.account__c in :stAccountIds and Partner_Program__r.recordtype.developername = 'Advantage_Partner_Program'])
	       {
	           mpAccountemail.put(p.Partner_Program__r.Account__c, p.Lead_Admin__r.email)    ;
	       }
	      for(lead l: Trigger.new)
	      {
	          if(AcountLead != null && AcountLead.get(l.id) != null && mpAccountemail != null)
	          {
	              l.Partner_Email__c = mpAccountemail.get(AcountLead.get(l.id));
	          }
	      }
	    }
	}
}