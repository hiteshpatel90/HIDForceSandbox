public with sharing class deleteTestLeads {
	Lead[] testLeads = [SELECT id, name FROM Lead WHERE Owner.Name = 'Test Campaign Leads'];
	Database.DeleteResult[] dr = Database.delete(testLeads);
}