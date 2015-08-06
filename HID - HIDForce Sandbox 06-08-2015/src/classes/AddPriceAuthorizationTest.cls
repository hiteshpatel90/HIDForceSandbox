@isTest

private class AddPriceAuthorizationTest{

   
    static testMethod void NewPafTest(){
    //insert account record
    Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', BillingCountry = 'Brazil', BillingState = 'Acre', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
    insert account;
    
    //for PafPicklistsController controller with billingCountry=null
    Account account1=new Account(Name = 'Test Account', Channel__c = 'Test Channel',E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
    insert account1;
     
    
    Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
    insert acpf;
       
    Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');
    insert con; 
    
    Contact con1 = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Status__c='active',Pricing_Notifications__c = 'No');
    insert con1;   
       
   
    Id idAdvantagePartnerRecordType = [SELECT Id FROM RecordType WHERE Name = 'Advantage Partner' AND SobjectType = 'Partner_Program__c'].Id;
    
    Partner_Program__c pp =new Partner_Program__c(Partner_Program_Status__c='Enrolled',Partner_Program_Status_Modifier__c='Inelegible',Account__c=account.id,Primary_Contact__c=con1.id);
    insert pp;
    
    Partner_Program__c pp1 =new Partner_Program__c(Partner_Program_Status__c='Enrolled',Partner_Program_Status_Modifier__c='Inelegible',Account__c=account.id,Primary_Contact__c=con1.id,RecordTypeid=idAdvantagePartnerRecordType );
    insert pp1; 
    
    Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con1.Id,L2_Approver__c =UserInfo.getUserId(), Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');

    //for PafPicklistsController controller
    Price_Authorization_Form__c paf2 = new Price_Authorization_Form__c(Account__c = account1.id,iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
        
    //for PafPicklistsController controller
    Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'FA_Prof_Printers__c', Display_Value__c = 'FA55 Gold', Submit_Value__c = 'FA55',Country__c ='Brazil');
    insert pafc;

    //for PafPicklistsController controller
    ApexPages.StandardController contr = new ApexPages.StandardController(paf2);
    AddPriceAuthorization adpaf = new AddPriceAuthorization(contr);
    
   
    
    
    
    
    ApexPages.StandardController contr1 = new ApexPages.StandardController(paf);
    AddPriceAuthorization adpaf1 = new AddPriceAuthorization(contr1); 
   
    getQueryforAccount qry = new  getQueryforAccount();
    AddPriceAuthorization adpaf2 = new AddPriceAuthorization(contr1);
    adpaf2.savePriceAuthorization();
    adpaf2.saveAndNewPriceAuthorization();
    adpaf2.cancelPriceAuthorization();
              
    Price_Authorization_Form__c PAF1 =new Price_Authorization_Form__c(Account__c = account.id,iR__c = 'iR45', New_HID_Customer__c = 'No');
    adpaf2.savePriceAuthorization();
    
    
    }
    
}