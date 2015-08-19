/****************************************************************************
* Type               : Apex Class
* Name               : ScheduleBatchExecUpdateIntPriceCode 
* Modified by        : Hitesh Patel
* Modified Date      : 11th June 2015
* Last Modified By   : Hitesh Patel 18th June 2015
* Purpose            : This controller is used to schedule a batch class - BatchExecUpdateIntegrationPriceCode
****************************************************************************/
global class ScheduleBatchExecUpdateIntPriceCode implements schedulable{
    global void execute(SchedulableContext sc){     
        String sQuery= getQueryString('Price_Authorization_Form__c');
        BatchExecUpdateIntegrationPriceCode batchApex = new BatchExecUpdateIntegrationPriceCode(sQuery);
        //ID batchprocessid
        Database.executeBatch(batchApex, 1);         
    }
    
    public String getQueryString(String objectName){
        Map<String, Schema.SObjectType> objMap = new Map<String, Schema.SObjectType>();
        objMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = objMap.get(objectName).getDescribe().fields.getMap();
        string queryString = 'select Account__r.BillingCountry, Recordtype.DeveloperName, ';
        for(Schema.SObjectField field :fieldMap.values()){
            queryString = queryString + field.getDescribe().getName() + ', ';
        }
        queryString = queryString.substring(0,queryString.length() - 2);
        queryString = queryString + ' from ' + objectName;
        return queryString;
    }
}