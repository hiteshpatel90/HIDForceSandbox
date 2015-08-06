public with sharing class updateLeadsReadByOwner {
	public updateLeadsReadByOwner(){
		list<Lead> lstLeads = new list<Lead>();
		
		for(Lead l : [
			SELECT
				Id,
				Status,
				IsUnreadByOwner,
				Lead_Stage__c
			FROM
				Lead
			WHERE
				Status = 'New'
				AND IsConverted = false
				AND IsDeleted = false
				AND (
					Lead_Stage__c = null
					OR (
						IsUnreadByOwner = false
						AND Lead_Stage__c = 'New'
					)
				)
			LIMIT 10000
			]
		){
			Lead ll = new Lead(Id = l.Id);
			if(l.IsUnreadByOwner){
				ll.Lead_Stage__c = 'New';
			}else{
				ll.Lead_Stage__c = 'Read';
			}
			lstLeads.add(ll);
		}
		update lstLeads;
	}
}