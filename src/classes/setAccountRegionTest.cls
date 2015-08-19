@isTest (seeAllData=true)
private class setAccountRegionTest {
    static final String COMP = 'HID Global';

    static final list<Countries__c> COUNTRIES = new list<Countries__c>([SELECT Name, Country__c, Region__c, Territory__c FROM Countries__c]);
    static final list<States__c> STATES = new list<States__c>([SELECT Name, State__c, Region__c, Territory__c FROM States__c]);
    
    static User u;
    
    static {
        Profile p = [
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
            ProfileId = p.Id,
            Country = 'United States',
            CountryCode = 'US',
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'u1@hidglobal.com'
        );
        insert u;
    }
    
    static testMethod void setAccountRegionTest() {
        list<Account> lstAccount = new list<Account>();
        list<Database.SaveResult> lstDsrInsertAccount = new list<Database.SaveResult>();
        Account a = new Account(Name = COMP, BillingCountryCode = 'US', BillingStateCode = 'NY');
        lstAccount.add(a);
        /*
        a = new Account(Name = COMP, BillingCountry = 'Haiti', BillingState = '');
        lstAccount.add(a);
        */
        a = new Account(Name = COMP, Cardiris_Country__c = 'Germany', BillingCountryCode = 'DE');
        lstAccount.add(a);

        /*
        for(Countries__c c : COUNTRIES){
            a = new Account(Name = COMP, BillingCountry = 'United States', BillingState = '');
            lstAccount.add(a);
        }
        
        for(States__c s : STATES){
            a = new Account(Name = COMP, BillingCountryCode = 'US', BillingStateCode = s.State__c);
            lstAccount.add(a);
        }
        */
        
        Test.startTest();
        
        lstDsrInsertAccount = Database.insert(lstAccount);
        
        Test.stopTest();
        
        for(Database.Saveresult d : lstDsrInsertAccount){
            System.assert(d.isSuccess());
        }
    }
    
    static testMethod void testAccountProfilePricebookCurrency(){
        Account a = new Account(
            Name = 'Don Bilbo Inc.',
            BillingCountryCode = 'DE',
            Channel__c = 'IAM - Distributor',
            Sub_Region__c = 'W. Europe'
        );
        insert a;
        
        Account_Profile__c p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Sales_Manager__c = u.Id
        );
        insert p;
        
        a.BillingCountryCode = 'PL';
        a.Oracle_Customer_Number__c = '98765';
        update a;
        
        a.BillingCountry = 'United States';
        //a.BillingCountryCode = 'US';
        //a.BillingStateCode = 'CA';
        a.BillingState = 'California';
        a.Sub_Region__c = 'N. America';
        update a;
        
        /*
        a.Sub_Region__c = 'NAM';
        update a;
        */
    }
}