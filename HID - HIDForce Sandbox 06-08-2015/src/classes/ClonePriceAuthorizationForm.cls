/****************************************************************************
* Type               : Apex Class
* Name               : ClonePriceAuthorizationForm
* Modified by        : Hitesh Patel
* Modified Date      : 5th June 2015
* Last Modified By   : Hitesh Patel 5th June 2015
* Purpose            : This is Extension class for "PriceAuthorizationFormClone" visualforce page
                       This class will handle oprations on PAF Clone page.                
****************************************************************************/
public class ClonePriceAuthorizationForm {
    public Price_Authorization_Form__c priceAuthorization{get; set;}
    String parentPafId = ApexPages.CurrentPage().getParameters().get('retURL');
    public Account account {get;set;}
    public string query {get;set;}
    public List<Account_Profile__c>acProfile  {get;set;}
    public String serverURL {get;set;}
    public static final Id idAdvantagePartnerRecordType = [SELECT Id FROM RecordType WHERE Name = 'Advantage Partner' AND SobjectType = 'Partner_Program__c'].Id;
    public String PartnerProgramStatus {get;set;}
    List<Partner_Program__c> PartnerProgramStatusList;
    public String PartnerProgramStatusModifier {get;set;}
    
    public List<SelectOption> selectOptionsIR {get;set;}
    public List<SelectOption> selectOptionsWR {get;set;}
    public List<SelectOption> selectOptionsIC {get;set;}
    public List<SelectOption> selectOptionsWC {get;set;}
    public List<SelectOption> selectOptionsID {get;set;}
    public List<SelectOption> selectOptionsMS {get;set;}
    public List<SelectOption> selectOptionsIP {get;set;}
    //public List<SelectOption> selectOptionsSL {get;set;}
    public List<SelectOption> selectOptionsMC {get;set;}
    public List<SelectOption> selectOptionsVS {get;set;}
    public List<SelectOption> selectOptionsMD {get;set;}
    public List<SelectOption> selectOptionsLV {get;set;}
    public List<SelectOption> selectOptionsME {get;set;}
    public List<SelectOption> selectOptionsLW {get;set;}
    public List<SelectOption> selectOptionsMF {get;set;}
    //public List<SelectOption> selectOptionsIB {get;set;}
    public List<SelectOption> selectOptionsRA {get;set;}
    //public List<SelectOption> selectOptionsPI {get;set;}
    public List<SelectOption> selectOptionsRB {get;set;}
    public List<SelectOption> selectOptionsIEClass {get;set;}
    public List<SelectOption> selectOptionsRC {get;set;}
    public List<SelectOption> selectOptionsIJ {get;set;}
    public List<SelectOption> selectOptionsIF {get;set;}
    public List<SelectOption> selectOptionsRD {get;set;}
    public List<SelectOption> selectOptionsIG {get;set;}
    public List<SelectOption> selectOptionsRE {get;set;}
    public List<SelectOption> selectOptionsIH {get;set;}
    public List<SelectOption> selectOptionsIK {get;set;}
    public List<SelectOption> selectOptionsPC {get;set;}
    public List<SelectOption> selectOptionsEZ {get;set;}
    public List<SelectOption> selectOptionsAC {get;set;}
    public List<SelectOption> selectOptionsOL {get;set;}
    public List<SelectOption> selectOptionsLC {get;set;}
    public List<SelectOption> selectOptionsLR {get;set;}
    public List<SelectOption> selectOptionsEBEMBD {get;set;}
    public List<SelectOption> selectOptionsIOD {get;set;}
    public List<SelectOption> selectOptionsVX {get;set;}
    public List<SelectOption> selectOptionsVC {get;set;}
    public List<SelectOption> selectOptionsVI {get;set;}
    public List<SelectOption> selectOptionsVEC {get;set;}
    public List<SelectOption> selectOptionsVD {get;set;}
    public List<SelectOption> selectOptionsEC {get;set;}
    public List<SelectOption> selectOptionsEJ {get;set;}
    public List<SelectOption> selectOptionsIOC {get;set;}
    public List<SelectOption> selectOptionsEDVeri {get;set;}
    public List<SelectOption> selectOptionsEP {get;set;}
    public List<SelectOption> selectOptionsEE {get;set;}
    public List<SelectOption> selectOptionsLOC {get;set;}
    public List<SelectOption> selectOptionsEFO {get;set;}
    public List<SelectOption> selectOptionsELEM {get;set;}
    public List<SelectOption> selectOptionsEGSMART {get;set;}
    public List<SelectOption> selectOptionsEK {get;set;}
    public List<SelectOption> selectOptionsEHCLASS {get;set;}
    public List<SelectOption> selectOptionsEAISO {get;set;}
    public List<SelectOption> selectOptionsEI {get;set;}
    public List<SelectOption> selectOptionsFAPROP {get;set;}
    public List<SelectOption> selectOptionsFM {get;set;}
    public List<SelectOption> selectOptionsFB {get;set;}
    public List<SelectOption> selectOptionsFN {get;set;}
    public List<SelectOption> selectOptionsFX {get;set;}
    public List<SelectOption> selectOptionsFY {get;set;}
    public List<SelectOption> selectOptionsFZ {get;set;}
    public List<SelectOption> selectOptionsFC {get;set;}
    public List<SelectOption> selectOptionsFO {get;set;}
    public List<SelectOption> selectOptionsFDR {get;set;}
    public List<SelectOption> selectOptionsFPID {get;set;}
    public List<SelectOption> selectOptionsFEENTRY {get;set;}
    public List<SelectOption> selectOptionsFQ {get;set;}
    public List<SelectOption> selectOptionsFF {get;set;}
    public List<SelectOption> selectOptionsFR {get;set;}
    public List<SelectOption> selectOptionsFGVERI {get;set;}
    public List<SelectOption> selectOptionsFS {get;set;}
    public List<SelectOption> selectOptionsFHULTRA {get;set;}
    public List<SelectOption> selectOptionsFT {get;set;}
    public List<SelectOption> selectOptionsFKHD {get;set;}
    public List<SelectOption> selectOptionsFU {get;set;}
    public List<SelectOption> selectOptionsFL {get;set;}
    public List<SelectOption> selectOptionsFV {get;set;}
    public List<SelectOption> selectOptionsFMFIN {get;set;}
    public List<SelectOption> selectOptionsPS {get;set;}
    public List<SelectOption> selectOptionsAA {get;set;}
    public List<SelectOption> selectOptionsAD {get;set;}
    public List<SelectOption> selectOptionsAG {get;set;}
    public List<SelectOption> selectOptionsAI {get;set;}
    public List<SelectOption> selectOptionsAJ {get;set;}
    
