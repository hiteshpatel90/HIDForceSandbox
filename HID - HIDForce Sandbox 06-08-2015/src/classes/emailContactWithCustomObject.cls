public with sharing class emailContactWithCustomObject {
	public emailContactWithCustomObject(){
		Id idTemplate = [
			SELECT
				Id
			FROM
				EmailTemplate
			WHERE
				DeveloperName = 'Advantage_Partner_Resource_Centre'
		].Id;
		
		Id idUser = [
			SELECT
				Id
			FROM
				User
			WHERE
				Name = 'Tanja Neumann'
		].Id;
		
		Id idCampaign = [
			SELECT
				Id
			FROM
				Campaign
			WHERE
				Campaign.Name = 'Advantage Partner Marketing Resource Centre'
		].Id;
		
		list<Messaging.SingleEmailMessage> lstEmailMessage = new list<Messaging.SingleEmailMessage>();
		
		for(CampaignMember c : [SELECT c.ContactId FROM CampaignMember c WHERE CampaignId =: idCampaign]){
			Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();

			m.setTemplateID(idTemplate);
			m.setSenderDisplayName('Tanja Neumann');
			m.setReplyTo('tneumann@hidglobal.com');
			m.setUseSignature(false);
			m.setTargetObjectId(c.ContactId);
			
			lstEmailMessage.add(m);
		}
		
		Messaging.sendEmail(lstEmailMessage);
	}
}