@isTest

private class priceAuthorizationHistoryControllerTest {

    static testMethod void PAFobjectHistory(){
         
         Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India',E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
         insert account;
    
         Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
         insert acpf;
       
         Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, 
                                   Pricing_Notifications__c = 'No');   
           
         Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'FA_Prof_Printers__c', 
                                    Display_Value__c = 'FA55 Gold', Submit_Value__c = 'FA55');
                                   
         insert pafc; 
           
         Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,
                                    iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
    
         insert paf;                               
    
        ApexPages.StandardController contr = new ApexPages.StandardController(paf);
        priceAuthorizationHistoryController objpafHistory = new priceAuthorizationHistoryController(contr);
    
    }
}