    public List<SelectOption> selectOptionsAF {get;set;}
    public List<SelectOption> selectOptionsAB {get;set;}
    public List<SelectOption> selectOptionsAL {get;set;}
    public List<SelectOption> selectOptionsAH {get;set;}
    public List<SelectOption> selectOptionsAZ {get;set;}
    public List<SelectOption> selectOptionsAE {get;set;}
    public List<SelectOption> selectOptionsIM {get;set;}
    public List<SelectOption> selectOptionsCP {get;set;}
    
    //ADDED @ Hitesh Patel - Jade Global 2015/07/13
    public List<SelectOption> selectOptionsAK {get;set;}
    public List<SelectOption> selectOptionsAM {get;set;}
    public List<SelectOption> selectOptionsAN {get;set;}
        
    public string tierValueiR {get;set;}
    public string tierValueMS {get;set;}
    public string tierValueiC {get;set;}
    public string tierValueSL {get;set;}
    public string tierValueiD {get;set;}
    public string tierValueVS {get;set;}
    public string tierValueiP {get;set;}
    public string tierValueLV {get;set;}
    public string tierValueMC {get;set;}
    public string tierValueLW {get;set;}
    public string tierValueMD {get;set;}
    public string tierValueIB {get;set;}
    public string tierValueME {get;set;}
    public string tierValuePI {get;set;}
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
    public string tierValueEF {get;set;}
    public string tierValueEL {get;set;}
    public string tierValueEG {get;set;}
    public string tierValueEK {get;set;}
    public string tierValueEH {get;set;}
    public string tierValueEA {get;set;}
    public string tierValueEI {get;set;}
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
    public string tierValueAA {get;set;}
    
    //Added by Hitesh - Jade Global - 12/18/2014
    public string tierValueAD {get;set;}
    public string tierValueAG {get;set;}
    public string tierValueAI {get;set;}
    public string tierValueAJ {get;set;}
    
    //ADDED @ Hitesh Patel - Jade Global 2015/07/13
    public string tierValueAK {get;set;}
    public string tierValueAM {get;set;}
    //public string tierValueAL {get;set;}
    public string tierValueAN {get;set;}
    
       
        
    public string tierValueAF {get;set;}
    public string tierValueAB {get;set;}
    public string tierValueAL {get;set;}
    public string tierValueAH {get;set;}
    public string tierValueAZ {get;set;}
    public string tierValueAE {get;set;}  
    public string tierValueCP {get;set;}
    public string tierValueIM {get;set;}
    public string accCountry; 
    Account relatedAccount;
    PafPicklistsController PafPicklistsController;
    
    
    public ClonePriceAuthorizationForm(ApexPages.StandardController controller) {
    
        parentPafId = parentPafId.subString(1,16);  
        serverURL = System.URL.getSalesforceBaseUrl().getHost();
        priceAuthorization = new Price_Authorization_Form__c();
        string queryString = getQueryString('Price_Authorization_Form__c');
        queryString = queryString + ' where id = :parentPafId';
        
        Price_Authorization_Form__c parentPaf = new Price_Authorization_Form__c(); 
        parentPaf  = dataBase.Query(queryString);
        
        priceAuthorization = parentPaf.clone(false, true);
        priceAuthorization.Status__c = 'Draft';
        priceAuthorization.L1_Approval__c = null;
        priceAuthorization.E21_Approval__c = null;
        priceAuthorization.L2_Approval__c = null;
        priceAuthorization.E21VP_Approval__c = null;
        priceAuthorization.Pricing_Approval__c = null;
        priceAuthorization.ERP_Update__c = FALSE;
        priceAuthorization.ERP_Update_Date__c = null;
        priceAuthorization.Pricing_Effective_Date__c = null;
        priceAuthorization.ERP_Update_Error__c = null;
        accCountry=priceAuthorization.Account__r.BillingCountry;
        
        account = new Account();        
        PartnerProgramStatusList = [SELECT Partner_Program_Status__c, Partner_Program_Status_Modifier__c FROM  Partner_Program__c WHERE RecordTypeId =: idAdvantagePartnerRecordType AND Account__c =: priceAuthorization.Account__c]; 
        if(PartnerProgramStatusList.size() > 0 && priceAuthorization.Account__c != null){
            PartnerProgramStatus = PartnerProgramStatusList[0].Partner_Program_Status__c;
            PartnerProgramStatusModifier = PartnerProgramStatusList[0].Partner_Program_Status_Modifier__c;
        }else{PartnerProgramStatus = '';
            PartnerProgramStatusModifier = ''; 
        }
        
        getQueryforAccount qry = new  getQueryforAccount();            
        query = qry.getQuery();
        getAccountProfileDetails();
        PafPicklistsController = new PafPicklistsController(accCountry, priceAuthorization.Recordtype.Developername);
        resetPriceCodeValues();
                
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
        tierValueEF = tdc.getTierDiscountDetails('EF_OMNIKEY_Chipsets__c');
        tierValueEL = tdc.getTierDiscountDetails('EL_Embedded_Accessories__c');
        tierValueEG = tdc.getTierDiscountDetails('EG_SmartID_Reader_Boards__c');
        tierValueEK = tdc.getTierDiscountDetails('EK_iCLASS_SE_Reader_Modules__c');
        tierValueEH = tdc.getTierDiscountDetails('EH_identiCLASS_Readers__c');
        tierValueEA = tdc.getTierDiscountDetails('EA_ISO_Reader_Boards__c');
        tierValueEI = tdc.getTierDiscountDetails('EI_Developer_Services_Plus__c');
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
        tierValueAD = tdc.getTierDiscountDetails('AD__c');
        tierValueAG = tdc.getTierDiscountDetails('AG__c');
        tierValueAI = tdc.getTierDiscountDetails('AI__c');
        tierValueAJ = tdc.getTierDiscountDetails('AJ__c');
        
        tierValueAF = tdc.getTierDiscountDetails('AF__c');
        tierValueAB = tdc.getTierDiscountDetails('AB__c');
        tierValueAL = tdc.getTierDiscountDetails('AL__c');
        tierValueAH = tdc.getTierDiscountDetails('AH__c');
        tierValueAZ = tdc.getTierDiscountDetails('AZ__c');
        tierValueAE = tdc.getTierDiscountDetails('AE__c');     
        tierValueIM = tdc.getTierDiscountDetails('iM_HID_Mobile_Access__c');
        tierValueCP = tdc.getTierDiscountDetails('CP_Custom_Special_Products_w_o_Discount__c');  
        
        //ADDED @ Hitesh Patel - Jade Global 2015/07/13
        tierValueAK = tdc.getTierDiscountDetails('AK__c');
        tierValueAM = tdc.getTierDiscountDetails('AM__c');
        tierValueAN = tdc.getTierDiscountDetails('AN__c');     
    }
    
