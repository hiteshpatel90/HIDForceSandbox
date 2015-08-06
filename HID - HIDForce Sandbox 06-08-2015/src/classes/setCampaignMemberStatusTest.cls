@isTest
private class setCampaignMemberStatusTest {

    static testMethod void setCampaignMemberStatusTest() {
        Date datToday = Date.today();
        Campaign c = new Campaign(
            Name = 'Test Tradeshow',
            Type = 'Tradeshow',
            StartDate = datToday,
            EndDate = datToday.addDays(1)
        );
        insert c;
        Id s = [SELECT Id FROM CampaignMemberStatus WHERE CampaignId =: c.Id AND Label = 'Attended'].Id;
        system.assert(s != null);
    }
}