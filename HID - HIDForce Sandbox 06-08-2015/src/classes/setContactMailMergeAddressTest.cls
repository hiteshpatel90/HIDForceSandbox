@isTest
private class setContactMailMergeAddressTest {

    static testMethod void myUnitTest() {
        Account a = new Account(Name = 'Don Bilbo\'s Pub');
        insert a;
        Contact c = new Contact();
        c.AccountID = a.Id;
        c.Salutation = 'Mr.';
        c.FirstName = 'Don';
        c.LastName = 'Bilbo';
        /*c.Address_1__c = 'Address 1';
        c.Address_2__c = 'Address 2';
        c.Address_3__c = 'Address 3';
        c.Address_4__c = 'Address 4';
        c.City__c = 'Irvine';
        c.State__c = 'CA';
        c.Postal_Code__c = '92618-3106';
        c.Country_BW__c = 'United States';*/
        
        
        c.MailingStreet = 'Address 1';
        c.MailingCity = 'Irvine';
        c.MailingState = 'California';
        c.MailingPostalCode = '92618-3106';
        c.MailingCountry = 'United States';
        insert c;
        
        System.assertNotEquals([SELECT Mail_Merge_Address__c FROM Contact WHERE Id = :c.Id], null);
        
        /*c.Country_BW__c = 'United Kingdom';
        c.State__c = 'N/A';*/
        
        c.MailingCountry = 'United Kingdom';
        c.MailingState = '';
        
        update c;
        
        System.assertNotEquals([SELECT Mail_Merge_Address__c FROM Contact WHERE Id = :c.Id], null);
        
        //c.Country_BW__c = 'Germany';
        c.MailingCountry = 'Germany';
        update c;
        
        System.assertNotEquals([SELECT Mail_Merge_Address__c FROM Contact WHERE Id = :c.Id], null);
    }
}