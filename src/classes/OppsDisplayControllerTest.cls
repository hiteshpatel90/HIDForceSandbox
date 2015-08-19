@istest
class OppsDisplayControllerTest
{
	static{
    	Currencies__c curr = new Currencies__c(Name = 'N. America USD', Sub_Region__c = 'N. America', Currency__c = 'USD', Default__c = true);
    	insert curr;
	}

    static testMethod void testPage(){
    
    Profile p = [SELECT Id FROM Profile WHERE Name = 'HID Business Administrator'];
    
    User u1 = new User(Alias = 'standt', Email='standarduser@hidglobal.com', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@hidglobal.com');
    
    system.runas(u1){
        
        
        Account testAcct = new Account();
        testAcct.name = 'temp';
        testAcct.BillingCountry = 'United States';
        testAcct.BillingState = 'California';
        testAcct.business_segment__c = 'Secure Issuance';
        testAcct.channel__c = 'competitor';
        testAcct.type = 'End-User';
        insert testAcct;
        
        Account_Profile__c ap = new Account_Profile__c(
            Account__c = testAcct.Id,
            Business_Segment__c = 'Animal ID',
            Partner_Type__c = 'OEM',
            Tier__c = 'Silver',
            Recommended_Tier__c = 'Silver'
        );
        insert ap;
        
        Opportunity testOpps = new Opportunity();
        testOpps.name = 'test name';
        testOpps.recordTypeId = [select id from recordtype where developername = 'IDS_Opportunity'].Id;
        testOpps.Accountid = testAcct.id;
        testOpps.region__c = 'nam';
        testOpps.type = 'project';
        testOpps.stagename = 'Discovery';
        testopps.CloseDate=Date.today();
        testOpps.Business_Segment__c = 'Animal ID';
        insert testOpps;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(testOpps);
        ApexPages.currentPage().getParameters().put('id',testOpps.id);
        
        
        OppsDisplayPageController temp = new OppsDisplayPageController(controller);
        temp.goback();
        temp.saveopp();
        temp.changeStageName();
        temp.Authenticate();
        }
    }
}