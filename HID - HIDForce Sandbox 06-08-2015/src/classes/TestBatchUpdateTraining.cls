@isTest
private class TestBatchUpdateTraining {

    Static testmethod void test(){
String Query = 'SELECT id,Training_Status__c,Expiry_Date__c FROM Training__c WHERE Expiry_Date__c < Today';
     
   Account acct = new Account(Name='Test Account');
   Course__c coursey = new Course__c(Name='Test Course', CurrencyIsoCode = 'USD');
   Contact learner = new Contact(FirstName='Test',LastName='Learner',Account =acct );
        insert acct;
        insert coursey;
        insert learner;
        
Training__c[] ml = new List<Training__c>();
        date mydate = date.parse('5/11/2014');
       for (Integer i=0;i<10;i++) {
           Training__c m = new Training__c(
               Course_or_Module__c= coursey.id,
               Account__c = acct.id,
               Attendee__c = learner.id, //Learner
               Training_Status__c='Completed',
           		Expiry_Date__c = mydate);
           ml.add(m);
           System.debug(ml);
       }
    insert ml;
    
    Test.startTest();
    BatchUpdateTraining bit = new BatchUpdateTraining();
    Database.executeBatch(bit);
    system.debug(bit);
  
    Test.stopTest();
    
    Integer it = [SELECT COUNT() FROM Training__c WHERE Expiry_Date__c < Today AND Training_Status__c != 'Expired'];
    System.assertEquals(it, 0);
    }
}