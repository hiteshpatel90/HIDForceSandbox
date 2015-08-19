/****************************************************************************
* Type               : Apex Class
* Name               : PAFDetailPageController
* Modified by        : Hitesh Patel
* Modified Date      : 5th June 2015
* Last Modified By   : Hitesh Patel 13th July 2015
* Purpose            : This is Extension class for "PriceAuthorizationFormDetail" visualforce page
                       This class will handle oprations on PAF detail page.                
****************************************************************************/
public class PAFDetailPageController{
    
    public Price_Authorization_Form__c PriceAuthorizationForm{get; set;}
    public ApexPages.StandardController controller;
    String PafId = ApexPages.CurrentPage().getParameters().get('id');
    Price_Authorization_Form__c paf;
    public String HIDBusAdmin {get;set;}
    public String HIDBusAdminModAll {get;set;}
    public static final Id idAdvantagePartnerRecordType = [SELECT Id FROM RecordType WHERE Name = 'Advantage Partner' AND SobjectType = 'Partner_Program__c'].Id;
    public String PartnerProgramStatus {get;set;}
    public String vPAFRecordTypeId {get;set;}
    public String PartnerProgramStatusModifier {get;set;}
    
    //To show and hide Edit PAF Button on detail page
    public boolean IsshowEdit{get; set;}
    //To show and hide cancel PAF Button on detail page
    public boolean IsshowCancel{get; set;}
    //To show and hide Recall PAF button on detail page
    public boolean IsshowRecall{get; set;}
    
    public string tierValueiR {get;set;}
    public string tierValueMS {get;set;}
    public string tierValueiC {get;set;}
    //public string tierValueSL {get;set;}
    public string tierValueiD {get;set;}
    public string tierValueVS {get;set;}
    public string tierValueiP {get;set;}
    public string tierValueLV {get;set;}
    public string tierValueMC {get;set;}
    public string tierValueLW {get;set;}
    public string tierValueMD {get;set;}
    //public string tierValueIB {get;set;}
    public string tierValueME {get;set;}
    //public string tierValuePI {get;set;}
    public string tierValueMF {get;set;}
    public string tierValueiE {get;set;}
    public string tierValueRA {get;set;}
    public string tierValueiJ {get;set;}
    public string tierValueRB {get;set;}
    public string tierValueiF {get;set;}
    public string tierValueRC {get;set;}
    public string tierValueiH {get;set;}
    public string tierValueiK {get;set;}
    public string tierValueRD {get;set;}
    public string tierValueEZ {get;set;}
    public string tierValueRE {get;set;}
    public string tierValueAC {get;set;}
    public string tierValuePC {get;set;}
    public string tierValueOL {get;set;}
    public string tierValueLC {get;set;}
    public string tierValueLR {get;set;}
    public string tierValueEB {get;set;}
    public string tierValueIoD {get;set;}
    public string tierValueVX {get;set;}
    public string tierValueVC {get;set;}
    public string tierValueVI {get;set;}
    public string tierValueVE {get;set;}
    public string tierValueVD {get;set;}
    public string tierValueEC {get;set;}
    public string tierValueEJ {get;set;}
    public string tierValueiO {get;set;}
    public string tierValueED {get;set;}
    public string tierValueEP {get;set;}
    public string tierValueEE {get;set;}
    public string tierValueLO {get;set;}
    public string tierValueEI {get;set;}
    public string tierValueEF {get;set;}
    public string tierValueEL {get;set;}
    public string tierValueEG {get;set;}
    public string tierValueEK {get;set;}
    public string tierValueEH {get;set;}
    public string tierValueEA {get;set;}
    //public string tierValueEI {get;set;}
    public string tierValueFL {get;set;}
    public string tierValueFM {get;set;}
    public string tierValueFZ {get;set;}
    public string tierValueFN {get;set;}
    public string tierValueFX {get;set;}
    public string tierValueFO {get;set;}
    public string tierValueFC {get;set;}
    public string tierValueFP {get;set;}
    public string tierValueFQ {get;set;}
    public string tierValueFR {get;set;}
    public string tierValueFY {get;set;}
    public string tierValueFS {get;set;}
    public string tierValueFF {get;set;}
    public string tierValueFT {get;set;}
    public string tierValueFG {get;set;}
    public string tierValueFU {get;set;}
    public string tierValueFH {get;set;}
    public string tierValueFV {get;set;}
    public string tierValueFK {get;set;}
    public string tierValueFW {get;set;}
    public string tierValueFA {get;set;}
    public string tierValueFB {get;set;}
    public string tierValueFD {get;set;}
    public string tierValueFE {get;set;}
    public string tierValuePS {get;set;}
    
