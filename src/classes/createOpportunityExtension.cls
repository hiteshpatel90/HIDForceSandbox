/****************************************************************************
* Type               : Apex Class
* Name               : createOpportunityExtension
* Created by         : Hitesh Patel
* Created Date       : 27th May 2015
* Last Modified By   : Hitesh Patel 27th May 2015
* Purpose            : This is Extension class for "createOpportunity"
                       This controller is used to get region value from particular account                  
****************************************************************************/
public class createOpportunityExtension{
    public string strAccRegion {get; set;}
    public createOpportunityExtension(apexpages.standardcontroller stdCon){
        String strAccId = apexpages.currentPage().getParameters().get('accid');
        if(strAccId != null && strAccId != ''){
            List<Account> lstAccount = [select id, Region__c from Account where id =: strAccId];
            if(!lstAccount.isEmpty()){
                strAccRegion = '&00N80000003anrm=' + lstAccount[0].Region__c;
            }
        }
        
        system.debug('@@@@@@@@@@'+strAccRegion);
    }
}