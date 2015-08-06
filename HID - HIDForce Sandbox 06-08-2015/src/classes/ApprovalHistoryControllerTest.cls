@isTest

private class ApprovalHistoryControllerTest{

   
   static testMethod void PAFSubmsnRestrictionAsSalesTeam(){
        
        Profile p = [select id from profile where name='System Administrator'];  
              
        User testUser = new User(alias = 'u1', email='testSalesTeamUser@hidglobal.com',
        emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, country='United States',
        timezonesidkey='America/Los_Angeles', username='testSalesTeamUser@hidglobal.com', Sales_Team__c = 'HID Connect'); 
        // test
        insert testUser;
    
        System.RunAs(testUser){   
            Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
            insert account;
    
            Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
            insert acpf;
       
            Contact con = new Contact(FirstName = 'FirstName',Status__c = 'Active', LastName = 'LastName', AccountId = account.id,Pricing_Notifications__c = 'No');  
            insert con;
        
            Role_Hierarchy_Approval__c rha = new Role_Hierarchy_Approval__c( L1_Approver__c = UserInfo.getUserId(), E21_Approver__c = UserInfo.getUserId(),
                                             L2_Approver__c = UserInfo.getUserId(), E21VP_Approver__c = UserInfo.getUserId(), Pricing_Approver__c = UserInfo.getUserId(), Full_Name__c = UserInfo.getUserId());
            insert rha;
        
            Partner_Program__c pp = new Partner_Program__c(Account__c = account.id, Primary_Contact__c = con.id, Program_Status__c = 'Pending', Business_Segment__c = 'HID Connect',
                                    Use_Application__c = 'Campus Solutions');
            insert pp;
    
    
        Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,
                                    New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Status__c = 'Draft', Pricing_Effective_Date__c = System.Today(), iR__c = 'IR40', WR__c = 'WR40', iC__c = 'IC40', WC__c = 'WC40', iD__c = 'ID40', MS__c = 'MS40',  iP__c = 'IP40', SL__c = 'SL40', MC__c = 'MC40',  
                                    VS__c = 'VS40', MD__c = 'MD40', LV__c = 'LV40', ME__c = 'ME40', LW_Indala_Credentials__c = 'LW40', MF__c = 'MF40', IB__c = 'IB40', RA__c = 'RA40',  
                                    PI__c = 'PI40', RB__c = 'RB40', iE_pivCLASS_Modules_Software__c = 'IE40', RC__c = 'RC40', iJ_pivCLASS_Modules_Software__c = 'IJ40', iF_pivCLASS_Kits__c = 'IF40',  
                                    RD__c = 'RD40', iG_pivCLASS_Readers__c = 'IG40', RE__c = 'RE40', iH_pivCLASS_Bundles__c = 'IH40', PC__c = 'PC40', EZ_EasyLobby__c = 'EZ40', AC__c = 'AC40',  
                                    OL__c = 'OL40', LC__c = 'LC40', LR__c = 'LR40', EB_Embeddable_Credentials__c = 'EB40', IoD__c = 'IO40', VX__c = 'VX40', VC__c = 'VC40', VI__c = 'VI40',  
                                    VE__c = 'VE40', VD__c = 'VD40', EC__c = 'EC40', EJ_SIO_Processor__c = 'EJ40', iO__c = 'IO40', ED_veriCLASS_Readers__c = 'ED40', EP__c = 'EP40',   
                                    EE_OMNIKEY_Reader_Board__c = 'EE40', LO__c = 'LO40', EF_OMNIKEY_Chipsets__c = 'EF40', EL_Embedded_Accessories__c = 'EL40', EG_SmartID_Reader_Boards__c = 'EG40',   
                                    EK_iCLASS_SE_Reader_Modules__c = 'EK40', EH_identiCLASS_Readers__c = 'EH40', EA_ISO_Reader_Boards__c = 'EA40', EI_Developer_Services_Plus__c = 'EI40',   
                                    FA_Prof_Printers__c = 'FA40', FM_SDK_S_W_Support__c = 'FM40', FB_Entry_Level_Printers__c = 'FB40', FN_Extended_Warranties__c = 'FN40', FX_Standard_Series_C50_Printers__c = 'FX40',   
                                    FY_Standard_C50_Regional_Ribbons_Only__c = 'FY40', FZ_Standard_Series_DTC1250e_Printers__c = 'FZ40', FC_Print_Heads__c = 'FC40', FO_Cameras_Camera_S_W__c = 'FO40',  
                                    FD_Ribbons_Clear_Film__c = 'FD40', FP_Photo_ID_Accessories__c = 'FP40', FE_Entry_Level_Ribbons__c = 'FE40', FQ_Spare_Parts_Packages__c = 'FQ40',  
                                    FF_Holo_Film_Overlams__c = 'FF40', FR_Spare_Parts_Kits__c = 'FR40', FG_Veri_Holo_OVD_Cards__c = 'FG40', FS_Rewriteable_Cards__c = 'FS40', FH_UltraCards__c = 'FH40',  
                                    FT_HDP8500_Printers__c = 'FT40', FK_HDPii_Printers__c = 'FK40', FU_Industrial_Series_Ribbons_HDP_Film__c = 'FU40', FL_Asure_ID_Software__c = 'FL40',   
                                    FV_Laser_Engravers__c = 'FV40', FW_Financial_Series_Ribbons_HDP_Film__c = 'FW40',
                                    L1_Approver__c = UserInfo.getUserId(),E21_Approver__c =UserInfo.getUserId(),E21VP_Approver__c =UserInfo.getUserId(),Pricing_Approver__c =UserInfo.getUserId(),
                                    Is_L1_Approval_Needed__c = true,Is_E21_Approval_Needed__c=false,Is_L2_Approval_Needed__c=false,Is_E21VP_Approval_Needed__c=false,
                                    Is_Pricing_Approval_Needed__c=true);

        Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'EC__c', 
                                            Display_Value__c = 'EC47', Submit_Value__c = 'EC47');
        insert pafc; 
        insert paf;
        