    //ADDED @ Abhijeet baneka - Jade Global 2014/08/20
    public string tierValueAA {get;set;}
    public string tierValueAF {get;set;}
    public string tierValueAB {get;set;}
    public string tierValueAL {get;set;}
    public string tierValueAH {get;set;}
    public string tierValueAZ {get;set;}
    public string tierValueAE {get;set;}
    public string tierValueCP {get;set;}
    public string tierValueIM {get;set;} 
    
    
    //ADDED @ Hitesh Patel - Jade Global 2014/12/18
    public string tierValueAD {get;set;}
    public string tierValueAG {get;set;}
    public string tierValueAI {get;set;}
    public string tierValueAJ {get;set;}
    
    //ADDED @ Hitesh Patel - Jade Global 2015/07/13
    public string tierValueAK {get;set;}
    public string tierValueAM {get;set;}
    //public string tierValueAL {get;set;}
    public string tierValueAN {get;set;}
    
    // For Display value of PAF Price Cod         
    public string priceCodeValueiR {get;set;}
    public string priceCodeValueMS {get;set;}
    public string priceCodeValueiC {get;set;}
    public string priceCodeValueiD {get;set;}
    public string priceCodeValueVS {get;set;}
    public string priceCodeValueiP {get;set;}
    public string priceCodeValueLV {get;set;}
    public string priceCodeValueMC {get;set;}
    public string priceCodeValueLW {get;set;}
    public string priceCodeValueMD {get;set;}
    public string priceCodeValueME {get;set;}
    public string priceCodeValueMF {get;set;}
    public string priceCodeValueiE {get;set;}
    public string priceCodeValueRA {get;set;}
    public string priceCodeValueiJ {get;set;}
    public string priceCodeValueRB {get;set;}
    public string priceCodeValueiF {get;set;}
    public string priceCodeValueRC {get;set;}
    public string priceCodeValueiH {get;set;}
    public string priceCodeValueiK {get;set;}
    public string priceCodeValueRD {get;set;}
    public string priceCodeValueEZ {get;set;}
    public string priceCodeValueRE {get;set;}
    public string priceCodeValueAC {get;set;}
    public string priceCodeValuePC {get;set;}
    public string priceCodeValueOL {get;set;}
    public string priceCodeValueLC {get;set;}
    public string priceCodeValueLR {get;set;}
    public string priceCodeValueEB {get;set;}
    public string priceCodeValueIoD {get;set;}
    public string priceCodeValueVX {get;set;}
    public string priceCodeValueVC {get;set;}
    public string priceCodeValueVI {get;set;}
    public string priceCodeValueVE {get;set;}
    public string priceCodeValueVD {get;set;}
    public string priceCodeValueEC {get;set;}
    public string priceCodeValueEJ {get;set;}
    public string priceCodeValueiO {get;set;}
    public string priceCodeValueED {get;set;}
    public string priceCodeValueEP {get;set;}
    public string priceCodeValueEE {get;set;}
    public string priceCodeValueLO {get;set;}
    public string priceCodeValueEI {get;set;}
    public string priceCodeValueEF {get;set;}
    public string priceCodeValueEL {get;set;}
    public string priceCodeValueEG {get;set;}
    public string priceCodeValueEK {get;set;}
    public string priceCodeValueEH {get;set;}
    public string priceCodeValueEA {get;set;}
    public string priceCodeValueFL {get;set;}
    public string priceCodeValueFM {get;set;}
    public string priceCodeValueFZ {get;set;}
    public string priceCodeValueFN {get;set;}
    public string priceCodeValueFX {get;set;}
    public string priceCodeValueFO {get;set;}
    public string priceCodeValueFC {get;set;}
    public string priceCodeValueFP {get;set;}
    public string priceCodeValueFQ {get;set;}
    public string priceCodeValueFR {get;set;}
    public string priceCodeValueFY {get;set;}
    public string priceCodeValueFS {get;set;}
    public string priceCodeValueFF {get;set;}
    public string priceCodeValueFT {get;set;}
    public string priceCodeValueFG {get;set;}
    public string priceCodeValueFU {get;set;}
    public string priceCodeValueFH {get;set;}
    public string priceCodeValueFV {get;set;}
    public string priceCodeValueFK {get;set;}
    public string priceCodeValueFW {get;set;}
    public string priceCodeValueFA {get;set;}
    public string priceCodeValueFB {get;set;}
    public string priceCodeValueFD {get;set;}
    public string priceCodeValueFE {get;set;}
    public string priceCodeValuePS {get;set;}
    
