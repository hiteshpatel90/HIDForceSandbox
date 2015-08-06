@isTest(seeAllData=true)
private class setBidDeadlineFromQuoteTest {
    static testMethod void setBidDeadlineFromQuoteTest() {
		BigMachines__Quote__c b = [SELECT Id, Bid_Deadline__c, BigMachines__Opportunity__c FROM BigMachines__Quote__c WHERE BigMachines__Is_Primary__c = true LIMIT 1];
		b.Bid_Deadline__c = date.today();
		update b;
		/*Account a = new Account(Name='Damage Inc.');
		insert a;
		Opportunity o = new Opportunity(Name='The Damage Done', Account=a, StageName='Discovery', CloseDate=date.today().addDays(1));
		insert o;
		BigMachines__Quote__c b = new BigMachines__Quote__c(BigMachines__Account__c = a.Id, BigMachines__Opportunity__c = o.Id, Bid_Deadline__c = date.today(), BigMachines__Is_Primary__c=true);
		insert b;*/
		/*Opportunity o = [SELECT Bid_Deadline__c FROM Opportunity WHERE Id =: b.BigMachines__Opportunity__c];
		system.assertEquals(o.Bid_Deadline__c,date.today());*/
    }
}