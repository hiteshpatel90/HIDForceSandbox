global class emailCaseReminderSchedule implements Schedulable{
	global void execute(SchedulableContext c){
		system.debug(UserInfo.getOrganizationId());
		if(UserInfo.getOrganizationId().startsWith('00Dn0000000DdL9')){
			emailCaseReminder e = new emailCaseReminder();
		}
	}
}