global class ScheduledLeadRoutingReset implements Schedulable{
    // Author : Timmus Agersea
    // Purpose: Run the monthly process of resetting LeadRouting
    global void execute(SchedulableContext sc) {
        LeadRoutingReset lrr = new LeadRoutingReset();
        lrr.Reset();
    }
    
    static testmethod void ScheduledLeadRoutingReset_Test() {
        Test.startTest();

        ScheduledLeadRoutingReset thisClass = new ScheduledLeadRoutingReset();
        thisClass.execute(null);

        Test.stopTest();
   }
}