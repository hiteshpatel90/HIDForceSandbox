/****************************************************************************
* Type               : Apex Class
* Name               : opportunityApprovalHistoryController
* Created by         : Hitesh Patel
* Created Date       : 7th May 2015
* Last Modified By   : Hitesh Patel 12th May 2015
* Purpose            : This is Extension class for "opportunityApprovalHistory"
                       This controller is used to                   
****************************************************************************/
public class opportunityApprovalHistoryController{
    public string serverURL {get;set;}
    public ProcessInstanceWorkitem piw {get;set;}
    
    public boolean IsdelegatedUserId {get;set;}
    Id recordId = ApexPages.CurrentPage().getParameters().get('Id');
    public Opportunity opp {get; set;}
    public string strApprovalErrormsg {get; set;}
    
    public opportunityApprovalHistoryController(ApexPages.StandardController con){
        serverURL = System.URL.getSalesforceBaseUrl().getHost();
        piw = new ProcessInstanceWorkitem();
        
        opp = [select id, Name, owner.Skip_CPO_Sales_Approver__c, owner.CPO_Sales_Approver__c, Recordtype.DeveloperName, Regional_Segment_Director__c, Business_Segment_Leader__c, Business_Segment__c, Opportunity_Owner_Approval__c , Engineering_Site_Manager__c, Product_Marketing_Manager__c , ownerid, Owner.Name, Comments_to_Approver__c from opportunity where id =: recordId];
        IsdelegatedUserId = false;
        opp.Comments_to_Approver__c = null;
        strApprovalErrormsg = '';
        
        if(opp.Engineering_Site_Manager__c == null){
            strApprovalErrormsg = 'Engineering Site Manager assignment required. Either you have not added a CPO Product or the Product Team is not set up properly for the Product used.';
        }
        
        if(opp.Product_Marketing_Manager__c == null){
            strApprovalErrormsg = 'Product Marketing Manager assignment required. Either you have not added a CPO Product or the Product Team is not set up properly for the Product used.';   
        }
        
        User currentUser = [select id, Skip_CPO_Sales_Approver__c, CPO_Sales_Approver__c from user where id =: system.userinfo.getUserid()];
        if(currentUser.Skip_CPO_Sales_Approver__c == false && currentUser.CPO_Sales_Approver__c == null){
                                  

           strApprovalErrormsg = 'You are not CPO Sales Approver or CPO Sales Approver has not defined for you.';
            
        }
        if(opp.Business_Segment__c != 'Identity Assurance' && opp.Business_Segment__c != 'Connect' && opp.Business_Segment__c != 'PACS' && opp.Business_Segment__c != 'Secure Issuance'){
        
            strApprovalErrormsg = 'Primary Business Segment doesn\'t match.';
        }
        if(opp.Recordtype.DeveloperName != 'CPO_Opportunity'){
            strApprovalErrormsg = 'Please select CPO Opportunity record type';           
        }
        if(strApprovalErrormsg != ''){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING, strApprovalErrormsg);
            ApexPages.addMessage(myMsg);
        }
    }
    
    public List<ProcessInstance> getApprovals(){
        List<ProcessInstance> approvals = new List<ProcessInstance>();
        approvals = [select id, IsDeleted, Status, (select ActorId, IsPending, Actor.Name, OriginalActor.Name, OriginalActorId, StepStatus, Comments, CreatedDate
                          from StepsAndWorkitems order by CreatedDate desc) from ProcessInstance where TargetObjectId = :recordId order by CreatedDate desc];
        return approvals;
    }
    public string strActualApprover {get; set;}
    public string strlatestApprovedBy {get; set;}
    public string strlatestRejectedBy {get; set;}
    
    public string strRegSegDirectorApprover {get; set;}
    public string strSalesManagerApprover {get; set;}
    public string strProdMarketingApprover {get; set;}
    public string strEnggInputApprover {get; set;}
    public string strProdPostMarketingApprover {get; set;}
    public string strBusSegApprover {get; set;}
    public string strOppOwnerApprover {get; set;}
    
    public List<approvalWrapper> getApprovalHistory(){
        List<approvalWrapper> awList = new List<approvalWrapper>();
        for(ProcessInstance pi :getApprovals()){
              approvalWrapper aw = new approvalWrapper();
              aw.processInstance = pi;
              //aw.approvalHistoryList = pi.StepsAndWorkitems;
              aw.approvalHistoryList = new List<ProcessInstanceHistory>();
              Id submitterId = null;
              
              for(ProcessInstanceHistory pis :pi.StepsAndWorkitems){
                  if(pis.IsPending == true){
                      if(pis.StepStatus == 'Pending'){     
                          strActualApprover = pis.Actor.Name;
                      }
                      aw.approvalHistoryList.add(pis);
                  }
                  
              }
              
              Integer intApprovalStep = 0;
              for(integer i = pi.StepsAndWorkitems.size() - 1; i >= 0; i--){
                  if(pi.Status == 'Pending' || pi.Status == 'Approved'){ 
                                           
                      if(pi.StepsAndWorkitems[i].StepStatus == 'Approved'){ 
                          intApprovalStep += 1;
                          if(opp.owner.Skip_CPO_Sales_Approver__c == false && opp.owner.CPO_Sales_Approver__c != null){
                              if(intApprovalStep == 1){
                                  strSalesManagerApprover = pi.StepsAndWorkitems[i].Actor.Name;
                              }
                              if(opp.Regional_Segment_Director__c != null){
                                  if(intApprovalStep == 2){
                                      strRegSegDirectorApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(intApprovalStep == 3){
                                      strProdMarketingApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(intApprovalStep == 4){
                                      strEnggInputApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(intApprovalStep == 5){
                                      strProdPostMarketingApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(Opp.Business_Segment_Leader__c != null){
                                      if(intApprovalStep == 6){
                                          strBusSegApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                      if(intApprovalStep == 7){
                                          strOppOwnerApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                  }else{
                                      if(intApprovalStep == 5){
                                          strOppOwnerApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                  }
                              }else{
                                  if(intApprovalStep == 2){
                                      strProdMarketingApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(intApprovalStep == 3){
                                      strEnggInputApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(intApprovalStep == 4){
                                      strProdPostMarketingApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(Opp.Business_Segment_Leader__c != null){
                                      if(intApprovalStep == 5){
                                          strBusSegApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                      if(intApprovalStep == 6){
                                          strOppOwnerApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                  }else{
                                      if(intApprovalStep == 5){
                                          strOppOwnerApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                  }
                              }
                              
                          }else{
                              if(intApprovalStep == 1){
                                  strRegSegDirectorApprover = pi.StepsAndWorkitems[i].Actor.Name;
                              }
                              if(opp.Regional_Segment_Director__c != null){
                                  if(intApprovalStep == 2){
                                      strRegSegDirectorApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(intApprovalStep == 3){
                                      strProdMarketingApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(intApprovalStep == 4){
                                      strEnggInputApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(intApprovalStep == 5){
                                      strProdPostMarketingApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(Opp.Business_Segment_Leader__c != null){
                                      if(intApprovalStep == 6){
                                          strBusSegApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                      if(intApprovalStep == 7){
                                          strOppOwnerApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                  }else{
                                      if(intApprovalStep == 5){
                                          strOppOwnerApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                  }
                              }else{
                                  if(intApprovalStep == 2){
                                      strProdMarketingApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(intApprovalStep == 3){
                                      strEnggInputApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(intApprovalStep == 4){
                                      strProdPostMarketingApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                  }
                                  if(Opp.Business_Segment_Leader__c != null){
                                      if(intApprovalStep == 5){
                                          strBusSegApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                      if(intApprovalStep == 6){
                                          strOppOwnerApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                  }else{
                                      if(intApprovalStep == 5){
                                          strOppOwnerApprover = pi.StepsAndWorkitems[i].Actor.Name;
                                      }
                                  }
                              }
                          }
                      }
                  }
              }
              
              for(ProcessInstanceHistory pis :pi.StepsAndWorkitems){
                  system.debug('@@@@@@@@@'+pis.StepStatus);
                  if(pis.IsPending == false){
                      aw.approvalHistoryList.add(pis);
                      if(pis.StepStatus == 'Started'){
                          submitterId = pis.ActorId;
                                        
                      }else if(pi.status == 'Pending'){                      
                          if(strlatestApprovedBy == null && pis.StepStatus == 'Approved'){                     
                              strlatestApprovedBy = pis.Actor.Name;                      
                          }else if(strActualApprover == null && pis.StepStatus == 'Reassigned'){
                              strActualApprover = pis.Actor.Name;
                          }                         
                      }else if(pi.status == 'Rejected' && strlatestRejectedBy == null && pis.StepStatus == 'Rejected'){
                          strlatestRejectedBy = pis.Actor.Name;
                      }
                  }
                  
              } 
                
              if(submitterId != null)      
                  aw.submitterSalesTeam = [Select Sales_Team__c from User where id = :submitterId].Sales_Team__c;            
              awList.add(aw);
        }     
        return awList;
    }
    
    public ProcessInstanceWorkitem getWorkItem(){
        set<Id> appIds = new Set<Id>();
        List<ProcessInstanceWorkitem> piwi = new List<ProcessInstanceWorkitem>();
        for(ProcessInstance pi :getApprovals()){
            appIds.add(pi.id);
        }
        piwi = [select id, ActorId, Actor.Name, OriginalActor.Name, OriginalActorId, ProcessInstanceId, CreatedDate from ProcessInstanceWorkitem 
              where ProcessInstanceId in :appIds];
        if(piwi.size() > 0){
            piw = piwi[0];
            if(piw.ActorId != null){
                List<user> lstUser = [select DelegatedApproverId from user where id =: piw.ActorId and Vacation_Start_Date__c <=: system.today() and Vacation_end_Date__c >=: system.today()];
                if(lstUser.size() > 0){
                    if(lstUser[0].DelegatedApproverId == system.userinfo.getUserID()){
                        IsdelegatedUserId = true;
                    }
                }
            }
            
            return piwi[0];
        }    
        else
            return null;    
    }
    
    public PageReference gotoApprovalPage(){
        PageReference pr = new PageReference('/apex/cpoSubmitforApproval?id='+recordId);
        pr.setRedirect(true);
        return pr;
    }
    
    public PageReference submitForApproval(){
        update opp;
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setObjectId(recordId);
        try{  
            Approval.ProcessResult result =  Approval.process(req);            
        }catch (Exception ex){
            system.debug('=============== Exception =============='+ ex.getMessage());
        }
        PageReference pr = new PageReference('/'+recordId);
        pr.setRedirect(true);
        return pr;
    }
    
    public class approvalWrapper{
        public ProcessInstance processInstance{get;set;}
        public List<ProcessInstanceHistory> approvalHistoryList{get;set;}
        public string submitterSalesTeam {get;set;}
        public approvalWrapper(){
            processInstance = new ProcessInstance();
            approvalHistoryList = new List<ProcessInstanceHistory>();
        }
    }

}