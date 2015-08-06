@isTest
private class setERPUpdateOracleTest {
    static User u;

    static {
        Profile up = [
            SELECT
                Id
            FROM
                Profile
            WHERE
                Name = 'HID Sales User - IAM'
        ];
        u = new User(
            Alias = 'u1',
            Email = 'u1@hidglobal.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = up.Id,
            Country = 'United States',
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'u1@hidglobal.com'
        );
        insert u;
    }
    
    static testMethod void testSuccess() {
        Account a = new Account(
            Name = 'Sag ich nicht',
            BillingCountry = 'United States',
            BillingState = 'California',
            Channel__c = 'IAM - Distribution',
            Sub_Region__c = 'N. America'
        );
        insert a;
        
        Contact c = new Contact(
            AccountId = a.Id,
            LastName = 'Don Bilbo'
        );
        
        Price_Authorization_Form__c p = new Price_Authorization_Form__c(
            Account__c = a.Id,
            Key_Contact__c = c.Id,
            Status__c = 'Approved',
            FA_Prof_Printers__c = 'FA50',
            Pricing_Effective_Date__c = date.today()
        );
        insert p;
        
        test.startTest();
        
        Account b = [
            SELECT
                Id,
                Oracle_Customer_Number__c
            FROM
                Account
            WHERE
                Id =: a.Id
        ];
        b.Oracle_Customer_Number__c = '99999';
        update b;
        
        test.stopTest();
    }
}