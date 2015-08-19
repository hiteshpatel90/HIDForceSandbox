//[Uttam : date :5 Jun 2013 - The Trigger is used for set a Role hierarchy Approver for all PAF owner]
trigger populatePAFApproversTrigger on Price_Authorization_Form__c (before insert,before update) {
    
    // The below Set is used for store a PAF Owner Id
    Set<Id> pafOwnerIds = new Set<Id>(); 
    for(integer i=0; i<Trigger.new.size(); i++){
        if((Trigger.new[i].Status__c != 'Approved' || Trigger.new[i].Status__c != 'Awaiting Approval'))
           pafOwnerIds.add(Trigger.new[i].OwnerId);
        if(Trigger.isInsert)
           pafOwnerIds.add(Trigger.new[i].OwnerId);     
        }
    
    // The below Map is used for store a Role Hierarchy Approval Object with Owner Id as Key
    Map<id, Role_Hierarchy_Approval__c> rhaMap = new Map<id, Role_Hierarchy_Approval__c>();
    for(Role_Hierarchy_Approval__c rha :[Select id, Program_management_Approver__c, L1_Approver__c,E21_Approver__c,L2_Approver__c,E21VP_Approver__c,Pricing_Approver__c, 
                                         Full_Name__c FROM Role_Hierarchy_Approval__c WHERE Full_Name__c in :pafOwnerIds]){
        rhaMap.put(rha.Full_Name__c, rha);
    }
    
    //Assigning Role Hierarchy Approver to PAF Approver level fields.
    for(Price_Authorization_Form__c paf :Trigger.new){    
        if(rhaMap.get(paf.OwnerId) != null){
            paf.L1_Approver__c=  rhaMap.get(paf.OwnerId).L1_Approver__c;
            paf.E21_Approver__c= rhaMap.get(paf.OwnerId).E21_Approver__c;
            paf.L2_Approver__c=  rhaMap.get(paf.OwnerId).L2_Approver__c;
            paf.E21VP_Approver__c=rhaMap.get(paf.OwnerId).E21VP_Approver__c;
            paf.Pricing_Approver__c=rhaMap.get(paf.OwnerId).Pricing_Approver__c;
            paf.Program_Management_Approver__c =rhaMap.get(paf.OwnerId).Program_management_Approver__c;
        }
    }
}