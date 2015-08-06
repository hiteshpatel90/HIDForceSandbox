/****************************************************************************
* Type               : Apex Class
* Name               : BatchExecUpdateAllPriceCodes 
* Modified by        : Hitesh Patel
* Modified Date      : 11th June 2015
* Last Modified By   : Hitesh Patel 11th June 2015
* Purpose            : This controller is used to populate all the price codes for existing PAF
****************************************************************************/
global class BatchExecUpdateAllPriceCodes implements Database.Batchable<sObject>{
    global final String Query;
 
    global BatchExecUpdateAllPriceCodes(String q){
        Query=q;        
    }

    global Database.QueryLocator start(Database.BatchableContext BC)   {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope)   {
        UpdateAllPriceCodes(scope);
    }
    
    public void UpdateAllPriceCodes(List<sObject> scope) {
        List<Price_Authorization_Form__c> lstPAFUpdate = new List<Price_Authorization_Form__c>();
        for(integer i = 0;i<scope.size();i++){
            Price_Authorization_Form__c priceAuthorization = (Price_Authorization_Form__c)scope[i];
            string accCountry=priceAuthorization.Account__r.BillingCountry;
            PafPicklistsController objPafPicklistsController = new PafPicklistsController(accCountry, priceAuthorization.Recordtype.Developername);   
            if(priceAuthorization.iR__c != null && priceAuthorization.iR__c != ''){
                priceAuthorization.iR__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.iR__c);
            }
             if(priceAuthorization.MS__c != null && priceAuthorization.MS__c != ''){
                priceAuthorization.MS__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.MS__c);
            }
            if(priceAuthorization.iC__c != null && priceAuthorization.iC__c != ''){
                priceAuthorization.iC__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.iC__c);
            }
            if(priceAuthorization.iD__c != null && priceAuthorization.iD__c != ''){
                priceAuthorization.iD__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.iD__c);
            }
            if(priceAuthorization.VS__c != null && priceAuthorization.VS__c != ''){
                priceAuthorization.VS__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.VS__c);
            }
            if(priceAuthorization.iP__c != null && priceAuthorization.iP__c != ''){
                priceAuthorization.iP__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.iP__c);
            }
            if(priceAuthorization.LV__c != null && priceAuthorization.LV__c!= ''){
                priceAuthorization.LV__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.LV__c);
            }
            if(priceAuthorization.MC__c != null && priceAuthorization.MC__c != ''){
                priceAuthorization.MC__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.MC__c);
            }
            if(priceAuthorization.LW_Indala_Credentials__c != null && priceAuthorization.LW_Indala_Credentials__c!= ''){
                priceAuthorization.LW_Indala_Credentials__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.LW_Indala_Credentials__c);
            }
            if(priceAuthorization.MD__c != null && priceAuthorization.MD__c != ''){
                priceAuthorization.MD__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.MD__c);
            }
            if(priceAuthorization.ME__c!= null && priceAuthorization.ME__c != ''){
                priceAuthorization.ME__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.ME__c);
            }
            if(priceAuthorization.MF__c != null && priceAuthorization.MF__c != ''){
                priceAuthorization.MF__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.MF__c);
            }
            if(priceAuthorization.iE_pivCLASS_Modules_Software__c != null && priceAuthorization.iE_pivCLASS_Modules_Software__c != ''){
                priceAuthorization.iE_pivCLASS_Modules_Software__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.iE_pivCLASS_Modules_Software__c);
            }
            if(priceAuthorization.RA__c != null && priceAuthorization.RA__c!= ''){
                priceAuthorization.RA__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.RA__c);
            }
            if(priceAuthorization.iJ_pivCLASS_Modules_Software__c != null && priceAuthorization.iJ_pivCLASS_Modules_Software__c != ''){
                priceAuthorization.iJ_pivCLASS_Modules_Software__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.iJ_pivCLASS_Modules_Software__c);
            }
            if(priceAuthorization.RB__c != null && priceAuthorization.RB__c != ''){
                priceAuthorization.RB__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.RB__c);
            }
            if(priceAuthorization.iF_pivCLASS_Kits__c != null && priceAuthorization.iF_pivCLASS_Kits__c!= ''){
                priceAuthorization.iF_pivCLASS_Kits__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.iF_pivCLASS_Kits__c);
            }
            if(priceAuthorization.RC__c != null && priceAuthorization.RC__c != ''){
                priceAuthorization.RC__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.RC__c);
            }
            if(priceAuthorization.iH_pivCLASS_Bundles__c != null && priceAuthorization.iH_pivCLASS_Bundles__c != ''){
                priceAuthorization.iH_pivCLASS_Bundles__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.iH_pivCLASS_Bundles__c);
            }
            if(priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c != null && priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c!= ''){
                priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c);
            }
            if(priceAuthorization.RD__c != null && priceAuthorization.RD__c != ''){
                priceAuthorization.RD__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.RD__c);
            }
            if(priceAuthorization.EZ_EasyLobby__c != null && priceAuthorization.EZ_EasyLobby__c != ''){
                priceAuthorization.EZ_EasyLobby__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EZ_EasyLobby__c);
            }
            if(priceAuthorization.RE__c != null && priceAuthorization.RE__c != ''){
                priceAuthorization.RE__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.RE__c);
            }
            if(priceAuthorization.AC__c != null && priceAuthorization.AC__c != ''){
                priceAuthorization.AC__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AC__c);
            }
            if(priceAuthorization.PC__c != null && priceAuthorization.PC__c != ''){
                priceAuthorization.PC__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.PC__c);
            }
            if(priceAuthorization.OL__c != null && priceAuthorization.OL__c != ''){
                priceAuthorization.OL__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.OL__c);
            }
            if(priceAuthorization.LC__c != null && priceAuthorization.LC__c!= ''){
                priceAuthorization.LC__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.LC__c);
            }
            if(priceAuthorization.LR__c != null && priceAuthorization.LR__c != ''){
                priceAuthorization.LR__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.LR__c);
            }
            if(priceAuthorization.EB_Embeddable_Credentials__c != null && priceAuthorization.EB_Embeddable_Credentials__c != ''){
                priceAuthorization.EB_Embeddable_Credentials__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EB_Embeddable_Credentials__c);
            }
            if(priceAuthorization.IoD__c != null && priceAuthorization.IoD__c != ''){
                priceAuthorization.IoD__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.IoD__c);
            }
            if(priceAuthorization.VX__c != null && priceAuthorization.VX__c != ''){
                priceAuthorization.VX__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.VX__c);
            }
            if(priceAuthorization.VC__c != null && priceAuthorization.VC__c != ''){
                priceAuthorization.VC__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.VC__c);
            }
            if(priceAuthorization.VI__c != null && priceAuthorization.VI__c != ''){
                priceAuthorization.VI__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.VI__c);
            }
            if(priceAuthorization.VE__c != null && priceAuthorization.VE__c != ''){
                priceAuthorization.VE__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.VE__c);
            }
            if(priceAuthorization.VD__c != null && priceAuthorization.VD__c != ''){
                priceAuthorization.VD__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.VD__c);
            }
            if(priceAuthorization.EC__c != null && priceAuthorization.EC__c != ''){
                priceAuthorization.EC__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EC__c);
            }
            if(priceAuthorization.EJ_SIO_Processor__c != null && priceAuthorization.EJ_SIO_Processor__c != ''){
                priceAuthorization.EJ_SIO_Processor__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EJ_SIO_Processor__c);
            }
            if(priceAuthorization.iO__c != null && priceAuthorization.iO__c != ''){
                priceAuthorization.iO__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.iO__c);
            }
            if(priceAuthorization.ED_veriCLASS_Readers__c != null && priceAuthorization.ED_veriCLASS_Readers__c != ''){
                priceAuthorization.ED_veriCLASS_Readers__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.ED_veriCLASS_Readers__c);
            }
            if(priceAuthorization.EP__c != null && priceAuthorization.EP__c != ''){
                priceAuthorization.EP__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EP__c);
            }
            if(priceAuthorization.EE_OMNIKEY_Reader_Board__c != null && priceAuthorization.EE_OMNIKEY_Reader_Board__c != ''){
                priceAuthorization.EE_OMNIKEY_Reader_Board__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EE_OMNIKEY_Reader_Board__c);
            }
            if(priceAuthorization.LO__c != null && priceAuthorization.LO__c != ''){
                priceAuthorization.LO__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.LO__c);
            }
            if(priceAuthorization.EI_Developer_Services_Plus__c != null && priceAuthorization.EI_Developer_Services_Plus__c != ''){
                priceAuthorization.EI_Developer_Services_Plus__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EI_Developer_Services_Plus__c);
            }
            if(priceAuthorization.EF_OMNIKEY_Chipsets__c != null && priceAuthorization.EF_OMNIKEY_Chipsets__c != ''){
                priceAuthorization.EF_OMNIKEY_Chipsets__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EF_OMNIKEY_Chipsets__c);
            }
            if(priceAuthorization.EL_Embedded_Accessories__c != null && priceAuthorization.EL_Embedded_Accessories__c != ''){
                priceAuthorization.EL_Embedded_Accessories__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EL_Embedded_Accessories__c);
            }
            if(priceAuthorization.EG_SmartID_Reader_Boards__c != null && priceAuthorization.EG_SmartID_Reader_Boards__c != ''){
                priceAuthorization.EG_SmartID_Reader_Boards__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EG_SmartID_Reader_Boards__c);
            }
            if(priceAuthorization.EK_iCLASS_SE_Reader_Modules__c != null && priceAuthorization.EK_iCLASS_SE_Reader_Modules__c != ''){
                priceAuthorization.EK_iCLASS_SE_Reader_Modules__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EK_iCLASS_SE_Reader_Modules__c);
            }
            if(priceAuthorization.EH_identiCLASS_Readers__c != null && priceAuthorization.EH_identiCLASS_Readers__c != ''){
                priceAuthorization.EH_identiCLASS_Readers__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EH_identiCLASS_Readers__c);
            }
            if(priceAuthorization.EA_ISO_Reader_Boards__c != null && priceAuthorization.EA_ISO_Reader_Boards__c != ''){
                priceAuthorization.EA_ISO_Reader_Boards__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.EA_ISO_Reader_Boards__c);
            }
            if(priceAuthorization.FL_Asure_ID_Software__c != null && priceAuthorization.FL_Asure_ID_Software__c != ''){
                priceAuthorization.FL_Asure_ID_Software__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FL_Asure_ID_Software__c);
            }
            if(priceAuthorization.FM_SDK_S_W_Support__c != null && priceAuthorization.FM_SDK_S_W_Support__c != ''){
                priceAuthorization.FM_SDK_S_W_Support__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FM_SDK_S_W_Support__c);
            }
            if(priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c != null && priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c != ''){
                priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c);
            }
            if(priceAuthorization.FN_Extended_Warranties__c != null && priceAuthorization.FN_Extended_Warranties__c != ''){
                priceAuthorization.FN_Extended_Warranties__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FN_Extended_Warranties__c);
            }
            if(priceAuthorization.FX_Standard_Series_C50_Printers__c != null && priceAuthorization.FX_Standard_Series_C50_Printers__c != ''){
                priceAuthorization.FX_Standard_Series_C50_Printers__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FX_Standard_Series_C50_Printers__c);
            }
            if(priceAuthorization.FO_Cameras_Camera_S_W__c != null && priceAuthorization.FO_Cameras_Camera_S_W__c != ''){
                priceAuthorization.FO_Cameras_Camera_S_W__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FO_Cameras_Camera_S_W__c);
            }
            if(priceAuthorization.FC_Print_Heads__c != null && priceAuthorization.FC_Print_Heads__c != ''){
                priceAuthorization.FC_Print_Heads__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FC_Print_Heads__c);
            }
            if(priceAuthorization.FP_Photo_ID_Accessories__c != null && priceAuthorization.FP_Photo_ID_Accessories__c != ''){
                priceAuthorization.FP_Photo_ID_Accessories__c= objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FP_Photo_ID_Accessories__c);
            }
            if(priceAuthorization.FQ_Spare_Parts_Packages__c != null && priceAuthorization.FQ_Spare_Parts_Packages__c != ''){
                priceAuthorization.FQ_Spare_Parts_Packages__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FQ_Spare_Parts_Packages__c);
            }
            if(priceAuthorization.FR_Spare_Parts_Kits__c != null && priceAuthorization.FR_Spare_Parts_Kits__c != ''){
                priceAuthorization.FR_Spare_Parts_Kits__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FR_Spare_Parts_Kits__c);
            }
            if(priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c != null && priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c != ''){
                priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c);
            }
            if(priceAuthorization.FS_Rewriteable_Cards__c != null && priceAuthorization.FS_Rewriteable_Cards__c != ''){
                priceAuthorization.FS_Rewriteable_Cards__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FS_Rewriteable_Cards__c);
            }
            if(priceAuthorization.FF_Holo_Film_Overlams__c != null && priceAuthorization.FF_Holo_Film_Overlams__c != ''){
                priceAuthorization.FF_Holo_Film_Overlams__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FF_Holo_Film_Overlams__c);
            }
            if(priceAuthorization.FT_HDP8500_Printers__c != null && priceAuthorization.FT_HDP8500_Printers__c != ''){
                priceAuthorization.FT_HDP8500_Printers__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FT_HDP8500_Printers__c);
            }
            if(priceAuthorization.FG_Veri_Holo_OVD_Cards__c != null && priceAuthorization.FG_Veri_Holo_OVD_Cards__c != ''){
                priceAuthorization.FG_Veri_Holo_OVD_Cards__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FG_Veri_Holo_OVD_Cards__c);
            }
            if(priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c != null && priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c != ''){
                priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c);
            }
            if(priceAuthorization.FH_UltraCards__c != null && priceAuthorization.FH_UltraCards__c != ''){
                priceAuthorization.FH_UltraCards__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FH_UltraCards__c);
            }
            if(priceAuthorization.FV_Laser_Engravers__c != null && priceAuthorization.FV_Laser_Engravers__c != ''){
                priceAuthorization.FV_Laser_Engravers__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FV_Laser_Engravers__c);
            }
            if(priceAuthorization.FK_HDPii_Printers__c != null && priceAuthorization.FK_HDPii_Printers__c != ''){
                priceAuthorization.FK_HDPii_Printers__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FK_HDPii_Printers__c);
            }
            if(priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c != null && priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c != ''){
                priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c);
            }
            if(priceAuthorization.FA_Prof_Printers__c != null && priceAuthorization.FA_Prof_Printers__c != ''){
                priceAuthorization.FA_Prof_Printers__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FA_Prof_Printers__c);
            }
            if(priceAuthorization.FB_Entry_Level_Printers__c != null && priceAuthorization.FB_Entry_Level_Printers__c != ''){
                priceAuthorization.FB_Entry_Level_Printers__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FB_Entry_Level_Printers__c);
            }
            if(priceAuthorization.FD_Ribbons_Clear_Film__c != null && priceAuthorization.FD_Ribbons_Clear_Film__c != ''){
                priceAuthorization.FD_Ribbons_Clear_Film__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FD_Ribbons_Clear_Film__c);
            }
            if(priceAuthorization.FE_Entry_Level_Ribbons__c != null && priceAuthorization.FE_Entry_Level_Ribbons__c != ''){
                priceAuthorization.FE_Entry_Level_Ribbons__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.FE_Entry_Level_Ribbons__c);
            }
            if(priceAuthorization.PS_Professional_Services__c != null && priceAuthorization.PS_Professional_Services__c != ''){
                priceAuthorization.PS_Professional_Services__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.PS_Professional_Services__c);
            }
            if(priceAuthorization.AA__c != null && priceAuthorization.AA__c != ''){
                priceAuthorization.AA__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AA__c);
            }
            if(priceAuthorization.AF__c != null && priceAuthorization.AF__c != ''){
                priceAuthorization.AF__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AF__c);
            }
            if(priceAuthorization.AB__c != null && priceAuthorization.AB__c != ''){
                priceAuthorization.AB__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AB__c);
            }
            if(priceAuthorization.AL__c != null && priceAuthorization.AL__c != ''){
                priceAuthorization.AL__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AL__c);
            }
            if(priceAuthorization.AH__c != null && priceAuthorization.AH__c != ''){
                priceAuthorization.AH__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AH__c);
            }
            if(priceAuthorization.AZ__c != null && priceAuthorization.AZ__c != ''){
                priceAuthorization.AZ__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AZ__c);
            }
            if(priceAuthorization.AE__c != null && priceAuthorization.AE__c != ''){
                priceAuthorization.AE__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AE__c);
            }
            if(priceAuthorization.iM_HID_Mobile_Access__c != null && priceAuthorization.iM_HID_Mobile_Access__c != ''){
                priceAuthorization.iM_HID_Mobile_Access__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.iM_HID_Mobile_Access__c);
            }
            if(priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c != null && priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c != ''){
                priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c);
            }
            if(priceAuthorization.AD__c != null && priceAuthorization.AD__c != ''){
                priceAuthorization.AD__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AD__c);
            }
            if(priceAuthorization.AG__c != null && priceAuthorization.AG__c != ''){
                priceAuthorization.AG__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AG__c);
            }
            if(priceAuthorization.AI__c != null && priceAuthorization.AI__c != ''){
                priceAuthorization.AI__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AI__c);
            }
            if(priceAuthorization.AJ__c != null && priceAuthorization.AJ__c  != ''){
                priceAuthorization.AJ__c = objPafPicklistsController.getPAFPriceCodeDisplayValue(priceAuthorization.AJ__c);
            }      
            lstPAFUpdate.add(priceAuthorization);
        }
        if(!lstPAFUpdate.isEmpty()){
            update lstPAFUpdate;
        }
    }   
    
    global void finish(Database.BatchableContext BC) {
       
    }    
   
}