    public string priceCodeValueAA {get;set;}
    public string priceCodeValueAF {get;set;}
    public string priceCodeValueAB {get;set;}
    public string priceCodeValueAL {get;set;}
    public string priceCodeValueAH {get;set;}
    public string priceCodeValueAZ {get;set;}
    public string priceCodeValueAE {get;set;}
    public string priceCodeValueIM {get;set;}
    public string priceCodeValueCP {get;set;}
    
    public string priceCodeValueAD {get;set;}
    public string priceCodeValueAG {get;set;}
    public string priceCodeValueAI {get;set;}
    public string priceCodeValueAJ {get;set;}
    
    // ADDED @ Hitesh Patel - Jade Global 2015/07/13
    public string priceCodeValueAK {get;set;}
    public string priceCodeValueAM {get;set;}
    public string priceCodeValueAN {get;set;}
    
    public PAFDetailPageController(ApexPages.StandardController controller){
        this.controller = controller;
        paf = [SELECT ID, Account__r.BillingCountry, Recordtype.Developername, iR__c, MS__c, iC__c, iD__c, VS__c, iP__c, LV__c, MC__c, LW_Indala_Credentials__c,
        MD__c, ME__c, MF__c, iE_pivCLASS_Modules_Software__c, RA__c, iJ_pivCLASS_Modules_Software__c, RB__c, iF_pivCLASS_Kits__c, 
        RC__c, iH_pivCLASS_Bundles__c, iK_pivCLASS_Mobile_Handheld_Readers__c, RD__c, EZ_EasyLobby__c, RE__c, AC__c, PC__c, 
        OL__c, LC__c, LR__c, EB_Embeddable_Credentials__c, IoD__c, VX__c, VC__c, VI__c, VE__c, VD__c, EC__c, EJ_SIO_Processor__c,
        iO__c, ED_veriCLASS_Readers__c, EP__c, EE_OMNIKEY_Reader_Board__c, LO__c, EI_Developer_Services_Plus__c, EF_OMNIKEY_Chipsets__c, 
        EL_Embedded_Accessories__c, EG_SmartID_Reader_Boards__c, EK_iCLASS_SE_Reader_Modules__c, EH_identiCLASS_Readers__c, 
        EA_ISO_Reader_Boards__c, FL_Asure_ID_Software__c, FM_SDK_S_W_Support__c, FZ_Standard_Series_DTC1250e_Printers__c, 
        FN_Extended_Warranties__c, FX_Standard_Series_C50_Printers__c, FO_Cameras_Camera_S_W__c, FC_Print_Heads__c, FP_Photo_ID_Accessories__c,
        FQ_Spare_Parts_Packages__c, FR_Spare_Parts_Kits__c, FY_Standard_C50_Regional_Ribbons_Only__c, FS_Rewriteable_Cards__c, FF_Holo_Film_Overlams__c,
        FT_HDP8500_Printers__c, FG_Veri_Holo_OVD_Cards__c, FU_Industrial_Series_Ribbons_HDP_Film__c, FH_UltraCards__c, 
        FV_Laser_Engravers__c, FK_HDPii_Printers__c, FW_Financial_Series_Ribbons_HDP_Film__c, FA_Prof_Printers__c,
        FB_Entry_Level_Printers__c, FD_Ribbons_Clear_Film__c, FE_Entry_Level_Ribbons__c, PS_Professional_Services__c, 
        AA__c, AF__c, AB__c, AL__c, AK__c, AM__c, AN__c, AH__c, AZ__c, AE__c, iM_HID_Mobile_Access__c, CP_Custom_Special_Products_w_o_Discount__c,
        AD__c, AG__c, AI__c, AJ__c, Account__c, Status__c FROM Price_Authorization_Form__c WHERE Id =:PafId];
        HIDBusAdmin = [SELECT Id FROM profile WHERE name = 'HID Business Administrator'].Id;
        HIDBusAdminModAll = [SELECT Id FROM profile WHERE name = 'HID Business Administrator Modify All Data'].Id;
        vPAFRecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'vPAF' AND SobjectType = 'Price_Authorization_Form__c'].Id;
        //       idAdvantagePartnerRecordType = [SELECT Id FROM RecordType WHERE Name = 'Advantage Partner' AND SobjectType = 'Partner_Program__c'].Id;
        List<Partner_Program__c> PartnerProgramStatusList = [SELECT Partner_Program_Status__c, Partner_Program_Status_Modifier__c FROM  Partner_Program__c WHERE RecordTypeId =: idAdvantagePartnerRecordType AND Account__c =: paf.Account__c]; 
        if(PartnerProgramStatusList.size()>0){
            PartnerProgramStatus = PartnerProgramStatusList[0].Partner_Program_Status__c;
            PartnerProgramStatusModifier = PartnerProgramStatusList[0].Partner_Program_Status_Modifier__c;
        }else{PartnerProgramStatus = '';
            PartnerProgramStatusModifier ='';
        }
        