    public void resetPriceCodeValues(){
    
        selectOptionsIR = PafPicklistsController.getFieldValues('iR__c');
        selectOptionsWR = PafPicklistsController.getFieldValues('WR__c'); 
        selectOptionsIC = PafPicklistsController.getFieldValues('iC__c');
        selectOptionsWC = PafPicklistsController.getFieldValues('WC__c');
        selectOptionsID = PafPicklistsController.getFieldValues('iD__c');
        selectOptionsMS = PafPicklistsController.getFieldValues('MS__c'); 
        selectOptionsIP = PafPicklistsController.getFieldValues('iP__c'); 
        //selectOptionsSL = PafPicklistsController.getFieldValues('SL__c');
        selectOptionsMC = PafPicklistsController.getFieldValues('MC__c');
        selectOptionsVS = PafPicklistsController.getFieldValues('VS__c');
        selectOptionsMD = PafPicklistsController.getFieldValues('MD__c');   
        selectOptionsLV = PafPicklistsController.getFieldValues('LV__c');
        selectOptionsME = PafPicklistsController.getFieldValues('ME__c');
        selectOptionsLW = PafPicklistsController.getFieldValues('LW_Indala_Credentials__c');
        selectOptionsMF = PafPicklistsController.getFieldValues('MF__c');
        //selectOptionsIB = PafPicklistsController.getFieldValues('IB__c');
        selectOptionsRA = PafPicklistsController.getFieldValues('RA__c');
        //selectOptionsPI = PafPicklistsController.getFieldValues('PI__c');
        selectOptionsRB = PafPicklistsController.getFieldValues('RB__c');
        selectOptionsIEClass = PafPicklistsController.getFieldValues('iE_pivCLASS_Modules_Software__c');
        selectOptionsRC = PafPicklistsController.getFieldValues('RC__c');
        selectOptionsIJ = PafPicklistsController.getFieldValues('iJ_pivCLASS_Modules_Software__c');
        selectOptionsIF = PafPicklistsController.getFieldValues('iF_pivCLASS_Kits__c');
        selectOptionsRD = PafPicklistsController.getFieldValues('RD__c');
        selectOptionsIG = PafPicklistsController.getFieldValues('iG_pivCLASS_Readers__c');
        selectOptionsRE = PafPicklistsController.getFieldValues('RE__c');
        selectOptionsIH = PafPicklistsController.getFieldValues('iH_pivCLASS_Bundles__c');
        selectOptionsIK = PafPicklistsController.getFieldValues('iK_pivCLASS_Mobile_Handheld_Readers__c');
        selectOptionsPC = PafPicklistsController.getFieldValues('PC__c');
        selectOptionsEZ = PafPicklistsController.getFieldValues('EZ_EasyLobby__c');
        selectOptionsAC = PafPicklistsController.getFieldValues('AC__c');
        selectOptionsOL = PafPicklistsController.getFieldValues('OL__c');
        selectOptionsLC = PafPicklistsController.getFieldValues('LC__c');
        selectOptionsLR = PafPicklistsController.getFieldValues('LR__c');
        selectOptionsEBEMBD = PafPicklistsController.getFieldValues('EB_Embeddable_Credentials__c');
        selectOptionsIOD = PafPicklistsController.getFieldValues('IoD__c');
        selectOptionsVX = PafPicklistsController.getFieldValues('VX__c');
        selectOptionsVC = PafPicklistsController.getFieldValues('VC__c');
        selectOptionsVI = PafPicklistsController.getFieldValues('VI__c');
        selectOptionsVEC = PafPicklistsController.getFieldValues('VE__c');
        selectOptionsVD = PafPicklistsController.getFieldValues('VD__c');
        selectOptionsEC = PafPicklistsController.getFieldValues('EC__c');
        selectOptionsEJ = PafPicklistsController.getFieldValues('EJ_SIO_Processor__c');
        selectOptionsIOC = PafPicklistsController.getFieldValues('iO__c');
        selectOptionsEDVeri = PafPicklistsController.getFieldValues('ED_veriCLASS_Readers__c');
        selectOptionsEP = PafPicklistsController.getFieldValues('EP__c');
        selectOptionsEE = PafPicklistsController.getFieldValues('EE_OMNIKEY_Reader_Board__c');
        selectOptionsLOC = PafPicklistsController.getFieldValues('LO__c');
        selectOptionsEFO = PafPicklistsController.getFieldValues('EF_OMNIKEY_Chipsets__c');
        selectOptionsELEM = PafPicklistsController.getFieldValues('EL_Embedded_Accessories__c');
        selectOptionsEGSMART = PafPicklistsController.getFieldValues('EG_SmartID_Reader_Boards__c');
        selectOptionsEK = PafPicklistsController.getFieldValues('EK_iCLASS_SE_Reader_Modules__c');
        selectOptionsEHCLASS = PafPicklistsController.getFieldValues('EH_identiCLASS_Readers__c');
        selectOptionsEAISO = PafPicklistsController.getFieldValues('EA_ISO_Reader_Boards__c');
        selectOptionsEI = PafPicklistsController.getFieldValues('EI_Developer_Services_Plus__c');
        selectOptionsFAPROP = PafPicklistsController.getFieldValues('FA_Prof_Printers__c');
        selectOptionsFM = PafPicklistsController.getFieldValues('FM_SDK_S_W_Support__c');
        selectOptionsFB = PafPicklistsController.getFieldValues('FB_Entry_Level_Printers__c');
        selectOptionsFN = PafPicklistsController.getFieldValues('FN_Extended_Warranties__c');
        selectOptionsFX = PafPicklistsController.getFieldValues('FX_Standard_Series_C50_Printers__c');
        selectOptionsFY = PafPicklistsController.getFieldValues('FY_Standard_C50_Regional_Ribbons_Only__c');
        selectOptionsFZ = PafPicklistsController.getFieldValues('FZ_Standard_Series_DTC1250e_Printers__c');
        selectOptionsFC = PafPicklistsController.getFieldValues('FC_Print_Heads__c');
        selectOptionsFO = PafPicklistsController.getFieldValues('FO_Cameras_Camera_S_W__c');
        selectOptionsFDR = PafPicklistsController.getFieldValues('FD_Ribbons_Clear_Film__c');
        selectOptionsFPID = PafPicklistsController.getFieldValues('FP_Photo_ID_Accessories__c'); 
        selectOptionsFEENTRY = PafPicklistsController.getFieldValues('FE_Entry_Level_Ribbons__c');
        selectOptionsFQ= PafPicklistsController.getFieldValues('FQ_Spare_Parts_Packages__c');
        selectOptionsFF = PafPicklistsController.getFieldValues('FF_Holo_Film_Overlams__c');
        selectOptionsFR = PafPicklistsController.getFieldValues('FR_Spare_Parts_Kits__c');
        selectOptionsFGVERI = PafPicklistsController.getFieldValues('FG_Veri_Holo_OVD_Cards__c');
        selectOptionsFS = PafPicklistsController.getFieldValues('FS_Rewriteable_Cards__c');
        selectOptionsFHULTRA = PafPicklistsController.getFieldValues('FH_UltraCards__c');
        selectOptionsFT = PafPicklistsController.getFieldValues('FT_HDP8500_Printers__c');
        selectOptionsFKHD = PafPicklistsController.getFieldValues('FK_HDPii_Printers__c');
        selectOptionsFU = PafPicklistsController.getFieldValues('FU_Industrial_Series_Ribbons_HDP_Film__c');
        selectOptionsFL = PafPicklistsController.getFieldValues('FL_Asure_ID_Software__c');
        selectOptionsFV = PafPicklistsController.getFieldValues('FV_Laser_Engravers__c');
        selectOptionsFMFIN = PafPicklistsController.getFieldValues('FW_Financial_Series_Ribbons_HDP_Film__c');
        selectOptionsPS = PafPicklistsController.getFieldValues('PS_Professional_Services__c');
        selectOptionsAA = PafPicklistsController.getFieldValues('AA__c');
        selectOptionsAD = PafPicklistsController.getFieldValues('AD__c');
        selectOptionsAG = PafPicklistsController.getFieldValues('AG__c');
        selectOptionsAI = PafPicklistsController.getFieldValues('AI__c');
        selectOptionsAJ = PafPicklistsController.getFieldValues('AJ__c');
        
        selectOptionsAF = PafPicklistsController.getFieldValues('AF__c');
        selectOptionsAB = PafPicklistsController.getFieldValues('AB__c');
        selectOptionsAL = PafPicklistsController.getFieldValues('AL__c');
        selectOptionsAH = PafPicklistsController.getFieldValues('AH__c');
        selectOptionsAZ = PafPicklistsController.getFieldValues('AZ__c');
        selectOptionsAE = PafPicklistsController.getFieldValues('AE__c');
        selectOptionsIM = PafPicklistsController.getFieldValues('iM_HID_Mobile_Access__c');
        selectOptionsCP = PafPicklistsController.getFieldValues('CP_Custom_Special_Products_w_o_Discount__c');
        
        //ADDED @ Hitesh Patel - Jade Global 2015/07/13
        selectOptionsAK = PafPicklistsController.getFieldValues('AK__c');
        selectOptionsAM = PafPicklistsController.getFieldValues('AM__c');
        selectOptionsAN = PafPicklistsController.getFieldValues('AN__c');
        
    }
    
