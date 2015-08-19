trigger setRoleHierarchyApprovalData on Role_Hierarchy_Approval__c (before insert, before update) {
	map<Id, Role_Hierarchy_Approval__c> mapRoleHierarchyApprovals = new map<Id, Role_Hierarchy_Approval__c>();
	
	for(Role_Hierarchy_Approval__c r : trigger.new){
		if(trigger.isInsert || r.Full_Name__c != trigger.oldMap.get(r.Id).Full_Name__c){
			if(mapRoleHierarchyApprovals.containsKey(r.Full_Name__c)){
				r.Full_Name__c.addError('A Role Hierarchy Approval record for this user already exists.');
			}else{
				mapRoleHierarchyApprovals.put(r.Full_Name__c, r);
			}
		}
	}
	
	for(Role_Hierarchy_Approval__c r : [
		SELECT
			Id,
			Full_Name__c
		FROM
			Role_Hierarchy_Approval__c
		WHERE
			Full_Name__c IN: mapRoleHierarchyApprovals.keySet()
	]){
		Role_Hierarchy_Approval__c r2 = mapRoleHierarchyApprovals.get(r.Full_Name__c);
		r2.Full_Name__c.addError('A Role Hierarchy Approval record for this User already exists.');
	}
}