global class emailContactWithCustomObjectSchedule implements Schedulable{
	global void execute(SchedulableContext c){
		emailContactWithCustomObject e = new emailContactWithCustomObject();
	}
}