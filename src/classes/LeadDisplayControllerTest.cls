@istest
class LeadDisplayControllerTest
{
    static testMethod void testPage(){
      
    Profile p = [SELECT Id FROM Profile WHERE Name = 'HID Business Administrator'];
    
    User u1 = new User(Alias = 'standt', Email='standarduser@hidglobal.com', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@hidglobal.com');
      
    system.runas(u1){
        
        Lead testLead = new lead();
        testLead.lastname = 'testerson';
        testLead.firstname = 'test';
        testLead.company = 'Testing';
        testLead.status = 'new';
        testLead.leadsource = 'Tradeshow or Event';
        testLead.Areas_Of_Interest__c = 'Laser Card';
        
        /*testLead.Address_Country__c = 'United States';
        testLead.Address_State__c = 'MI';*/
        
        testLead.Country = 'United States';
        testLead.State = 'Michigan';
        insert testLead;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(testLead);
        ApexPages.currentPage().getParameters().put('id',testLead.id);
        
        LeadDisplayPageController temp = new LeadDisplayPageController(controller);
        temp.convert();
        temp.goback();
        temp.authenticate();
        temp.save();
        temp.SaveLead();
        }
    }
}