@isTest(seeAllData=true)
private class setAccountTierDiscountOverrideTest {
    static User u;
    static Account a;
    static Contact c;
    static Account_Profile__c p;
    
    static Profile pr = [
        SELECT
            Id
        FROM
            Profile
        WHERE
            Name = 'HID Sales User - IAM'
    ];
    
    static {
        u = new User(
            Alias = 'u1',
            Email = 'u1@hidglobal.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = pr.Id,
            Country = 'United States',
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'u1@hidglobal.com'
        );
        insert u;
        
        a = new Account(
            Name = 'Don Bilbo Inc.',
            BillingCountry = 'Germany',
            BillingState = '',
            Channel__c = 'IAM - Distribution',
            Sub_Region__c = 'W. Europe',
            Oracle_Customer_Number__c = '12345'
        );
        insert a;
        
        c = new Contact(
            AccountId = a.Id,
            LastName = 'Don Bilbo'
        );
        
        p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'EUR',
            Market_Size__c = 'EMEA-Small',
            Sales_Manager__c = u.Id
        );
        insert p;
    }
    
    static testMethod void testSuccess() {
        Assessment__c s = new Assessment__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Requested_Tier__c = 'Platinum',
            Approval_Status__c = 'Approved'
        );
        insert s;
        
        Tier_Discount__c t = [
            SELECT
                Id,
                Price_Code_Letters__c,
                Discount__c
            FROM
                Tier_Discount__c
            WHERE
                Price_Code__c = 'FA_Prof_Printers__c'
            LIMIT 1
        ];
        Account_Tier_Discount__c d = new Account_Tier_Discount__c(
            Account__c = a.Id,
            Tier_Discount__c = t.Id
        );
        insert d;   
        
        Price_Authorization_Form__c f = new Price_Authorization_Form__c(
            Account__c = a.Id,
            Key_Contact__c = c.Id,
            Pricing_Effective_Date__c = date.today(),
            FA_Prof_Printers__c = 'FA50',
            Status__c = 'ERP Update'
        );
        insert f;
        
        f = new Price_Authorization_Form__c(
            Account__c = a.Id,
            Key_Contact__c = c.Id,
            Pricing_Effective_Date__c = date.today(),
            FB_Entry_Level_Printers__c = 'FB50',
            FD_Ribbons_Clear_Film__c = 'FD50',
            FE_Entry_Level_Ribbons__c = 'FE50',
            Status__c = 'ERP Update'
        );
        insert f;
        
        f = new Price_Authorization_Form__c(
            Account__c = a.Id,
            Key_Contact__c = c.Id,
            Pricing_Effective_Date__c = date.today(),
            FA_Prof_Printers__c = 'FA59',
            Status__c = 'ERP Update'
        );
        insert f;
        
        f = new Price_Authorization_Form__c(
            Account__c = a.Id,
            Key_Contact__c = c.Id,
            Pricing_Effective_Date__c = date.today(),
            FA_Prof_Printers__c = 'FA Delete',
            Status__c = 'ERP Update'
        );
        insert f;
        
        String strPC = t.Price_Code_Letters__c + String.valueOf(t.Discount__c); 
        f = new Price_Authorization_Form__c(
        	Account__c = a.Id,
        	Key_Contact__c = c.Id,
        	Pricing_Effective_Date__c = date.today(),
        	FA_Prof_Printers__c = strPC.substring(0, strPC.length() - 2),
        	Status__c = 'ERP Update'
        );
        insert f;
    }
    
    static testMethod void myUnitTest1(){
        
        Assessment__c s = new Assessment__c(
            Account__c = a.Id,
            Business_Segment__c = 'PACS',
            Requested_Tier__c = 'Platinum',
            Approval_Status__c = 'Approved'
        );
        insert s;
        
        Tier_Discount__c t = [
            SELECT
                Id
            FROM
                Tier_Discount__c
            WHERE
                Price_Code__c = 'EZ_EasyLobby__c'
            LIMIT 1
        ];
        Account_Tier_Discount__c d = new Account_Tier_Discount__c(
            Account__c = a.Id,
            Tier_Discount__c = t.Id
        );
        insert d; 
        
        Price_Authorization_Form__c f = new Price_Authorization_Form__c(
        	Account__c = a.Id,
        	Key_Contact__c = c.Id,
        	Pricing_Effective_Date__c = date.today(),
        	EZ_EasyLobby__c = 'EZ-Dealer',
        	Status__c = 'ERP Update'
        );
        insert f;
    }
}