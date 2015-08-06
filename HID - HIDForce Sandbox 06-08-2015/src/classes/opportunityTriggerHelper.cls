/****************************************************************************
* Type               : Apex Class
* Name               : opportunityTriggerHelper
* Created by         : Hitesh Patel
* Created Date       : 13th April 2015
* Last Modified By   : Hitesh Patel 28th May 2015
* Purpose            : This is helper class of Opportunity                  
****************************************************************************/
public class opportunityTriggerHelper{
    public static void opportunityTriggerHandle(List<Opportunity> lstOpportunityNew, Map<Id,Opportunity> mapOpportunityOld){
        if(trigger.isBefore){  
            opportunityTriggerHandler.oppAccountProfileValidation(lstOpportunityNew);
            opportunityTriggerHandler.oppCPOLastApprovalValidation(lstOpportunityNew);
            
        }else if(trigger.isAfter){  
             opportunityTriggerHandler.populateBussandRegSegmentLeader(lstOpportunityNew, mapOpportunityOld);
             opportunityTriggerHandler.insertChatterFollowerofOpp(lstOpportunityNew, mapOpportunityOld);
             if(trigger.isUpdate){
                 opportunityTriggerHandler.cpoApprovalFieldUpdates(lstOpportunityNew, mapOpportunityOld);
             }
        }
    }
}