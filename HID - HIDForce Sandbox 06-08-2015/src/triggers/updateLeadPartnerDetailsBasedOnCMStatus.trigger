trigger updateLeadPartnerDetailsBasedOnCMStatus on CampaignMember (after insert, after update) {
List<Id> LeadsToUpdateIds = new List<Id>();
List<Id> LeadsToUpdateIdsForPartnerAssignments = new List<Id>();
List<Lead> LeadsToUpdateList = new List<Lead>();
List<Lead> assignLeads = new List<Lead>();
    for (CampaignMember cm : Trigger.new){ 
        if(cm.CampaignId != null && cm.LeadId != null && cm.status == 'Sent'){
            LeadsToUpdateIds.add(cm.LeadId);
        }else{
            LeadsToUpdateIdsForPartnerAssignments.add(cm.LeadId);
        }
    }
    system.debug('LeadsToUpdateIds===>'+LeadsToUpdateIds);
    List<Lead> unassignedLeads = new List<Lead>(); 
    if(LeadsToUpdateIds.isEmpty() == false){
        LeadsToUpdateList = [Select id, LeadRouting__c,Business_Segment__c, OriginalRank__c , CurrentRank__c , PartnerAssignment__c , OriginalAssignmentDate__c ,CurrentAssignmentDate__c from Lead where id in :LeadsToUpdateIds];
        //if(LeadsToUpdateList.size() > 0){
            for(Lead ld : LeadsToUpdateList){
                if(ld.Business_Segment__c == 'Secure Issuance'){
                    ld.LeadRouting__c = null;
                    ld.OriginalRank__c = null;
                    ld.CurrentRank__c = null;
                    ld.PartnerAssignment__c = null;
                    ld.OriginalAssignmentDate__c = null;
                    ld.CurrentAssignmentDate__c = null;                 
                    unassignedLeads.add(ld);
                }
            }
             
            //LeadTriggerHandler handler = new LeadTriggerHandler();
            //handler.OnBeforeUpdate(LeadsToUpdateList);  
              
            update unassignedLeads;
      }else if(LeadsToUpdateIdsForPartnerAssignments.Isempty() == false){
           
        assignLeads = [Select id, Name,LeadRouting__c,State,City,CountryCode,StateCode,Other_Role__c,Role__c,Business_Segment__c,Country, OriginalRank__c , CurrentRank__c , PartnerAssignment__c , OriginalAssignmentDate__c ,CurrentAssignmentDate__c from Lead where id in :LeadsToUpdateIdsForPartnerAssignments];
        system.debug('assignLeads===>'+assignLeads);        
        
        LeadAssignment la = new LeadAssignment();
        la.AssignLeads(assignLeads , false);
        
    }  
}