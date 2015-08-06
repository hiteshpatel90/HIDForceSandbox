global class xmlWriterBrazilTaxAdjustmentSchedule implements Schedulable{
    global void execute(SchedulableContext c){
		xmlWriterBrazilTaxAdjustment.sendXML('add');
    }
}