    public void getAccountProfileDetails(){
        acProfile = new List<Account_Profile__c>(); 
        if(priceAuthorization.account__c != null){
            acProfile = [SELECT Business_Segment__c, Partner_Type__c, Tier__c, Sales_Manager__c FROM Account_Profile__c WHERE account__c = :priceAuthorization.account__c];
            string accountId = priceAuthorization.account__c;            
            string queryString = query;
            queryString = queryString +'accountId';
            account =  dataBase.query(queryString);
            PartnerProgramStatusList = [SELECT Partner_Program_Status__c, Partner_Program_Status_Modifier__c FROM  Partner_Program__c WHERE RecordTypeId =: idAdvantagePartnerRecordType AND Account__c =: priceAuthorization.Account__c]; 
            if(PartnerProgramStatusList.size() > 0 ){
                PartnerProgramStatus = PartnerProgramStatusList[0].Partner_Program_Status__c;
                PartnerProgramStatusModifier = PartnerProgramStatusList[0].Partner_Program_Status_Modifier__c;
            }else{
                PartnerProgramStatus = '';
                PartnerProgramStatusModifier = '';
            }
            relatedAccount=[select id,BillingCountry from account where id=:priceAuthorization.Account__c];
            accCountry=relatedAccount.BillingCountry;
            System.debug('@@@@@@'+relatedAccount);
            PafPicklistsController = new PafPicklistsController(accCountry,  priceAuthorization.Recordtype.Developername);
            resetPriceCodeValues();
        }   
    }
    
