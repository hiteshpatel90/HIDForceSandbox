@isTest
private class setRequestedByCustomerTest {
    static testMethod void myUnitTest() {
        Lead l = new Lead(
            Company = 'Test',
            LastName = 'Test',
            Status = 'New',
            LeadSource = 'Website or Online Promotion',
            Areas_of_Interest__c = 'Credentials',
            Region__c = 'EMEA',
            Country = 'Germany',
            Want_Free_Dell_iCLASS_Card__c = 'Yes',
            Checked_for_Spam__c = 'Yes'
        );
        Database.SaveResult[] r = Database.insert(new Lead[]{l});
        List<Id> lstL = new List<Id>();
        for(Database.SaveResult sr:r){
            lstL.add(sr.getId());
        }
        for(Lead ll:[SELECT Requested_by_Lead__c FROM Lead WHERE Id IN :lstL]){
            System.assertEquals(ll.Requested_by_Lead__c, 'Free Dell iCLASS card');
        }
    }
}