        IsshowCancel = true;
        IsshowRecall= true;
        IsshowEdit = true;
        
        if(paf.Status__c == 'Awaiting Approval'){
            IsshowCancel = false;         
        }
        if(paf.Status__c == 'Approved'){
            IsshowCancel = false;
            IsshowRecall= false;
        }
        if(paf.Status__c == 'Cancelled' || paf.Status__c == 'Recalled'){
            IsshowEdit = false;
            IsshowCancel = false;
            IsshowRecall= false;
        }
        if(paf.Status__c == 'Draft' || paf.Status__c == 'Rejected'){
            IsshowRecall = false;
        }
        
        if(paf.Status__c == 'ERP Update' || paf.Status__c == 'ERP Update Error'){
            IsshowCancel = false;
            IsshowRecall = false;
        }
        
        if(paf.Status__c == 'Recalled'){
            IsshowRecall = false;
            IsshowCancel = false;
            IsshowEdit = false;
        }      
        
        TierDiscountController tdc = new TierDiscountController();
        
        tierValueiR = tdc.getTierDiscountDetails('iR__c');
        tierValueMS = tdc.getTierDiscountDetails('MS__c');
        tierValueiC = tdc.getTierDiscountDetails('iC__c');
        //tierValueSL = tdc.getTierDiscountDetails('SL__c');
        tierValueiD = tdc.getTierDiscountDetails('iD__c');
        tierValueVS = tdc.getTierDiscountDetails('VS__c');
        tierValueiP = tdc.getTierDiscountDetails('iP__c');
        tierValueLV = tdc.getTierDiscountDetails('LV__c');
        tierValueMC = tdc.getTierDiscountDetails('MC__c');
        tierValueLW = tdc.getTierDiscountDetails('LW_Indala_Credentials__c');
        tierValueMD = tdc.getTierDiscountDetails('MD__c');
        //tierValueIB = tdc.getTierDiscountDetails('IB__c');
        tierValueME = tdc.getTierDiscountDetails('ME__c');
        //tierValuePI = tdc.getTierDiscountDetails('PI__c');
        tierValueMF = tdc.getTierDiscountDetails('MF__c');
        tierValueiE = tdc.getTierDiscountDetails('iE_pivCLASS_Modules_Software__c');
        tierValueRA = tdc.getTierDiscountDetails('RA__c');
        tierValueiJ = tdc.getTierDiscountDetails('iJ_pivCLASS_Modules_Software__c');
        tierValueRB = tdc.getTierDiscountDetails('RB__c');
        tierValueiF = tdc.getTierDiscountDetails('iF_pivCLASS_Kits__c');
        tierValueRC = tdc.getTierDiscountDetails('RC__c');
        tierValueiH = tdc.getTierDiscountDetails('iH_pivCLASS_Bundles__c');
        tierValueiK = tdc.getTierDiscountDetails('iK_pivCLASS_Mobile_Handheld_Readers__c');
        tierValueRD = tdc.getTierDiscountDetails('RD__c');
        tierValueEZ = tdc.getTierDiscountDetails('EZ_EasyLobby__c');
        tierValueRE = tdc.getTierDiscountDetails('RE__c');
        tierValueAC = tdc.getTierDiscountDetails('AC__c');
        tierValuePC = tdc.getTierDiscountDetails('PC__c');
        tierValueOL = tdc.getTierDiscountDetails('OL__c');
        tierValueLC = tdc.getTierDiscountDetails('LC__c');
        tierValueLR = tdc.getTierDiscountDetails('LR__c');
        tierValueEB = tdc.getTierDiscountDetails('EB_Embeddable_Credentials__c');
        tierValueIoD = tdc.getTierDiscountDetails('IoD__c');
        tierValueVX = tdc.getTierDiscountDetails('VX__c');
        tierValueVC = tdc.getTierDiscountDetails('VC__c');
        tierValueVI = tdc.getTierDiscountDetails('VI__c');
        tierValueVE = tdc.getTierDiscountDetails('VE__c');
        tierValueVD = tdc.getTierDiscountDetails('VD__c');
        tierValueEC = tdc.getTierDiscountDetails('EC__c');
        tierValueEJ = tdc.getTierDiscountDetails('EJ_SIO_Processor__c');
        tierValueiO = tdc.getTierDiscountDetails('iO__c');
        tierValueED = tdc.getTierDiscountDetails('ED_veriCLASS_Readers__c');
        tierValueEP = tdc.getTierDiscountDetails('EP__c');
        tierValueEE = tdc.getTierDiscountDetails('EE_OMNIKEY_Reader_Board__c');
        tierValueLO = tdc.getTierDiscountDetails('LO__c');
        tierValueEI = tdc.getTierDiscountDetails('EI_Developer_Services_Plus__c');
        tierValueEF = tdc.getTierDiscountDetails('EF_OMNIKEY_Chipsets__c');
        tierValueEL = tdc.getTierDiscountDetails('EL_Embedded_Accessories__c');
        tierValueEG = tdc.getTierDiscountDetails('EG_SmartID_Reader_Boards__c');
        tierValueEK = tdc.getTierDiscountDetails('EK_iCLASS_SE_Reader_Modules__c');
        tierValueEH = tdc.getTierDiscountDetails('EH_identiCLASS_Readers__c');
        tierValueEA = tdc.getTierDiscountDetails('EA_ISO_Reader_Boards__c');
        //tierValueEI = tdc.getTierDiscountDetails('EI_Developer_Services_Plus__c');
        tierValueFL = tdc.getTierDiscountDetails('FL_Asure_ID_Software__c');
        tierValueFM = tdc.getTierDiscountDetails('FM_SDK_S_W_Support__c');
        tierValueFZ = tdc.getTierDiscountDetails('FZ_Standard_Series_DTC1250e_Printers__c');
        tierValueFN = tdc.getTierDiscountDetails('FN_Extended_Warranties__c');
        tierValueFX = tdc.getTierDiscountDetails('FX_Standard_Series_C50_Printers__c');
        tierValueFO = tdc.getTierDiscountDetails('FO_Cameras_Camera_S_W__c');
        tierValueFC = tdc.getTierDiscountDetails('FC_Print_Heads__c');
        tierValueFP = tdc.getTierDiscountDetails('FP_Photo_ID_Accessories__c');
        tierValueFQ = tdc.getTierDiscountDetails('FQ_Spare_Parts_Packages__c');
        tierValueFR = tdc.getTierDiscountDetails('FR_Spare_Parts_Kits__c');
        tierValueFY = tdc.getTierDiscountDetails('FY_Standard_C50_Regional_Ribbons_Only__c');
        tierValueFS = tdc.getTierDiscountDetails('FS_Rewriteable_Cards__c');
        tierValueFF = tdc.getTierDiscountDetails('FF_Holo_Film_Overlams__c');
        tierValueFT = tdc.getTierDiscountDetails('FT_HDP8500_Printers__c'); 
        tierValueFG = tdc.getTierDiscountDetails('FG_Veri_Holo_OVD_Cards__c');
        tierValueFU = tdc.getTierDiscountDetails('FU_Industrial_Series_Ribbons_HDP_Film__c');
        tierValueFH = tdc.getTierDiscountDetails('FH_UltraCards__c');
        tierValueFV = tdc.getTierDiscountDetails('FV_Laser_Engravers__c');
        tierValueFK = tdc.getTierDiscountDetails('FK_HDPii_Printers__c');
        tierValueFW = tdc.getTierDiscountDetails('FW_Financial_Series_Ribbons_HDP_Film__c');      
        tierValueFA = tdc.getTierDiscountDetails('FA_Prof_Printers__c');
        tierValueFB = tdc.getTierDiscountDetails('FB_Entry_Level_Printers__c');
        tierValueFD = tdc.getTierDiscountDetails('FD_Ribbons_Clear_Film__c');
        tierValueFE = tdc.getTierDiscountDetails('FE_Entry_Level_Ribbons__c');
        tierValuePS = tdc.getTierDiscountDetails('PS_Professional_Services__c');   
        
