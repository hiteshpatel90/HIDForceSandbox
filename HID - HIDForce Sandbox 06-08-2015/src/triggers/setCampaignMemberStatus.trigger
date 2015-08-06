trigger setCampaignMemberStatus on Campaign (after insert) {
	list<CampaignMemberStatus> s = new list<CampaignMemberStatus>();
	for(Campaign c : trigger.new){
		if(
			c.Type == 'Tradeshow'
			|| c.Type == 'Event'
		){
			s.add(
				new CampaignMemberStatus(
					CampaignId = c.Id,
					HasResponded = false,
					Label = 'Attended',
					SortOrder = 0
				)
			);
		}
	}
	insert s;
}