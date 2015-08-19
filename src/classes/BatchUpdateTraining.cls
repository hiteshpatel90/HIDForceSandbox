global class BatchUpdateTraining implements Database.Batchable<sobject> {

     public String Query;

     public Database.QueryLocator start(Database.BatchableContext BC)  {  

        Query = 'SELECT id,Training_Status__c,Expiry_Date__c FROM Training__c WHERE Expiry_Date__c < Today';
        
        return Database.getQueryLocator(Query); 

    }

     public void execute(Database.BatchableContext BC, List<Training__c> scope) { 
        List<Training__c> tr = new List<Training__c>(); 
        System.debug(scope);
        for (Training__c ac : scope)  {
        ac.Training_Status__c = 'Expired';
        tr.add(ac);
        System.debug(tr.size());

       }

           update tr;
     }

 
    public void finish(Database.BatchableContext BC) {   
    AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
      TotalJobItems, CreatedDate, CreatedBy.Email
      FROM AsyncApexJob WHERE Id =
      :BC.getJobId()];
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    List<String> toAddresses = new List<String> {a.CreatedBy.Email};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Training Expiration Job Processed ' + a.Status);
        mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems + ' batches with ' + a.NumberOfErrors + ' failures ' + a.CreatedDate + ' Date Ran');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
   }

}