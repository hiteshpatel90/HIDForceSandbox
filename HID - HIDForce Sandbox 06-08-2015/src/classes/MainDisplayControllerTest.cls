@istest(seeAllData = true)
class MainDisplayControllerTest
{
    static testMethod void testPage(){
    Profile p = [SELECT Id FROM Profile WHERE Name = 'HID Business Administrator'];
    
    User u1 = new User(Alias = 'standt', Email='standarduser@hidglobal.com', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@hidglobal.com');
    //user u1 = [SELECT Id FROM User WHERE Alias='alech'];
    
    system.runas(u1){
        
        Lead testLead = new lead();
        testLead.lastname = 'testerson';
        testLead.firstname = 'test';
        testLead.company = 'Testing';
        testLead.status = 'new';
        testLead.leadsource = 'Tradeshow or Event';
        testLead.Areas_Of_Interest__c = 'Laser Card';
        testLead.Partner_Name__c = 'None';
        testLead.Country = 'United States';
        testLead.State = 'Michigan';
        insert testLead;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(testLead);
        ApexPages.currentPage().getParameters().put('pageToDisplay','test');
        HidPortalAuthenticationController pController = new HidPortalAuthenticationController();
        
        //ApexPages.currentPage().getParameters().put('u','None');
        MainDisplayPageController temp = new MainDisplayPageController(controller);
  
        temp.getData();
        temp.getLeadResults();
        temp.getOppsResults();
        //temp.OpenOppsPage();
        //temp.OpenLeadPage();
        temp.setString('All Leads');
        temp.getPaginationList();// added by Gaurav for pagination.
        temp.FilterData();
        CommUtils.getPaginationList(5,100,10 );
        CommUtils.getPaginationList(9,100,10 );
        }
    }
}