        tierValueAA = tdc.getTierDiscountDetails('AA__c');
        tierValueAF = tdc.getTierDiscountDetails('AF__c');
        tierValueAB = tdc.getTierDiscountDetails('AB__c');
        tierValueAL = tdc.getTierDiscountDetails('AL__c');
        tierValueAH = tdc.getTierDiscountDetails('AH__c');
        tierValueAZ = tdc.getTierDiscountDetails('AZ__c');
        tierValueAE = tdc.getTierDiscountDetails('AE__c');
        tierValueIM = tdc.getTierDiscountDetails('iM_HID_Mobile_Access__c');
        tierValueCP = tdc.getTierDiscountDetails('CP_Custom_Special_Products_w_o_Discount__c');
        
        tierValueAD = tdc.getTierDiscountDetails('AD__c');
        tierValueAG = tdc.getTierDiscountDetails('AG__c');
        tierValueAI = tdc.getTierDiscountDetails('AI__c');
        tierValueAJ = tdc.getTierDiscountDetails('AJ__c');
        
        
        
        // ADDED @ Hitesh Patel - Jade Global 2015/07/13
        tierValueAK = tdc.getTierDiscountDetails('AK__c');
        tierValueAM = tdc.getTierDiscountDetails('AM__c');
        tierValueAN = tdc.getTierDiscountDetails('AN__c');
        
