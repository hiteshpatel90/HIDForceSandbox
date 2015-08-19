@isTest
class testCampaignMemberTrigger{
    static testmethod void CampaignMemberTriggerTest() {
        Test.startTest();
        campaign c = new Campaign(name = 'Test');
        insert c;
        
        
        List<campaign> camp = [select id from campaign where id = :c.id];
        Lead l = new lead(Company = 'grazitti', LastName = 'My test Lead', Status = 'New', LeadSource = 'Tradeshow or Event', Areas_of_Interest__c = 'ActivIdentity', 
        
        Country = 'United States', State = 'Indiana');
        
        insert l;
        CampaignMember cm = new CampaignMember(status = 'Sent', campaignId = camp[0].id,leadId = l.id);
        insert cm;
        
        cm.status = 'Responded';
        update cm;
         Test.stopTest();
    }
}