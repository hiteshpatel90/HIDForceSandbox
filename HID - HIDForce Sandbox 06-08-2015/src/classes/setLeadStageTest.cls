@isTest
private class setLeadStageTest {
    static testMethod void setLeadStageTest() {
    	Lead l = new Lead();
        
        l.FirstName = 'Dothetriggertest';
		l.LastName = 'Test';
		l.Company = 'Testcompany';
		l.Status = 'In Progress';
		insert l;
		
		l = [SELECT Lead_Stage__c, Status FROM Lead WHERE Id =: l.id];
		system.assertEquals(l.Lead_Stage__c, 'In Progress');
		
		l.Status = 'Qualified';
		update l;
		
		l = [SELECT Lead_Stage__c, Status FROM Lead WHERE Id =: l.id];
		system.assertEquals(l.Lead_Stage__c, 'Closed');
    }
}