/* Last Modified on- 15th Nov. 2013
    PAF Submission restriction 
*/

public class ApprovalHistoryController{
    public class MyException extends Exception {}
    public string serverURL {get;set;}
    Id recordId = ApexPages.CurrentPage().getParameters().get('Id');
    public ProcessInstanceWorkitem piw {get;set;}
    public string sysAdminProfId {get;set;}
    public boolean isReloaded {get; set;}
    public List <String> errMessage {get;set;}
    public boolean IsdelegatedUserId {get;set;}
    
//    public Price_Authorization_Form__c paf {get;set;}
    public ApprovalHistoryController(ApexPages.StandardController con){
        serverURL = System.URL.getSalesforceBaseUrl().getHost();
        isReloaded = false;
        piw = new ProcessInstanceWorkitem();
        sysAdminProfId = [select id from Profile where Id = :Label.SysAdminProfileId].id;
        errMessage = new List <String> ();
        IsdelegatedUserId = false;
        
    }
    
    public List<ProcessInstance> getApprovals(){
        List<ProcessInstance> approvals = new List<ProcessInstance>();
        approvals = [select id, IsDeleted, Status from ProcessInstance where TargetObjectId = :recordId order by CreatedDate desc];
        return approvals;
    }
    
    public List<approvalWrapper> getApprovalHistory(){
        List<approvalWrapper> awList = new List<approvalWrapper>();
        for(ProcessInstance pi :getApprovals()){
              approvalWrapper aw = new approvalWrapper();
              aw.processInstance = pi;
              aw.approvalHistoryList = [select ActorId, OriginalActorId, StepStatus, Comments, CreatedDate
                          from ProcessInstanceStep where ProcessInstanceId = :pi.id order by CreatedDate desc];
              Id submitterId = null;
              for(ProcessInstanceStep pis :aw.approvalHistoryList){
                  if(pis.StepStatus == 'Started'){
                      submitterId = pis.ActorId;                    
                  }
              }   
              if(submitterId != null)      
                  aw.submitterSalesTeam = [Select Sales_Team__c from User where id = :submitterId].Sales_Team__c;            
              awList.add(aw);
        }     
        return awList;
    }
    
    public ProcessInstanceWorkitem getWorkItem(){
        set<Id> appIds = new Set<Id>();
        List<ProcessInstanceWorkitem> piwi = new List<ProcessInstanceWorkitem>();
        for(ProcessInstance pi :getApprovals()){
            appIds.add(pi.id);
        }
        piwi = [select id, ActorId, OriginalActorId, ProcessInstanceId, CreatedDate from ProcessInstanceWorkitem 
              where ProcessInstanceId in :appIds];
        if(piwi.size() > 0){
            piw = piwi[0];
            if(piw.ActorId != null){
                List<user> lstUser = [select DelegatedApproverId from user where id =: piw.ActorId and Vacation_Start_Date__c <=: system.today() and Vacation_end_Date__c >=: system.today()];
                if(lstUser.size() > 0){
                    if(lstUser[0].DelegatedApproverId == system.userinfo.getUserID()){
                        IsdelegatedUserId = true;
                    }
                }
            }
            
            return piwi[0];
        }    
        else
            return null;    
    }
    
    public PageReference submitForApproval(){
       
        Price_Authorization_Form__c paf = new Price_Authorization_Form__c();
        
        paf = [select id, Account__c, iR__c,WR__c,iC__c,WC__c,iD__c,MS__c,iP__c,SL__c,MC__c,VS__c,MD__c,LV__c,ME__c,LW_Indala_Credentials__c,
        MF__c,IB__c,RA__c,PI__c,RB__c,iE_pivCLASS_Modules_Software__c,RC__c,iJ_pivCLASS_Modules_Software__c,
        iF_pivCLASS_Kits__c,RD__c,iG_pivCLASS_Readers__c,RE__c,iH_pivCLASS_Bundles__c,PC__c,EZ_EasyLobby__c,iK_pivCLASS_Mobile_Handheld_Readers__c,
        AC__c,OL__c,LC__c,LR__c,EB_Embeddable_Credentials__c,IoD__c,VX__c,VC__c,VI__c,VE__c,VD__c,EC__c,EJ_SIO_Processor__c,
        iO__c,ED_veriCLASS_Readers__c,EP__c,EE_OMNIKEY_Reader_Board__c,LO__c,EF_OMNIKEY_Chipsets__c,EL_Embedded_Accessories__c,
        EG_SmartID_Reader_Boards__c,EK_iCLASS_SE_Reader_Modules__c,EH_identiCLASS_Readers__c,EA_ISO_Reader_Boards__c,EI_Developer_Services_Plus__c,
        FA_Prof_Printers__c,FM_SDK_S_W_Support__c,FB_Entry_Level_Printers__c,FN_Extended_Warranties__c,FX_Standard_Series_C50_Printers__c,
        FY_Standard_C50_Regional_Ribbons_Only__c,FZ_Standard_Series_DTC1250e_Printers__c,FC_Print_Heads__c,FO_Cameras_Camera_S_W__c,
        FD_Ribbons_Clear_Film__c,FP_Photo_ID_Accessories__c,FE_Entry_Level_Ribbons__c,FQ_Spare_Parts_Packages__c,FF_Holo_Film_Overlams__c,PS_Professional_Services__c,
        FR_Spare_Parts_Kits__c,FG_Veri_Holo_OVD_Cards__c,FS_Rewriteable_Cards__c,FH_UltraCards__c,FT_HDP8500_Printers__c,FK_HDPii_Printers__c,
        FU_Industrial_Series_Ribbons_HDP_Film__c,FL_Asure_ID_Software__c,FV_Laser_Engravers__c,FW_Financial_Series_Ribbons_HDP_Film__c, ownerId, Is_L1_Approval_Needed__c, Is_E21_Approval_Needed__c, Is_L2_Approval_Needed__c, Is_E21VP_Approval_Needed__c, Is_Pricing_Approval_Needed__c from Price_Authorization_Form__c where id =:recordId];
                
       
        update paf;
        
        List<Partner_Program__c> partnerprogstatus = new List<Partner_Program__c>();
        partnerprogstatus = [SELECT Partner_Program_Status__c FROM Partner_Program__c WHERE Account__c =: paf.Account__c AND Partner_Program_Status__c = 'Inter Company'];
        
        if(partnerprogstatus.size() == 0){
            errMessage = isConnectSalesTeam(paf);
        }    
           if(errMessage.size() == 0){
                try{
        
      //paf = [select id, ownerId, Is_L1_Approval_Needed__c, Is_E21_Approval_Needed__c, Is_L2_Approval_Needed__c, Is_E21VP_Approval_Needed__c, Is_Pricing_Approval_Needed__c from Price_Authorization_Form__c where id =:recordId];
       
       if(paf.Is_L1_Approval_Needed__c == True || paf.Is_E21_Approval_Needed__c == True || paf.Is_L2_Approval_Needed__c == True || paf.Is_E21VP_Approval_Needed__c == True || paf.Is_Pricing_Approval_Needed__c == True){
           
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setObjectId(recordId);    
            Approval.ProcessResult result =  Approval.process(req);            
            pageReference pf = new PageReference('/'+recordId);
            return pf;      
        }else{throw new MyException('No entry in the approval hierarchy found. Please contact your local Business Administrator or submit an IT helpdesk ticket.');}      
        }
        catch(exception e){    
            ApexPages.addMessages(e);
            PageReference pfe = new PageReference('/apex/PAFApprovalErrorPage?pafId='+recordId);
            pfe.setRedirect(true);
            return pfe;
        }
    }else{
       PageReference pfe = new PageReference('/apex/PAFPriceCodeErrorMessages?pafId='+recordId);
            
            return pfe;
        }
    }
    
