public with sharing class emailCaseReminder {
	public emailCaseReminder(){
		
		String strFromId = [
			SELECT
				Id
			FROM
				OrgWideEmailAddress
			WHERE
				Address = 'hidepsupport@hidglobal.com'
			LIMIT 1
		].Id;
		
		String strQPrinterReceivingId = [
			SELECT
				QueueId
			FROM
				QueueSobject
			WHERE
				SobjectType = 'Case'
				AND Queue.Name = 'Q: Printer RECEIVING'
				LIMIT 1
		].QueueId;
		
		String strTaskOwner = [
			SELECT
				Id
			FROM
				User
			WHERE
				Email = 'jmunoz@hidglobal.com'
				AND UserType = 'Standard'
		].Id;
		
		map<String, Date> mapDate = new map<String, Date>{
			'today' => date.today(),
			'add15' => date.today().addDays(-15),
			'add30' => date.today().addDays(-30),
			'add45' => date.today().addDays(-45),
			'add60' => date.today().addDays(-60)
		};
		
		map<String, Id> mapEmailTemplate = new map<String, Id>();
		
		for(EmailTemplate t : [
			SELECT 
				DeveloperName,
				Id
			FROM
				EmailTemplate
			WHERE
				DeveloperName IN (
					'Overdue_Loaner_Notification',
					'Overdue_Loaner_Notification_2nd_notice',
					'Overdue_Loaner_Notification_Final_notice',
					'Overdue_Cross_Ship_notification',
					'Overdue_Cross_Ship_notification_Final',
					'Repair_payment_hold_notification',
					'Evaluation_Printer_Request_Processed',
					'Evaluation_Printer_Expired_1st_Notice',
					'Evaluation_Printer_Expired_2nd_Notice',
					'Evaluation_Printer_Expired_Final_Notice',
					'Evaluation_Printer_Expired'
				)
			]
		){
			mapEmailTemplate.put(t.DeveloperName, t.Id);
		}
	
		list<Case> lstCase = new list<Case>([
			SELECT 
				Id,
				ContactId,
				RMA_Expiration_Date__c,
				RMA_Type__c
			FROM
				Case
			WHERE
				(
					(
						RMA_Type__c = '39-Loaner Printer'
						AND RMA_Expiration_Date__c IN (
							:mapDate.get('today'),
							:mapDate.get('add15'),
							:mapDate.get('add30')
						)
					)OR(
						RMA_Type__c = '32-Warranty cross-ship'
						AND RMA_Expiration_Date__c IN (
							:mapDate.get('today'),
							:mapDate.get('add30')
						)
					)OR(
						RMA_Type__c = '50-Non-warranty repair'
						AND RMA_Expiration_Date__c IN (
							:mapDate.get('today'),
							:mapDate.get('add30'),
							:mapDate.get('add60')
						) 
					)OR(
						RMA_Type__c = '202-Sales product evaluation'
						AND RMA_Expiration_Date__c IN (
							:mapDate.get('today'),
							:mapDate.get('add15'),
							:mapDate.get('add30'),
							:mapDate.get('add45')
						)
					)
				)
				AND RMA_Date_In__c = null
				AND RMA_Date_Out__c != null
				AND Region__c = 'NAM'
			]
		);
		
		list<Messaging.SingleEmailMessage> lstEmailMessage = new list<Messaging.SingleEmailMessage>();
		list<Task> lstTask = new list<Task>();
		
		for(Case c : lstCase){
			Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
			
			m.setWhatId(c.Id);
			m.setUseSignature(false);
			m.setTargetObjectId(c.ContactId);
			m.setOrgWideEmailAddressId(strFromId);
			
			if(c.RMA_Type__c == '39-Loaner Printer'){
				if(c.RMA_Expiration_Date__c == mapDate.get('today')){
					m.setTemplateID(mapEmailTemplate.get('Overdue_Loaner_Notification'));
				}else if(c.RMA_Expiration_Date__c == mapDate.get('add15')){
					m.setTemplateID(mapEmailTemplate.get('Overdue_Loaner_Notification_2nd_notice'));
				}else if(c.RMA_Expiration_Date__c == mapDate.get('add30')){
					m.setTemplateID(mapEmailTemplate.get('Overdue_Loaner_Notification_Final_notice'));
				}
			}else if(c.RMA_Type__c == '32-Warranty cross-ship'){
				if(c.RMA_Expiration_Date__c == mapDate.get('today')){
					m.setTemplateID(mapEmailTemplate.get('Overdue_Cross_Ship_notification'));
				}else if(c.RMA_Expiration_Date__c == mapDate.get('add30')){
					m.setTemplateID(mapEmailTemplate.get('Overdue_Cross_Ship_notification_Final'));
				}
			}else if(c.RMA_Type__c == '50-Non-warranty repair'){
				m.setTemplateID(mapEmailTemplate.get('Repair_payment_hold_notification'));
			}else if(c.RMA_Type__c == '202-Sales product evaluation'){
				if(c.RMA_Expiration_Date__c == mapDate.get('today')){
					m.setTemplateID(mapEmailTemplate.get('Evaluation_Printer_Expired'));
				}else if(c.RMA_Expiration_Date__c == mapDate.get('add15')){
					m.setTemplateID(mapEmailTemplate.get('Evaluation_Printer_Expired_1st_Notice'));
				}else if(c.RMA_Expiration_Date__c == mapDate.get('add30')){
					m.setTemplateID(mapEmailTemplate.get('Evaluation_Printer_Expired_2nd_Notice'));
				}else if(c.RMA_Expiration_Date__c == mapDate.get('add45')){
					m.setTemplateID(mapEmailTemplate.get('Evaluation_Printer_Expired_Final_Notice'));
					Task t = new Task(
						OwnerId = strTaskOwner,
						WhatId = c.Id,
						WhoId = c.ContactId,
						Type = 'Email',
						ActivityDate = date.today(),
						IsReminderSet = true,
						ReminderDateTime = datetime.now(),
						Priority = 'Normal',
						Status = 'Not Started',
						Subject = 'Evaluation Printer Expired - Final Notice'
					);
					lstTask.add(t);
				}
			}
			
			lstEmailMessage.add(m);
		}
		
		insert(lstTask);
		
		map<Id, Case> mapCase = new map<Id, Case>([
			SELECT 
				Id,
				ContactId
			FROM
				Case
			WHERE
				RMA_Expiration_Date__c > TODAY 
				AND RMA_Type__c = '202-Sales product evaluation'
				AND RMA_Date_In__c = null
				AND OwnerId =: strQPrinterReceivingId
				AND Region__c = 'NAM'
			]
		);

		for(EmailMessage e : [
			SELECT
				ParentId
			FROM
				EmailMessage
			WHERE
				Subject	LIKE 'Processed Fargo Evaluation Printer%'
				AND ParentId IN : mapCase.keySet()
			]
		){
			mapCase.remove(e.ParentId);	
		}

		for(Case c : mapCase.values()){
			Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
			
			m.setWhatId(c.Id);
			m.setUseSignature(false);
			m.setTargetObjectId(c.ContactId);
			m.setOrgWideEmailAddressId(strFromId);
			m.setTemplateID(mapEmailTemplate.get('Evaluation_Printer_Request_Processed'));
			
			lstEmailMessage.add(m);
		}

		Messaging.sendEmail(lstEmailMessage);
	}
}