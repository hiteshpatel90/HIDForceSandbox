@isTest(seeAllData=true)
private class assessmentEditControllerTest {
    static User u;
    static Account a;
    static Account aca;
    static Account_Cluster__c ac;
    static Account_Profile__c p;
    static Account_Profile__c acap;
    static Account_Cluster_Member__c acm;
    
    static { 
        aca = new Account(
            Name = 'Don Bilbo Co.',
            BillingCountry = 'United States',
            BillingState = 'California',
            Channel__c = 'IAM - Distribution',
            Sub_Region__c = 'N. America',
            Region__c = 'NAM'
        );
        insert aca;
    }
    static{
        ac = new Account_Cluster__c(
            Name = 'HID Test 3564',
            Cluster_Type__c = 'Regional',
            Region__c = 'NAM'
        );
        insert ac;
    }
    static{
        acap = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'EMEA-Regional'
        );
        insert acap;
    }

    static{
        acm = new Account_Cluster_Member__c(
            Account_Cluster__c = ac.Id,
            Account__c = aca.Id
        );
        insert acm;
    }
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
    static { 
        a = new Account(
            Name = 'Don Bilbo Co.',
            BillingCountry = 'United States',
            BillingState = 'California',
            Channel__c = 'IAM - Distribution',
            Sub_Region__c = 'N. America',
            Region__c = 'NAM'
        );
        insert a;
    }
    static {
        p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'EMEA-Small',
            Sales_Manager__c = u.Id
        );
        insert p;
    }
    
    static testMethod void testCluster(){
        Assessment__c s = new Assessment__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'PACS',
            Market_Size__c = 'EMEA-Small',
            Partner_Type__c = 'Distributor',
            Requested_Tier__c = 'Silver',
            SI_Spend__c = 200000,
            Requested_Effective_Date_for_Pricing__c = date.today()
        );
        
        test.startTest();
        
        PageReference ref = Page.AssessmentEditPage1;
        Test.setCurrentPage(ref);
        
        assessmentEditController c = new assessmentEditController(new ApexPages.StandardController(s));
        c.getObjAssessment();
        c.getObjAssessmentApproved();
        
        ApexPages.PageReference returnPage = c.step2();
        
        c.getStrTE1();
        c.getLstBusinessSegment();
        c.getLstPartnerType();
        c.getLstMarketSize();
        c.getLstDaysInventory();
        c.getLstHIDAPISolutions();
        c.getLstSIProductCertifications();
        c.getLstIAProductCertifications();
        c.getLstHIDAcademyCoursesCompleted();
        c.getLstSICertifiedEmployees();
        c.getLstIACertifiedEmployees();
        c.getLstEmployeesWpivCLASSCert();
        c.getLstOEMSpecDoc();
        c.getLstIANewCustomers();
        
        c.getBolSI();
        c.getBolIA();
        c.getBolPACS();
        c.getBolEdit();
        c.getBolCustomDelete();
        c.getBolAccount();
        c.getBolJointIntegratorTraining();
        c.getBolSIDistributor();
        c.getBolSIPACSIntegrator();
        c.getBolPACSIntegrator();
        c.getBolOEM();
        c.getBolSIPACSOEM();
        //c.getBolIAOEM();
        c.getBolDistributorOEM();
        c.getBolIADistributorIntegrator();
        
        ApexPages.currentPage().getParameters().put('retURL', ac.Id);
        returnPage = c.step1();
        returnPage = c.updateAccount();
        returnPage = c.step2();
        returnPage = c.updateAssessment();
        returnPage = c.customSave();
        returnPage = c.customCancel();
        
        test.stopTest();
    }
    static testMethod void testSuccess(){
        Assessment__c s = new Assessment__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Market_Size__c = 'EMEA-Small',
            Partner_Type__c = 'Distributor',
            Requested_Tier__c = 'Silver',
            SI_Spend__c = 200000,
            Requested_Effective_Date_for_Pricing__c = date.today()
        );

        test.startTest();
        
        PageReference ref = Page.AssessmentEditPage1;
        Test.setCurrentPage(ref);
        
        assessmentEditController c = new assessmentEditController(new ApexPages.StandardController(s));
        c.getObjAssessment();
        c.getObjAssessmentApproved();

        ApexPages.PageReference returnPage = c.step2();
        
        c.getStrTE1();
        c.getLstBusinessSegment();
        c.getLstPartnerType();
        c.getLstMarketSize();
        c.getLstDaysInventory();
        c.getLstHIDAPISolutions();
        c.getLstSIProductCertifications();
        c.getLstIAProductCertifications();
        c.getLstHIDAcademyCoursesCompleted();
        c.getLstSICertifiedEmployees();
        c.getLstIACertifiedEmployees();
        c.getLstEmployeesWpivCLASSCert();
        c.getLstOEMSpecDoc();
        c.getLstIANewCustomers();
        
        c.getBolSI();
        c.getBolIA();
        c.getBolPACS();
        c.getBolEdit();
        c.getBolCustomDelete();
        c.getBolAccount();
        c.getBolJointIntegratorTraining();
        c.getBolSIDistributor();
        c.getBolSIPACSIntegrator();
        c.getBolPACSIntegrator();
        c.getBolOEM();
        c.getBolSIPACSOEM();
        //c.getBolIAOEM();
        c.getBolDistributorOEM();
        c.getBolIADistributorIntegrator();
        
        ApexPages.currentPage().getParameters().put('retURL', a.Id);
        returnPage = c.step1();
        returnPage = c.updateAccount();
        returnPage = c.step2();
        returnPage = c.updateAssessment();
        returnPage = c.customSave();
        returnPage = c.customCancel();
        
        s = new Assessment__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Market_Size__c = 'EMEA-Small',
            Partner_Type__c = 'Integrator',
            Requested_Tier__c = 'Silver',
            SI_Spend__c = 200000,
            Requested_Effective_Date_for_Pricing__c = date.today()
        );
        c = new assessmentEditController(new ApexPages.StandardController(s));
        c.getObjAssessment();
        c.getObjAssessmentApproved();
        
        returnPage = c.step2();
        c.getBolSIPACSIntegrator();
        
        test.stopTest();
    }
    
    static testMethod void testFail(){
        Assessment__c s = new Assessment__c();

        test.startTest();
        
        PageReference ref = Page.AssessmentEditPage1;
        Test.setCurrentPage(ref);
        assessmentEditController c = new assessmentEditController(new ApexPages.StandardController(s));
        ApexPages.PageReference returnPage = c.step2();
        s.Account__c = a.Id;
        s.Business_Segment__c = 'RTFM';
        s.Market_Size__c = 'Monopoly';
        s.Partner_Type__c = 'Frigid';
        returnPage = c.step2();
        s.Requested_Tier__c = 'Silver';
        returnPage = c.customSave();
        
        test.stopTest();
    }
    
    static testMethod void testClusterAccount(){
        Assessment__c s = new Assessment__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'PACS',
            Market_Size__c = 'EMEA-Small',
            Partner_Type__c = 'Distributor',
            Requested_Tier__c = 'Silver',
            SI_Spend__c = 200000,
            Requested_Effective_Date_for_Pricing__c = date.today()
        );
        insert s;
        
        s = new Assessment__c(
            Account__c = a.Id,
            Business_Segment__c = 'Identity Assurance',
            Market_Size__c = 'EMEA-Small',
            Partner_Type__c = 'Distributor',
            Requested_Tier__c = 'Silver',
            SI_Spend__c = 200000,
            Requested_Effective_Date_for_Pricing__c = date.today()
        );
        test.startTest();
        
        PageReference ref = Page.AssessmentEditPage1;
        Test.setCurrentPage(ref);
        
        assessmentEditController c = new assessmentEditController(new ApexPages.StandardController(s));
        c.getObjAssessment();
        c.getObjAssessmentApproved();
        c.getBolIA();
        
        ApexPages.PageReference returnPage = c.step2();
        returnPage = c.step1();
        returnPage = c.customSave();
        
        test.stopTest();
    }
    static testMethod void testDelete(){
        Assessment__c s = new Assessment__c(
            Account__c = a.Id,
            Partner_Type__c = 'OEM',
            Requested_Tier__c = 'Silver',
            Requested_Effective_Date_for_Pricing__c = date.today()
        );
        insert s;
        
        test.startTest();
        
        assessmentEditController c = new assessmentEditController(new ApexPages.StandardController(s));
        c.customDelete();
        
        test.stopTest();
    }
}