    public void updateApproverComments() {
               
        /*List<Price_Authorization_Form__c> pafList = [select L1_Approver_Comments__c, Status__c,L1_Approval__c from Price_Authorization_Form__c where id =: recordId];
        List<ProcessInstance> lstProcess = [SELECT Id,TargetObjectId, (SELECT Id, StepStatus, Comments FROM Steps where comments != null  order by createddate desc limit 1) FROM ProcessInstance where TargetObjectId =: recordId order by createddate asc];
        Map<Id,String> mapComment = new Map<Id,String>();
        for(ProcessInstance ps: lstProcess){           
            for(ProcessInstanceStep sw: ps.Steps){               
                if(sw.Comments != null && sw.Comments != ''){                   
                    mapComment.put(ps.TargetObjectId,sw.Comments);
                }
            }
        }
        for(Price_Authorization_Form__c paf: pafList){           
            if(mapComment.get(paf.id) != paf.L1_Approver_Comments__c){
                paf.L1_Approver_Comments__c = mapComment.get(paf.id);
                isReloaded = true; 
            }
            //paf.CommentInserted__c = false;
        }
        if(pafList.size() > 0){
            commonUtilityClass.firstExecution = false;
            update pafList;
        }*/
        
    }
    public pagereference updatePAFApproveStatus() {
        List<Price_Authorization_Form__c> pafList = [select Status__c,L1_Approval__c from Price_Authorization_Form__c where id =: recordId and Status__c = 'Draft'];
        if(pafList.size() > 0){
            for(Price_Authorization_Form__c paf: pafList){
                paf.Status__c = 'Cancelled';             
            }
            update pafList;
        }
        pagereference pr = new pagereference('/'+recordId );
        pr.setRedirect(true);
        return pr;
    }
    public class approvalWrapper{
        public ProcessInstance processInstance{get;set;}
        public List<ProcessInstanceStep> approvalHistoryList{get;set;}
        public string submitterSalesTeam {get;set;}
        public approvalWrapper(){
            processInstance = new ProcessInstance();
            approvalHistoryList = new List<ProcessInstanceStep>();
        }
    }
    
//This method will check whether PAF owner is from APAC HID Connect or EMEA Connect or HID Connect.
    private List <String> isConnectSalesTeam(Price_Authorization_Form__c paf){
       // String salesTeam = [SELECT Sales_Team__c FROM User WHERE Id =: paf.OwnerId].Sales_Team__c;
        String salesTeam = [SELECT Sales_Team__c FROM User WHERE Id = : UserInfo.getUserId()].Sales_Team__c;
        boolean isSalesTeam = False;        
                
        System.debug('*******In sales team');
        
        if(salesTeam == 'APAC HID Connect' || salesTeam == 'EMEA Connect' || salesTeam == 'HID Connect'){
          isSalesTeam = true;
         errMessage = isConnectCustomer(paf);
        }else{
            errMessage = checkforConnectSalesTeam(paf,isSalesTeam);            
            }
    return errMessage;
    }

//This method will check current accounts Bussiness Segment = 'Connect' from account profile.    
    private List <String> isConnectCustomer(Price_Authorization_Form__c paf){
        List <Account_Profile__c> accProfile = new List <Account_Profile__c>();
        boolean isConnect = False;           
        
        accProfile = [SELECT Business_Segment__c FROM Account_Profile__c WHERE Account__c =: paf.Account__c AND Business_Segment__c = 'Connect'];
        System.debug('*******In connect customer');
        if(accProfile.size() > 0){
            //errMessage = ''; // call submit for apporval..
            system.debug('*************SUBMIT');
        }else{
            errMessage = checkforConnectCustomer(paf, isConnect);                
            }
    return errMessage;
    }

// This method will check HID Connect value for each price code if PAF owner is not in sales team.
    public List <String> checkforConnectSalesTeam(Price_Authorization_Form__c paf, boolean isSalesTeam){

        Map<String, String> priceCodeMap = new Map<String,String>();        
        String msg = '';
        boolean partnerStatus = False;
        
        for(Price_Authorization_Form_Code__c pfc : [SELECT Price_Code__c, HID_Connect__c FROM Price_Authorization_Form_Code__c]){
            priceCodeMap.put(pfc.Price_Code__c, pfc.HID_Connect__c);    
        }
        
        if(paf.iR__c != null){if(priceCodeMap.get('iR__c') == 'C'){msg = getErrorMessagesForSalesTeam('iR: iCLASS Readers', isSalesTeam, paf);errMessage.add(msg);}}      
        if(paf.WR__c != null){if(priceCodeMap.get('WR__c') == 'C'){msg = getErrorMessagesForSalesTeam('WR: Wiegand Readers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.iC__c != null){if(priceCodeMap.get('iC__c') == 'C'){msg = getErrorMessagesForSalesTeam('iC: iCLASS Credentials', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.WC__c != null){if(priceCodeMap.get('WC__c') == 'C'){msg = getErrorMessagesForSalesTeam('WC: Wiegand Cards', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.iD__c != null){if(priceCodeMap.get('iD__c') == 'C'){msg = getErrorMessagesForSalesTeam('iD: iCLASS Clamshell', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.MS__c != null){if(priceCodeMap.get('MS__c') == 'C'){msg = getErrorMessagesForSalesTeam('MS: Magnetic Stripe', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.iP__c != null){if(priceCodeMap.get('iP__c') == 'C'){msg = getErrorMessagesForSalesTeam('iP: Credential Programmers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.SL__c != null){if(priceCodeMap.get('SL__c') == 'C'){msg = getErrorMessagesForSalesTeam('SL: Proxima/MultiProx', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.MC__c != null){if(priceCodeMap.get('MC__c') == 'C'){msg = getErrorMessagesForSalesTeam('MC: FlexSmart', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.VS__c != null){if(priceCodeMap.get('VS__c') == 'C'){msg = getErrorMessagesForSalesTeam('VS: Edge Solo', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.MD__c != null){if(priceCodeMap.get('MD__c') == 'C'){msg = getErrorMessagesForSalesTeam('MD: MIFARE/DESFire', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.LV__c != null){if(priceCodeMap.get('LV__c') == 'C'){msg = getErrorMessagesForSalesTeam('LV: Indala Readers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.ME__c != null){if(priceCodeMap.get('ME__c') == 'C'){msg = getErrorMessagesForSalesTeam('ME: SmartID Readers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.LW_Indala_Credentials__c != null){if(priceCodeMap.get('LW_Indala_Credentials__c') == 'C'){msg = getErrorMessagesForSalesTeam('LW Indala Credentials', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.MF__c != null){if(priceCodeMap.get('MF__c') == 'C'){msg = getErrorMessagesForSalesTeam('MF: SmartID Keypad', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.IB__c != null){if(priceCodeMap.get('IB__c') == 'C'){msg = getErrorMessagesForSalesTeam('IB: idBank Product', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.RA__c != null){if(priceCodeMap.get('RA__c') == 'C'){msg = getErrorMessagesForSalesTeam('RA: Prox Readers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.PI__c != null){if(priceCodeMap.get('PI__c') == 'C'){msg = getErrorMessagesForSalesTeam('PI: plusID Products', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.RB__c != null){if(priceCodeMap.get('RB__c') == 'C'){msg = getErrorMessagesForSalesTeam('RB: Prox Readers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.iE_pivCLASS_Modules_Software__c != null){if(priceCodeMap.get('iE_pivCLASS_Modules_Software__c') == 'C'){msg = getErrorMessagesForSalesTeam('iE: pivCLASS Modules-Software', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.RC__c != null){if(priceCodeMap.get('RC__c') == 'C'){msg = getErrorMessagesForSalesTeam('RC: Prox Readers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.iJ_pivCLASS_Modules_Software__c != null){if(priceCodeMap.get('iJ_pivCLASS_Modules_Software__c') == 'C'){msg = getErrorMessagesForSalesTeam('iJ pivCLASS Modules Software', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.iF_pivCLASS_Kits__c != null){if(priceCodeMap.get('iF_pivCLASS_Kits__c') == 'C'){msg = getErrorMessagesForSalesTeam('iF pivCLASS Kits', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.RD__c != null){if(priceCodeMap.get('RD__c') == 'C'){msg = getErrorMessagesForSalesTeam('RD: ProxPoint Readers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.iG_pivCLASS_Readers__c != null){if(priceCodeMap.get('iG_pivCLASS_Readers__c') == 'C'){msg = getErrorMessagesForSalesTeam('iG pivCLASS Readers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.RE__c != null){if(priceCodeMap.get('RE__c') == 'C'){msg = getErrorMessagesForSalesTeam('RE: EntryProx Readers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.iH_pivCLASS_Bundles__c != null){if(priceCodeMap.get('iH_pivCLASS_Bundles__c') == 'C'){msg = getErrorMessagesForSalesTeam('iH pivCLASS Bundles', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.PC__c != null){if(priceCodeMap.get('PC__c') == 'C'){msg = getErrorMessagesForSalesTeam('PC: Prox Credentials', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EZ_EasyLobby__c != null){if(priceCodeMap.get('EZ_EasyLobby__c') == 'C'){msg = getErrorMessagesForSalesTeam('EZ EasyLobby', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.AC__c != null){if(priceCodeMap.get('AC__c') == 'C'){msg = getErrorMessagesForSalesTeam('AC: Accessories', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.OL__c != null){if(priceCodeMap.get('OL__c') == 'C'){msg = getErrorMessagesForSalesTeam('OL: OMNIKEY Standard', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.LC__c != null){if(priceCodeMap.get('LC__c') == 'C'){msg = getErrorMessagesForSalesTeam('LC: Crescendo', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.LR__c != null){if(priceCodeMap.get('LR__c') == 'C'){msg = getErrorMessagesForSalesTeam('LR: Omnikey (HOTD)', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EB_Embeddable_Credentials__c != null){if(priceCodeMap.get('EB_Embeddable_Credentials__c') == 'C'){msg = getErrorMessagesForSalesTeam('EB Embeddable Credentials', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.IoD__c != null){if(priceCodeMap.get('IoD__c') == 'C'){msg = getErrorMessagesForSalesTeam('IY: Credential Services', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.VX__c != null){if(priceCodeMap.get('VX__c') == 'C'){msg = getErrorMessagesForSalesTeam('VX: VertX CS', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.VC__c != null){if(priceCodeMap.get('VC__c') == 'C'){msg = getErrorMessagesForSalesTeam('VC: VertX Controller', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.VI__c != null){if(priceCodeMap.get('VI__c') == 'C'){msg = getErrorMessagesForSalesTeam('VI: VertX Interface', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.VE__c != null){if(priceCodeMap.get('VE__c') == 'C'){msg = getErrorMessagesForSalesTeam('VE: Edge Host', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.VD__c != null){if(priceCodeMap.get('VD__c') == 'C'){msg = getErrorMessagesForSalesTeam('VD: VertX/EDGE EVO Developer Kit', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EC__c != null){if(priceCodeMap.get('EC__c') == 'C'){msg = getErrorMessagesForSalesTeam('EC: Embedded Credentials', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EJ_SIO_Processor__c != null){if(priceCodeMap.get('EJ_SIO_Processor__c') == 'C'){msg = getErrorMessagesForSalesTeam('EJ SIO Processor', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.iO__c != null){if(priceCodeMap.get('iO__c') == 'C'){msg = getErrorMessagesForSalesTeam('iO: iCLASS OEM', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.ED_veriCLASS_Readers__c != null){if(priceCodeMap.get('ED_veriCLASS_Readers__c') == 'C'){msg = getErrorMessagesForSalesTeam('ED veriCLASS Readers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EP__c != null){if(priceCodeMap.get('EP__c') == 'C'){msg = getErrorMessagesForSalesTeam('EP: Embedded Prox', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EE_OMNIKEY_Reader_Board__c != null){if(priceCodeMap.get('EE_OMNIKEY_Reader_Board__c') == 'C'){msg = getErrorMessagesForSalesTeam('EE OMNIKEY Reader Board', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.LO__c != null){if(priceCodeMap.get('LO__c') == 'C'){msg = getErrorMessagesForSalesTeam('LO: Indala OEM', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EF_OMNIKEY_Chipsets__c != null){if(priceCodeMap.get('EF_OMNIKEY_Chipsets__c') == 'C'){msg = getErrorMessagesForSalesTeam('EF OMNIKEY Chipsets', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EL_Embedded_Accessories__c != null){if(priceCodeMap.get('EL_Embedded_Accessories__c') == 'C'){msg = getErrorMessagesForSalesTeam('EL Embedded Accessories', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EG_SmartID_Reader_Boards__c != null){if(priceCodeMap.get('EG_SmartID_Reader_Boards__c') == 'C'){msg = getErrorMessagesForSalesTeam('EG SmartID Reader Boards', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EK_iCLASS_SE_Reader_Modules__c != null){if(priceCodeMap.get('EK_iCLASS_SE_Reader_Modules__c') == 'C'){msg = getErrorMessagesForSalesTeam('EK iCLASS SE Reader Modules', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EH_identiCLASS_Readers__c != null){if(priceCodeMap.get('EH_identiCLASS_Readers__c') == 'C'){msg = getErrorMessagesForSalesTeam('EH identiCLASS Readers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EA_ISO_Reader_Boards__c != null){if(priceCodeMap.get('EA_ISO_Reader_Boards__c') == 'C'){msg = getErrorMessagesForSalesTeam('EA ISO Reader Boards', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.EI_Developer_Services_Plus__c != null){if(priceCodeMap.get('EI_Developer_Services_Plus__c') == 'C'){msg = getErrorMessagesForSalesTeam('EI Omnikey Embedded Reader Modules', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FA_Prof_Printers__c != null){if(priceCodeMap.get('FA_Prof_Printers__c') == 'C'){msg = getErrorMessagesForSalesTeam('FA Prof Printers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FM_SDK_S_W_Support__c != null){if(priceCodeMap.get('FM_SDK_S_W_Support__c') == 'C'){msg = getErrorMessagesForSalesTeam('FM: SDK & S/W Support', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FB_Entry_Level_Printers__c != null){if(priceCodeMap.get('FB_Entry_Level_Printers__c') == 'C'){msg = getErrorMessagesForSalesTeam('FB: Standard Series Printers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FN_Extended_Warranties__c != null){if(priceCodeMap.get('FN_Extended_Warranties__c') == 'C'){msg = getErrorMessagesForSalesTeam('FN: Extended Warranties', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FX_Standard_Series_C50_Printers__c != null){if(priceCodeMap.get('FX_Standard_Series_C50_Printers__c') == 'C'){msg = getErrorMessagesForSalesTeam('FX: Standard Series C50 Printers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FY_Standard_C50_Regional_Ribbons_Only__c != null){if(priceCodeMap.get('FY_Standard_C50_Regional_Ribbons_Only__c') == 'C'){msg = getErrorMessagesForSalesTeam('FY: Standard C50 Regional Ribbons Only', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FZ_Standard_Series_DTC1250e_Printers__c != null){if(priceCodeMap.get('FZ_Standard_Series_DTC1250e_Printers__c') == 'C'){msg = getErrorMessagesForSalesTeam('FZ: Standard Series DTC1250e Printers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FC_Print_Heads__c != null){if(priceCodeMap.get('FC_Print_Heads__c') == 'C'){msg = getErrorMessagesForSalesTeam('FC: Print Heads', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FO_Cameras_Camera_S_W__c != null){if(priceCodeMap.get('FO_Cameras_Camera_S_W__c') == 'C'){msg = getErrorMessagesForSalesTeam('FO: Cameras & Camera S/W', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FD_Ribbons_Clear_Film__c != null){if(priceCodeMap.get('FD_Ribbons_Clear_Film__c') == 'C'){msg = getErrorMessagesForSalesTeam('FD: Ribbons & Clear Film', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FP_Photo_ID_Accessories__c != null){if(priceCodeMap.get('FP_Photo_ID_Accessories__c') == 'C'){msg = getErrorMessagesForSalesTeam('FP: Photo ID Accessories', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FE_Entry_Level_Ribbons__c != null){if(priceCodeMap.get('FE_Entry_Level_Ribbons__c') == 'C'){msg = getErrorMessagesForSalesTeam('FE: Standard Series Ribbons', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FQ_Spare_Parts_Packages__c != null){if(priceCodeMap.get('FQ_Spare_Parts_Packages__c') == 'C'){msg = getErrorMessagesForSalesTeam('FQ: Spare Parts Packages', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FF_Holo_Film_Overlams__c != null){if(priceCodeMap.get('FF_Holo_Film_Overlams__c') == 'C'){msg = getErrorMessagesForSalesTeam('FF: Holo. Film & Overlams', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FR_Spare_Parts_Kits__c != null){if(priceCodeMap.get('FR_Spare_Parts_Kits__c') == 'C'){msg = getErrorMessagesForSalesTeam('FR: Spare Parts & Kits', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FG_Veri_Holo_OVD_Cards__c != null){if(priceCodeMap.get('FG_Veri_Holo_OVD_Cards__c') == 'C'){msg = getErrorMessagesForSalesTeam('FG: Veri/Holo & OVD Cards', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FS_Rewriteable_Cards__c != null){if(priceCodeMap.get('FS_Rewriteable_Cards__c') == 'C'){msg = getErrorMessagesForSalesTeam('FS: Rewriteable Cards', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FH_UltraCards__c != null){if(priceCodeMap.get('FH_UltraCards__c') == 'C'){msg = getErrorMessagesForSalesTeam('FH: UltraCards', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FT_HDP8500_Printers__c != null){if(priceCodeMap.get('FT_HDP8500_Printers__c') == 'C'){msg = getErrorMessagesForSalesTeam('FT: Industrial Series Printers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FK_HDPii_Printers__c != null){if(priceCodeMap.get('FK_HDPii_Printers__c') == 'C'){msg = getErrorMessagesForSalesTeam('FK: HDPii Printers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FU_Industrial_Series_Ribbons_HDP_Film__c != null){if(priceCodeMap.get('FU_Industrial_Series_Ribbons_HDP_Film__c') == 'C'){msg = getErrorMessagesForSalesTeam('FU: Industrial Series Ribbons & HDP Film', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FL_Asure_ID_Software__c != null){if(priceCodeMap.get('FL_Asure_ID_Software__c') == 'C'){msg = getErrorMessagesForSalesTeam('FL: Asure ID Software', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FV_Laser_Engravers__c != null){if(priceCodeMap.get('FV_Laser_Engravers__c') == 'C'){msg = getErrorMessagesForSalesTeam('FV: Laser Engravers', isSalesTeam, paf);errMessage.add(msg);}}
        if(paf.FW_Financial_Series_Ribbons_HDP_Film__c != null){if(priceCodeMap.get('FW_Financial_Series_Ribbons_HDP_Film__c') == 'C'){msg = getErrorMessagesForSalesTeam('FW: Financial Series Ribbons & HDP Film', isSalesTeam, paf);errMessage.add(msg);}}    
        if(paf.PS_Professional_Services__c != null){if(priceCodeMap.get('PS_Professional_Services__c') == 'C'){msg = getErrorMessagesForSalesTeam('PS: Professional Services', isSalesTeam, paf);errMessage.add(msg);}}    
        if(paf.iK_pivCLASS_Mobile_Handheld_Readers__c != null){if(priceCodeMap.get('iK_pivCLASS_Mobile_Handheld_Readers__c') == 'C'){msg = getErrorMessagesForSalesTeam('iK: pivCLASS Mobile Handheld Readers', isSalesTeam, paf);errMessage.add(msg);}}    

            
        system.debug('*******SIZE in SalesTeam '+errMessage.size());
         
        if(errMessage.size()==0){
            partnerStatus = checkPartnerProgramStatus(paf);
            string strCurrentProfileName = [select Profile.Name from user where id =: userinfo.getUserid()].Profile.Name;
            if(strCurrentProfileName == 'HID Business Administrator' || strCurrentProfileName == 'HID Business Administrator Modify All Data' || strCurrentProfileName == 'System Administrator' || partnerStatus){                          
                msg = '';     //  submitForApproval                                                
            }else{
                //msg = 'Your PAF cannot be submitted because your account must be Enrolled in the Advantage Program to gain access to the price codes';
                msg = System.Label.PAFSubmsnRstrcnErrMsg4;
                system.debug('************ MSG Sales: '+msg);
                errMessage.add(msg);
            }
        }
        return errMessage;
               
    }

// This method will check HID Connect for each price code if Bussiness Segment on Account Profile is not 'Connect'. 
public List <String> checkforConnectCustomer(Price_Authorization_Form__c paf, boolean isConnect){

        Map<String, String> priceCodeMap = new Map<String,String>();        
        String msg = '';
        
        for(Price_Authorization_Form_Code__c pfc : [SELECT Price_Code__c, HID_Connect__c FROM Price_Authorization_Form_Code__c]){
            priceCodeMap.put(pfc.Price_Code__c, pfc.HID_Connect__c);    
        }
        if(paf.iR__c != null){if(priceCodeMap.get('iR__c') == 'C'){isConnect = true;isConnect = true;msg = getErrorMessagesforCustomer('iR: iCLASS Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('iR: iCLASS Readers', isConnect, paf);errMessage.add(msg);}}      
        if(paf.WR__c != null){if(priceCodeMap.get('WR__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('WR: Wiegand Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('WR: Wiegand Readers', isConnect, paf);errMessage.add(msg);}}
        if(paf.iC__c != null){if(priceCodeMap.get('iC__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('iC: iCLASS Credentials', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('iC: iCLASS Credentials', isConnect, paf);errMessage.add(msg);}}
        if(paf.WC__c != null){if(priceCodeMap.get('WC__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('WC: Wiegand Cards', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('WC: Wiegand Cards', isConnect, paf);errMessage.add(msg);}}
        if(paf.iD__c != null){if(priceCodeMap.get('iD__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('iD: iCLASS Clamshell', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('iD: iCLASS Clamshell', isConnect, paf);errMessage.add(msg);}}
        if(paf.MS__c != null){if(priceCodeMap.get('MS__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('MS: Magnetic Stripe', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('MS: Magnetic Stripe', isConnect, paf);errMessage.add(msg);}}
        if(paf.iP__c != null){if(priceCodeMap.get('iP__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('iP: Credential Programmers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('iP: Credential Programmers', isConnect, paf);errMessage.add(msg);}}
        if(paf.SL__c != null){if(priceCodeMap.get('SL__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('SL: Proxima/MultiProx', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('SL: Proxima/MultiProx', isConnect, paf);errMessage.add(msg);}}
        if(paf.MC__c != null){if(priceCodeMap.get('MC__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('MC: FlexSmart', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('MC: FlexSmart', isConnect, paf);errMessage.add(msg);}}
        if(paf.VS__c != null){if(priceCodeMap.get('VS__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('VS: Edge Solo', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('VS: Edge Solo', isConnect, paf);errMessage.add(msg);}}
        if(paf.MD__c != null){if(priceCodeMap.get('MD__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('MD: MIFARE/DESFire', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('MD: MIFARE/DESFire', isConnect, paf);errMessage.add(msg);}}
        if(paf.LV__c != null){if(priceCodeMap.get('LV__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('LV: Indala Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('LV: Indala Readers', isConnect, paf);errMessage.add(msg);}}
        if(paf.ME__c != null){if(priceCodeMap.get('ME__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('ME: SmartID Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('ME: SmartID Readers', isConnect, paf);errMessage.add(msg);}}
        if(paf.LW_Indala_Credentials__c != null){if(priceCodeMap.get('LW_Indala_Credentials__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('LW Indala Credentials', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('LW Indala Credentials', isConnect, paf);errMessage.add(msg);}}
        if(paf.MF__c != null){if(priceCodeMap.get('MF__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('MF: SmartID Keypad', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('MF: SmartID Keypad', isConnect, paf);errMessage.add(msg);}}
        if(paf.IB__c != null){if(priceCodeMap.get('IB__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('IB: idBank Product', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('IB: idBank Product', isConnect, paf);errMessage.add(msg);}}
        if(paf.RA__c != null){if(priceCodeMap.get('RA__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('RA: Prox Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('RA: Prox Readers', isConnect, paf);errMessage.add(msg);}}
        if(paf.PI__c != null){if(priceCodeMap.get('PI__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('PI: plusID Products', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('PI: plusID Products', isConnect, paf);errMessage.add(msg);}}
        if(paf.RB__c != null){if(priceCodeMap.get('RB__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('RB: Prox Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('RB: Prox Readers', isConnect, paf);errMessage.add(msg);}}
        if(paf.iE_pivCLASS_Modules_Software__c != null){if(priceCodeMap.get('iE_pivCLASS_Modules_Software__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('iE: pivCLASS Modules-Software', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('iE: pivCLASS Modules-Software', isConnect, paf);errMessage.add(msg);}}
        if(paf.RC__c != null){if(priceCodeMap.get('RC__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('RC: Prox Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('RC: Prox Readers', isConnect, paf);errMessage.add(msg);}}
        if(paf.iJ_pivCLASS_Modules_Software__c != null){if(priceCodeMap.get('iJ_pivCLASS_Modules_Software__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('iJ pivCLASS Modules Software', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('iJ pivCLASS Modules Software', isConnect, paf);errMessage.add(msg);}}
        if(paf.iF_pivCLASS_Kits__c != null){if(priceCodeMap.get('iF_pivCLASS_Kits__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('iF pivCLASS Kits', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('iF pivCLASS Kits', isConnect, paf);errMessage.add(msg);}}
        if(paf.RD__c != null){if(priceCodeMap.get('RD__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('RD: ProxPoint Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('RD: ProxPoint Readers', isConnect, paf);errMessage.add(msg);}}
        if(paf.iG_pivCLASS_Readers__c != null){if(priceCodeMap.get('iG_pivCLASS_Readers__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('iG pivCLASS Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('iG pivCLASS Readers', isConnect, paf);errMessage.add(msg);}}
        if(paf.RE__c != null){if(priceCodeMap.get('RE__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('RE: EntryProx Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('RE: EntryProx Readers', isConnect, paf);errMessage.add(msg);}}
        if(paf.iH_pivCLASS_Bundles__c != null){if(priceCodeMap.get('iH_pivCLASS_Bundles__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('iH pivCLASS Bundles', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('iH pivCLASS Bundles', isConnect, paf);errMessage.add(msg);}}
        if(paf.PC__c != null){if(priceCodeMap.get('PC__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('PC: Prox Credentials', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('PC: Prox Credentials', isConnect, paf);errMessage.add(msg);}}
        if(paf.EZ_EasyLobby__c != null){if(priceCodeMap.get('EZ_EasyLobby__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EZ EasyLobby', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EZ EasyLobby', isConnect, paf);errMessage.add(msg);}}
        if(paf.AC__c != null){if(priceCodeMap.get('AC__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('AC: Accessories', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('AC: Accessories', isConnect, paf);errMessage.add(msg);}}
        if(paf.OL__c != null){if(priceCodeMap.get('OL__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('OL: OMNIKEY Standard', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('OL: OMNIKEY Standard', isConnect, paf);errMessage.add(msg);}}
        if(paf.LC__c != null){if(priceCodeMap.get('LC__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('LC: Crescendo', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('LC: Crescendo', isConnect, paf);errMessage.add(msg);}}
        if(paf.LR__c != null){if(priceCodeMap.get('LR__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('LR: Omnikey (HOTD)', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('LR: Omnikey (HOTD)', isConnect, paf);errMessage.add(msg);}}
        if(paf.EB_Embeddable_Credentials__c != null){if(priceCodeMap.get('EB_Embeddable_Credentials__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EB Embeddable Credentials', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EB Embeddable Credentials', isConnect, paf);errMessage.add(msg);}}
        if(paf.IoD__c != null){if(priceCodeMap.get('IoD__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('IY: Credential Services', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('IY: Credential Services', isConnect, paf);errMessage.add(msg);}}
        if(paf.VX__c != null){if(priceCodeMap.get('VX__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('VX: VertX CS', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('VX: VertX CS', isConnect, paf);errMessage.add(msg);}}
        if(paf.VC__c != null){if(priceCodeMap.get('VC__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('VC: VertX Controller', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('VC: VertX Controller', isConnect, paf);errMessage.add(msg);}}
        if(paf.VI__c != null){if(priceCodeMap.get('VI__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('VI: VertX Interface', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('VI: VertX Interface', isConnect, paf);errMessage.add(msg);}}
        if(paf.VE__c != null){if(priceCodeMap.get('VE__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('VE: Edge Host', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('VE: Edge Host', isConnect, paf);errMessage.add(msg);}}
        if(paf.VD__c != null){if(priceCodeMap.get('VD__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('VD: VertX/EDGE EVO Developer Kit', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('VD: VertX/EDGE EVO Developer Kit', isConnect, paf);errMessage.add(msg);}}
        if(paf.EC__c != null){if(priceCodeMap.get('EC__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EC: Embedded Credentials', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EC: Embedded Credentials', isConnect, paf);errMessage.add(msg);}}
        if(paf.EJ_SIO_Processor__c != null){if(priceCodeMap.get('EJ_SIO_Processor__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EJ SIO Processor', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EJ SIO Processor', isConnect, paf);errMessage.add(msg);}}
        if(paf.iO__c != null){if(priceCodeMap.get('iO__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('iO: iCLASS OEM', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('iO: iCLASS OEM', isConnect, paf);errMessage.add(msg);}}
        if(paf.ED_veriCLASS_Readers__c != null){if(priceCodeMap.get('ED_veriCLASS_Readers__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('ED veriCLASS Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('ED veriCLASS Readers', isConnect, paf);errMessage.add(msg);}}
        if(paf.EP__c != null){if(priceCodeMap.get('EP__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EP: Embedded Prox', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EP: Embedded Prox', isConnect, paf);errMessage.add(msg);}}
        if(paf.EE_OMNIKEY_Reader_Board__c != null){if(priceCodeMap.get('EE_OMNIKEY_Reader_Board__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EE OMNIKEY Reader Board', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EE OMNIKEY Reader Board', isConnect, paf);errMessage.add(msg);}}
        if(paf.LO__c != null){if(priceCodeMap.get('LO__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('LO: Indala OEM', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('LO: Indala OEM', isConnect, paf);errMessage.add(msg);}}
        if(paf.EF_OMNIKEY_Chipsets__c != null){if(priceCodeMap.get('EF_OMNIKEY_Chipsets__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EF OMNIKEY Chipsets', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EF OMNIKEY Chipsets', isConnect, paf);errMessage.add(msg);}}
        if(paf.EL_Embedded_Accessories__c != null){if(priceCodeMap.get('EL_Embedded_Accessories__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EL Embedded Accessories', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EL Embedded Accessories', isConnect, paf);errMessage.add(msg);}}
        if(paf.EG_SmartID_Reader_Boards__c != null){if(priceCodeMap.get('EG_SmartID_Reader_Boards__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EG SmartID Reader Boards', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EG SmartID Reader Boards', isConnect, paf);errMessage.add(msg);}}
        if(paf.EK_iCLASS_SE_Reader_Modules__c != null){if(priceCodeMap.get('EK_iCLASS_SE_Reader_Modules__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EK iCLASS SE Reader Modules', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EK iCLASS SE Reader Modules', isConnect, paf);errMessage.add(msg);}}
        if(paf.EH_identiCLASS_Readers__c != null){if(priceCodeMap.get('EH_identiCLASS_Readers__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EH identiCLASS Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EH identiCLASS Readers', isConnect, paf);errMessage.add(msg);}}
        if(paf.EA_ISO_Reader_Boards__c != null){if(priceCodeMap.get('EA_ISO_Reader_Boards__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EA ISO Reader Boards', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EA ISO Reader Boards', isConnect, paf);errMessage.add(msg);}}
        if(paf.EI_Developer_Services_Plus__c != null){if(priceCodeMap.get('EI_Developer_Services_Plus__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('EI Omnikey Embedded Reader Modules', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('EI Omnikey Embedded Reader Modules', isConnect, paf);errMessage.add(msg);}}
        if(paf.FA_Prof_Printers__c != null){if(priceCodeMap.get('FA_Prof_Printers__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FA Prof Printers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FA Prof Printers', isConnect, paf);errMessage.add(msg);}}
        if(paf.FM_SDK_S_W_Support__c != null){if(priceCodeMap.get('FM_SDK_S_W_Support__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FM: SDK & S/W Support', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FM: SDK & S/W Support', isConnect, paf);errMessage.add(msg);}}
        if(paf.FB_Entry_Level_Printers__c != null){if(priceCodeMap.get('FB_Entry_Level_Printers__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FB: Standard Series Printers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FB: Standard Series Printers', isConnect, paf);errMessage.add(msg);}}
        if(paf.FN_Extended_Warranties__c != null){if(priceCodeMap.get('FN_Extended_Warranties__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FN: Extended Warranties', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FN: Extended Warranties', isConnect, paf);errMessage.add(msg);}}
        if(paf.FX_Standard_Series_C50_Printers__c != null){if(priceCodeMap.get('FX_Standard_Series_C50_Printers__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FX: Standard Series C50 Printers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FX: Standard Series C50 Printers', isConnect, paf);errMessage.add(msg);}}
        if(paf.FY_Standard_C50_Regional_Ribbons_Only__c != null){if(priceCodeMap.get('FY_Standard_C50_Regional_Ribbons_Only__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FY: Standard C50 Regional Ribbons Only', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FY: Standard C50 Regional Ribbons Only', isConnect, paf);errMessage.add(msg);}}
        if(paf.FZ_Standard_Series_DTC1250e_Printers__c != null){if(priceCodeMap.get('FZ_Standard_Series_DTC1250e_Printers__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FZ: Standard Series DTC1250e Printers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FZ: Standard Series DTC1250e Printers', isConnect, paf);errMessage.add(msg);}}        
        if(paf.FC_Print_Heads__c != null){if(priceCodeMap.get('FC_Print_Heads__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FC: Print Heads', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FC: Print Heads', isConnect, paf);errMessage.add(msg);}}
        if(paf.FO_Cameras_Camera_S_W__c != null){if(priceCodeMap.get('FO_Cameras_Camera_S_W__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FO: Cameras & Camera S/W', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FO: Cameras & Camera S/W', isConnect, paf);errMessage.add(msg);}}
        if(paf.FD_Ribbons_Clear_Film__c != null){if(priceCodeMap.get('FD_Ribbons_Clear_Film__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FD: Ribbons & Clear Film', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FD: Ribbons & Clear Film', isConnect, paf);errMessage.add(msg);}}
        if(paf.FP_Photo_ID_Accessories__c != null){if(priceCodeMap.get('FP_Photo_ID_Accessories__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FP: Photo ID Accessories', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FP: Photo ID Accessories', isConnect, paf);errMessage.add(msg);}}
        if(paf.FE_Entry_Level_Ribbons__c != null){if(priceCodeMap.get('FE_Entry_Level_Ribbons__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FE: Standard Series Ribbons', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FE: Standard Series Ribbons', isConnect, paf);errMessage.add(msg);}}
        if(paf.FQ_Spare_Parts_Packages__c != null){if(priceCodeMap.get('FQ_Spare_Parts_Packages__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FQ: Spare Parts Packages', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FQ: Spare Parts Packages', isConnect, paf);errMessage.add(msg);}}
        if(paf.FF_Holo_Film_Overlams__c != null){if(priceCodeMap.get('FF_Holo_Film_Overlams__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FF: Holo. Film & Overlams', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FF: Holo. Film & Overlams', isConnect, paf);errMessage.add(msg);}}
        if(paf.FR_Spare_Parts_Kits__c != null){if(priceCodeMap.get('FR_Spare_Parts_Kits__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FR: Spare Parts & Kits', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FR: Spare Parts & Kits', isConnect, paf);errMessage.add(msg);}}
        if(paf.FG_Veri_Holo_OVD_Cards__c != null){if(priceCodeMap.get('FG_Veri_Holo_OVD_Cards__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FG: Veri/Holo & OVD Cards', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FG: Veri/Holo & OVD Cards', isConnect, paf);errMessage.add(msg);}}
        if(paf.FS_Rewriteable_Cards__c != null){if(priceCodeMap.get('FS_Rewriteable_Cards__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FS: Rewriteable Cards', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FS: Rewriteable Cards', isConnect, paf);errMessage.add(msg);}}
        if(paf.FH_UltraCards__c != null){if(priceCodeMap.get('FH_UltraCards__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FH: UltraCards', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FH: UltraCards', isConnect, paf);errMessage.add(msg);}}
        if(paf.FT_HDP8500_Printers__c != null){if(priceCodeMap.get('FT_HDP8500_Printers__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FT: Industrial Series Printers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FT: Industrial Series Printers', isConnect, paf);errMessage.add(msg);}}
        if(paf.FK_HDPii_Printers__c != null){if(priceCodeMap.get('FK_HDPii_Printers__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FK: HDPii Printers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FK: HDPii Printers', isConnect, paf);errMessage.add(msg);}}
        if(paf.FU_Industrial_Series_Ribbons_HDP_Film__c != null){if(priceCodeMap.get('FU_Industrial_Series_Ribbons_HDP_Film__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FU: Industrial Series Ribbons & HDP Film', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FU: Industrial Series Ribbons & HDP Film', isConnect, paf);errMessage.add(msg);}}
        if(paf.FL_Asure_ID_Software__c != null){if(priceCodeMap.get('FL_Asure_ID_Software__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FL: Asure ID Software', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FL: Asure ID Software', isConnect, paf);errMessage.add(msg);}}
        if(paf.FV_Laser_Engravers__c != null){if(priceCodeMap.get('FV_Laser_Engravers__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FV: Laser Engravers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FV: Laser Engravers', isConnect, paf);errMessage.add(msg);}}
        if(paf.FW_Financial_Series_Ribbons_HDP_Film__c != null){if(priceCodeMap.get('FW_Financial_Series_Ribbons_HDP_Film__c') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('FW: Financial Series Ribbons & HDP Film', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('FW: Financial Series Ribbons & HDP Film', isConnect, paf);errMessage.add(msg);}}    
        if(paf.iK_pivCLASS_Mobile_Handheld_Readers__c != null){if(priceCodeMap.get('iK: pivCLASS Mobile Handheld Readers') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('iK: pivCLASS Mobile Handheld Readers', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('iK: pivCLASS Mobile Handheld Readers', isConnect, paf);errMessage.add(msg);}}    
        if(paf.PS_Professional_Services__c != null){if(priceCodeMap.get('PS: Professional Services') == 'C'){isConnect = true;msg = getErrorMessagesforCustomer('PS: Professional Services', isConnect, paf);errMessage.add(msg);}
        else{msg = getErrorMessagesforCustomer('PS: Professional Services', isConnect, paf);errMessage.add(msg);}}   
                  
        system.debug('*******SIZE in Connect Customer'+errMessage.size());     
        return errMessage;
    }
//This method will check Partner Program Status for current Account.    
    public boolean checkPartnerProgramStatus(Price_Authorization_Form__c paf){
        List<Partner_Program__c> partnerprogstatus = new List<Partner_Program__c>();
        partnerprogstatus = [SELECT Partner_Program_Status__c FROM Partner_Program__c WHERE Account__c =: paf.Account__c AND Partner_Program_Status__c IN('Enrolled','In Progress')];
        system.debug('*******PP '+partnerprogstatus.size());
        if(partnerprogstatus.size() > 0){
            return true;
        }else{
            return false;
        }
        
    }

//This method will give the specified error mesaage if each price code does not criteria for sales team.  
    public String getErrorMessagesForSalesTeam (String pricecode, boolean isSalesTeam, Price_Authorization_Form__c paf){

        String msg = '';
        system.debug('*******Get Error Message: '+pricecode);
    //    msg = '<b>'+pricecode + ':</b> Your PAF cannot be submitted because you are adding or changing HID Connect price codes and you are not designated as an HID Connect sales team member';            
      
      msg = '<b>'+pricecode + ':</b> ' + System.Label.PAFSubmsnRstrcnErrMsg1; 
        return msg;              
}

//This method will give the specified error mesaages if each price code does not criteria for connect customer.
    public String getErrorMessagesforCustomer (String pricecode, boolean isConnect, Price_Authorization_Form__c paf){   
        String msg = '';
        if(isConnect){
            //msg = '<b>'+pricecode + ':</b> Your PAF for HID Connect Price Codes may not be submitted until you create an Account Profile for the account for the HID Connect Segment';
            msg = '<b>'+pricecode + ':</b> ' + System.Label.PAFSubmsnRstrcnErrMsg2;
            system.debug('************ MSG connect1: '+msg);
        }
        else{
           // msg = '<b>'+pricecode +':</b> Your PAF cannot be submitted because your account needs and HID profile to be assigned HID Connect price codes';
            msg = '<b>'+pricecode +':</b> ' + System.Label.PAFSubmsnRstrcnErrMsg3;
            system.debug('************ MSG connect2: '+msg);
            }          
    return msg;
    }   
}