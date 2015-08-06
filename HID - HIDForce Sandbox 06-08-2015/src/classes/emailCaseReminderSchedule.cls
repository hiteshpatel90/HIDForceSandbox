global class emailCaseReminderSchedule implements Schedulable{
	global void execute(SchedulableContext c){
		system.debug(UserInfo.getOrganizationId());
		if(UserInfo.getOrganizationId().startsWith('00D560000000awV')){
			emailCaseReminder e = new emailCaseReminder();
		}
	}
}