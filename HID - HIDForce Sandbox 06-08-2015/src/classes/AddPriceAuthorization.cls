/****************************************************************************
* Type               : Apex Class
* Name               : AddPriceAuthorization
* Modified by        : Hitesh Patel
* Modified Date      : 5th June 2015
* Last Modified By   : Hitesh Patel 5th June 2015
* Purpose            : This is Extension class for "PriceAuthorizationForm" visualforce page
                       This class will handle oprations on PAF detail page.                
****************************************************************************/
public class AddPriceAuthorization {
    public Price_Authorization_Form__c priceAuthorization{get; set;}
    public ApexPages.StandardController controller;
    public Account account {get;set;}
    public string query {get;set;}
    public List<Account_Profile__c>acProfile  {get;set;}
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
    
    //ADDED @ Hitesh Patel - Jade Global 2015/07/13
    public string tierValueAK {get;set;}
    public string tierValueAM {get;set;}
    //public string tierValueAL {get;set;}
    public string tierValueAN {get;set;}
    
        
    //ADDED @ Hitesh Patel - Jade Global 2014/12/18
    public string tierValueAD {get;set;}
    public string tierValueAG {get;set;}
    public string tierValueAI {get;set;}
    public string tierValueAJ {get;set;}
    public string accCountry;
    Account relatedAccount;
    PafPicklistsController PafPicklistsController;
    
    public AddPriceAuthorization(ApexPages.StandardController controller) {
        priceAuthorization = (Price_Authorization_Form__c)Controller.getRecord();
       
        
        this.controller=Controller;
        accCountry=priceAuthorization.Account__r.BillingCountry;        
        PartnerProgramStatusList = [SELECT Partner_Program_Status__c, Partner_Program_Status_Modifier__c  FROM  Partner_Program__c WHERE RecordTypeId =: idAdvantagePartnerRecordType AND Account__c =: priceAuthorization.Account__c];
  
        if(PartnerProgramStatusList.size() > 0 && priceAuthorization.Account__c != null){
            PartnerProgramStatus = PartnerProgramStatusList[0].Partner_Program_Status__c;
            PartnerProgramStatusModifier = PartnerProgramStatusList[0].Partner_Program_Status_Modifier__c;
        }else{
            PartnerProgramStatus = '';
            PartnerProgramStatusModifier = '';
        }        
        getQueryforAccount qry = new  getQueryforAccount();            
        query = qry.getQuery();
        account = new Account(); 
        getAccountProfileDetails();
        PafPicklistsController = new PafPicklistsController(accCountry, 'Standard_PAF');
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
        
        // ADDED @ Hitesh Patel - Jade Global 2015/07/13
        tierValueAK = tdc.getTierDiscountDetails('AK__c');
        tierValueAM = tdc.getTierDiscountDetails('AM__c');
        tierValueAN = tdc.getTierDiscountDetails('AN__c');
        
    }
    
