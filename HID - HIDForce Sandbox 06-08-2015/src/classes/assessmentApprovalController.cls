public class assessmentApprovalController {
    Id recordId = ApexPages.CurrentPage().getParameters().get('id');
    private final Assessment__c objAssessment; 
    public ProcessInstanceWorkitem piw {get;set;}
    public boolean bolDelegatedUser {get;set;}
    //public string sysAdminProfId {get;set;}
    
    public assessmentApprovalController(ApexPages.StandardController s){
        piw = new ProcessInstanceWorkitem();
        objAssessment = (Assessment__c)s.getRecord();
        bolDelegatedUser = false;
    }
    
    public List<ProcessInstance> getApprovals(){
        list<ProcessInstance> approvals = [
            SELECT
                Id,
                IsDeleted,
                Status
            FROM
                ProcessInstance
            WHERE
                TargetObjectId =: recordId
            ORDER BY
                CreatedDate DESC
        ];
        return approvals;
    }
    
    public List<approvalWrapper> getApprovalHistory(){
        list<approvalWrapper> awList = new list<approvalWrapper>();
        for(ProcessInstance pi :getApprovals()){
            approvalWrapper aw = new approvalWrapper();
            aw.processInstance = pi;
            aw.approvalHistoryList = [
                SELECT
                    ActorId,
                    OriginalActorId,
                    StepStatus,
                    Comments,
                    CreatedDate
                FROM
                    ProcessInstanceStep
                WHERE
                    ProcessInstanceId =: pi.id
                ORDER BY
                    CreatedDate DESC
            ];
            awList.add(aw);
        }
        return awList;
    }
    
    public ProcessInstanceWorkitem getWorkItem(){
        set<Id> appIds = new Set<Id>();
        for(ProcessInstance pi :getApprovals()){
            appIds.add(pi.id);
        }
        list<ProcessInstanceWorkitem> piwi = [
            SELECT
                Id,
                ActorId,
                OriginalActorId,
                ProcessInstanceId,
                CreatedDate
            FROM
                ProcessInstanceWorkitem 
            WHERE
                ProcessInstanceId in :appIds
        ];
        if(piwi.size() > 0){
            piw = piwi[0];
           if(piw.ActorId != null){
                List<User> lstUser = new list<User>([
                	SELECT
                		DelegatedApproverId
                	FROM
                		User
                	WHERE
                		id =: piw.ActorId
                		AND Vacation_Start_Date__c <=: system.today()
                		AND Vacation_end_Date__c >=: system.today()
                ]);
                if(lstUser.size() > 0){
                    if(lstUser[0].DelegatedApproverId == system.userinfo.getUserID()){
                        bolDelegatedUser = true;
                    }
                }
            }
            return piwi[0];
        }else{
            return null;
        }    
    }
    
    public PageReference submitForApproval(){
        Assessment__c asmt = [
            SELECT
                Partner_Tier_Notification_Contact__c,
                L1_Approver__c,
                E21_Approver__c,
                L2_Approver__c,
                E21VP_Approver__c,
                Program_Management_Approver__c              
            FROM
                Assessment__c
            WHERE
                Id =: recordId
        ];
        if(asmt.Partner_Tier_Notification_Contact__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Warning,'Please select Partner Tier Notification Contact before Submit for Approval.'));
            PageReference pfe = Page.AssessmentApprovalError;
            return pfe;
            
        }else if(
            asmt.L1_Approver__c == null
            && asmt.E21_Approver__c == null
            && asmt.L2_Approver__c == null
            && asmt.E21VP_Approver__c == null
            && asmt.Program_Management_Approver__c == null
        ){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No entry in the approval hierarchy found. Please contact your local Business Administrator or submit an IT helpdesk ticket.'));
            PageReference pfe = Page.AssessmentApprovalError;
            return pfe;
        }else{
            try{
                Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                req.setObjectId(recordId);    
                Approval.ProcessResult result = Approval.process(req);
                pageReference pf = new PageReference('/'+recordId);
                return pf;
            }catch(exception e){    
                ApexPages.addMessages(e);
                PageReference pfe = Page.AssessmentApprovalError;
                return pfe;
            }
        }
    }
    
	public PageReference recallApprovalRequest(){
		try{
			Approval.ProcessWorkItemRequest pwr = new Approval.ProcessWorkItemRequest();
			
			list<ProcessInstance> lstProcessInstances = new list<ProcessInstance>([
				SELECT
					Id
				FROM
					ProcessInstance
				WHERE
					Status = 'Pending'
					AND TargetObjectId =: recordId
			]);
			
			list<ProcessInstanceWorkitem> lstProcessInstanceWorkitems = new list<ProcessInstanceWorkitem>([
				SELECT
					Id
				FROM
					ProcessInstanceWorkitem
				WHERE
					ProcessInstanceId =: lstProcessInstances[0].Id
			]);
			
			if(
				lstProcessInstanceWorkitems != null
				&& lstProcessInstanceWorkitems.size() > 0
			){
				pwr.setWorkItemId(lstProcessInstanceWorkitems[0].Id);
				pwr.setAction('Removed');
				Approval.ProcessResult apr = Approval.process(pwr);
			}
			PageReference p = new PageReference('/' + objAssessment.Id);
			p.setRedirect(true);
			return p;
		}catch(Exception e){
			ApexPages.AddMessages(e);
			return null;
		}
	}
	
    public class approvalWrapper{
        public ProcessInstance processInstance{get;set;}
        public List<ProcessInstanceStep> approvalHistoryList{get;set;}
        public approvalWrapper(){
            processInstance = new ProcessInstance();
            approvalHistoryList = new List<ProcessInstanceStep>();
        }
    }
}