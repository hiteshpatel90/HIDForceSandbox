@isTest
private class assessmentApprovalControllerTest {
    static User u;
    static User l1;
    static User e21; 
    static User l2;
    static User e21vp;
    static Role_Hierarchy_Approval__c r;
    static Account a;
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

    	Currencies__c curr = new Currencies__c(Name = 'W. Europe EUR', Sub_Region__c = 'W. Europe', Currency__c = 'EUR', Default__c = true);
    	insert curr;
    	
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

        l1 = new User(
            Alias = 'l1',
            Email = 'l1@hidglobal.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = pr.Id,
            Country = 'United States',
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'l1@hidglobal.com'
        );
        insert l1;

        e21 = new User(
            Alias = 'e21',
            Email = 'e21@hidglobal.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = pr.Id,
            Country = 'United States',
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'e21@hidglobal.com'
        );
        insert e21;

        l2 = new User(
            Alias = 'l2',
            Email = 'l2@hidglobal.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = pr.Id,
            Country = 'United States',
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'l2@hidglobal.com'
        );
        insert l2;

        e21vp = new User(
            Alias = 'e21vp',
            Email = 'e21vp@hidglobal.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = pr.Id,
            Country = 'United States',
            TimeZoneSidKey = 'America/Los_Angeles',
            Username = 'e21vp@hidglobal.com'
        );
        insert e21vp;

        r = new Role_Hierarchy_Approval__c(
            Full_Name__c = u.Id,
            L1_Approver__c = l1.Id,
            E21_Approver__c = e21.Id,
            L2_Approver__c = l2.Id,
            E21VP_Approver__c = e21vp.Id
        );
        insert r;

        a = new Account(
            Name = 'Don Bilbo Inc.',
            BillingCountry = 'Germany',
            Channel__c = 'IAM - Distribution',
            Sub_Region__c = 'W. Europe'
        );
        insert a;
        
        p = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Market_Size__c = 'EMEA-Small',
            Sales_Manager__c = u.Id
        );
        insert p;
    }
    
    static testMethod void testSuccess(){
        system.runAs(u){
            Assessment__c s = new Assessment__c(
                Account__c = a.Id,
                Business_Segment__c = 'Secure Issuance',
                Requested_Tier__c = 'Platinum',
                Requested_Effective_Date_for_Pricing__c = date.today()
            );
            insert s;
            
            test.startTest();
            
            PageReference ref = Page.AssessmentEditPage2;
            Test.setCurrentPage(ref);
            ApexPages.currentPage().getParameters().put('id', s.Id);
            
            assessmentApprovalController c = new assessmentApprovalController(new ApexPages.StandardController(s));
            
            c.getApprovals();
            c.submitForApproval();
            c.getApprovalHistory();
            c.getWorkItem();
            
            test.stopTest();
        }
    }
    
    static testMethod void testNoApprovalHierarchy(){
        system.runAs(l1){
        
            Contact objCon = new Contact();
            objCon.LastName = 'Tellex';
            objCon.MailingCountry = 'United States';
            objCon.Role__c = 'Information Technology';
            objCon.Role_LMS__c = 'Information Technology';
            objCon.Title = 'Product Manager';
            objCon.Status__c = 'Active';            
            objCon.Email = 'greg.tellex@xerox.com';
            insert objCon;
            
            Assessment__c s = new Assessment__c(
                Account__c = a.Id,
                Business_Segment__c = 'Secure Issuance',
                Requested_Tier__c = 'Platinum',
                Requested_Effective_Date_for_Pricing__c = date.today()
                
            );
            insert s;
            
           
            
            test.startTest();
            
            PageReference ref = Page.AssessmentEditPage2;
            Test.setCurrentPage(ref);
            ApexPages.currentPage().getParameters().put('id', s.Id);
            
            assessmentApprovalController c = new assessmentApprovalController(new ApexPages.StandardController(s));
            
            PageReference pf = c.submitForApproval();
            
            
            s.Partner_Tier_Notification_Contact__c = objCon.id;
            update s;
            
            PageReference pf1 = c.submitForApproval();
            List<ProcessInstance> PIW = c.getApprovals();
            //ProcessInstanceWorkitem PIW1 = c.getApprovals();
        
            c.getApprovals();
            c.submitForApproval();
            
            s.L1_Approver__c = system.userinfo.getuserId();
            update s;
            c.submitForApproval();
            
            c.getApprovalHistory();
            c.getWorkItem();
            
            test.stopTest();
        }
    }
}