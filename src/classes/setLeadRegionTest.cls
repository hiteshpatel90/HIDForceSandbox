@isTest
private class setLeadRegionTest {
    static final String FIRST = 'Jan';
    static final String LAST = 'Ackermann';
    static final String COMP = 'HID Global';
    static final String CHECK = 'Yes';

    static final list<Countries__c> COUNTRIES = new list<Countries__c>([SELECT Name, Country__c, Region__c, Territory__c, Sales_Territory__c FROM Countries__c]);
    static final list<States__c> STATES = new list<States__c>([SELECT Name, State__c, Region__c, Territory__c, Sales_Territory__c FROM States__c]);
    
    static testMethod void setLeadRegionTest() {
        list<Lead> lstLead = new list<Lead>();
        list<Database.SaveResult> lstDsrInsertLead = new list<Database.SaveResult>();
        Lead l = new Lead(FirstName = FIRST, LastName = LAST, Company = COMP, Checked_for_Spam__c = CHECK, Country = 'United States', State = 'California');
        lstLead.add(l);
        l = new Lead(FirstName = FIRST, LastName = LAST, Company = COMP, Checked_for_Spam__c = CHECK, Country = 'Germany', State = '');
        lstLead.add(l);
        l = new Lead(FirstName = FIRST, LastName = LAST, Company = COMP, Checked_for_Spam__c = CHECK, Cardiris_Country__c = 'Germany', Country = 'Germany', State = '');
        lstLead.add(l);
        
        for(Countries__c c : COUNTRIES){
            l = new Lead(FirstName = FIRST, LastName = LAST, Company = COMP, Checked_for_Spam__c = CHECK, Country = 'United States');
            lstLead.add(l);
        }

        for(States__c s : STATES){
            l = new Lead(FirstName = FIRST, LastName = LAST, Company = COMP, Checked_for_Spam__c = CHECK, Country = 'United States', State = 'California');
            lstLead.add(l);
        }
        
        Test.startTest();
        
        lstDsrInsertLead = Database.insert(lstLead);
        
        Test.stopTest();
        
        for(Database.Saveresult d : lstDsrInsertLead){
            System.assert(d.isSuccess());
        }
    }
}