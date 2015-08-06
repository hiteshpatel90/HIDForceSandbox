@isTest(seeAlldata=true)
private class setAccountClusterMemberDataTest {

    static testMethod void myUnitTest() {
        Account a = new Account(Name = 'Don Bilbo Inc.', BillingCountry = 'United States', BillingState = 'California', Sub_Region__c = 'N. America', Region__c = 'NAM');
        insert a;
        
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test 4567', Cluster_Type__c = 'Regional', Region__c = 'NAM');
        insert ac;
        
        Account_Cluster_Member__c acm = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
        try{
            insert acm;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        }
        
        Account_Profile__c cp = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'EMEA-Regional'
        );
        insert cp;
        
        insert acm;
        
        ac.Name = 'HID Test 4566';
        update ac;
        
        delete acm;
        
        a = new Account(Name = 'Don Bilbo 4 Inc.', BillingCountry = 'Germany', Sub_Region__c = 'W. Europe', Region__c = 'EMEA');
        insert a;
        
        acm = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
        try{
            insert acm;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        }
        
        a = new Account(Name = 'Don Bilbo 2 Inc.', BillingCountry = 'United States', BillingState = 'California', Sub_Region__c = 'N. America', Region__c = 'NAM');
        insert a;
        
		cp = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'EMEA-Large'
        );
        insert cp;
        
		cp = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Connect',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'EMEA-Large'
        );
        insert cp;
        
        acm = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
        insert acm;
        
        acm = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
        try{
            insert acm;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        }
        
    }
    static testMethod void myUnitTest2() {
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test 4576', Cluster_Type__c = 'Global', Region__c = 'EMEA');
        insert ac;
        
        Account a = new Account(Name = 'Don Bilbo 3 Inc.', BillingCountry = 'United States', BillingState = 'California', Sub_Region__c = 'N. America', Region__c = 'NAM');
        insert a;
        
        Account_Cluster_Member__c acm = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
        
        test.startTest();
        try{
            insert acm;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        }
        test.stopTest();
    }
    
	static testMethod void myUnitTest3(){
        Account a = new Account(Name = 'Don Bilbo 2 Inc.', BillingCountry = 'United States', BillingState = 'California', Sub_Region__c = 'N. America', Region__c = 'NAM');
        insert a;
        
		Account_Profile__c cp = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert cp;
        
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test 4576', Cluster_Type__c = 'Regional', Region__c = 'NAM');
        insert ac;
        
		cp = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'OEM',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert cp;
        
        Account_Cluster_Member__c acm = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
		
		test.startTest();
        try{
            insert acm;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        }
        test.stopTest();
	}
	
	static testMethod void myUnitTest4(){
        Account a = new Account(Name = 'Don Bilbo 2 Inc.', BillingCountry = 'United States', BillingState = 'California',  Sub_Region__c = 'N. America', Region__c = 'NAM');
        insert a;
        
		Account_Profile__c cp = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert cp;
        
		cp = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Identity Assurance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert cp;
        
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test 4576', Cluster_Type__c = 'Regional', Region__c = 'NAM');
        insert ac;
        
		cp = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert cp;
        
        Account_Cluster_Member__c acm = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);

		test.startTest();
        try{
            insert acm;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        }
        test.stopTest();
	}
	
	static testMethod void myUnitTest5(){
        Account a = new Account(
        	Name = 'Don Bilbo 2 Inc.',
        	BillingCountry = 'United States',
        	BillingState = 'California',
        	Sub_Region__c = 'N. America',
        	Region__c = 'NAM',
            Oracle_Customer_Number__c = '55555'
        );
        insert a;
        
		Account_Profile__c cp = new Account_Profile__c(
            Account__c = a.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert cp;
        
        Partner_Program__c pp = new Partner_Program__c(
        	RecordTypeId = utilController.idAdvantagePartnerRecordType,
        	Account__c = a.Id,
        	Partner_Program_Status__c = 'Enrolled',
        	Partner_Program_Status_Modifier__c = 'N/A'
        );
        insert pp;

		Assessment__c asm = new Assessment__c(
			Account__c = a.Id,
			Business_Segment__c = 'Secure Issuance',
			Partner_Type__c = 'Distributor',
			Market_Size__c = 'AME-Large',
			Approval_Status__c = 'Approved',
			Recommended_Tier__c = 'Silver',
			Requested_Tier__c  ='Silver',
			Requested_Effective_Date_For_Pricing__c = date.today()
		);
		insert asm;
		
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test 4576', Cluster_Type__c = 'Regional', Region__c = 'NAM');
        insert ac;
        
		cp = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert cp;
        
		cp = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'PACS',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert cp;
        
		asm = new Assessment__c(
			Account_Cluster__c = ac.Id,
			Business_Segment__c = 'Secure Issuance',
			Partner_Type__c = 'Distributor',
			Market_Size__c = 'AME-Large',
			Approval_Status__c = 'Approved',
			Recommended_Tier__c = 'Silver',
			Requested_Tier__c  ='Silver',
			Requested_Effective_Date_For_Pricing__c = date.today()
		);
		insert asm;
		
		asm = new Assessment__c(
			Account_Cluster__c = ac.Id,
			Business_Segment__c = 'PACS',
			Partner_Type__c = 'Distributor',
			Market_Size__c = 'AME-Large',
			Approval_Status__c = 'Approved',
			Recommended_Tier__c = 'Silver',
			Requested_Tier__c  ='Silver',
			Requested_Effective_Date_For_Pricing__c = date.today()
		);
		insert asm;
        
        Account_Cluster_Member__c acm = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);

		test.startTest();
		insert acm;
        /* try{
            insert acm;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        } */
        test.stopTest();
	}
	
    static testMethod void myUnitTest6() {
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test 4576', Cluster_Type__c = 'Regional', Region__c = 'LAM');
        insert ac;
        
		Account_Profile__c cp = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert cp;
        
        Account a = new Account(Name = 'Don Bilbo 3 Inc.', BillingCountry = 'Brazil', BillingState = 'Acre', Sub_Region__c = 'Brazil', Region__c = 'LAM');
        insert a;
        
        Account_Cluster_Member__c acm = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);
        
        test.startTest();
        insert acm;
        /* try{
            insert acm;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        } */
        test.stopTest();
    }
    
	static testMethod void myUnitTest7(){
        Account a = new Account(
        	Name = 'Don Bilbo 2 Inc.',
        	BillingCountry = 'United States',
        	BillingState = 'California',
        	Sub_Region__c = 'N. America',
        	Region__c = 'NAM',
            Oracle_Customer_Number__c = '55555'
        );
        insert a;
        
        Partner_Program__c pp = new Partner_Program__c(
        	RecordTypeId = utilController.idAdvantagePartnerRecordType,
        	Account__c = a.Id,
        	Partner_Program_Status__c = 'Enrolled',
        	Partner_Program_Status_Modifier__c = 'N/A'
        );
        insert pp;
        
        Account_Cluster__c ac = new Account_Cluster__c(Name = 'HID Test 4576', Cluster_Type__c = 'Regional', Region__c = 'NAM');
        insert ac;
        
		Account_Profile__c cp = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'Secure Issuance',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert cp;
        
		cp = new Account_Profile__c(
            Account_Cluster__c = ac.Id,
            Business_Segment__c = 'PACS',
            Partner_Type__c = 'Distributor',
            Pricebook_Currency__c = 'USD',
            Market_Size__c = 'AME-Large'
        );
        insert cp;
        
		Assessment__c asm = new Assessment__c(
			Account_Cluster__c = ac.Id,
			Business_Segment__c = 'Secure Issuance',
			Partner_Type__c = 'Distributor',
			Market_Size__c = 'AME-Large',
			Approval_Status__c = 'Approved',
			Recommended_Tier__c = 'Silver',
			Requested_Tier__c  ='Silver',
			Requested_Effective_Date_For_Pricing__c = date.today()
		);
		insert asm;
		
		asm = new Assessment__c(
			Account_Cluster__c = ac.Id,
			Business_Segment__c = 'PACS',
			Partner_Type__c = 'Distributor',
			Market_Size__c = 'AME-Large',
			Approval_Status__c = 'Approved',
			Recommended_Tier__c = 'Silver',
			Requested_Tier__c  ='Silver',
			Requested_Effective_Date_For_Pricing__c = date.today()
		);
		insert asm;
        
        Account_Cluster_Member__c acm = new Account_Cluster_Member__c(Account_Cluster__c = ac.Id, Account__c = a.Id);

		test.startTest();
		insert acm;
        /* try{
            insert acm;
            system.assert(false);
        }catch(Exception e){
            system.debug(e.getMessage());
        } */
        test.stopTest();
	}
}