        ApexPages.StandardController contr = new ApexPages.StandardController(paf);
        ApexPages.CurrentPage().getParameters().put('id', paf.id);
        ApprovalHistoryController apHistory= new ApprovalHistoryController(contr);
     
        List<ApprovalHistoryController.approvalWrapper> AWP = new List<ApprovalHistoryController.approvalWrapper>();    
     
        PageReference pf = apHistory.submitForApproval();
     
        ProcessInstanceWorkitem PIW = apHistory.getWorkItem();
        AWP = apHistory.getApprovalHistory();
        apHistory.updateApproverComments();
        apHistory.updatePAFApproveStatus(); 
        }   
   }
   
   static testMethod void PAFSubmsnRestrictionAsSalesTeamPaartnerProgram(){
  
        Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                          BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
        insert account;
    
        Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
        insert acpf;
       
        Contact con = new Contact(FirstName = 'FirstName',Status__c = 'Active', LastName = 'LastName', AccountId = account.id,Pricing_Notifications__c = 'No');  
        insert con;
        
        Role_Hierarchy_Approval__c rha = new Role_Hierarchy_Approval__c( L1_Approver__c = UserInfo.getUserId(), E21_Approver__c = UserInfo.getUserId(),
                                         L2_Approver__c = UserInfo.getUserId(), E21VP_Approver__c = UserInfo.getUserId(), Pricing_Approver__c = UserInfo.getUserId(), Full_Name__c = UserInfo.getUserId());
        insert rha;
        
        Partner_Program__c pp = new Partner_Program__c(Account__c = account.id, Primary_Contact__c = con.id, Program_Status__c = 'Pending', Business_Segment__c = 'HID Connect',
                                                        Use_Application__c = 'Campus Solutions', Partner_Program_Status__c = 'Enrolled');
        insert pp;
    
    
        Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,
                                    New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Status__c = 'Draft', Pricing_Effective_Date__c = System.Today(), iR__c = 'IR40', WR__c = 'WR40', iC__c = 'IC40', WC__c = 'WC40', iD__c = 'ID40', MS__c = 'MS40',  iP__c = 'IP40', SL__c = 'SL40', MC__c = 'MC40',  
                                    VS__c = 'VS40', MD__c = 'MD40', LV__c = 'LV40', ME__c = 'ME40', LW_Indala_Credentials__c = 'LW40', MF__c = 'MF40', IB__c = 'IB40', RA__c = 'RA40',  
                                    PI__c = 'PI40', RB__c = 'RB40', iE_pivCLASS_Modules_Software__c = 'IE40', RC__c = 'RC40', iJ_pivCLASS_Modules_Software__c = 'IJ40', iF_pivCLASS_Kits__c = 'IF40',  
                                    RD__c = 'RD40', iG_pivCLASS_Readers__c = 'IG40', RE__c = 'RE40', iH_pivCLASS_Bundles__c = 'IH40', PC__c = 'PC40', EZ_EasyLobby__c = 'EZ40', AC__c = 'AC40',  
                                    OL__c = 'OL40', LC__c = 'LC40', LR__c = 'LR40', EB_Embeddable_Credentials__c = 'EB40', IoD__c = 'IO40', VX__c = 'VX40', VC__c = 'VC40', VI__c = 'VI40',  
                                    VE__c = 'VE40', VD__c = 'VD40', EC__c = 'EC40', EJ_SIO_Processor__c = 'EJ40', iO__c = 'IO40', ED_veriCLASS_Readers__c = 'ED40', EP__c = 'EP40',   
                                    EE_OMNIKEY_Reader_Board__c = 'EE40', LO__c = 'LO40', EF_OMNIKEY_Chipsets__c = 'EF40', EL_Embedded_Accessories__c = 'EL40', EG_SmartID_Reader_Boards__c = 'EG40',   
                                    EK_iCLASS_SE_Reader_Modules__c = 'EK40', EH_identiCLASS_Readers__c = 'EH40', EA_ISO_Reader_Boards__c = 'EA40', EI_Developer_Services_Plus__c = 'EI40',   
                                    FA_Prof_Printers__c = 'FA40', FM_SDK_S_W_Support__c = 'FM40', FB_Entry_Level_Printers__c = 'FB40', FN_Extended_Warranties__c = 'FN40', FX_Standard_Series_C50_Printers__c = 'FX40',   
                                    FY_Standard_C50_Regional_Ribbons_Only__c = 'FY40', FZ_Standard_Series_DTC1250e_Printers__c = 'FZ40', FC_Print_Heads__c = 'FC40', FO_Cameras_Camera_S_W__c = 'FO40',  
                                    FD_Ribbons_Clear_Film__c = 'FD40', FP_Photo_ID_Accessories__c = 'FP40', FE_Entry_Level_Ribbons__c = 'FE40', FQ_Spare_Parts_Packages__c = 'FQ40',  
                                    FF_Holo_Film_Overlams__c = 'FF40', FR_Spare_Parts_Kits__c = 'FR40', FG_Veri_Holo_OVD_Cards__c = 'FG40', FS_Rewriteable_Cards__c = 'FS40', FH_UltraCards__c = 'FH40',  
                                    FT_HDP8500_Printers__c = 'FT40', FK_HDPii_Printers__c = 'FK40', FU_Industrial_Series_Ribbons_HDP_Film__c = 'FU40', FL_Asure_ID_Software__c = 'FL40',   
                                    FV_Laser_Engravers__c = 'FV40', FW_Financial_Series_Ribbons_HDP_Film__c = 'FW40',
                                    L1_Approver__c = UserInfo.getUserId(),E21_Approver__c =UserInfo.getUserId(),E21VP_Approver__c =UserInfo.getUserId(),Pricing_Approver__c =UserInfo.getUserId(),
                                    Is_L1_Approval_Needed__c = true,Is_E21_Approval_Needed__c=false,Is_L2_Approval_Needed__c=false,Is_E21VP_Approval_Needed__c=false,
                                    Is_Pricing_Approval_Needed__c=true);

        Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'EC__c', 
                                    Display_Value__c = 'EC40', Submit_Value__c = 'EC40');
        insert pafc; 
        insert paf;
        
        ApexPages.StandardController contr = new ApexPages.StandardController(paf);
        ApexPages.CurrentPage().getParameters().put('id', paf.id);
        ApprovalHistoryController apHistory= new ApprovalHistoryController(contr);
     
        List<ApprovalHistoryController.approvalWrapper> AWP = new List<ApprovalHistoryController.approvalWrapper>();    
     
        PageReference pf = apHistory.submitForApproval();
     
        ProcessInstanceWorkitem PIW = apHistory.getWorkItem();
        AWP = apHistory.getApprovalHistory();
        apHistory.updateApproverComments();
        apHistory.updatePAFApproveStatus(); 
   
   }
      
   static testMethod void PAFSubmsnRestrictionNoConnect(){
           
        Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
        insert account;
    
        Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Business_Segment__c = 'Connect', Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
        insert acpf;
       
        Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id,Pricing_Notifications__c = 'No');  
        insert con;
         
        Role_Hierarchy_Approval__c rha = new Role_Hierarchy_Approval__c( L1_Approver__c = UserInfo.getUserId(), E21_Approver__c = UserInfo.getUserId(),
                                         L2_Approver__c = UserInfo.getUserId(), E21VP_Approver__c = UserInfo.getUserId(), Pricing_Approver__c = UserInfo.getUserId(), Full_Name__c = UserInfo.getUserId());
        insert rha;
         
        Partner_Program__c pp = new Partner_Program__c(Account__c = account.id, Primary_Contact__c = con.id, Program_Status__c = 'Pending',
                                                          Use_Application__c = 'Campus Solutions');
        insert pp;
            
        Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,
                                    New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Status__c = 'Draft', Pricing_Effective_Date__c = System.Today(), iR__c = 'IR40', WR__c = 'WR40', iC__c = 'IC40', WC__c = 'WC40', iD__c = 'ID40', MS__c = 'MS40',  iP__c = 'IP40', SL__c = 'SL40', MC__c = 'MC40',  
                                    VS__c = 'VS40', MD__c = 'MD40', LV__c = 'LV40', ME__c = 'ME40', LW_Indala_Credentials__c = 'LW40', MF__c = 'MF40', IB__c = 'IB40', RA__c = 'RA40',  
                                    PI__c = 'PI40', RB__c = 'RB40', iE_pivCLASS_Modules_Software__c = 'IE40', RC__c = 'RC40', iJ_pivCLASS_Modules_Software__c = 'IJ40', iF_pivCLASS_Kits__c = 'IF40',  
                                    RD__c = 'RD40', iG_pivCLASS_Readers__c = 'IG40', RE__c = 'RE40', iH_pivCLASS_Bundles__c = 'IH40', PC__c = 'PC40', EZ_EasyLobby__c = 'EZ40', AC__c = 'AC40',  
                                    OL__c = 'OL40', LC__c = 'LC40', LR__c = 'LR40', EB_Embeddable_Credentials__c = 'EB40', IoD__c = 'IO40', VX__c = 'VX40', VC__c = 'VC40', VI__c = 'VI40',  
                                    VE__c = 'VE40', VD__c = 'VD40', EC__c = 'EC40', EJ_SIO_Processor__c = 'EJ40', iO__c = 'IO40', ED_veriCLASS_Readers__c = 'ED40', EP__c = 'EP40',   
                                    EE_OMNIKEY_Reader_Board__c = 'EE40', LO__c = 'LO40', EF_OMNIKEY_Chipsets__c = 'EF40', EL_Embedded_Accessories__c = 'EL40', EG_SmartID_Reader_Boards__c = 'EG40',   
                                    EK_iCLASS_SE_Reader_Modules__c = 'EK40', EH_identiCLASS_Readers__c = 'EH40', EA_ISO_Reader_Boards__c = 'EA40', EI_Developer_Services_Plus__c = 'EI40',   
                                    FA_Prof_Printers__c = 'FA40', FM_SDK_S_W_Support__c = 'FM40', FB_Entry_Level_Printers__c = 'FB40', FN_Extended_Warranties__c = 'FN40', FX_Standard_Series_C50_Printers__c = 'FX40',   
                                    FY_Standard_C50_Regional_Ribbons_Only__c = 'FY40', FZ_Standard_Series_DTC1250e_Printers__c = 'FZ40', FC_Print_Heads__c = 'FC40', FO_Cameras_Camera_S_W__c = 'FO40',  
                                    FD_Ribbons_Clear_Film__c = 'FD40', FP_Photo_ID_Accessories__c = 'FP40', FE_Entry_Level_Ribbons__c = 'FE40', FQ_Spare_Parts_Packages__c = 'FQ40',  
                                    FF_Holo_Film_Overlams__c = 'FF40', FR_Spare_Parts_Kits__c = 'FR40', FG_Veri_Holo_OVD_Cards__c = 'FG40', FS_Rewriteable_Cards__c = 'FS40', FH_UltraCards__c = 'FH40',  
                                    FT_HDP8500_Printers__c = 'FT40', FK_HDPii_Printers__c = 'FK40', FU_Industrial_Series_Ribbons_HDP_Film__c = 'FU40', FL_Asure_ID_Software__c = 'FL40',   
                                    FV_Laser_Engravers__c = 'FV40', FW_Financial_Series_Ribbons_HDP_Film__c = 'FW40',
                                    L1_Approver__c = UserInfo.getUserId(),E21_Approver__c =UserInfo.getUserId(),E21VP_Approver__c =UserInfo.getUserId(),Pricing_Approver__c =UserInfo.getUserId(),
                                    Is_L1_Approval_Needed__c = true,Is_E21_Approval_Needed__c=false,Is_L2_Approval_Needed__c=false,Is_E21VP_Approval_Needed__c=false,
                                    Is_Pricing_Approval_Needed__c=true);
        
        Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'EC__c', 
                                    Display_Value__c = 'EC47', Submit_Value__c = 'EC47', HID_Connect__c = 'C');
        insert pafc;
        insert paf;
        
        ApexPages.StandardController contr = new ApexPages.StandardController(paf);
        ApexPages.CurrentPage().getParameters().put('id', paf.id);
        ApprovalHistoryController apHistory= new ApprovalHistoryController(contr);
     
        List<ApprovalHistoryController.approvalWrapper> AWP = new List<ApprovalHistoryController.approvalWrapper>();    
     
        PageReference pf = apHistory.submitForApproval();
     
        ProcessInstanceWorkitem PIW = apHistory.getWorkItem();
        AWP = apHistory.getApprovalHistory();
        apHistory.updateApproverComments();
        apHistory.updatePAFApproveStatus(); 
    }   
 
 static testMethod void PAFSubmsnRestrictionNoPartnerProg(){
       
        Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                          BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
        insert account;
    
        Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold');
        insert acpf;
       
        Contact con = new Contact(FirstName = 'FirstName',Status__c = 'Active', LastName = 'LastName', AccountId = account.id,Pricing_Notifications__c = 'No');  
        insert con;
        
        Role_Hierarchy_Approval__c rha = new Role_Hierarchy_Approval__c( L1_Approver__c = UserInfo.getUserId(), E21_Approver__c = UserInfo.getUserId(),
                                         L2_Approver__c = UserInfo.getUserId(), E21VP_Approver__c = UserInfo.getUserId(), Pricing_Approver__c = UserInfo.getUserId(), Full_Name__c = UserInfo.getUserId());
        insert rha;
        
        Partner_Program__c pp = new Partner_Program__c(Account__c = account.id, Primary_Contact__c = con.id, Program_Status__c = 'Pending', Business_Segment__c = 'HID Connect',
                                Use_Application__c = 'Campus Solutions');
        insert pp;
    
    
        Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,
                                    New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Status__c = 'Draft', Pricing_Effective_Date__c = System.Today(), iR__c = 'IR40', WR__c = 'WR40', iC__c = 'IC40', WC__c = 'WC40', iD__c = 'ID40', MS__c = 'MS40',  iP__c = 'IP40', SL__c = 'SL40', MC__c = 'MC40',  
                                    VS__c = 'VS40', MD__c = 'MD40', LV__c = 'LV40', ME__c = 'ME40', LW_Indala_Credentials__c = 'LW40', MF__c = 'MF40', IB__c = 'IB40', RA__c = 'RA40',  
                                    PI__c = 'PI40', RB__c = 'RB40', iE_pivCLASS_Modules_Software__c = 'IE40', RC__c = 'RC40', iJ_pivCLASS_Modules_Software__c = 'IJ40', iF_pivCLASS_Kits__c = 'IF40',  
                                    RD__c = 'RD40', iG_pivCLASS_Readers__c = 'IG40', RE__c = 'RE40', iH_pivCLASS_Bundles__c = 'IH40', PC__c = 'PC40', EZ_EasyLobby__c = 'EZ40', AC__c = 'AC40',  
                                    OL__c = 'OL40', LC__c = 'LC40', LR__c = 'LR40', EB_Embeddable_Credentials__c = 'EB40', IoD__c = 'IO40', VX__c = 'VX40', VC__c = 'VC40', VI__c = 'VI40',  
                                    VE__c = 'VE40', VD__c = 'VD40', EC__c = 'EC40', EJ_SIO_Processor__c = 'EJ40', iO__c = 'IO40', ED_veriCLASS_Readers__c = 'ED40', EP__c = 'EP40',   
                                    EE_OMNIKEY_Reader_Board__c = 'EE40', LO__c = 'LO40', EF_OMNIKEY_Chipsets__c = 'EF40', EL_Embedded_Accessories__c = 'EL40', EG_SmartID_Reader_Boards__c = 'EG40',   
                                    EK_iCLASS_SE_Reader_Modules__c = 'EK40', EH_identiCLASS_Readers__c = 'EH40', EA_ISO_Reader_Boards__c = 'EA40', EI_Developer_Services_Plus__c = 'EI40',   
                                    FA_Prof_Printers__c = 'FA40', FM_SDK_S_W_Support__c = 'FM40', FB_Entry_Level_Printers__c = 'FB40', FN_Extended_Warranties__c = 'FN40', FX_Standard_Series_C50_Printers__c = 'FX40',   
                                    FY_Standard_C50_Regional_Ribbons_Only__c = 'FY40', FZ_Standard_Series_DTC1250e_Printers__c = 'FZ40', FC_Print_Heads__c = 'FC40', FO_Cameras_Camera_S_W__c = 'FO40',  
                                    FD_Ribbons_Clear_Film__c = 'FD40', FP_Photo_ID_Accessories__c = 'FP40', FE_Entry_Level_Ribbons__c = 'FE40', FQ_Spare_Parts_Packages__c = 'FQ40',  
                                    FF_Holo_Film_Overlams__c = 'FF40', FR_Spare_Parts_Kits__c = 'FR40', FG_Veri_Holo_OVD_Cards__c = 'FG40', FS_Rewriteable_Cards__c = 'FS40', FH_UltraCards__c = 'FH40',  
                                    FT_HDP8500_Printers__c = 'FT40', FK_HDPii_Printers__c = 'FK40', FU_Industrial_Series_Ribbons_HDP_Film__c = 'FU40', FL_Asure_ID_Software__c = 'FL40',   
                                    FV_Laser_Engravers__c = 'FV40', FW_Financial_Series_Ribbons_HDP_Film__c = 'FW40',
                                    L1_Approver__c = UserInfo.getUserId(),E21_Approver__c =UserInfo.getUserId(),E21VP_Approver__c =UserInfo.getUserId(),Pricing_Approver__c =UserInfo.getUserId(),
                                    Is_L1_Approval_Needed__c = true,Is_E21_Approval_Needed__c=false,Is_L2_Approval_Needed__c=false,Is_E21VP_Approval_Needed__c=false,
                                    Is_Pricing_Approval_Needed__c=true);

        Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'EC__c', 
                                    Display_Value__c = 'EC47', Submit_Value__c = 'EC47', HID_Connect__c = 'C');
        insert pafc; 
        insert paf;
        
        ApexPages.StandardController contr = new ApexPages.StandardController(paf);
        ApexPages.CurrentPage().getParameters().put('id', paf.id);
        ApprovalHistoryController apHistory= new ApprovalHistoryController(contr);
     
        List<ApprovalHistoryController.approvalWrapper> AWP = new List<ApprovalHistoryController.approvalWrapper>();    
     
        PageReference pf = apHistory.submitForApproval();
     
        ProcessInstanceWorkitem PIW = apHistory.getWorkItem();
        AWP = apHistory.getApprovalHistory();
        apHistory.updateApproverComments();
        apHistory.updatePAFApproveStatus(); 
      
   }
   
    static testMethod void PAFSubmsnRestrictionNoErrMSG(){
       
        Profile p = [select id from profile where name='System Administrator']; 
       
        User testUser = new User(alias = 'u1', email='testSalesTeamUser@hidglobal.com',
        emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, country='United States',
        timezonesidkey='America/Los_Angeles', username='testSalesTeamUser@hidglobal.com', Sales_Team__c = 'HID Connect'); 
        
        insert testUser;
        System.RunAs(testUser){  
            Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', 
                            BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);
            insert account;
    
            Account_Profile__c acpf = new Account_Profile__c(Account__c = account.id, Partner_Type__c = 'Media', Sales_Manager__c =UserInfo.getUserId(),Tier__c='Gold',Business_Segment__c = 'Connect');
            insert acpf;
       
            Contact con = new Contact(FirstName = 'FirstName',Status__c = 'Active', LastName = 'LastName', AccountId = account.id,Pricing_Notifications__c = 'No');  
            insert con;
        
            Role_Hierarchy_Approval__c rha = new Role_Hierarchy_Approval__c( L1_Approver__c = UserInfo.getUserId(), E21_Approver__c = UserInfo.getUserId(),
                                            L2_Approver__c = UserInfo.getUserId(), E21VP_Approver__c = UserInfo.getUserId(), Pricing_Approver__c = UserInfo.getUserId(), Full_Name__c = UserInfo.getUserId());
            insert rha;
        
            Partner_Program__c pp = new Partner_Program__c(Account__c = account.id, Primary_Contact__c = con.id, Program_Status__c = 'Pending', Business_Segment__c = 'HID Connect',
                                    Use_Application__c = 'Campus Solutions');
            insert pp;
    
    
        Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,
                                    New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), 
                                    Status__c = 'Draft', Pricing_Effective_Date__c = System.Today(), iR__c = 'IR40', WR__c = 'WR40', iC__c = 'IC40', WC__c = 'WC40', iD__c = 'ID40', MS__c = 'MS40',  iP__c = 'IP40', SL__c = 'SL40', MC__c = 'MC40',  
                                    VS__c = 'VS40', MD__c = 'MD40', LV__c = 'LV40', ME__c = 'ME40', LW_Indala_Credentials__c = 'LW40', MF__c = 'MF40', IB__c = 'IB40', RA__c = 'RA40',  
                                    PI__c = 'PI40', RB__c = 'RB40', iE_pivCLASS_Modules_Software__c = 'IE40', RC__c = 'RC40', iJ_pivCLASS_Modules_Software__c = 'IJ40', iF_pivCLASS_Kits__c = 'IF40',  
                                    RD__c = 'RD40', iG_pivCLASS_Readers__c = 'IG40', RE__c = 'RE40', iH_pivCLASS_Bundles__c = 'IH40', PC__c = 'PC40', EZ_EasyLobby__c = 'EZ40', AC__c = 'AC40',  
                                    OL__c = 'OL40', LC__c = 'LC40', LR__c = 'LR40', EB_Embeddable_Credentials__c = 'EB40', IoD__c = 'IO40', VX__c = 'VX40', VC__c = 'VC40', VI__c = 'VI40',  
                                    VE__c = 'VE40', VD__c = 'VD40', EC__c = 'EC40', EJ_SIO_Processor__c = 'EJ40', iO__c = 'IO40', ED_veriCLASS_Readers__c = 'ED40', EP__c = 'EP40',   
                                    EE_OMNIKEY_Reader_Board__c = 'EE40', LO__c = 'LO40', EF_OMNIKEY_Chipsets__c = 'EF40', EL_Embedded_Accessories__c = 'EL40', EG_SmartID_Reader_Boards__c = 'EG40',   
                                    EK_iCLASS_SE_Reader_Modules__c = 'EK40', EH_identiCLASS_Readers__c = 'EH40', EA_ISO_Reader_Boards__c = 'EA40', EI_Developer_Services_Plus__c = 'EI40',   
                                    FA_Prof_Printers__c = 'FA40', FM_SDK_S_W_Support__c = 'FM40', FB_Entry_Level_Printers__c = 'FB40', FN_Extended_Warranties__c = 'FN40', FX_Standard_Series_C50_Printers__c = 'FX40',   
                                    FY_Standard_C50_Regional_Ribbons_Only__c = 'FY40', FZ_Standard_Series_DTC1250e_Printers__c = 'FZ40', FC_Print_Heads__c = 'FC40', FO_Cameras_Camera_S_W__c = 'FO40',  
                                    FD_Ribbons_Clear_Film__c = 'FD40', FP_Photo_ID_Accessories__c = 'FP40', FE_Entry_Level_Ribbons__c = 'FE40', FQ_Spare_Parts_Packages__c = 'FQ40',  
                                    FF_Holo_Film_Overlams__c = 'FF40', FR_Spare_Parts_Kits__c = 'FR40', FG_Veri_Holo_OVD_Cards__c = 'FG40', FS_Rewriteable_Cards__c = 'FS40', FH_UltraCards__c = 'FH40',  
                                    FT_HDP8500_Printers__c = 'FT40', FK_HDPii_Printers__c = 'FK40', FU_Industrial_Series_Ribbons_HDP_Film__c = 'FU40', FL_Asure_ID_Software__c = 'FL40',   
                                    FV_Laser_Engravers__c = 'FV40', FW_Financial_Series_Ribbons_HDP_Film__c = 'FW40',
                                    L1_Approver__c = UserInfo.getUserId(),E21_Approver__c =UserInfo.getUserId(),E21VP_Approver__c =UserInfo.getUserId(),Pricing_Approver__c =UserInfo.getUserId(),
                                    Is_L1_Approval_Needed__c = true,Is_E21_Approval_Needed__c=false,Is_L2_Approval_Needed__c=false,Is_E21VP_Approval_Needed__c=false,
                                    Is_Pricing_Approval_Needed__c=true);

        Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'EC__c', 
                                    Display_Value__c = 'EC47', Submit_Value__c = 'EC47', HID_Connect__c = 'C');
        insert pafc; 
        insert paf;
        
        ApexPages.StandardController contr = new ApexPages.StandardController(paf);
        ApexPages.CurrentPage().getParameters().put('id', paf.id);
        ApprovalHistoryController apHistory= new ApprovalHistoryController(contr);
     
        List<ApprovalHistoryController.approvalWrapper> AWP = new List<ApprovalHistoryController.approvalWrapper>();    
     
        PageReference pf = apHistory.submitForApproval();
     
        ProcessInstanceWorkitem PIW = apHistory.getWorkItem();
        AWP = apHistory.getApprovalHistory();
        apHistory.updateApproverComments();
        apHistory.updatePAFApproveStatus(); 
        }
   }  
}