    public void resetPriceCodeValues(){
        selectOptionsIR = PafPicklistsController.getFieldValues('iR__c');
        for(integer i=0; i < selectOptionsIR.size(); i ++){
            if(selectOptionsIR[i].getvalue().contains('Standard Pricing')){
                selectOptionsIR.remove(i);
            }
        }
        
        selectOptionsWR = PafPicklistsController.getFieldValues('WR__c');
        for(integer i=0; i < selectOptionsWR.size(); i ++){
            if(selectOptionsWR[i].getvalue().contains('Standard Pricing')){
                selectOptionsWR.remove(i);
            }
        }
        
        selectOptionsIC = PafPicklistsController.getFieldValues('iC__c');
        for(integer i=0; i < selectOptionsIC.size(); i ++){
            if(selectOptionsIC[i].getvalue().contains('Standard Pricing')){
                selectOptionsIC.remove(i);
            }
        }
        
        selectOptionsWC = PafPicklistsController.getFieldValues('WC__c');
        for(integer i=0; i < selectOptionsWC.size(); i ++){
            if(selectOptionsWC[i].getvalue().contains('Standard Pricing')){
                selectOptionsWC.remove(i);
            }
        }
        
        selectOptionsID = PafPicklistsController.getFieldValues('iD__c');
        for(integer i=0; i < selectOptionsID.size(); i ++){
            if(selectOptionsID[i].getvalue().contains('Standard Pricing')){
                selectOptionsID.remove(i);
            }
        }
        
        selectOptionsMS = PafPicklistsController.getFieldValues('MS__c');
        for(integer i=0; i < selectOptionsMS.size(); i ++){
            if(selectOptionsMS[i].getvalue().contains('Standard Pricing')){
                selectOptionsMS.remove(i);
            }
        }
        
        selectOptionsIP = PafPicklistsController.getFieldValues('iP__c');
        for(integer i=0; i < selectOptionsIP.size(); i ++){
            if(selectOptionsIP[i].getvalue().contains('Standard Pricing')){
                selectOptionsIP.remove(i);
            }
        }
         
        //selectOptionsSL = PafPicklistsController.getFieldValues('SL__c');
        selectOptionsMC = PafPicklistsController.getFieldValues('MC__c');
        for(integer i=0; i < selectOptionsMC.size(); i ++){
            if(selectOptionsMC[i].getvalue().contains('Standard Pricing')){
                selectOptionsMC.remove(i);
            }
        }
        
        selectOptionsVS = PafPicklistsController.getFieldValues('VS__c');
        for(integer i=0; i < selectOptionsVS.size(); i ++){
            if(selectOptionsVS[i].getvalue().contains('Standard Pricing')){
                selectOptionsVS.remove(i);
            }
        }
        
        selectOptionsMD = PafPicklistsController.getFieldValues('MD__c');
        for(integer i=0; i < selectOptionsMD.size(); i ++){
            if(selectOptionsMD[i].getvalue().contains('Standard Pricing')){
                selectOptionsMD.remove(i);
            }
        }
        
        selectOptionsLV = PafPicklistsController.getFieldValues('LV__c');
        for(integer i=0; i < selectOptionsLV.size(); i ++){
            if(selectOptionsLV[i].getvalue().contains('Standard Pricing')){
                selectOptionsLV.remove(i);
            }
        }
        
        selectOptionsME = PafPicklistsController.getFieldValues('ME__c');
        for(integer i=0; i < selectOptionsME.size(); i ++){
            if(selectOptionsME[i].getvalue().contains('Standard Pricing')){
                selectOptionsME.remove(i);
            }
        }
        
        selectOptionsLW = PafPicklistsController.getFieldValues('LW_Indala_Credentials__c');
        for(integer i=0; i < selectOptionsLW.size(); i ++){
            if(selectOptionsLW[i].getvalue().contains('Standard Pricing')){
                selectOptionsLW.remove(i);
            }
        }
        
        selectOptionsMF = PafPicklistsController.getFieldValues('MF__c');
        for(integer i=0; i < selectOptionsMF.size(); i ++){
            if(selectOptionsMF[i].getvalue().contains('Standard Pricing')){
                selectOptionsMF.remove(i);
            }
        }
        
        //selectOptionsIB = PafPicklistsController.getFieldValues('IB__c');
        selectOptionsRA = PafPicklistsController.getFieldValues('RA__c');
        for(integer i=0; i < selectOptionsRA.size(); i ++){
            if(selectOptionsRA[i].getvalue().contains('Standard Pricing')){
                selectOptionsRA.remove(i);
            }
        }
        
        //selectOptionsPI = PafPicklistsController.getFieldValues('PI__c');
        selectOptionsRB = PafPicklistsController.getFieldValues('RB__c');
        for(integer i=0; i < selectOptionsRB.size(); i ++){
            if(selectOptionsRB[i].getvalue().contains('Standard Pricing')){
                selectOptionsRB.remove(i);
            }
        }
        
        selectOptionsIEClass = PafPicklistsController.getFieldValues('iE_pivCLASS_Modules_Software__c');
        for(integer i=0; i < selectOptionsIEClass.size(); i ++){
            if(selectOptionsIEClass[i].getvalue().contains('Standard Pricing')){
                selectOptionsIEClass.remove(i);
            }
        }
        
        selectOptionsRC = PafPicklistsController.getFieldValues('RC__c');
        for(integer i=0; i < selectOptionsRC.size(); i ++){
            if(selectOptionsRC[i].getvalue().contains('Standard Pricing')){
                selectOptionsRC.remove(i);
            }
        }
        
        selectOptionsIJ = PafPicklistsController.getFieldValues('iJ_pivCLASS_Modules_Software__c');
        for(integer i=0; i < selectOptionsIJ.size(); i ++){
            if(selectOptionsIJ[i].getvalue().contains('Standard Pricing')){
                selectOptionsIJ.remove(i);
            }
        }
        
        selectOptionsIF = PafPicklistsController.getFieldValues('iF_pivCLASS_Kits__c');
        for(integer i=0; i < selectOptionsIF.size(); i ++){
            if(selectOptionsIF[i].getvalue().contains('Standard Pricing')){
                selectOptionsIF.remove(i);
            }
        }
        
        selectOptionsRD = PafPicklistsController.getFieldValues('RD__c');
        for(integer i=0; i < selectOptionsRD.size(); i ++){
            if(selectOptionsRD[i].getvalue().contains('Standard Pricing')){
                selectOptionsRD.remove(i);
            }
        }
        
        selectOptionsIG = PafPicklistsController.getFieldValues('iG_pivCLASS_Readers__c');
        for(integer i=0; i < selectOptionsIG.size(); i ++){
            if(selectOptionsIG[i].getvalue().contains('Standard Pricing')){
                selectOptionsIG.remove(i);
            }
        }
        
        selectOptionsRE = PafPicklistsController.getFieldValues('RE__c');
        for(integer i=0; i < selectOptionsRE.size(); i ++){
            if(selectOptionsRE[i].getvalue().contains('Standard Pricing')){
                selectOptionsRE.remove(i);
            }
        }
        
        selectOptionsIH = PafPicklistsController.getFieldValues('iH_pivCLASS_Bundles__c');
        for(integer i=0; i < selectOptionsIH.size(); i ++){
            if(selectOptionsIH[i].getvalue().contains('Standard Pricing')){
                selectOptionsIH.remove(i);
            }
        }
        
        selectOptionsIK = PafPicklistsController.getFieldValues('iK_pivCLASS_Mobile_Handheld_Readers__c');
        for(integer i=0; i < selectOptionsIK.size(); i ++){
            if(selectOptionsIK[i].getvalue().contains('Standard Pricing')){
                selectOptionsIK.remove(i);
            }
        }
        
        selectOptionsPC = PafPicklistsController.getFieldValues('PC__c');
        for(integer i=0; i < selectOptionsPC.size(); i ++){
            if(selectOptionsPC[i].getvalue().contains('Standard Pricing')){
                selectOptionsPC.remove(i);
            }
        }
        
        selectOptionsEZ = PafPicklistsController.getFieldValues('EZ_EasyLobby__c');
        for(integer i=0; i < selectOptionsEZ.size(); i ++){
            if(selectOptionsEZ[i].getvalue().contains('Standard Pricing')){
                selectOptionsEZ.remove(i);
            }
        }
        
        selectOptionsAC = PafPicklistsController.getFieldValues('AC__c');
        for(integer i=0; i < selectOptionsAC.size(); i ++){
            if(selectOptionsAC[i].getvalue().contains('Standard Pricing')){
                selectOptionsAC.remove(i);
            }
        }
        
        selectOptionsOL = PafPicklistsController.getFieldValues('OL__c');
        for(integer i=0; i < selectOptionsOL.size(); i ++){
            if(selectOptionsOL[i].getvalue().contains('Standard Pricing')){
                selectOptionsOL.remove(i);
            }
        }
        
        selectOptionsLC = PafPicklistsController.getFieldValues('LC__c');
        for(integer i=0; i < selectOptionsLC.size(); i ++){
            if(selectOptionsLC[i].getvalue().contains('Standard Pricing')){
                selectOptionsLC.remove(i);
            }
        }
        
        selectOptionsLR = PafPicklistsController.getFieldValues('LR__c');
        for(integer i=0; i < selectOptionsLR.size(); i ++){
            if(selectOptionsLR[i].getvalue().contains('Standard Pricing')){
                selectOptionsLR.remove(i);
            }
        }
        
        selectOptionsEBEMBD = PafPicklistsController.getFieldValues('EB_Embeddable_Credentials__c');
        for(integer i=0; i < selectOptionsEBEMBD.size(); i ++){
            if(selectOptionsEBEMBD[i].getvalue().contains('Standard Pricing')){
                selectOptionsEBEMBD.remove(i);
            }
        }
        
        selectOptionsIOD = PafPicklistsController.getFieldValues('IoD__c');
        for(integer i=0; i < selectOptionsIOD.size(); i ++){
            if(selectOptionsIOD[i].getvalue().contains('Standard Pricing')){
                selectOptionsIOD.remove(i);
            }
        }
        
        selectOptionsVX = PafPicklistsController.getFieldValues('VX__c');
        for(integer i=0; i < selectOptionsVX.size(); i ++){
            if(selectOptionsVX[i].getvalue().contains('Standard Pricing')){
                selectOptionsVX.remove(i);
            }
        }
        
        selectOptionsVC = PafPicklistsController.getFieldValues('VC__c');
        for(integer i=0; i < selectOptionsVC.size(); i ++){
            if(selectOptionsVC[i].getvalue().contains('Standard Pricing')){
                selectOptionsVC.remove(i);
            }
        }
        
        selectOptionsVI = PafPicklistsController.getFieldValues('VI__c');
        for(integer i=0; i < selectOptionsVI.size(); i ++){
            if(selectOptionsVI[i].getvalue().contains('Standard Pricing')){
                selectOptionsVI.remove(i);
            }
        }
        
        selectOptionsVEC = PafPicklistsController.getFieldValues('VE__c');
        for(integer i=0; i < selectOptionsVEC.size(); i ++){
            if(selectOptionsVEC[i].getvalue().contains('Standard Pricing')){
                selectOptionsVEC.remove(i);
            }
        }
        
        selectOptionsVD = PafPicklistsController.getFieldValues('VD__c');
        for(integer i=0; i < selectOptionsVD.size(); i ++){
            if(selectOptionsVD[i].getvalue().contains('Standard Pricing')){
                selectOptionsVD.remove(i);
            }
        }
        
        selectOptionsEC = PafPicklistsController.getFieldValues('EC__c');
        for(integer i=0; i < selectOptionsEC.size(); i ++){
            if(selectOptionsEC[i].getvalue().contains('Standard Pricing')){
                selectOptionsEC.remove(i);
            }
        }
        
        selectOptionsEJ = PafPicklistsController.getFieldValues('EJ_SIO_Processor__c');
        for(integer i=0; i < selectOptionsEJ.size(); i ++){
            if(selectOptionsEJ[i].getvalue().contains('Standard Pricing')){
                selectOptionsEJ.remove(i);
            }
        }
        
        selectOptionsIOC = PafPicklistsController.getFieldValues('iO__c');
        for(integer i=0; i < selectOptionsIOC.size(); i ++){
            if(selectOptionsIOC[i].getvalue().contains('Standard Pricing')){
                selectOptionsIOC.remove(i);
            }
        }
        
        selectOptionsEDVeri = PafPicklistsController.getFieldValues('ED_veriCLASS_Readers__c');
        for(integer i=0; i < selectOptionsEDVeri.size(); i ++){
            if(selectOptionsEDVeri[i].getvalue().contains('Standard Pricing')){
                selectOptionsEDVeri.remove(i);
            }
        }
        
        selectOptionsEP = PafPicklistsController.getFieldValues('EP__c');
        for(integer i=0; i < selectOptionsEP.size(); i ++){
            if(selectOptionsEP[i].getvalue().contains('Standard Pricing')){
                selectOptionsEP.remove(i);
            }
        }
        
        selectOptionsEE = PafPicklistsController.getFieldValues('EE_OMNIKEY_Reader_Board__c');
        for(integer i=0; i < selectOptionsEE.size(); i ++){
            if(selectOptionsEE[i].getvalue().contains('Standard Pricing')){
                selectOptionsEE.remove(i);
            }
        }
        
        selectOptionsLOC = PafPicklistsController.getFieldValues('LO__c');
        for(integer i=0; i < selectOptionsLOC.size(); i ++){
            if(selectOptionsLOC[i].getvalue().contains('Standard Pricing')){
                selectOptionsLOC.remove(i);
            }
        }
        
        selectOptionsEFO = PafPicklistsController.getFieldValues('EF_OMNIKEY_Chipsets__c');
        for(integer i=0; i < selectOptionsEFO.size(); i ++){
            if(selectOptionsEFO[i].getvalue().contains('Standard Pricing')){
                selectOptionsEFO.remove(i);
            }
        }
        
        selectOptionsELEM = PafPicklistsController.getFieldValues('EL_Embedded_Accessories__c');
        for(integer i=0; i < selectOptionsELEM.size(); i ++){
            if(selectOptionsELEM[i].getvalue().contains('Standard Pricing')){
                selectOptionsELEM.remove(i);
            }
        }
        
        selectOptionsEGSMART = PafPicklistsController.getFieldValues('EG_SmartID_Reader_Boards__c');
        for(integer i=0; i < selectOptionsEGSMART.size(); i ++){
            if(selectOptionsEGSMART[i].getvalue().contains('Standard Pricing')){
                selectOptionsEGSMART.remove(i);
            }
        }
        
        selectOptionsEK = PafPicklistsController.getFieldValues('EK_iCLASS_SE_Reader_Modules__c');
        for(integer i=0; i < selectOptionsEK.size(); i ++){
            if(selectOptionsEK[i].getvalue().contains('Standard Pricing')){
                selectOptionsEK.remove(i);
            }
        }
        
        selectOptionsEHCLASS = PafPicklistsController.getFieldValues('EH_identiCLASS_Readers__c');
        for(integer i=0; i < selectOptionsEHCLASS.size(); i ++){
            if(selectOptionsEHCLASS[i].getvalue().contains('Standard Pricing')){
                selectOptionsEHCLASS.remove(i);
            }
        }
        
        selectOptionsEAISO = PafPicklistsController.getFieldValues('EA_ISO_Reader_Boards__c');
        for(integer i=0; i < selectOptionsEAISO.size(); i ++){
            if(selectOptionsEAISO[i].getvalue().contains('Standard Pricing')){
                selectOptionsEAISO.remove(i);
            }
        }
        
        selectOptionsEI = PafPicklistsController.getFieldValues('EI_Developer_Services_Plus__c');
        for(integer i=0; i < selectOptionsEI.size(); i ++){
            if(selectOptionsEI[i].getvalue().contains('Standard Pricing')){
                selectOptionsEI.remove(i);
            }
        }
        
        selectOptionsFAPROP = PafPicklistsController.getFieldValues('FA_Prof_Printers__c');
        for(integer i=0; i < selectOptionsFAPROP.size(); i ++){
            if(selectOptionsFAPROP[i].getvalue().contains('Standard Pricing')){
                selectOptionsFAPROP.remove(i);
            }
        }
        
        selectOptionsFM = PafPicklistsController.getFieldValues('FM_SDK_S_W_Support__c');
        for(integer i=0; i < selectOptionsFM.size(); i ++){
            if(selectOptionsFM[i].getvalue().contains('Standard Pricing')){
                selectOptionsFM.remove(i);
            }
        }
        
        selectOptionsFB = PafPicklistsController.getFieldValues('FB_Entry_Level_Printers__c');
        for(integer i=0; i < selectOptionsFB.size(); i ++){
            if(selectOptionsFB[i].getvalue().contains('Standard Pricing')){
                selectOptionsFB.remove(i);
            }
        }
        
        selectOptionsFN = PafPicklistsController.getFieldValues('FN_Extended_Warranties__c');
        for(integer i=0; i < selectOptionsFN.size(); i ++){
            if(selectOptionsFN[i].getvalue().contains('Standard Pricing')){
                selectOptionsFN.remove(i);
            }
        }
        
        selectOptionsFX = PafPicklistsController.getFieldValues('FX_Standard_Series_C50_Printers__c');
        for(integer i=0; i < selectOptionsFX.size(); i ++){
            if(selectOptionsFX[i].getvalue().contains('Standard Pricing')){
                selectOptionsFX.remove(i);
            }
        }
        
        selectOptionsFY = PafPicklistsController.getFieldValues('FY_Standard_C50_Regional_Ribbons_Only__c');
        for(integer i=0; i < selectOptionsFY.size(); i ++){
            if(selectOptionsFY[i].getvalue().contains('Standard Pricing')){
                selectOptionsFY.remove(i);
            }
        }
        
        selectOptionsFZ = PafPicklistsController.getFieldValues('FZ_Standard_Series_DTC1250e_Printers__c');
        for(integer i=0; i < selectOptionsFZ.size(); i ++){
            if(selectOptionsFZ[i].getvalue().contains('Standard Pricing')){
                selectOptionsFZ.remove(i);
            }
        }
        
        selectOptionsFC = PafPicklistsController.getFieldValues('FC_Print_Heads__c');
        for(integer i=0; i < selectOptionsFC.size(); i ++){
            if(selectOptionsFC[i].getvalue().contains('Standard Pricing')){
                selectOptionsFC.remove(i);
            }
        }
        
        selectOptionsFO = PafPicklistsController.getFieldValues('FO_Cameras_Camera_S_W__c');
        for(integer i=0; i < selectOptionsFO.size(); i ++){
            if(selectOptionsFO[i].getvalue().contains('Standard Pricing')){
                selectOptionsFO.remove(i);
            }
        }
        
        selectOptionsFDR = PafPicklistsController.getFieldValues('FD_Ribbons_Clear_Film__c');
        for(integer i=0; i < selectOptionsFDR.size(); i ++){
            if(selectOptionsFDR[i].getvalue().contains('Standard Pricing')){
                selectOptionsFDR.remove(i);
            }
        }
        
        selectOptionsFPID = PafPicklistsController.getFieldValues('FP_Photo_ID_Accessories__c');
        for(integer i=0; i < selectOptionsFPID.size(); i ++){
            if(selectOptionsFPID[i].getvalue().contains('Standard Pricing')){
                selectOptionsFPID.remove(i);
            }
        }
         
        selectOptionsFEENTRY = PafPicklistsController.getFieldValues('FE_Entry_Level_Ribbons__c');
        for(integer i=0; i < selectOptionsFEENTRY.size(); i ++){
            if(selectOptionsFEENTRY[i].getvalue().contains('Standard Pricing')){
                selectOptionsFEENTRY.remove(i);
            }
        }
        
        selectOptionsFQ = PafPicklistsController.getFieldValues('FQ_Spare_Parts_Packages__c');
        for(integer i=0; i < selectOptionsFQ.size(); i ++){
            if(selectOptionsFQ[i].getvalue().contains('Standard Pricing')){
                selectOptionsFQ.remove(i);
            }
        }
        
        selectOptionsFF = PafPicklistsController.getFieldValues('FF_Holo_Film_Overlams__c');
        for(integer i=0; i < selectOptionsFF.size(); i ++){
            if(selectOptionsFF[i].getvalue().contains('Standard Pricing')){
                selectOptionsFF.remove(i);
            }
        }
        
        selectOptionsFR = PafPicklistsController.getFieldValues('FR_Spare_Parts_Kits__c');
        for(integer i=0; i < selectOptionsFR.size(); i ++){
            if(selectOptionsFR[i].getvalue().contains('Standard Pricing')){
                selectOptionsFR.remove(i);
            }
        }
        
        selectOptionsFGVERI = PafPicklistsController.getFieldValues('FG_Veri_Holo_OVD_Cards__c');
        for(integer i=0; i < selectOptionsFGVERI.size(); i ++){
            if(selectOptionsFGVERI[i].getvalue().contains('Standard Pricing')){
                selectOptionsFGVERI.remove(i);
            }
        }
        
        selectOptionsFS = PafPicklistsController.getFieldValues('FS_Rewriteable_Cards__c');
        for(integer i=0; i < selectOptionsFS.size(); i ++){
            if(selectOptionsFS[i].getvalue().contains('Standard Pricing')){
                selectOptionsFS.remove(i);
            }
        }
        
        selectOptionsFHULTRA = PafPicklistsController.getFieldValues('FH_UltraCards__c');
        for(integer i=0; i < selectOptionsFHULTRA.size(); i ++){
            if(selectOptionsFHULTRA[i].getvalue().contains('Standard Pricing')){
                selectOptionsFHULTRA.remove(i);
            }
        }
        
        selectOptionsFT = PafPicklistsController.getFieldValues('FT_HDP8500_Printers__c');
        for(integer i=0; i < selectOptionsFT.size(); i ++){
            if(selectOptionsFT[i].getvalue().contains('Standard Pricing')){
                selectOptionsFT.remove(i);
            }
        }
        
        selectOptionsFKHD = PafPicklistsController.getFieldValues('FK_HDPii_Printers__c');
        for(integer i=0; i < selectOptionsFKHD.size(); i ++){
            if(selectOptionsFKHD[i].getvalue().contains('Standard Pricing')){
                selectOptionsFKHD.remove(i);
            }
        }
        
        selectOptionsFU = PafPicklistsController.getFieldValues('FU_Industrial_Series_Ribbons_HDP_Film__c');
        for(integer i=0; i < selectOptionsFU.size(); i ++){
            if(selectOptionsFU[i].getvalue().contains('Standard Pricing')){
                selectOptionsFU.remove(i);
            }
        }
        
        selectOptionsFL = PafPicklistsController.getFieldValues('FL_Asure_ID_Software__c');
        for(integer i=0; i < selectOptionsFL.size(); i ++){
            if(selectOptionsFL[i].getvalue().contains('Standard Pricing')){
                selectOptionsFL.remove(i);
            }
        }
        
        selectOptionsFV = PafPicklistsController.getFieldValues('FV_Laser_Engravers__c');
        for(integer i=0; i < selectOptionsFV.size(); i ++){
            if(selectOptionsFV[i].getvalue().contains('Standard Pricing')){
                selectOptionsFV.remove(i);
            }
        }
        
        selectOptionsFMFIN = PafPicklistsController.getFieldValues('FW_Financial_Series_Ribbons_HDP_Film__c');
        for(integer i=0; i < selectOptionsFMFIN.size(); i ++){
            if(selectOptionsFMFIN[i].getvalue().contains('Standard Pricing')){
                selectOptionsFMFIN.remove(i);
            }
        }
        
        selectOptionsPS = PafPicklistsController.getFieldValues('PS_Professional_Services__c');
        for(integer i=0; i < selectOptionsPS.size(); i ++){
            if(selectOptionsPS[i].getvalue().contains('Standard Pricing')){
                selectOptionsPS.remove(i);
            }
        }
        
        selectOptionsAA = PafPicklistsController.getFieldValues('AA__c');
        for(integer i=0; i < selectOptionsAA.size(); i ++){
            if(selectOptionsAA[i].getvalue().contains('Standard Pricing')){
                selectOptionsAA.remove(i);
            }
        }
        
        selectOptionsAD = PafPicklistsController.getFieldValues('AD__c');
        for(integer i=0; i < selectOptionsAD.size(); i ++){
            if(selectOptionsAD[i].getvalue().contains('Standard Pricing')){
                selectOptionsAD.remove(i);
            }
        }
        
        selectOptionsAG = PafPicklistsController.getFieldValues('AG__c');
        for(integer i=0; i < selectOptionsAG.size(); i ++){
            if(selectOptionsAG[i].getvalue().contains('Standard Pricing')){
                selectOptionsAG.remove(i);
            }
        }
        
        selectOptionsAI = PafPicklistsController.getFieldValues('AI__c');
        for(integer i=0; i < selectOptionsAI.size(); i ++){
            if(selectOptionsAI[i].getvalue().contains('Standard Pricing')){
                selectOptionsAI.remove(i);
            }
        }
        
        selectOptionsAJ = PafPicklistsController.getFieldValues('AJ__c');
        for(integer i=0; i < selectOptionsAJ.size(); i ++){
            if(selectOptionsAJ[i].getvalue().contains('Standard Pricing')){
                selectOptionsAJ.remove(i);
            }
        }
        
        selectOptionsAF = PafPicklistsController.getFieldValues('AF__c');
        for(integer i=0; i < selectOptionsAF.size(); i ++){
            if(selectOptionsAF[i].getvalue().contains('Standard Pricing')){
                selectOptionsAF.remove(i);
            }
        }
        
        selectOptionsAB = PafPicklistsController.getFieldValues('AB__c');
        for(integer i=0; i < selectOptionsAB.size(); i ++){
            if(selectOptionsAB[i].getvalue().contains('Standard Pricing')){
                selectOptionsAB.remove(i);
            }
        }
        
        selectOptionsAL = PafPicklistsController.getFieldValues('AL__c');
        for(integer i=0; i < selectOptionsAL.size(); i ++){
            if(selectOptionsAL[i].getvalue().contains('Standard Pricing')){
                selectOptionsAL.remove(i);
            }
        }
        
        selectOptionsAH = PafPicklistsController.getFieldValues('AH__c');
        for(integer i=0; i < selectOptionsAH.size(); i ++){
            if(selectOptionsAH[i].getvalue().contains('Standard Pricing')){
                selectOptionsAH.remove(i);
            }
        }
        
        selectOptionsAZ = PafPicklistsController.getFieldValues('AZ__c');
        for(integer i=0; i < selectOptionsAZ.size(); i ++){
            if(selectOptionsAZ[i].getvalue().contains('Standard Pricing')){
                selectOptionsAZ.remove(i);
            }
        }
        
        selectOptionsAE = PafPicklistsController.getFieldValues('AE__c');
        for(integer i=0; i < selectOptionsAE.size(); i ++){
            if(selectOptionsAE[i].getvalue().contains('Standard Pricing')){
                selectOptionsAE.remove(i);
            }
        }
        
        selectOptionsIM = PafPicklistsController.getFieldValues('iM_HID_Mobile_Access__c');
        for(integer i=0; i < selectOptionsIM.size(); i ++){
            if(selectOptionsIM[i].getvalue().contains('Standard Pricing')){
                selectOptionsIM.remove(i);
            }
        }
        
        selectOptionsCP = PafPicklistsController.getFieldValues('CP_Custom_Special_Products_w_o_Discount__c');        
        for(integer i=0; i < selectOptionsCP.size(); i ++){
            if(selectOptionsCP[i].getvalue().contains('Standard Pricing')){
                selectOptionsCP.remove(i);
            }
        }
        
        //ADDED @ Hitesh Patel - Jade Global 2015/07/13
        selectOptionsAK = PafPicklistsController.getFieldValues('AK__c');
        for(integer i=0; i < selectOptionsAK.size(); i ++){
            if(selectOptionsAK[i].getvalue().contains('Standard Pricing')){
                selectOptionsAK.remove(i);
            }
        }
        
        selectOptionsAM = PafPicklistsController.getFieldValues('AM__c');
        for(integer i=0; i < selectOptionsAM.size(); i ++){
            if(selectOptionsAM[i].getvalue().contains('Standard Pricing')){
                selectOptionsAM.remove(i);
            }
        }
        
        selectOptionsAN = PafPicklistsController.getFieldValues('AN__c');        
        for(integer i=0; i < selectOptionsAN.size(); i ++){
            if(selectOptionsAN[i].getvalue().contains('Standard Pricing')){
                selectOptionsAN.remove(i);
            }
        }
    }
    