        //ADDED @ Hitesh Patel - Jade Global 2015/06/03
        string accCountry=paf.Account__r.BillingCountry;
        PafPicklistsController objPafPicklistsController = new PafPicklistsController(accCountry, paf.Recordtype.Developername);
        
        
        priceCodeValueiR = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.iR__c);
        priceCodeValueMS = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.MS__c);
        priceCodeValueiC = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.iC__c);
        //tierValueSL = tdc.getTierDiscountDetails('SL__c');
        priceCodeValueiD = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.iD__c);
        priceCodeValueVS = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.VS__c);
        priceCodeValueiP = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.iP__c);
        priceCodeValueLV = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.LV__c);
        priceCodeValueMC = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.MC__c);
        priceCodeValueLW = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.LW_Indala_Credentials__c);
        priceCodeValueMD = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.MD__c);
        //tierValueIB = tdc.getTierDiscountDetails('IB__c');
        priceCodeValueME = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.ME__c);
        //tierValuePI = tdc.getTierDiscountDetails('PI__c');
        priceCodeValueMF = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.MF__c);
        priceCodeValueiE = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.iE_pivCLASS_Modules_Software__c);
        priceCodeValueRA = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.RA__c);
        priceCodeValueiJ = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.iJ_pivCLASS_Modules_Software__c);
        priceCodeValueRB = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.RB__c);
        priceCodeValueiF = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.iF_pivCLASS_Kits__c);
        priceCodeValueRC = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.RC__c);
        priceCodeValueiH = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.iH_pivCLASS_Bundles__c);
        priceCodeValueiK = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.iK_pivCLASS_Mobile_Handheld_Readers__c);
        priceCodeValueRD = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.RD__c);
        priceCodeValueEZ = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EZ_EasyLobby__c);
        priceCodeValueRE = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.RE__c);
        priceCodeValueAC = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AC__c);
        priceCodeValuePC = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.PC__c);
        priceCodeValueOL = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.OL__c);
        priceCodeValueLC = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.LC__c);
        priceCodeValueLR = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.LR__c);
        priceCodeValueEB = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EB_Embeddable_Credentials__c);
        priceCodeValueIoD = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.IoD__c);
        priceCodeValueVX = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.VX__c);
        priceCodeValueVC = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.VC__c);
        priceCodeValueVI = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.VI__c);
        priceCodeValueVE = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.VE__c);
        priceCodeValueVD = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.VD__c);
        priceCodeValueEC = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EC__c);
        priceCodeValueEJ = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EJ_SIO_Processor__c);
        priceCodeValueiO = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.iO__c);
        priceCodeValueED = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.ED_veriCLASS_Readers__c);
        priceCodeValueEP = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EP__c);
        priceCodeValueEE = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EE_OMNIKEY_Reader_Board__c);
        priceCodeValueLO = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.LO__c);
        priceCodeValueEI = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EI_Developer_Services_Plus__c);
        priceCodeValueEF = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EF_OMNIKEY_Chipsets__c);
        priceCodeValueEL = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EL_Embedded_Accessories__c);
        priceCodeValueEG = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EG_SmartID_Reader_Boards__c);
        priceCodeValueEK = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EK_iCLASS_SE_Reader_Modules__c);
        priceCodeValueEH = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EH_identiCLASS_Readers__c);
        priceCodeValueEA = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.EA_ISO_Reader_Boards__c);
        //tierValueEI = tdc.getTierDiscountDetails('EI_Developer_Services_Plus__c);
        priceCodeValueFL = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FL_Asure_ID_Software__c);
        priceCodeValueFM = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FM_SDK_S_W_Support__c);
        priceCodeValueFZ = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FZ_Standard_Series_DTC1250e_Printers__c);
        priceCodeValueFN = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FN_Extended_Warranties__c);
        priceCodeValueFX = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FX_Standard_Series_C50_Printers__c);
        priceCodeValueFO = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FO_Cameras_Camera_S_W__c);
        priceCodeValueFC = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FC_Print_Heads__c);
        priceCodeValueFP = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FP_Photo_ID_Accessories__c);
        priceCodeValueFQ = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FQ_Spare_Parts_Packages__c);
        priceCodeValueFR = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FR_Spare_Parts_Kits__c);
        priceCodeValueFY = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FY_Standard_C50_Regional_Ribbons_Only__c);
        priceCodeValueFS = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FS_Rewriteable_Cards__c);
        priceCodeValueFF = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FF_Holo_Film_Overlams__c);
        priceCodeValueFT = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FT_HDP8500_Printers__c); 
        priceCodeValueFG = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FG_Veri_Holo_OVD_Cards__c);
        priceCodeValueFU = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FU_Industrial_Series_Ribbons_HDP_Film__c);
        priceCodeValueFH = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FH_UltraCards__c);
        priceCodeValueFV = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FV_Laser_Engravers__c);
        priceCodeValueFK = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FK_HDPii_Printers__c);
        priceCodeValueFW = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FW_Financial_Series_Ribbons_HDP_Film__c);      
        priceCodeValueFA = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FA_Prof_Printers__c);
        priceCodeValueFB = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FB_Entry_Level_Printers__c);
        priceCodeValueFD = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FD_Ribbons_Clear_Film__c);
        priceCodeValueFE = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.FE_Entry_Level_Ribbons__c);
        priceCodeValuePS = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.PS_Professional_Services__c);   
        
        priceCodeValueAA = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AA__c);
        priceCodeValueAF = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AF__c);
        priceCodeValueAB = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AB__c);
        priceCodeValueAL = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AL__c);
        priceCodeValueAH = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AH__c);
        priceCodeValueAZ = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AZ__c);
        priceCodeValueAE = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AE__c);
        priceCodeValueIM = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.iM_HID_Mobile_Access__c);
        priceCodeValueCP = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.CP_Custom_Special_Products_w_o_Discount__c);
        
        priceCodeValueAD = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AD__c);
        priceCodeValueAG = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AG__c);
        priceCodeValueAI = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AI__c);
        priceCodeValueAJ = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AJ__c);
        
        // ADDED @ Hitesh Patel - Jade Global 2015/07/13
        priceCodeValueAK = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AK__c);
        priceCodeValueAM = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AM__c);
        priceCodeValueAN = objPafPicklistsController.getPAFPriceCodeSubmitValue(paf.AN__c);
        
    
    }
    
    //Redirect to PAF Edit VSF page 
    public PageReference EditPriceAuthorizationForm(){
        try{          
            return New PageReference('/apex/PriceAuthorizationFormEdit?id='+PafId+'&retURL=/'+PafId);
        }catch(exception e){
            ApexPages.AddMessages(e);
            return null;
        }    
    } 
    
    //Redirect to PAF Clone VSF page
    public PageReference ClonePriceAuthorizationForm(){
        try{          
            return New PageReference('/apex/PriceAuthorizationFormClone?clone=1&id='+PafId+'&retURL=/'+PafId);
        }catch(exception e){
            ApexPages.AddMessages(e);
            return null;
        } 
    }
    
    //TO delete current PAF record 
    public  PageReference DeletePriceAuthorizationForm(){
        try{
            delete paf;
            return New PageReference('/a0O/o');       
        }catch(exception e){
            ApexPages.AddMessages(e);
            return null;
        }
    }
    
    //To update PAF Status to Cancelled
    public pagereference CancelPAFApproveStatus() {
        try{  
            paf.Status__c = 'Cancelled';             
            update paf;      
            pagereference pr = new pagereference('/'+paf.Id);
            pr.setRedirect(true);
            return pr;
        }catch(exception e){
            ApexPages.AddMessages(e);
            return null;
        }        
    }
    
    //To update PAF to Recalled
    public pagereference PAFStatustoRecall(){
        try{        
            Approval.ProcessWorkItemRequest pwr = new Approval.ProcessWorkItemRequest();
            List<ProcessInstance> procins = new List<ProcessInstance>([select Id from ProcessInstance where Status = 'Pending' and TargetObjectId = :paf.Id]);
            List<ProcessInstanceWorkitem>  workitem = new List<ProcessInstanceWorkitem>([select Id from ProcessInstanceWorkitem where ProcessInstanceId = :procins[0].id]);
            if ((workitem != null) && (workitem.size() > 0)){
                //              pwr.SetComments(statusToUpdate);
                pwr.setWorkItemId(workitem[0].id);
                pwr.setAction('Removed');               
                // Execute process request
                Approval.ProcessResult apr = Approval.process(pwr);
                
                paf.Status__c = 'Draft';             
                update paf;
            }   
            pagereference pr = new pagereference('/'+paf.Id);
            pr.setRedirect(true);
            return pr;
        }catch(exception e){
            ApexPages.AddMessages(e);
            return null;
        }        
        
    }    
}