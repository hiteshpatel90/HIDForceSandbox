@isTest 

    public class UpdatePriceAuthorizationFormTest{

    static testMethod void EditPafTest(){
    
    Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);insert account;
    
    Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
    insert acpf;
       
    Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
       
    Contact con1 = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Status__c='active',Pricing_Notifications__c = 'No');
    insert con1;
    
    Id idAdvantagePartnerRecordType = [SELECT Id FROM RecordType WHERE Name = 'Advantage Partner' AND SobjectType = 'Partner_Program__c'].Id;

    Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
    
    insert paf;
    
    Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'FA_Prof_Printers__c', Display_Value__c = 'FA55 Gold', Submit_Value__c = 'FA55');
                                   
    insert pafc;                                
    
    
    ApexPages.StandardController contr = new ApexPages.StandardController(paf);
    ApexPages.CurrentPage().getParameters().put('id', paf.id);
    Partner_Program__c pp =new Partner_Program__c(Partner_Program_Status__c='Enrolled',Partner_Program_Status_Modifier__c='Inelegible',Account__c=account.id,Primary_Contact__c=con1.id);
    insert pp;
    UpdatePriceAuthorizationForm Updatepaf1 = new UpdatePriceAuthorizationForm(contr);
    
    Partner_Program__c pp1 =new Partner_Program__c(Partner_Program_Status__c='Enrolled',Partner_Program_Status_Modifier__c='Inelegible',Account__c=account.id,Primary_Contact__c=con1.id,RecordTypeid=idAdvantagePartnerRecordType );
    insert pp1;
    getQueryforAccount qry = new  getQueryforAccount();
    UpdatePriceAuthorizationForm Updatepaf = new UpdatePriceAuthorizationForm(contr);
    Updatepaf.savePriceAuthorization();
    Updatepaf.saveAndNewPriceAuthorization();
    Updatepaf.cancelPriceAuthorization();
    Updatepaf.priceAuthorization=null;
    Updatepaf.savePriceAuthorization();
    
    }
    
    static testMethod void DetailPafTest(){
    
    Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
    insert account;
    
    Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
    insert acpf;
       
    Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
       
    Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
    
    insert paf;
    
    Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'FA_Prof_Printers__c', Display_Value__c = 'FA55 Gold', Submit_Value__c = 'FA55');
                                   
    insert pafc;                                
    
    
    ApexPages.StandardController contr = new ApexPages.StandardController(paf);
    ApexPages.CurrentPage().getParameters().put('id', paf.id);
    
    PAFDetailPageController pfd= new PAFDetailPageController(contr); 
    PageReference pfe = pfd.EditPriceAuthorizationForm();
    PageReference pfc = pfd.ClonePriceAuthorizationForm();
    pagereference pfcan = pfd.CancelPAFApproveStatus();
    pagereference pfrecall = pfd.PAFStatustoRecall(); 
    PageReference pfdlt = pfd.DeletePriceAuthorizationForm();
    }
    
    static testMethod void DetailPafDraftTest(){
    
         Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
           insert account;
        
        Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
           insert acpf;
           
        Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
           
        Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52',Status__c = 'Draft');
        
        insert paf;
        
        Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'FA_Prof_Printers__c', Display_Value__c = 'FA55 Gold', Submit_Value__c = 'FA55');
                                       
        insert pafc;                                
        
        
        ApexPages.StandardController contr = new ApexPages.StandardController(paf);
        ApexPages.CurrentPage().getParameters().put('id', paf.id);
        PAFDetailPageController pfd= new PAFDetailPageController(contr);
    }
    
    static testMethod void DetailPafAwaitingTest(){
    
         Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', BillingCountry = 'India', BillingState = 'Assam',  E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
           insert account;
        
        Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
           insert acpf;
           
        Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
           
        Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52',Status__c = 'Awaiting Approval');
        
        insert paf;
        
        Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'FA_Prof_Printers__c', Display_Value__c = 'FA55 Gold', Submit_Value__c = 'FA55');
                                       
        insert pafc;                                
        
        
        ApexPages.StandardController contr = new ApexPages.StandardController(paf);
        ApexPages.CurrentPage().getParameters().put('id', paf.id);
        PAFDetailPageController pfd= new PAFDetailPageController(contr);
    }
    
    static testMethod void DetailPafApprovedTest(){
    
         Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
           insert account;
        
        Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
           insert acpf;
           
        Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
           
        Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52',Status__c = 'Approved');
        
        insert paf;
        
        Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'FA_Prof_Printers__c', Display_Value__c = 'FA55 Gold', Submit_Value__c = 'FA55');
                                       
        insert pafc;                                
        
        
        ApexPages.StandardController contr = new ApexPages.StandardController(paf);
        ApexPages.CurrentPage().getParameters().put('id', paf.id);
        PAFDetailPageController pfd= new PAFDetailPageController(contr);
    }
    
    static testMethod void DetailPafCancelledTest(){
    
         Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', BillingCountry = 'India', BillingState = 'Assam',  E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
           insert account;
        
        Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
           insert acpf;
           
        Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
           
        Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52',Status__c = 'Cancelled');
        
        insert paf;
        
        Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'FA_Prof_Printers__c', Display_Value__c = 'FA55 Gold', Submit_Value__c = 'FA55');
                                       
        insert pafc;                                
        
        
        ApexPages.StandardController contr = new ApexPages.StandardController(paf);
        ApexPages.CurrentPage().getParameters().put('id', paf.id);
        PAFDetailPageController pfd= new PAFDetailPageController(contr);
    }
}