    public void getAccountProfileDetails(){
        acProfile = new List<Account_Profile__c>(); 
        if(priceAuthorization.account__c != null){
            acProfile = [SELECT Business_Segment__c, Partner_Type__c, Tier__c, Sales_Manager__c FROM Account_Profile__c WHERE account__c = :priceAuthorization.account__c];
            string accountId = priceAuthorization.account__c;            
            string queryString = query;
            queryString = queryString +'accountId';
            system.debug('AAAA--'+queryString);
            account =  dataBase.query(queryString);
            
            PartnerProgramStatusList = [SELECT Partner_Program_Status__c,Partner_Program_Status_Modifier__c FROM  Partner_Program__c WHERE RecordTypeId =: idAdvantagePartnerRecordType AND Account__c =: priceAuthorization.Account__c]; 
            if(PartnerProgramStatusList.size() > 0 ){
                PartnerProgramStatus = PartnerProgramStatusList[0].Partner_Program_Status__c;
                PartnerProgramStatusModifier = PartnerProgramStatusList[0].Partner_Program_Status_Modifier__c;
            }else{
                PartnerProgramStatus = '';
                PartnerProgramStatusModifier = '';
            }
            relatedAccount=[select id,BillingCountry from account where id=:priceAuthorization.Account__c];
            accCountry=relatedAccount.BillingCountry;
            PafPicklistsController = new PafPicklistsController(accCountry, 'Standard_PAF');
            resetPriceCodeValues();
        }
    }    
    
    public PageReference savePriceAuthorization(){
        try{
            string strAllPriceCodes = '';
            PafPicklistsController objPafPicklistsController = new PafPicklistsController(accCountry, 'Standard_PAF');    
                    
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
        string strAllPriceCodes = '';
        PafPicklistsController objPafPicklistsController = new PafPicklistsController(accCountry, 'Standard_PAF');     
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
        upsert priceAuthorization;
        string s = '/' + ('' + priceAuthorization.get('Id')).subString(0, 3) + '/e?';
        ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.Info, s));
        return new Pagereference(s);
    }
    
    public PageReference cancelPriceAuthorization(){
        PageReference pg=New PageReference('/a0O/o');
        return pg;
    }
}