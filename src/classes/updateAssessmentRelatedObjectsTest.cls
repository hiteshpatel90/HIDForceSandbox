@isTest(seeAllData=true)
private class updateAssessmentRelatedObjectsTest {
    static User u;
    static Account a;
    static Contact c;
    static Account_Profile__c p;
    
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

        a = new Account(
            Name = 'Don Bilbo Inc.',
            BillingCountry = 'United States',
            Billingstate = 'California',
            Channel__c = 'IAM - Distribution',
            Sub_Region__c = 'N. America',
            Oracle_Customer_Number__c = '12345',
            Region__c = 'NAM'
        );
        insert a;

        p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'EMEA-Small',
            Sales_Manager__c = u.Id
        );
        insert p;
        
        list<Account_Tier_Discount__c> lstAccountTierDiscounts = new list<Account_Tier_Discount__c>();
        for(Tier_Discount__c t : [
            SELECT
                Id,
                Price_Code__c
            FROM
                Tier_Discount__c
            WHERE
                Partner_Type__c = 'Distributor' 
                AND Tier__c = 'Silver'
                AND (
                    Price_Code__c = 'FB_Entry_Level_Printers__c'
                    OR Price_Code__c = 'FA_Prof_Printers__c'
                )
        ]){
            Account_Tier_Discount__c d = new Account_Tier_Discount__c(
                Account__c = a.Id,
                Tier_Discount__c = t.Id
            );
            if(t.Price_Code__c == 'FA_Prof_Printers__c'){
                d.Override_Discount__c = 'FA60';
            }else{
                d.Override_Discount__c = 'FB60';
            }
            lstAccountTierDiscounts.add(d);
        }
        insert lstAccountTierDiscounts;
    }
    
    static testMethod void testCluster(){
        
        
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test Cluster', Cluster_Type__c = 'Regional', Region__c = 'NAM');
        insert ac;
        
        Account_Profile__c cp = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'EMEA-Small',
            Sales_Manager__c = u.Id
        );
        insert cp;
        
        Account_Cluster_Member__c m = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
        insert m;
        
        test.startTest();
        Assessment__c s = new Assessment__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'EMEA-Small',
            Requested_Tier__c = 'Platinum',
            Approval_Status__c = 'Draft'
        );
        insert s;
        
        s.Approval_Status__c = 'Approved';
        update s;
       
        
        Account aa = new Account(
            Name = 'Don Bilbo Co.',
            BillingCountry = 'United States',
            Billingstate = 'California',
            Channel__c = 'IAM - Distribution',
            Sub_Region__c = 'N. America',
            Oracle_Customer_Number__c = '12345',
            ERP_Update__c = false,
            ERP_Update_Date__c = null,
            Region__c = 'NAM'
        );
        insert aa;
        
        m = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = aa.Id);
        insert m;
        
        test.stopTest();
    }
    static testMethod void testCluster1(){
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test Cluster', Cluster_Type__c = 'Regional', Region__c = 'NAM');
        insert ac;
        
        Assessment__c s = new Assessment__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'EMEA-Small',
            Requested_Tier__c = 'Platinum',
            Approval_Status__c = 'Approved'
        );
        insert s;
        
        s = new Assessment__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'EMEA-Small',
            Requested_Tier__c = 'Platinum',
            Approval_Status__c = 'Approved'
        );
        insert s;
    }
    static testMethod void testSuccess(){
        
        Partner_Program__c pp = new Partner_Program__c(RecordTypeId = utilController.idAdvantagePartnerRecordType, Account__c = a.Id, Partner_Program_Status__c = 'Enrolled', Partner_Program_Status_Modifier__c = 'N/A');
        insert pp;
        
        Assessment__c s = new Assessment__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'EMEA-Small',
            Requested_Tier__c = 'Silver',
            Approval_Status__c = 'Approved'
        );
        insert s;
        
        test.startTest();
        s = new Assessment__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'EMEA-Small',
            Requested_Tier__c = 'Silver',
            Approval_Status__c = 'Draft'
        );
        insert s;
        
        s.Approval_Status__c = 'Approved';
        update s;
        update s;
        
        s = new Assessment__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'EMEA-Small',
            Requested_Tier__c = 'Platinum',
            Approval_Status__c = 'Draft'
        );
        insert s;
        
        Account aa = new Account(
            Name = 'Don Bilbo Co.',
            BillingCountry = 'United States',
            BillingCountryCode = 'US',
            BillingState = 'California',
            BillingStateCode = 'CA',
            Channel__c = 'IAM - Distribution',
            Sub_Region__c = 'N. America',
            Oracle_Customer_Number__c = '12345'
        );
        insert aa;
        
        s = new Assessment__c(
            Account__c = aa.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'EMEA-Small',
            Requested_Tier__c = 'Platinum',
            Approval_Status__c = 'Draft'
        );
        insert s;

        test.stopTest();
    }
}