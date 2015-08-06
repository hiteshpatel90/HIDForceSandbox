@isTest

public class PAFDetailPageControllerTest{

    static testMethod void PAFDetailPagePAFDraft(){
    
         Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India',E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
         insert account;
    
         Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
         insert acpf;
       
         Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
       
         Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'iR__c', 
                                    Display_Value__c = 'IR55', Submit_Value__c = 'IR55', HID_Connect__c = 'C', In_Program__c = 'P', Restricted__c = 'R');
         insert pafc;
                          
         Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id, Status__c = 'Draft',
                                    iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
         insert paf;
    
         Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setObjectId(paf.id);
        Approval.ProcessResult result = Approval.process(req1);   
            
         ApexPages.StandardController contr = new ApexPages.StandardController(paf);
         ApexPages.CurrentPage().getParameters().put('id', paf.id);
         PAFDetailPageController PAFDetail = new PAFDetailPageController(contr);
         PAFDetail.EditPriceAuthorizationForm();
         PAFDetail.ClonePriceAuthorizationForm();        
         PAFDetail.CancelPAFApproveStatus();
         PAFDetail.PAFStatustoRecall();
         PAFDetail.DeletePriceAuthorizationForm();   
    }
    
    static testMethod void PAFDetailPagePAFAwaiting(){
    
         Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India',E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
         insert account;
    
         Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
         insert acpf;
       
         Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
       
         Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'iR__c', 
                                    Display_Value__c = 'IR55', Submit_Value__c = 'IR55', HID_Connect__c = 'C', In_Program__c = 'P', Restricted__c = 'R');
         insert pafc;
                          
         Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id, Status__c = 'Awaiting Approval',
                                    iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
         insert paf;           
    
         ApexPages.StandardController contr = new ApexPages.StandardController(paf);
         ApexPages.CurrentPage().getParameters().put('id', paf.id);
         PAFDetailPageController PAFDetail = new PAFDetailPageController(contr);
    }
    
    static testMethod void PAFDetailPagePAFApproved(){
    
         Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India',E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
         insert account;
    
         Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
         insert acpf;
       
         Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
       
         Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'iR__c', 
                                    Display_Value__c = 'IR55', Submit_Value__c = 'IR55', HID_Connect__c = 'C', In_Program__c = 'P', Restricted__c = 'R');
         insert pafc;
                          
         Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id, Status__c = 'Approved',
                                    iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
         insert paf;           
    
         ApexPages.StandardController contr = new ApexPages.StandardController(paf);
         ApexPages.CurrentPage().getParameters().put('id', paf.id);
         PAFDetailPageController PAFDetail = new PAFDetailPageController(contr);
    }
    
    static testMethod void PAFDetailPagePAFCancelled(){
    
         Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India',E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
         insert account;
    
         Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
         insert acpf;
       
         Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
       
         Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'iR__c', 
                                    Display_Value__c = 'IR55', Submit_Value__c = 'IR55', HID_Connect__c = 'C', In_Program__c = 'P', Restricted__c = 'R');
         insert pafc;
                          
         Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id, Status__c = 'Cancelled',
                                    iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
         insert paf;           
    
         ApexPages.StandardController contr = new ApexPages.StandardController(paf);
         ApexPages.CurrentPage().getParameters().put('id', paf.id);
         PAFDetailPageController PAFDetail = new PAFDetailPageController(contr);
    }
    
    static testMethod void PAFDetailPagePAFERPUpdate(){
    
         Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India',E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
         insert account;
    
         Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
         insert acpf;
       
         Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
       
         Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'iR__c', 
                                    Display_Value__c = 'IR55', Submit_Value__c = 'IR55', HID_Connect__c = 'C', In_Program__c = 'P', Restricted__c = 'R');
         insert pafc;
                          
         Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id, Status__c = 'ERP Update',
                                    iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
         insert paf;           
    
         ApexPages.StandardController contr = new ApexPages.StandardController(paf);
         ApexPages.CurrentPage().getParameters().put('id', paf.id);
         PAFDetailPageController PAFDetail = new PAFDetailPageController(contr);
    }
    
    static testMethod void PAFDetailPagePAFRecalled(){
    
         Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India',E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
         insert account;
    
         Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
         insert acpf;
       
         Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
       
         Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'iR__c', 
                                    Display_Value__c = 'IR55', Submit_Value__c = 'IR55', HID_Connect__c = 'C', In_Program__c = 'P', Restricted__c = 'R');
         insert pafc;
                          
         Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id, Status__c = 'Recalled',
                                    iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
         insert paf;           
    
         ApexPages.StandardController contr = new ApexPages.StandardController(paf);
         ApexPages.CurrentPage().getParameters().put('id', paf.id);
         PAFDetailPageController PAFDetail = new PAFDetailPageController(contr);
    }
}