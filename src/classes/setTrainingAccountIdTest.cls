@isTest
private class setTrainingAccountIdTest {
    static testMethod void setTrainingAccountIdTest() {
        Account a = new Account(Name='New Account');
    	insert a;

    	/*Course__c k = new Course__c(Name = 'Do the pivCLASS Monkey!', Duration_Hours__c = 10);
    	Course__c k = new Course__c(Name = 'Do the pivCLASS Monkey!');
    	insert k;*/
    	list<Course__c> lstCourses = new list<Course__c>{
    		new Course__c(Name = 'pivCLASS Advanced Training V3.x'),
    		new Course__c(Name = 'pivCLASS PKI @ the Door Training V4.x'),
    		new Course__c(Name = 'pivCLASS Software Training V4.x')
    	};
    	Database.SaveResult[] dsrCourses = Database.insert(lstCourses);

    	
    	Contact c = new Contact(AccountId = a.Id, LastName='Test', Email='Test@force.com', Status__c='Active');
    	insert c;
    	
    	//Training__c t = new Training__c(Attendee__c = c.Id, Course_or_Module__c = k.Id);
    	Training__c t = new Training__c(Attendee__c = c.Id, Account__c = a.Id, Course_or_Module__c = dsrCourses[0].Id);
    	insert t;
    	
    	//t = [SELECT Account__c, Duration_Hours__c FROM Training__c WHERE Id =: t.Id];
    	t = [
    		SELECT
    			Id,
    			Account__c
    		FROM
    			Training__c
    		WHERE Id =: t.Id
    	];
    	
    	system.assertEquals(t.Account__c, a.Id);
    	//system.assertEquals(t.Duration_Hours__c, k.Duration_Hours__c);
    	
    	c = new Contact(AccountId = a.Id, LastName='Test2', Email='test2@force.com', Status__c='Active');
    	insert c;
    	
    	t = new Training__c(Attendee__c = c.Id, Account__c = a.Id, Course_or_Module__c = dsrCourses[0].Id);
    	insert t;
    	
    	a = [SELECT Id, HID__c FROM Account WHERE Id =: a.Id];
    	system.assertEquals(a.HID__c,'pivCLASS PAMs');
    	
    	a.HID__c += ';HDPii Reseller';
    	update a;
    	
    	delete t;
    	a = [SELECT Id, HID__c FROM Account WHERE Id =: a.Id];
    	system.assertEquals(a.HID__c,'HDPii Reseller');
    	
    	a.HID__c += ';HOTD Sales';
    	update a;
    	
    	t = new Training__c(Attendee__c = c.Id, Account__c = a.Id, Course_or_Module__c = dsrCourses[1].Id);
    	insert t;
    	
    	a = [SELECT Id, HID__c FROM Account WHERE Id =: a.Id];
    	system.assert(a.HID__c.contains('pivCLASS PAMs'));
    	
    	c.Status__c = 'Inactive';
    	update c;
    	
    	a = [SELECT Id, HID__c FROM Account WHERE Id =: a.Id];
    	system.assert(!a.HID__c.contains('pivCLASS PAMs'));
    	
    	c.Status__c = 'Active';
    	update c;
    	
    	delete c;
    	
    	c = new Contact(AccountId = a.Id, LastName='Test3', Email='test3@force.com', Status__c='Active');
    	insert c;
    	
    	t = new Training__c(Attendee__c = c.Id, Course_or_Module__c = dsrCourses[1].Id);
    	insert t;
    	
		Account a2 = new Account(Name='New Account2');
    	insert a2;
    	
    	c.AccountId = a2.Id;
    	update c;
    	
    	a = [SELECT Id, HID__c FROM Account WHERE Id =: a.Id];
    	system.assert(!a.HID__c.contains('pivCLASS PAMs'));
    }
}