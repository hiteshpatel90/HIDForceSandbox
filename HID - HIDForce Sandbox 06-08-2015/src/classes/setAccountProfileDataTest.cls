@isTest(seeAllData=true)
private class setAccountProfileDataTest {
    /* static Currencies__c cu = new Currencies__c();
    static Countries__c co = new Countries__c();
    static Tier_Discount__c td = new Tier_Discount__c();
    static {
        cu.Name = 'N. America USD';
        cu.Sub_Region__c = 'N. America';
        cu.Currency__c = 'USD';
        cu.Default__c = true;
        insert cu;
        
        co.Name = 'US';
        co.Country__c = 'United States';
        co.Region__c = 'NAM';
        co.Sub_Region__c = 'N. America';
        co.Territory__c = 'US';
        co.Sales_Territory__c = 'NAM';
        co.CPI__c = 7.1;
        co.Identity_Assurance_Market_Size__c = 'AME-Large';
        co.PACS_Market_Size__c = 'AME-Large';
        co.Secure_Issuance_Market_Size__c = 'AME-Large';
        insert co;
        
        td.Business_Segment__c = 'PACS';
        td.Partner_Type__c = 'OEM';
        td.Tier__c = 'Silver';
        td.Price_Code__c = 'iC__c';
        td.Price_Code_Letters__c = 'iC';
        td.Discount__c = 50;
        td.Numeric_Discount__c = true;
        insert td;
        
    }*/
    
    static testMethod void setAccountProfileDataTest() {
        Account a = new Account(
        	Name = 'Don Bilbo Inc.',
        	BillingCountry = 'United States',
        	BillingState = 'California',
        	Sub_Region__c = 'N. America',
        	Region__c ='NAM'
        );
        insert a;
        
        list<Account_Profile__c> lstAccountProfile = new list<Account_Profile__c>{
            new Account_Profile__c(Account__c = a.Id, Business_Segment__c = 'PACS', Partner_Type__c = 'OEM'),
            new Account_Profile__c(Account__c = a.Id, Business_Segment__c = 'Secure Issuance'),
            new Account_Profile__c(Account__c = a.Id, Business_Segment__c = 'Identity Assurance'),
            new Account_Profile__c(Account__c = a.Id, Business_Segment__c = 'Animal ID')
        };
        insert lstAccountProfile;
        
        Partner_Program__c pp = new Partner_Program__c(
        	RecordTypeId = utilController.idAdvantagePartnerRecordType,
        	Account__c = a.Id,
        	Partner_Program_Status__c = 'Enrolled',
        	Partner_Program_Status_Modifier__c = 'N/A'
        );
        insert pp;
        
        Account_Profile__c p = new Account_Profile__c(Account__c = a.Id, Business_Segment__c = 'PACS');
        try{
            insert p;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        }
        
		Assessment__c asm = new Assessment__c(
			Account__c = a.Id,
			Business_Segment__c = 'PACS',
			Partner_Type__c = 'OEM',
			Market_Size__c = 'AME-Large',
			Approval_Status__c = 'Approved',
			Recommended_Tier__c = 'Silver',
			Requested_Tier__c  ='Silver',
			Requested_Effective_Date_For_Pricing__c = date.today()
		);
		insert asm;
        
        p = new Account_Profile__c(Id = lstAccountProfile[0].Id, Tier__c = null);
        update p;
        
        list<Account_Cluster__c> lstAccountCluster = new list<Account_Cluster__c>{
            new Account_Cluster__c(Name = 'HID Test Cluster 5646', Cluster_Type__c = 'Regional', Region__c = 'NAM'),
            new Account_Cluster__c(Name = 'HID Test Cluster 3562', Cluster_Type__c = 'Regional', Region__c = 'EMEA'),
            new Account_Cluster__c(Name = 'HID Test Cluster 9352', Cluster_Type__c = 'Regional', Region__c = 'ASI')
        };
        insert lstAccountCluster;
        
        lstAccountProfile = new list<Account_Profile__c>{
            new Account_Profile__c(Account_Cluster__c = lstAccountCluster[0].Id, Business_Segment__c = 'PACS', Partner_Type__c = 'OEM'),
            new Account_Profile__c(Account_Cluster__c = lstAccountCluster[0].Id, Business_Segment__c = 'Secure Issuance'),
            new Account_Profile__c(Account_Cluster__c = lstAccountCluster[0].Id, Business_Segment__c = 'Identity Assurance'),
            new Account_Profile__c(Account_Cluster__c = lstAccountCluster[1].Id, Business_Segment__c = 'PACS'),
            new Account_Profile__c(Account_Cluster__c = lstAccountCluster[2].Id, Business_Segment__c = 'Secure Issuance')
        };
        insert lstAccountProfile;
        
        Account_Cluster_Member__c m = new Account_Cluster_Member__c(Account_Cluster__c = lstAccountCluster[0].Id, Account__c = a.Id);
        insert m;
        
        p = new Account_Profile__c(Account_Cluster__c = lstAccountCluster[0].Id, Business_Segment__c = 'PACS');
        try{
            insert p;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        }
        
        p = new Account_Profile__c(Account_Cluster__c = lstAccountCluster[0].Id, Business_Segment__c = 'Animal ID');
        insert p;
        
        p = new Account_Profile__c(Account_Cluster__c = lstAccountCluster[0].Id, Business_Segment__c = 'Industry & Logistics');
        insert p;
    }
}