trigger setContractEndNotificationDate on Contract (before insert, before update) {
	for(Contract c : trigger.new){
		if(c.StartDate == null){
			c.addError('Start Date is required!');
		}else{
			Decimal decNotificationYears = Decimal.valueOf((c.StartDate.daysBetween(date.today()) / 365)).round(system.roundingmode.DOWN) + 1;
			if(c.EndDate != null){
				c.Contract_End_Notification_Date__c = c.EndDate;
				if(c.OwnerExpirationNotice != null){
					c.Contract_End_Warning_Date__c = c.EndDate.addDays(-(integer.valueOf(c.OwnerExpirationNotice)));
				}
				if(c.StartDate.daysBetween(c.EndDate) > 365 && c.StartDate.addYears(Integer.valueOf(decNotificationYears)) < c.EndDate){
					c.Anti_Bribery_Recertification_Date__c = c.StartDate.addYears(Integer.valueOf(decNotificationYears));
				}else{
					c.Anti_Bribery_Recertification_Date__c = null;
				}
			}else{
				c.Anti_Bribery_Recertification_Date__c = c.StartDate.addYears(Integer.valueOf(decNotificationYears));
			}
		}
	}
}