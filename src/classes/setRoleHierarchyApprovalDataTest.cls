@isTest
private class setRoleHierarchyApprovalDataTest {
	static User u;
	static User l1;
	static User e21; 
	static User l2;
	static User e21vp;
	static Role_Hierarchy_Approval__c r;
	
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
	}
	
    static testMethod void testAddDuplicate(){
    	test.startTest();
    	
    	try{
			Role_Hierarchy_Approval__c r2 = new Role_Hierarchy_Approval__c(
				Full_Name__c = u.Id,
				L1_Approver__c = l1.Id,
				E21_Approver__c = e21.Id,
				L2_Approver__c = l2.Id,
				E21VP_Approver__c = e21vp.Id
			);
			insert r2;
    	}catch(DmlException e){
	         System.assert(e.getNumDml() == 1);
	         System.assert(e.getDmlIndex(0) == 0);
	         System.assert(e.getDmlFields(0).size() == 1);
      	}
    	
    	test.stopTest();
    }
    
    static testMethod void testUpdateDuplicate(){
    	test.startTest();
    	
    	try{
	    	Role_Hierarchy_Approval__c r2 = [
	    		SELECT
		    		Full_Name__c
		    	FROM
		    		Role_Hierarchy_Approval__c
		    	WHERE
		    		Id =: r.Id
	    	];
	    	r2.Full_Name__c = l1.Id;
	    	update r2;
    	}catch(DmlException e){
	         System.assert(e.getNumDml() == 1);
	         System.assert(e.getDmlIndex(0) == 0);
	         System.assert(e.getDmlFields(0).size() == 1);
      	}
      	
      	test.stopTest();
    }
    
    static testMethod void testAddDuplicateList(){
    	test.startTest();
    	
    	try{
	    	list<Role_Hierarchy_Approval__c> lstRoleHierarchyApproval = new list<Role_Hierarchy_Approval__c>{
    			new Role_Hierarchy_Approval__c(Full_Name__c = l1.Id, E21_Approver__c = e21.Id, L2_Approver__c = l2.Id, E21VP_Approver__c = e21vp.Id),
    			new Role_Hierarchy_Approval__c(Full_Name__c = l1.Id, E21_Approver__c = e21.Id, L2_Approver__c = l2.Id, E21VP_Approver__c = e21vp.Id)
    		};
    		insert lstRoleHierarchyApproval;
    	}catch(DmlException e){
	         System.assert(e.getNumDml() == 1);
	         System.assert(e.getDmlFields(0).size() == 1);
      	}
      	
      	test.stopTest();
    }
}