    public PageReference savePriceAuthorization(){
        try{
            string strAllPriceCodes = '';
            PafPicklistsController objPafPicklistsController = new PafPicklistsController(accCountry, priceAuthorization.Recordtype.Developername);   
  
            if(priceAuthorization.iR__c != null && priceAuthorization.iR__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iR__c) + ',';
            }
            if(priceAuthorization.MS__c != null && priceAuthorization.MS__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.MS__c) + ',';
            }
            if(priceAuthorization.iC__c != null && priceAuthorization.iC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iC__c) + ',';
            }
            if(priceAuthorization.iD__c != null && priceAuthorization.iD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iD__c) + ',';
            }
            if(priceAuthorization.VS__c != null && priceAuthorization.VS__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VS__c) + ',';
            }
            if(priceAuthorization.iP__c != null && priceAuthorization.iP__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iP__c) + ',';
            }
            if(priceAuthorization.LV__c != null && priceAuthorization.LV__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.LV__c) + ',';
            }
            if(priceAuthorization.MC__c != null && priceAuthorization.MC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.MC__c) + ',';
            }
            if(priceAuthorization.LW_Indala_Credentials__c != null && priceAuthorization.LW_Indala_Credentials__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.LW_Indala_Credentials__c) + ',';
            }
            if(priceAuthorization.MD__c != null && priceAuthorization.MD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.MD__c) + ',';
            }
            if(priceAuthorization.ME__c!= null && priceAuthorization.ME__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.ME__c) + ',';
            }
            if(priceAuthorization.MF__c != null && priceAuthorization.MF__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.MF__c) + ',';
            }
            if(priceAuthorization.iE_pivCLASS_Modules_Software__c != null && priceAuthorization.iE_pivCLASS_Modules_Software__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iE_pivCLASS_Modules_Software__c) + ',';
            }
            if(priceAuthorization.RA__c != null && priceAuthorization.RA__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.RA__c) + ',';
            }
            if(priceAuthorization.iJ_pivCLASS_Modules_Software__c != null && priceAuthorization.iJ_pivCLASS_Modules_Software__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iJ_pivCLASS_Modules_Software__c) + ',';
            }
            if(priceAuthorization.RB__c != null && priceAuthorization.RB__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.RB__c) + ',';
            }
            if(priceAuthorization.iF_pivCLASS_Kits__c!= null && priceAuthorization.iF_pivCLASS_Kits__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iF_pivCLASS_Kits__c) + ',';
            }
            if(priceAuthorization.RC__c != null && priceAuthorization.RC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.RC__c) + ',';
            }
            if(priceAuthorization.iH_pivCLASS_Bundles__c != null && priceAuthorization.iH_pivCLASS_Bundles__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iH_pivCLASS_Bundles__c) + ',';
            }
            if(priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c != null && priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c) + ',';
            }
            if(priceAuthorization.RD__c != null && priceAuthorization.RD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.RD__c) + ',';
            }
            if(priceAuthorization.EZ_EasyLobby__c != null && priceAuthorization.EZ_EasyLobby__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EZ_EasyLobby__c) + ',';
            }
            if(priceAuthorization.RE__c != null && priceAuthorization.RE__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.RE__c) + ',';
            }
            if(priceAuthorization.AC__c != null && priceAuthorization.AC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AC__c) + ',';
            }
            if(priceAuthorization.PC__c != null && priceAuthorization.PC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.PC__c) + ',';
            }
            if(priceAuthorization.OL__c != null && priceAuthorization.OL__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.OL__c) + ',';
            }
            if(priceAuthorization.LC__c != null && priceAuthorization.LC__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.LC__c) + ',';
            }
            if(priceAuthorization.LR__c != null && priceAuthorization.LR__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.LR__c) + ',';
            }
            if(priceAuthorization.EB_Embeddable_Credentials__c != null && priceAuthorization.EB_Embeddable_Credentials__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EB_Embeddable_Credentials__c) + ',';
            }
            if(priceAuthorization.IoD__c != null && priceAuthorization.IoD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.IoD__c) + ',';
            }
            if(priceAuthorization.VX__c != null && priceAuthorization.VX__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VX__c) + ',';
            }
            if(priceAuthorization.VC__c != null && priceAuthorization.VC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VC__c) + ',';
            }
            if(priceAuthorization.VI__c != null && priceAuthorization.VI__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VI__c) + ',';
            }
            if(priceAuthorization.VE__c != null && priceAuthorization.VE__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VE__c) + ',';
            }
            if(priceAuthorization.VD__c != null && priceAuthorization.VD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VD__c) + ',';
            }
            if(priceAuthorization.EC__c != null && priceAuthorization.EC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EC__c) + ',';
            }
            if(priceAuthorization.EJ_SIO_Processor__c != null && priceAuthorization.EJ_SIO_Processor__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EJ_SIO_Processor__c) + ',';
            }
            if(priceAuthorization.iO__c != null && priceAuthorization.iO__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iO__c) + ',';
            }
            if(priceAuthorization.ED_veriCLASS_Readers__c != null && priceAuthorization.ED_veriCLASS_Readers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.ED_veriCLASS_Readers__c) + ',';
            }
            if(priceAuthorization.EP__c != null && priceAuthorization.EP__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EP__c) + ',';
            }
            if(priceAuthorization.EE_OMNIKEY_Reader_Board__c != null && priceAuthorization.EE_OMNIKEY_Reader_Board__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EE_OMNIKEY_Reader_Board__c) + ',';
            }
            if(priceAuthorization.LO__c != null && priceAuthorization.LO__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.LO__c) + ',';
            }
            if(priceAuthorization.EI_Developer_Services_Plus__c != null && priceAuthorization.EI_Developer_Services_Plus__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EI_Developer_Services_Plus__c) + ',';
            }
            if(priceAuthorization.EF_OMNIKEY_Chipsets__c != null && priceAuthorization.EF_OMNIKEY_Chipsets__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EF_OMNIKEY_Chipsets__c) + ',';
            }
            if(priceAuthorization.EL_Embedded_Accessories__c != null && priceAuthorization.EL_Embedded_Accessories__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EL_Embedded_Accessories__c) + ',';
            }
            if(priceAuthorization.EG_SmartID_Reader_Boards__c != null && priceAuthorization.EG_SmartID_Reader_Boards__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EG_SmartID_Reader_Boards__c) + ',';
            }
            if(priceAuthorization.EK_iCLASS_SE_Reader_Modules__c != null && priceAuthorization.EK_iCLASS_SE_Reader_Modules__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EK_iCLASS_SE_Reader_Modules__c) + ',';
            }
            if(priceAuthorization.EH_identiCLASS_Readers__c != null && priceAuthorization.EH_identiCLASS_Readers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EH_identiCLASS_Readers__c) + ',';
            }
            if(priceAuthorization.EA_ISO_Reader_Boards__c != null && priceAuthorization.EA_ISO_Reader_Boards__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EA_ISO_Reader_Boards__c) + ',';
            }
            if(priceAuthorization.FL_Asure_ID_Software__c != null && priceAuthorization.FL_Asure_ID_Software__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FL_Asure_ID_Software__c) + ',';
            }
            if(priceAuthorization.FM_SDK_S_W_Support__c != null && priceAuthorization.FM_SDK_S_W_Support__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FM_SDK_S_W_Support__c) + ',';
            }
            if(priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c != null && priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c) + ',';
            }
            if(priceAuthorization.FN_Extended_Warranties__c != null && priceAuthorization.FN_Extended_Warranties__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FN_Extended_Warranties__c) + ',';
            }
            if(priceAuthorization.FX_Standard_Series_C50_Printers__c != null && priceAuthorization.FX_Standard_Series_C50_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FX_Standard_Series_C50_Printers__c) + ',';
            }
            if(priceAuthorization.FO_Cameras_Camera_S_W__c != null && priceAuthorization.FO_Cameras_Camera_S_W__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FO_Cameras_Camera_S_W__c) + ',';
            }
            if(priceAuthorization.FC_Print_Heads__c != null && priceAuthorization.FC_Print_Heads__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FC_Print_Heads__c) + ',';
            }
            if(priceAuthorization.FP_Photo_ID_Accessories__c != null && priceAuthorization.FP_Photo_ID_Accessories__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FP_Photo_ID_Accessories__c) + ',';
            }
            if(priceAuthorization.FQ_Spare_Parts_Packages__c != null && priceAuthorization.FQ_Spare_Parts_Packages__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FQ_Spare_Parts_Packages__c) + ',';
            }
            if(priceAuthorization.FR_Spare_Parts_Kits__c != null && priceAuthorization.FR_Spare_Parts_Kits__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FR_Spare_Parts_Kits__c) + ',';
            }
            if(priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c != null && priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c) + ',';
            }
            if(priceAuthorization.FS_Rewriteable_Cards__c != null && priceAuthorization.FS_Rewriteable_Cards__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FS_Rewriteable_Cards__c) + ',';
            }
            if(priceAuthorization.FF_Holo_Film_Overlams__c != null && priceAuthorization.FF_Holo_Film_Overlams__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FF_Holo_Film_Overlams__c) + ',';
            }
            if(priceAuthorization.FT_HDP8500_Printers__c != null && priceAuthorization.FT_HDP8500_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FT_HDP8500_Printers__c) + ',';
            }
            if(priceAuthorization.FG_Veri_Holo_OVD_Cards__c != null && priceAuthorization.FG_Veri_Holo_OVD_Cards__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FG_Veri_Holo_OVD_Cards__c) + ',';
            }
            if(priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c != null && priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c) + ',';
            }
            if(priceAuthorization.FH_UltraCards__c != null && priceAuthorization.FH_UltraCards__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FH_UltraCards__c) + ',';
            }
            if(priceAuthorization.FV_Laser_Engravers__c != null && priceAuthorization.FV_Laser_Engravers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FV_Laser_Engravers__c) + ',';
            }
            if(priceAuthorization.FK_HDPii_Printers__c != null && priceAuthorization.FK_HDPii_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FK_HDPii_Printers__c) + ',';
            }
            if(priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c != null && priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c) + ',';
            }
            if(priceAuthorization.FA_Prof_Printers__c != null && priceAuthorization.FA_Prof_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FA_Prof_Printers__c) + ',';
            }
            if(priceAuthorization.FB_Entry_Level_Printers__c != null && priceAuthorization.FB_Entry_Level_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FB_Entry_Level_Printers__c) + ',';
            }
            if(priceAuthorization.FD_Ribbons_Clear_Film__c != null && priceAuthorization.FD_Ribbons_Clear_Film__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FD_Ribbons_Clear_Film__c) + ',';
            }
            if(priceAuthorization.FE_Entry_Level_Ribbons__c != null && priceAuthorization.FE_Entry_Level_Ribbons__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FE_Entry_Level_Ribbons__c) + ',';
            }
            if(priceAuthorization.PS_Professional_Services__c != null && priceAuthorization.PS_Professional_Services__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.PS_Professional_Services__c) + ',';
            }
            if(priceAuthorization.AA__c != null && priceAuthorization.AA__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AA__c) + ',';
            }
            if(priceAuthorization.AF__c != null && priceAuthorization.AF__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AF__c) + ',';
            }
            if(priceAuthorization.AB__c != null && priceAuthorization.AB__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AB__c) + ',';
            }
            if(priceAuthorization.AL__c != null && priceAuthorization.AL__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AL__c) + ',';
            }
            if(priceAuthorization.AH__c != null && priceAuthorization.AH__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AH__c) + ',';
            }
            if(priceAuthorization.AZ__c != null && priceAuthorization.AZ__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AZ__c) + ',';
            }
            if(priceAuthorization.AE__c != null && priceAuthorization.AE__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AE__c) + ',';
            }
            if(priceAuthorization.iM_HID_Mobile_Access__c != null && priceAuthorization.iM_HID_Mobile_Access__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iM_HID_Mobile_Access__c) + ',';
            }
            if(priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c != null && priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c) + ',';
            }
            if(priceAuthorization.AD__c != null && priceAuthorization.AD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AD__c) + ',';
            }
            if(priceAuthorization.AG__c != null && priceAuthorization.AG__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AG__c) + ',';
            }
            if(priceAuthorization.AI__c != null && priceAuthorization.AI__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AI__c) + ',';
            }
            if(priceAuthorization.AJ__c != null && priceAuthorization.AJ__c  != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AJ__c) + ',';
            }       
            
            
            //ADDED @ Hitesh Patel - Jade Global 2015/07/13
            if(priceAuthorization.AK__c != null && priceAuthorization.AK__c != ''){
                strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AK__c) + ',';
            }
            if(priceAuthorization.AM__c != null && priceAuthorization.AM__c != ''){
                strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AM__c) + ',';
            }
            if(priceAuthorization.AN__c != null && priceAuthorization.AN__c  != ''){
                strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AN__c) + ',';
            } 
            
            priceAuthorization.Integration_Price_Codes__c = strAllPriceCodes;
            insert priceAuthorization;
            return New PageReference('/'+priceAuthorization.ID);
        }catch(exception e){
            ApexPages.AddMessages(e);
            return null;
        }        
    }
    public PageReference saveAndNewPriceAuthorization(){
        try{
            string strAllPriceCodes = '';
            PafPicklistsController objPafPicklistsController = new PafPicklistsController(accCountry, priceAuthorization.Recordtype.Developername);   
            if(priceAuthorization.iR__c != null && priceAuthorization.iR__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iR__c) + ',';
            }
            if(priceAuthorization.MS__c != null && priceAuthorization.MS__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.MS__c) + ',';
            }
            if(priceAuthorization.iC__c != null && priceAuthorization.iC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iC__c) + ',';
            }
            if(priceAuthorization.iD__c != null && priceAuthorization.iD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iD__c) + ',';
            }
            if(priceAuthorization.VS__c != null && priceAuthorization.VS__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VS__c) + ',';
            }
            if(priceAuthorization.iP__c != null && priceAuthorization.iP__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iP__c) + ',';
            }
            if(priceAuthorization.LV__c != null && priceAuthorization.LV__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.LV__c) + ',';
            }
            if(priceAuthorization.MC__c != null && priceAuthorization.MC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.MC__c) + ',';
            }
            if(priceAuthorization.LW_Indala_Credentials__c != null && priceAuthorization.LW_Indala_Credentials__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.LW_Indala_Credentials__c) + ',';
            }
            if(priceAuthorization.MD__c != null && priceAuthorization.MD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.MD__c) + ',';
            }
            if(priceAuthorization.ME__c!= null && priceAuthorization.ME__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.ME__c) + ',';
            }
            if(priceAuthorization.MF__c != null && priceAuthorization.MF__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.MF__c) + ',';
            }
            if(priceAuthorization.iE_pivCLASS_Modules_Software__c != null && priceAuthorization.iE_pivCLASS_Modules_Software__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iE_pivCLASS_Modules_Software__c) + ',';
            }
            if(priceAuthorization.RA__c != null && priceAuthorization.RA__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.RA__c) + ',';
            }
            if(priceAuthorization.iJ_pivCLASS_Modules_Software__c != null && priceAuthorization.iJ_pivCLASS_Modules_Software__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iJ_pivCLASS_Modules_Software__c) + ',';
            }
            if(priceAuthorization.RB__c != null && priceAuthorization.RB__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.RB__c) + ',';
            }
            if(priceAuthorization.iF_pivCLASS_Kits__c!= null && priceAuthorization.iF_pivCLASS_Kits__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iF_pivCLASS_Kits__c) + ',';
            }
            if(priceAuthorization.RC__c != null && priceAuthorization.RC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.RC__c) + ',';
            }
            if(priceAuthorization.iH_pivCLASS_Bundles__c != null && priceAuthorization.iH_pivCLASS_Bundles__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iH_pivCLASS_Bundles__c) + ',';
            }
            if(priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c != null && priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c) + ',';
            }
            if(priceAuthorization.RD__c != null && priceAuthorization.RD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.RD__c) + ',';
            }
            if(priceAuthorization.EZ_EasyLobby__c != null && priceAuthorization.EZ_EasyLobby__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EZ_EasyLobby__c) + ',';
            }
            if(priceAuthorization.RE__c != null && priceAuthorization.RE__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.RE__c) + ',';
            }
            if(priceAuthorization.AC__c != null && priceAuthorization.AC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AC__c) + ',';
            }
            if(priceAuthorization.PC__c != null && priceAuthorization.PC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.PC__c) + ',';
            }
            if(priceAuthorization.OL__c != null && priceAuthorization.OL__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.OL__c) + ',';
            }
            if(priceAuthorization.LC__c != null && priceAuthorization.LC__c!= ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.LC__c) + ',';
            }
            if(priceAuthorization.LR__c != null && priceAuthorization.LR__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.LR__c) + ',';
            }
            if(priceAuthorization.EB_Embeddable_Credentials__c != null && priceAuthorization.EB_Embeddable_Credentials__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EB_Embeddable_Credentials__c) + ',';
            }
            if(priceAuthorization.IoD__c != null && priceAuthorization.IoD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.IoD__c) + ',';
            }
            if(priceAuthorization.VX__c != null && priceAuthorization.VX__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VX__c) + ',';
            }
            if(priceAuthorization.VC__c != null && priceAuthorization.VC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VC__c) + ',';
            }
            if(priceAuthorization.VI__c != null && priceAuthorization.VI__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VI__c) + ',';
            }
            if(priceAuthorization.VE__c != null && priceAuthorization.VE__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VE__c) + ',';
            }
            if(priceAuthorization.VD__c != null && priceAuthorization.VD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.VD__c) + ',';
            }
            if(priceAuthorization.EC__c != null && priceAuthorization.EC__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EC__c) + ',';
            }
            if(priceAuthorization.EJ_SIO_Processor__c != null && priceAuthorization.EJ_SIO_Processor__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EJ_SIO_Processor__c) + ',';
            }
            if(priceAuthorization.iO__c != null && priceAuthorization.iO__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iO__c) + ',';
            }
            if(priceAuthorization.ED_veriCLASS_Readers__c != null && priceAuthorization.ED_veriCLASS_Readers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.ED_veriCLASS_Readers__c) + ',';
            }
            if(priceAuthorization.EP__c != null && priceAuthorization.EP__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EP__c) + ',';
            }
            if(priceAuthorization.EE_OMNIKEY_Reader_Board__c != null && priceAuthorization.EE_OMNIKEY_Reader_Board__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EE_OMNIKEY_Reader_Board__c) + ',';
            }
            if(priceAuthorization.LO__c != null && priceAuthorization.LO__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.LO__c) + ',';
            }
            if(priceAuthorization.EI_Developer_Services_Plus__c != null && priceAuthorization.EI_Developer_Services_Plus__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EI_Developer_Services_Plus__c) + ',';
            }
            if(priceAuthorization.EF_OMNIKEY_Chipsets__c != null && priceAuthorization.EF_OMNIKEY_Chipsets__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EF_OMNIKEY_Chipsets__c) + ',';
            }
            if(priceAuthorization.EL_Embedded_Accessories__c != null && priceAuthorization.EL_Embedded_Accessories__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EL_Embedded_Accessories__c) + ',';
            }
            if(priceAuthorization.EG_SmartID_Reader_Boards__c != null && priceAuthorization.EG_SmartID_Reader_Boards__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EG_SmartID_Reader_Boards__c) + ',';
            }
            if(priceAuthorization.EK_iCLASS_SE_Reader_Modules__c != null && priceAuthorization.EK_iCLASS_SE_Reader_Modules__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EK_iCLASS_SE_Reader_Modules__c) + ',';
            }
            if(priceAuthorization.EH_identiCLASS_Readers__c != null && priceAuthorization.EH_identiCLASS_Readers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EH_identiCLASS_Readers__c) + ',';
            }
            if(priceAuthorization.EA_ISO_Reader_Boards__c != null && priceAuthorization.EA_ISO_Reader_Boards__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.EA_ISO_Reader_Boards__c) + ',';
            }
            if(priceAuthorization.FL_Asure_ID_Software__c != null && priceAuthorization.FL_Asure_ID_Software__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FL_Asure_ID_Software__c) + ',';
            }
            if(priceAuthorization.FM_SDK_S_W_Support__c != null && priceAuthorization.FM_SDK_S_W_Support__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FM_SDK_S_W_Support__c) + ',';
            }
            if(priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c != null && priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c) + ',';
            }
            if(priceAuthorization.FN_Extended_Warranties__c != null && priceAuthorization.FN_Extended_Warranties__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FN_Extended_Warranties__c) + ',';
            }
            if(priceAuthorization.FX_Standard_Series_C50_Printers__c != null && priceAuthorization.FX_Standard_Series_C50_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FX_Standard_Series_C50_Printers__c) + ',';
            }
            if(priceAuthorization.FO_Cameras_Camera_S_W__c != null && priceAuthorization.FO_Cameras_Camera_S_W__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FO_Cameras_Camera_S_W__c) + ',';
            }
            if(priceAuthorization.FC_Print_Heads__c != null && priceAuthorization.FC_Print_Heads__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FC_Print_Heads__c) + ',';
            }
            if(priceAuthorization.FP_Photo_ID_Accessories__c != null && priceAuthorization.FP_Photo_ID_Accessories__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FP_Photo_ID_Accessories__c) + ',';
            }
            if(priceAuthorization.FQ_Spare_Parts_Packages__c != null && priceAuthorization.FQ_Spare_Parts_Packages__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FQ_Spare_Parts_Packages__c) + ',';
            }
            if(priceAuthorization.FR_Spare_Parts_Kits__c != null && priceAuthorization.FR_Spare_Parts_Kits__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FR_Spare_Parts_Kits__c) + ',';
            }
            if(priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c != null && priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c) + ',';
            }
            if(priceAuthorization.FS_Rewriteable_Cards__c != null && priceAuthorization.FS_Rewriteable_Cards__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FS_Rewriteable_Cards__c) + ',';
            }
            if(priceAuthorization.FF_Holo_Film_Overlams__c != null && priceAuthorization.FF_Holo_Film_Overlams__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FF_Holo_Film_Overlams__c) + ',';
            }
            if(priceAuthorization.FT_HDP8500_Printers__c != null && priceAuthorization.FT_HDP8500_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FT_HDP8500_Printers__c) + ',';
            }
            if(priceAuthorization.FG_Veri_Holo_OVD_Cards__c != null && priceAuthorization.FG_Veri_Holo_OVD_Cards__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FG_Veri_Holo_OVD_Cards__c) + ',';
            }
            if(priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c != null && priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c) + ',';
            }
            if(priceAuthorization.FH_UltraCards__c != null && priceAuthorization.FH_UltraCards__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FH_UltraCards__c) + ',';
            }
            if(priceAuthorization.FV_Laser_Engravers__c != null && priceAuthorization.FV_Laser_Engravers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FV_Laser_Engravers__c) + ',';
            }
            if(priceAuthorization.FK_HDPii_Printers__c != null && priceAuthorization.FK_HDPii_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FK_HDPii_Printers__c) + ',';
            }
            if(priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c != null && priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c) + ',';
            }
            if(priceAuthorization.FA_Prof_Printers__c != null && priceAuthorization.FA_Prof_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FA_Prof_Printers__c) + ',';
            }
            if(priceAuthorization.FB_Entry_Level_Printers__c != null && priceAuthorization.FB_Entry_Level_Printers__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FB_Entry_Level_Printers__c) + ',';
            }
            if(priceAuthorization.FD_Ribbons_Clear_Film__c != null && priceAuthorization.FD_Ribbons_Clear_Film__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FD_Ribbons_Clear_Film__c) + ',';
            }
            if(priceAuthorization.FE_Entry_Level_Ribbons__c != null && priceAuthorization.FE_Entry_Level_Ribbons__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.FE_Entry_Level_Ribbons__c) + ',';
            }
            if(priceAuthorization.PS_Professional_Services__c != null && priceAuthorization.PS_Professional_Services__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.PS_Professional_Services__c) + ',';
            }
            if(priceAuthorization.AA__c != null && priceAuthorization.AA__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AA__c) + ',';
            }
            if(priceAuthorization.AF__c != null && priceAuthorization.AF__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AF__c) + ',';
            }
            if(priceAuthorization.AB__c != null && priceAuthorization.AB__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AB__c) + ',';
            }
            if(priceAuthorization.AL__c != null && priceAuthorization.AL__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AL__c) + ',';
            }
            if(priceAuthorization.AH__c != null && priceAuthorization.AH__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AH__c) + ',';
            }
            if(priceAuthorization.AZ__c != null && priceAuthorization.AZ__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AZ__c) + ',';
            }
            if(priceAuthorization.AE__c != null && priceAuthorization.AE__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AE__c) + ',';
            }
            if(priceAuthorization.iM_HID_Mobile_Access__c != null && priceAuthorization.iM_HID_Mobile_Access__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.iM_HID_Mobile_Access__c) + ',';
            }
            if(priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c != null && priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c) + ',';
            }
            if(priceAuthorization.AD__c != null && priceAuthorization.AD__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AD__c) + ',';
            }
            if(priceAuthorization.AG__c != null && priceAuthorization.AG__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AG__c) + ',';
            }
            if(priceAuthorization.AI__c != null && priceAuthorization.AI__c != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AI__c) + ',';
            }
            if(priceAuthorization.AJ__c != null && priceAuthorization.AJ__c  != ''){
              strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AJ__c) + ',';
            }            
            
            //ADDED @ Hitesh Patel - Jade Global 2015/07/13
            if(priceAuthorization.AK__c != null && priceAuthorization.AK__c != ''){
                strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AK__c) + ',';
            }
            if(priceAuthorization.AM__c != null && priceAuthorization.AM__c != ''){
                strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AM__c) + ',';
            }
            if(priceAuthorization.AN__c != null && priceAuthorization.AN__c  != ''){
                strAllPriceCodes += objPafPicklistsController.getPAFPriceCodeSubmitValue(priceAuthorization.AN__c) + ',';
            } 
            
            priceAuthorization.Integration_Price_Codes__c = strAllPriceCodes;
            insert priceAuthorization;
            string s = '/' + ('' + priceAuthorization.get('Id')).subString(0, 3) + '/e?';
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.Info, s));
            return new Pagereference(s);
        }catch(exception e){
            ApexPages.AddMessages(e);
            return null;
        }       
    }
    public PageReference cancelPriceAuthorization(){
        PageReference pg=New PageReference('/'+parentPafId);
        return pg;
    }
    
    public String getQueryString(String objectName){
        Map<String, Schema.SObjectType> objMap = new Map<String, Schema.SObjectType>();
        objMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = objMap.get(objectName).getDescribe().fields.getMap();
        string queryString = 'select Account__r.BillingCountry,';
        for(Schema.SObjectField field :fieldMap.values()){
            Schema.DescribeFieldResult fd = field.getDescribe();
            if(fd.isCreateable()){
                queryString = queryString + field.getDescribe().getName() + ', ';
            }            
        }
        queryString = queryString.substring(0,queryString.length() - 2);
        queryString = queryString + ' from ' + objectName;
        return queryString;
    } 
}