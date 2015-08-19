////////////////////////////////////////////////////////////////////
//Type                :  Test Class
//Name                :  ClonePriceAuthorizationFormTest
//Company             :  Jade Global
//Created By          :  Uttam Patil
//Created Date        :  21/08/2013
//Last Modified By    :  Uttam Patil
//Last Modified Date  :  08/08/2013
//////////////////////////////////////////////////////////////////////
@istest 
public class ClonePriceAuthorizationFormTest{
    Private Static testmethod void ClonePriceAuthorizationFormTest(){
        //Insert Test Recrods of Account object
        Account objAcc = new Account();
        objAcc.Name = 'Test Account';
        objAcc.Channel__c = 'Test Channel';
        objAcc.BillingCountry = 'India';
        objAcc.BillingState = 'Assam';
        objAcc.E_21_Account__c='No';
        objAcc.Sub_Region__c =Null;
        objAcc.Oracle_Customer_Number__c = Null;
        insert objAcc;
        
        //Insert Test Recrods of Account Profile object
        Account_Profile__c objacpf = new Account_Profile__c();
        objacpf.Account__c = objAcc.id;
        objacpf.Business_Segment__c = 'Connect';
        objacpf.Partner_Type__c = 'Media';
        objacpf.Sales_Manager__c =UserInfo.getUserId();
        objacpf.Tier__c='Gold';
        insert objacpf;
        
        //Insert Test Recrods of Contact object
        Contact objcon = new Contact();
        objcon.FirstName = 'FirstName';
        objcon.LastName = 'LastName';
        objcon.AccountId = objAcc.id;
        objcon.Pricing_Notifications__c = 'No'; 
        insert objcon;     
        
        Contact con1 = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = objAcc.id, Status__c='active',Pricing_Notifications__c = 'No');
        insert con1; 
        
        Id idAdvantagePartnerRecordType = [SELECT Id FROM RecordType WHERE Name = 'Advantage Partner' AND SobjectType = 'Partner_Program__c'].Id;
        
        //Insert Test Recrods of Price Authorization Form object
        Price_Authorization_Form__c objpaf = new Price_Authorization_Form__c();
        objpaf.Account__c = objAcc.id;
        objpaf.iR__c = 'iR45';
        objpaf.New_HID_Customer__c = 'No';
        objpaf.Key_Contact__c = objcon.Id;
        objpaf.L2_Approver__c =UserInfo.getUserId();
        objpaf.Pricing_Effective_Date__c = System.Today();
        objpaf.FA_Prof_Printers__c = 'FA55';
        objpaf.FB_Entry_Level_Printers__c = 'FB52';    
        insert objpaf;
        
        //set return UrL in Parameter
        ApexPages.CurrentPage().getParameters().put('retURL','0'+objpaf.id);
        
        ApexPages.StandardController stdConpaf = new ApexPages.StandardController(objpaf);
        
        Partner_Program__c pp =new Partner_Program__c(Partner_Program_Status__c='Enrolled',Partner_Program_Status_Modifier__c='Inelegible',Account__c=objAcc.id,Primary_Contact__c=con1.id);
        insert pp;
        ClonePriceAuthorizationForm objClonePAF2 = new ClonePriceAuthorizationForm(stdConpaf);

        //Build object for ClonePriceAuthorizationForm controller and call functions of class
        Partner_Program__c pp1 =new Partner_Program__c(Partner_Program_Status__c='Enrolled',Partner_Program_Status_Modifier__c='Inelegible',Account__c=objAcc.id,Primary_Contact__c=con1.id,RecordTypeid=idAdvantagePartnerRecordType );
        insert pp1;
        ClonePriceAuthorizationForm objClonePAF = new ClonePriceAuthorizationForm(stdConpaf);
        objClonePAF.getAccountProfileDetails();
        objClonePAF.savePriceAuthorization();
        objClonePAF.saveAndNewPriceAuthorization();
        objClonePAF.cancelPriceAuthorization();
        objClonePAF.getQueryString('Price_Authorization_Form__c');
        
        //Build object for ClonePriceAuthorizationForm controller and call functions of class
        ClonePriceAuthorizationForm objClonePAF1 = new ClonePriceAuthorizationForm(stdConpaf);        
        objClonePAF1.saveAndNewPriceAuthorization();
        objClonePAF1.savePriceAuthorization();
        
    }
}