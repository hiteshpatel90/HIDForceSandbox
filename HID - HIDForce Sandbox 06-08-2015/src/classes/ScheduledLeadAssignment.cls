global class ScheduledLeadAssignment implements Schedulable{
    // Author : Timmus Agersea
    // Purpose: Run the daily process of reassigning leads that were not reviewed
    global void execute(SchedulableContext sc) {
        LeadAssignment leadassign = new LeadAssignment();
        leadassign.ReassignLeads();
    }
    
    static testmethod void ScheduledLeadAssignment_Test() {
        Test.startTest();

        ScheduledLeadAssignment thisClass = new ScheduledLeadAssignment();
        thisClass.execute(null);

        Test.stopTest();
   }
}