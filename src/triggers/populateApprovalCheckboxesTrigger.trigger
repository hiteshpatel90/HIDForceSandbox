trigger populateApprovalCheckboxesTrigger on Price_Authorization_Form__c (after insert, after update) {
   //check is PAF First Execution to avoid trigger call recursively after update
    String recordTypeId = [select id from RecordType where DeveloperName = 'vPAF' and SObjectType = 'Price_Authorization_Form__c'].id;
    if(!PopulateApprovalCheckboxesController.isPAFFirstExcecution){
        List<Price_Authorization_Form__c> pafList = new List<Price_Authorization_Form__c>();
        try{
            
            pafList = [select id,Account__c, Status__c, L1_Approver__c, Is_L1_Approval_Needed__c, E21_Approver__c, 
                   Is_E21_Approval_Needed__c, L2_Approver__c, Is_L2_Approval_Needed__c, E21VP_Approver__c, 
                   Is_E21VP_Approval_Needed__c, Pricing_Approver__c,e_21_Account__c,OwnerId from Price_Authorization_Form__c 
                   where id in :Trigger.newMap.keySet() and RecordTypeId != :recordTypeId];
            
            PopulateApprovalCheckboxesController contoller = new PopulateApprovalCheckboxesController();       
            contoller.setApprovalNeededCheckboxes(pafList);      
            PopulateApprovalCheckboxesController.isPAFFirstExcecution = TRUE;
            update pafList; 
         }
         catch(exception e){for(Price_Authorization_Form__c paf :Trigger.new){paf.addError(e.getMessage());}
         }   
    }//End of isPAFFirstExcecution Check
    
    if(!UpdatePAFERPController.isPAFERPUpdateExcecution){
    //For set ERP Update Checkbox for when all fully approved PAF record with an Oracle Customer Number unless any of the Price_Code contains 'Tyco'          
     Set<id> approvedPAFIds = new Set<id>();
     for(Price_Authorization_Form__c paf :Trigger.new){
         if(paf.Status__c == 'Approved' && paf.ERP_Update_Date__c == null){
             approvedPAFIds.add(paf.id);
         }
     }
     UpdatePAFERPController ERPUpdateContoller=new UpdatePAFERPController();
     ERPUpdateContoller.setPAFERPUpdateCheckbox(approvedPAFIds);
    }
}