@isTest
private class setMailMergeAddress_test {

    static testMethod void myUnitTest() {
        Lead l = new Lead();
        l.Salutation = 'Mr.';
        l.FirstName = 'Don';
        l.LastName = 'Bilbo';
        l.Company = 'Don Bilbo';
        
        /*l.Address_1__c = 'Address 1';
        l.Address_2__c = 'Address 2';
        l.Address_3__c = 'Address 3';
        l.Address_4__c = 'Address 4';
        l.Address_City__c = 'Irvine';
        l.Address_State__c = 'CA';
        l.Postal_Code__c = '92618-3106';
        l.Address_Country__c = 'United States';*/
        
        l.Street = 'Address 1';
        l.City = 'Irvine';
        l.State = 'California';
        l.PostalCode = '92618-3106';
        l.Country = 'United States';
        insert l;
        
        System.assertNotEquals([SELECT Mail_Merge_Address__c FROM Lead WHERE Id = :l.Id], null);
        
        /*l.Address_Country__c = 'United Kingdom';
        l.Address_State__c = 'N/A';*/
        
        l.Country = 'United Kingdom';
        l.State = '';
        update l;
        
        System.assertNotEquals([SELECT Mail_Merge_Address__c FROM Lead WHERE Id = :l.Id], null);
        
        l.Country = 'Germany';
        
        update l;
        
        System.assertNotEquals([SELECT Mail_Merge_Address__c FROM Contact WHERE Id = :l.Id], null);
    }
}