@isTest
private class accountProfileEditControllerTest {
    static User u;
    static Account a;
    static Account_Profile__c pp;
    static Currencies__c c = new Currencies__c();
    
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
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'u1@hidglobal.com'
        );
        insert u;
    }
    static { 
        a = new Account(
            Name = 'Don Bilbo Inc.',
            /*Country__c = 'United States',
            State__c = 'CA',*/
            
            BillingCountry = 'United States',
            BillingState = 'California',
            
            Channel__c = 'IAM - Distribution',
            Sub_Region__c = 'N. America',
            Region__c = 'NAM'
        );
        insert a;
    }
    static {
        c.Name = 'N. America USD';
        c.Sub_Region__c = 'N. America';
        c.Currency__c = 'USD';
        c.Default__c = true;
        insert c;
    }
    static {
        pp = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'PACS',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'AME-Small',
            Tier__c = 'Silver',
            Recommended_Tier__c = 'Silver',
            Sales_Manager__c = u.Id
        );
        insert pp;
    }
    
    static testMethod void testSuccess(){
        Account_Profile__c p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'AME-Small',
            Tier__c = 'Platinum',
            Recommended_Tier__c = 'Gold',
            Requested_Tier_Expiration_Date__c = date.today().addDays(180),
            Sales_Manager__c = u.Id
        );
        
        Assessment__c asmt = new Assessment__c(
        	Account__c = a.Id,
        	Approval_Status__c = 'Approved',
        	Requested_Effective_Date_for_Pricing__c = date.today(),
        	Recommended_Tier__c = 'Gold',
        	Requested_Tier__c = 'Platinum'
        );
        insert asmt;
        
        test.startTest();
        
        PageReference ref = Page.AccountProfileEdit;
        Test.setCurrentPage(ref);
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
        ctr.getObjAccountProfile();

        ApexPages.PageReference returnPage;
        ApexPages.currentPage().getParameters().put('retURL', p.Id);
        
        ctr.getLstPricebookCurrency();
        ctr.getLstBusinessSegment();
        ctr.getLstPartnerType();
        ctr.getLstMarketSize();
        ctr.getLstUseApplication();
        Boolean bolRenderSave = ctr.bolRenderSave;
        ctr.getBolAccount();
        ctr.getBolNationalAccount();
        ctr.getBolBusinessSegment();
        ctr.getBolPartnerType();
        ctr.getBolMarketSize();
        ctr.getBolUseApplication();
        ctr.getBolIntegratedHardware();
        ctr.getBolPartnerDirectory();
        ctr.getBolPricebookCurrency();
        ctr.getBolPurchasingMethod();
        ctr.getBolRanking();
        ctr.getBolProgramCategory();
        ctr.getBolTier();
        ctr.getBolNASDeveloper();
        ctr.getBolContractManufacturer();
        ctr.getBolNationalAccountManager();
        ctr.getBolNationalAccountManager();
        ctr.getBolBusinessSegment();
        ctr.getBolUseApplication();
        ctr.getLstUseApplication();
        ctr.getBolIntegratedHardware();
        ctr.getBolNASDeveloper();
        ctr.getBolPartnerType();
        ctr.getBolUseApplication();
        ctr.getLstUseApplication();
        ctr.getBolIntegratedHardware();
        ctr.getBolCompetitor();
        ctr.tierUpdate();

        
        returnPage = ctr.bsUpdate();
        returnPage = ctr.customSave();
        
        test.stopTest();
    }
    
    static testMethod void testOverrideAccountTier(){
        Account_Profile__c p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'AME-Small',
            Tier__c = 'Platinum',
            Recommended_Tier__c = 'Gold',
            Requested_Tier_Expiration_Date__c = date.today().addDays(180),
            Sales_Manager__c = u.Id
        );
        
        Assessment__c asmt = new Assessment__c(
        	Account__c = a.Id,
        	Approval_Status__c = 'Approved',
        	Business_Segment__c = 'Secure Issuance',
        	Requested_Effective_Date_for_Pricing__c = date.today(),
        	Recommended_Tier__c = 'Gold',
        	Requested_Tier__c = 'Platinum'
        );
        insert asmt;
        
        test.startTest();
        
        PageReference ref = Page.AccountProfileEdit;
        Test.setCurrentPage(ref);
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
        ctr.getObjAccountProfile();

        ApexPages.PageReference returnPage;
        ApexPages.currentPage().getParameters().put('retURL', p.Id);
        ctr.objAccountProfile.Tier__c = 'Gold';
        ctr.tierUpdate();

        returnPage = ctr.bsUpdate();
        returnPage = ctr.customSave();
        
        test.stopTest();
    }
 
    static testMethod void testClusterSuccess(){
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test Cluster 8433', Cluster_Type__c = 'Regional', Region__c = 'NAM');
        insert ac;
        
        Account_Profile__c p = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Tier__c = 'Silver',
            Recommended_Tier__c = 'Silver',
            Sales_Manager__c = u.Id
        );
        insert p;
        
        p = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'PACS',
            Partner_Type__c = 'Distributor'
        );
        insert p;
        
        Account_Cluster_Member__c m = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
        insert m;
        
        PageReference ref = Page.AccountProfileEdit;
        Test.setCurrentPage(ref);
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
        ctr.getObjAccountProfile();

        ApexPages.PageReference returnPage;
        ApexPages.currentPage().getParameters().put('retURL', p.Id);

		ctr.tierUpdate();
        
        returnPage = ctr.bsUpdate();
        returnPage = ctr.customSave();
    }
    
    static testMethod void testOverrideClusterTier(){
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test Cluster 8433', Cluster_Type__c = 'Regional', Region__c = 'NAM');
        insert ac;
        
        Account_Profile__c p = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Tier__c = 'Silver',
            Recommended_Tier__c = 'Silver',
            Sales_Manager__c = u.Id
        );
        insert p;
        
        p = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'PACS',
            Partner_Type__c = 'Distributor',
            Tier__c = 'Platinum',
            Recommended_Tier__c = 'Gold'
        );
        insert p;
        
        Account_Cluster_Member__c m = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
        insert m;
        
        PageReference ref = Page.AccountProfileEdit;
        Test.setCurrentPage(ref);
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
        ctr.getObjAccountProfile();

        ApexPages.PageReference returnPage;
        ApexPages.currentPage().getParameters().put('retURL', p.Id);

		ctr.objAccountProfile.Tier__c = 'Gold';
		ctr.tierUpdate();
        
        returnPage = ctr.bsUpdate();
        returnPage = ctr.customSave();
    }
    
    static testMethod void testAccountAlreadyClusterMember(){
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test Cluster 8433', Cluster_Type__c = 'Regional', Region__c = 'NAM');
        insert ac;
        
        Account_Profile__c p = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Tier__c = 'Silver',
            Recommended_Tier__c = 'Silver',
            Sales_Manager__c = u.Id
        );
        insert p;
        
        p = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'PACS',
            Partner_Type__c = 'Distributor',
            Sales_Manager__c = u.Id
        );
        insert p;
        
        Account_Cluster_Member__c m = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
        insert m;
    	
        p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'PACS',
            Partner_Type__c = 'Distributor',
            Sales_Manager__c = u.Id
        );
        
        PageReference ref = Page.AccountProfileEdit;
        Test.setCurrentPage(ref);
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
        ctr.getObjAccountProfile();
        
        ctr.tierUpdate();

        PageReference returnPage = ctr.customSave();
    }        
    
    static testMethod void testFail(){
        Account_Profile__c p = new Account_Profile__c(
            Account__c = a.Id
        );

        test.startTest();
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
        ctr.objAccountProfile.Sales_Manager__c = null;
        ApexPages.PageReference returnPage = ctr.customSave();
        
        test.stopTest();
    }

    static testMethod void testNoGlobalAccountGroup(){
        Account_Profile__c p = new Account_Profile__c(
            Account__c = a.Id,
            Partner_Type__c = 'Global Account Group'
        );

        test.startTest();
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
        ctr.objAccountProfile.Sales_Manager__c = null;
        ApexPages.PageReference returnPage = ctr.customSave();
        
        test.stopTest();
    }

    static testMethod void testNoAdmin(){
        Account_Profile__c p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Sales_Manager__c = u.Id
        );
        
        test.startTest();
        
        system.runAs(u){                
            accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
            ctr.getObjAccountProfile();
            ctr.getBolPricebookCurrency();
            ctr.getLstBusinessSegment();
	        ctr.tierUpdate();
	
	        PageReference returnPage = ctr.customSave();
        }
        
        test.stopTest();
    }
    
    static testMethod void testClusterNoAdmin(){
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test Cluster 8433', Cluster_Type__c = 'Regional', Region__c = 'NAM');
        insert ac;
        
        Account_Profile__c p = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Tier__c = 'Silver',
            Recommended_Tier__c = 'Silver',
            Sales_Manager__c = u.Id
        );
        insert p;
        
        p = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'PACS',
            Partner_Type__c = 'Distributor'
        );
        insert p;
        
        Account_Cluster_Member__c m = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
        insert m;
        
        test.startTest();
        
        system.runAs(u){                
            accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
            ctr.getObjAccountProfile();
            ctr.getBolPricebookCurrency();
            ctr.getLstBusinessSegment();
	        ctr.tierUpdate();
	
	        PageReference returnPage = ctr.customSave();
        }
        
        test.stopTest();
    }
    
    static testMethod void testNoAccount(){
        Account_Profile__c p = new Account_Profile__c();
        
        test.startTest();
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
        ctr.getLstPricebookCurrency();
        ctr.getBolAccount();
        ctr.tierUpdate();

        PageReference returnPage = ctr.customSave();
        
        test.stopTest();
    }

    static testMethod void testConnectSuccess(){
        Account_Profile__c p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Connect',
            Integrated_Hardware__c = 'OEM50;OEM75',
            Use_Application__c = 'AFC',
            Partner_Type__c = 'Competitor'
        );
        
        test.startTest();
        
        PageReference ref = Page.AccountProfileEdit;
        Test.setCurrentPage(ref);
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p)); 
        ApexPages.currentPage().getParameters().put('retURL', p.Id);
        ctr.getLstPricebookCurrency();
        ctr.getLstBusinessSegment();
        ctr.getLstPartnerType();
        ctr.getLstMarketSize();
        ctr.getLstUseApplication();
        ctr.getLstCompetitor();
        ctr.getBolNationalAccount();
        ctr.getBolBusinessSegment();
        ctr.getBolPartnerType();
        ctr.getBolUseApplication();
        ctr.getBolIntegratedHardware();
        ctr.getBolPurchasingMethod();
        ctr.getBolRanking();
        ctr.getBolProgramCategory();
        ctr.getBolTier();
        ctr.getBolNASDeveloper();
        p.Partner_Type__c = 'OEM';
        ctr.getBolContractManufacturer();
        ctr.tierUpdate();
        ApexPages.PageReference returnPage = ctr.customSave();
        
        test.stopTest();
    }
        
    static testMethod void testConnectFail(){
        Account_Profile__c p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Connect'
        );
        
        test.startTest();
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
        ApexPages.PageReference returnPage = ctr.customSave();
        
        test.stopTest();
    }
    
    static testMethod void testCancel(){
        Account_Profile__c p = new Account_Profile__c(
            Account__c = a.Id
        );
        
        test.startTest();
        
        PageReference ref = Page.AccountProfileEdit;
        Test.setCurrentPage(ref);
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
        ApexPages.currentPage().getParameters().put('retURL', a.Id);
        ApexPages.PageReference returnPage = ctr.customCancel();
        
        test.stopTest();
    }
    
    static testMethod void testNoCountryChannel(){
        Account aa = new Account(
            Name = 'Don Bilbo Co.'
        );
        insert aa;
        
        Account_Profile__c p = new Account_Profile__c(
            Account__c = aa.Id
        );
        
        test.startTest();
        
        PageReference ref = Page.AccountProfileEdit;
        Test.setCurrentPage(ref);
        
        accountProfileEditController ctr = new accountProfileEditController(new ApexPages.StandardController(p));
        ApexPages.currentPage().getParameters().put('retURL', p.Id);
        ApexPages.PageReference updatePage = ctr.bsUpdate();
        
        test.stopTest();
    }
}