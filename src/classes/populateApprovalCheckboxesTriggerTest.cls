@isTest
private class populateApprovalCheckboxesTriggerTest{
	static{
    	Currencies__c curr = new Currencies__c(Name = 'South Asia USD', Sub_Region__c = 'South Asia', Currency__c = 'USD', Default__c = true);
    	insert curr;
	}

    static testMethod void validateFalseConditions(){
    	
        Role_Hierarchy_Approval__c rha= new Role_Hierarchy_Approval__c(L1_Approver__c=UserInfo.getUserId(),E21_Approver__c=UserInfo.getUserId(),
                                      L2_Approver__c=UserInfo.getUserId(),E21VP_Approver__c=UserInfo.getUserId(),
                                      Pricing_Approver__c=UserInfo.getUserId(), Full_Name__c=UserInfo.getUserId());
       insert rha;
       Account account = new Account(Name = 'Dummy Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
       insert account;
       Contact con = new Contact(FirstName = 'TestFirstName', LastName = 'TestLastName', AccountId = account.id, 
                                   Pricing_Notifications__c = 'No');
       Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c=Null);
       insert acpf; 
       
       Tier_Discount__c tdc=new  Tier_Discount__c(Price_Code__c='FA_Prof_Printers__c',Discount__c=55,Price_Code_Letters__c='FA', Numeric_Discount__c=true); 
       Tier_Discount__c tdc1=new Tier_Discount__c(Price_Code__c='FB_Entry_Level_Printers__c',Discount__c=52,Price_Code_Letters__c='FB', Numeric_Discount__c=true); 
       Tier_Discount__c tdc2=new Tier_Discount__c(Price_Code__c='FD_Ribbons_Clear_Film__c',Discount__c=42,Price_Code_Letters__c='FD', Numeric_Discount__c=true); 
       Tier_Discount__c tdc3=new Tier_Discount__c(Price_Code__c='FE_Entry_Level_Ribbons__c',Discount__c=42,Price_Code_Letters__c='FE', Numeric_Discount__c=true); 

  
       insert tdc;
       insert tdc1;
       insert tdc2;
       insert tdc3;     
       
       Account_Tier_Discount__c atdc1=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc.Id);
       Account_Tier_Discount__c atdc2=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc1.Id);
       Account_Tier_Discount__c atdc3=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc2.Id);
       Account_Tier_Discount__c atdc4=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc3.Id); 
       
       insert atdc1;
       insert atdc2;
       insert atdc3;
       insert atdc4;  
                
       Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,
                                    iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
       insert paf;
        
        system.debug('eeeeeeeee--'+[select E_21_Account__c from Price_Authorization_Form__c where id = :paf.id].E_21_Account__c);
        
        
        paf.Status__c = 'Approved';
        paf.L1_Approval__c = 'Approved';
        paf.L2_Approval__c = 'Approved';
        paf.E21_Approval__c= 'Approved';
        paf.E21VP_Approval__c= 'Approved';
        paf.Pricing_Approval__c= 'Approved';
        
        paf.Is_E21_Approval_Needed__c = FALSE;
        paf.Is_E21VP_Approval_Needed__c = FALSE;
        paf.Is_L1_Approval_Needed__c = FALSE;
        paf.Is_L2_Approval_Needed__c = FALSE;
        paf.Is_Pricing_Approval_Needed__c =FALSE;
        paf.E21VP_Approver__c = Null;
        
        
        update paf; 
        
        
        
      
     }
     
     static testMethod void validateOracleCUstomerNumber(){
    
       Account account = new Account(Name = 'Dummy Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = '12345');
       insert account;
       Contact con = new Contact(FirstName = 'TestFirstName', LastName = 'TestLastName', AccountId = account.id, 
                                   Pricing_Notifications__c = 'No');
       Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c=Null);
       insert acpf;
   
       Tier_Discount__c tdc=new  Tier_Discount__c(Price_Code__c='FA_Prof_Printers__c',Discount__c=55,Price_Code_Letters__c='FA', Numeric_Discount__c=true); 
       Tier_Discount__c tdc1=new Tier_Discount__c(Price_Code__c='FB_Entry_Level_Printers__c',Discount__c=52,Price_Code_Letters__c='FB', Numeric_Discount__c=true); 
       Tier_Discount__c tdc2=new Tier_Discount__c(Price_Code__c='FD_Ribbons_Clear_Film__c',Discount__c=42,Price_Code_Letters__c='FD', Numeric_Discount__c=true); 
       Tier_Discount__c tdc3=new Tier_Discount__c(Price_Code__c='FE_Entry_Level_Ribbons__c',Discount__c=42,Price_Code_Letters__c='FE', Numeric_Discount__c=true); 

       insert tdc;
       insert tdc1;
       insert tdc2;
       insert tdc3;     
       
       Account_Tier_Discount__c atdc1=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc.Id);
       Account_Tier_Discount__c atdc2=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc1.Id);
       Account_Tier_Discount__c atdc3=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc2.Id);
       Account_Tier_Discount__c atdc4=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc3.Id); 
       
       insert atdc1;
       insert atdc2;
       insert atdc3;
       insert atdc4;  
                
       Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,
                                    iR__c = 'Tyco', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
       insert paf;
        
       system.debug('eeeeeeeee--'+[select E_21_Account__c from Price_Authorization_Form__c where id = :paf.id].E_21_Account__c);
        
        paf.Status__c = 'Approved';
        paf.L1_Approval__c = 'Approved';
        paf.L2_Approval__c = 'Approved';
        paf.E21_Approval__c= 'Approved';
        paf.E21VP_Approval__c= 'Approved';
        paf.Pricing_Approval__c= 'Approved';
        
        paf.Is_E21_Approval_Needed__c = FALSE;
        paf.Is_E21VP_Approval_Needed__c = FALSE;
        paf.Is_L1_Approval_Needed__c = FALSE;
        paf.Is_L2_Approval_Needed__c = FALSE;
        paf.Is_Pricing_Approval_Needed__c =FALSE;
       paf.E21VP_Approver__c = Null;
        update paf; 
        
        
      
     }
     
     static testMethod void validateTierAccountProfile(){
    
       Account account = new Account(Name = 'Dummy Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c = null, Oracle_Customer_Number__c = '12345');
       insert account;
       Contact con = new Contact(FirstName = 'TestFirstName', LastName = 'TestLastName', AccountId = account.id, 
                                   Pricing_Notifications__c = 'No');
       Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Silver');
       insert acpf;
         
       Tier_Discount__c tdc=new  Tier_Discount__c(Price_Code__c='FA_Prof_Printers__c',Discount__c=55,Price_Code_Letters__c='FA', Numeric_Discount__c=true); 
       Tier_Discount__c tdc1=new Tier_Discount__c(Price_Code__c='FB_Entry_Level_Printers__c',Discount__c=52,Price_Code_Letters__c='FB', Numeric_Discount__c=true); 
       Tier_Discount__c tdc2=new Tier_Discount__c(Price_Code__c='FD_Ribbons_Clear_Film__c',Discount__c=42,Price_Code_Letters__c='FD', Numeric_Discount__c=true); 
       Tier_Discount__c tdc3=new Tier_Discount__c(Price_Code__c='FE_Entry_Level_Ribbons__c',Discount__c=42,Price_Code_Letters__c='FE', Numeric_Discount__c=true); 
          
       insert tdc;
       insert tdc1;
       insert tdc2;
       insert tdc3;     
       
       Account_Tier_Discount__c atdc1=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc.Id);
       Account_Tier_Discount__c atdc2=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc1.Id);
       Account_Tier_Discount__c atdc3=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc2.Id);
       Account_Tier_Discount__c atdc4=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc3.Id); 
       
       insert atdc1;
       insert atdc2;
       insert atdc3;
       insert atdc4;  
                
       Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,
                                    iR__c = 'Tyco', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
       insert paf;
        
       system.debug('eeeeeeeee--'+[select E_21_Account__c from Price_Authorization_Form__c where id = :paf.id].E_21_Account__c);
        
        paf.Status__c = 'Approved';
        paf.L1_Approval__c = 'Approved';
        paf.L2_Approval__c = 'Approved';
        paf.E21_Approval__c= 'Approved';
        paf.E21VP_Approval__c= 'Approved';
        paf.Pricing_Approval__c= 'Approved';
        
        paf.Is_E21_Approval_Needed__c = FALSE;
        paf.Is_E21VP_Approval_Needed__c = FALSE;
        paf.Is_L1_Approval_Needed__c = FALSE;
        paf.Is_L2_Approval_Needed__c = FALSE;
        paf.Is_Pricing_Approval_Needed__c =FALSE;
       paf.E21VP_Approver__c = Null;
        update paf; 
        
        
      
     }
     
     
    static testMethod void validateTrueConditions(){
       Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='Yes',Oracle_Customer_Number__c = '121345',
                            Sub_Region__c = null ,Group_Number__c='1010');
       insert account;
        
       Contact con = new Contact(FirstName = 'TestFirstName', LastName = 'TestLastName', AccountId = account.id, 
                                   Pricing_Notifications__c = 'No');
      
       Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c = 'Gold');
       
       insert acpf;
         
       Tier_Discount__c tdc=new  Tier_Discount__c(Price_Code__c='FA_Prof_Printers__c',Discount__c=55,Price_Code_Letters__c='FA', Numeric_Discount__c=true); 
       Tier_Discount__c tdc1=new Tier_Discount__c(Price_Code__c='FB_Entry_Level_Printers__c',Discount__c=52,Price_Code_Letters__c='FB', Numeric_Discount__c=true); 
       Tier_Discount__c tdc2=new Tier_Discount__c(Price_Code__c='FD_Ribbons_Clear_Film__c',Discount__c=42,Price_Code_Letters__c='FD', Numeric_Discount__c=true); 
       Tier_Discount__c tdc3=new Tier_Discount__c(Price_Code__c='FE_Entry_Level_Ribbons__c',Discount__c=42,Price_Code_Letters__c='FE', Numeric_Discount__c=true); 


       insert tdc;
       insert tdc1;
       insert tdc2;
       insert tdc3;     
       
       Account_Tier_Discount__c atdc1=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc.Id);
       Account_Tier_Discount__c atdc2=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc1.Id);
       Account_Tier_Discount__c atdc3=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc2.Id);
       Account_Tier_Discount__c atdc4=new Account_Tier_Discount__c(Account__c=account.Id,Tier_Discount__c=tdc3.Id); 
       
       insert atdc1;
       insert atdc2;
       insert atdc3;
       insert atdc4;       
       
 //      Account acc=[select E_21_Account__c from Account where Id = :account.Id];
       
       Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,
                                    iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id, 
                                    Pricing_Effective_Date__c = System.Today(),L1_Approver__c = UserInfo.getUserId(),L2_Approver__c =UserInfo.getUserId(),
                                    E21_Approver__c = UserInfo.getUserId(),
                                    E21VP_Approver__c = UserInfo.getUserId(), Pricing_Approver__c = UserInfo.getUserId(),
                                    FA_Prof_Printers__c = 'FA45', FB_Entry_Level_Printers__c = 'FB66');
        insert paf;
        
       system.debug('eeeeeeeee--'+[select E_21_Account__c from Price_Authorization_Form__c where id = :paf.id].E_21_Account__c);
        
        
        paf.Status__c = 'Approved';
        paf.L1_Approval__c = 'Approved';
        paf.L2_Approval__c = 'Approved';
        paf.E21_Approval__c= 'Approved';
        paf.E21VP_Approval__c= 'Approved';
        paf.Pricing_Approval__c= 'Approved';
        
        paf.Is_E21_Approval_Needed__c = True;
        paf.Is_E21VP_Approval_Needed__c = True;
        paf.Is_L1_Approval_Needed__c = True;
        paf.Is_L2_Approval_Needed__c = True;
        paf.Is_Pricing_Approval_Needed__c =True;
        
        update paf; 
        
        
    }  
}