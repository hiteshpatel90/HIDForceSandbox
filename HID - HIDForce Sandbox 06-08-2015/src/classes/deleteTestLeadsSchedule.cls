global class deleteTestLeadsSchedule implements Schedulable{
	global void execute(SchedulableContext c){
		deleteTestLeads l = new deleteTestLeads();
	}
}