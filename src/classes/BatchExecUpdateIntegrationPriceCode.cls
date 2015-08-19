/****************************************************************************
* Type               : Apex Class
* Name               : BatchExecUpdateIntegrationPriceCode 
* Modified by        : Hitesh Patel
* Modified Date      : 11th June 2015
* Last Modified By   : Hitesh Patel 11th June 2015
* Purpose            : This controller is used to populate all the price codes for existing PAF in single field
****************************************************************************/
global class BatchExecUpdateIntegrationPriceCode implements Database.Batchable<sObject>{
    global final String Query;
 
    global BatchExecUpdateIntegrationPriceCode(String q){
        Query=q;        
    }

    global Database.QueryLocator start(Database.BatchableContext BC)   {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope)   {
        UpdateIntegrationPriceCode(scope);
    }

   
    public void UpdateIntegrationPriceCode(List<sObject> scope) {
        List<Price_Authorization_Form__c> lstPAFUpdate = new List<Price_Authorization_Form__c>();
        for(integer i = 0;i<scope.size();i++){
            Price_Authorization_Form__c priceAuthorization = (Price_Authorization_Form__c)scope[i];
            string strAllPriceCodes = '';
            string accCountry=priceAuthorization.Account__r.BillingCountry;
            PafPicklistsController objPafPicklistsController = new PafPicklistsController(accCountry, priceAuthorization.Recordtype.Developername);   
            if(priceAuthorization.iR__c != null && priceAuthorization.iR__c != ''){
                //strAllPriceCodes += priceAuthorization.iR__c+ ',';
                strAllPriceCodes += priceAuthorization.iR__c + ',';
            }
            if(priceAuthorization.MS__c != null && priceAuthorization.MS__c != ''){
                strAllPriceCodes += priceAuthorization.MS__c+ ',';
            }
            if(priceAuthorization.iC__c != null && priceAuthorization.iC__c != ''){
                strAllPriceCodes += priceAuthorization.iC__c+ ',';
            }
            if(priceAuthorization.iD__c != null && priceAuthorization.iD__c != ''){
                strAllPriceCodes += priceAuthorization.iD__c+ ',';
            }
            if(priceAuthorization.VS__c != null && priceAuthorization.VS__c != ''){
                strAllPriceCodes += priceAuthorization.VS__c+ ',';
            }
            if(priceAuthorization.iP__c != null && priceAuthorization.iP__c != ''){
                strAllPriceCodes += priceAuthorization.iP__c+ ',';
            }
            if(priceAuthorization.LV__c != null && priceAuthorization.LV__c!= ''){
                strAllPriceCodes += priceAuthorization.LV__c+ ',';
            }
            if(priceAuthorization.MC__c != null && priceAuthorization.MC__c != ''){
                strAllPriceCodes += priceAuthorization.MC__c+ ',';
            }
            if(priceAuthorization.LW_Indala_Credentials__c != null && priceAuthorization.LW_Indala_Credentials__c!= ''){
                strAllPriceCodes += priceAuthorization.LW_Indala_Credentials__c+ ',';
            }
            if(priceAuthorization.MD__c != null && priceAuthorization.MD__c != ''){
                strAllPriceCodes += priceAuthorization.MD__c+ ',';
            }
            if(priceAuthorization.ME__c!= null && priceAuthorization.ME__c != ''){
                strAllPriceCodes += priceAuthorization.ME__c+ ',';
            }
            if(priceAuthorization.MF__c != null && priceAuthorization.MF__c != ''){
                strAllPriceCodes += priceAuthorization.MF__c+ ',';
            }
            if(priceAuthorization.iE_pivCLASS_Modules_Software__c != null && priceAuthorization.iE_pivCLASS_Modules_Software__c != ''){
                strAllPriceCodes += priceAuthorization.iE_pivCLASS_Modules_Software__c+ ',';
            }
            if(priceAuthorization.RA__c != null && priceAuthorization.RA__c!= ''){
                strAllPriceCodes += priceAuthorization.RA__c+ ',';
            }
            if(priceAuthorization.iJ_pivCLASS_Modules_Software__c != null && priceAuthorization.iJ_pivCLASS_Modules_Software__c != ''){
                strAllPriceCodes += priceAuthorization.iJ_pivCLASS_Modules_Software__c+ ',';
            }
            if(priceAuthorization.RB__c != null && priceAuthorization.RB__c != ''){
                strAllPriceCodes += priceAuthorization.RB__c+ ',';
            }
            if(priceAuthorization.iF_pivCLASS_Kits__c!= null && priceAuthorization.iF_pivCLASS_Kits__c!= ''){
                strAllPriceCodes += priceAuthorization.iF_pivCLASS_Kits__c+ ',';
            }
            if(priceAuthorization.RC__c != null && priceAuthorization.RC__c != ''){
                strAllPriceCodes += priceAuthorization.RC__c+ ',';
            }
            if(priceAuthorization.iH_pivCLASS_Bundles__c != null && priceAuthorization.iH_pivCLASS_Bundles__c != ''){
                strAllPriceCodes += priceAuthorization.iH_pivCLASS_Bundles__c+ ',';
            }
            if(priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c != null && priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c!= ''){
                strAllPriceCodes += priceAuthorization.iK_pivCLASS_Mobile_Handheld_Readers__c+ ',';
            }
            if(priceAuthorization.RD__c != null && priceAuthorization.RD__c != ''){
                strAllPriceCodes += priceAuthorization.RD__c+ ',';
            }
            if(priceAuthorization.EZ_EasyLobby__c != null && priceAuthorization.EZ_EasyLobby__c != ''){
                strAllPriceCodes += priceAuthorization.EZ_EasyLobby__c+ ',';
            }
            if(priceAuthorization.RE__c != null && priceAuthorization.RE__c != ''){
                strAllPriceCodes += priceAuthorization.RE__c+ ',';
            }
            if(priceAuthorization.AC__c != null && priceAuthorization.AC__c != ''){
                strAllPriceCodes += priceAuthorization.AC__c+ ',';
            }
            if(priceAuthorization.PC__c != null && priceAuthorization.PC__c != ''){
                strAllPriceCodes += priceAuthorization.PC__c+ ',';
            }
            if(priceAuthorization.OL__c != null && priceAuthorization.OL__c != ''){
                strAllPriceCodes += priceAuthorization.OL__c+ ',';
            }
            if(priceAuthorization.LC__c != null && priceAuthorization.LC__c!= ''){
                strAllPriceCodes += priceAuthorization.LC__c+ ',';
            }
            if(priceAuthorization.LR__c != null && priceAuthorization.LR__c != ''){
                strAllPriceCodes += priceAuthorization.LR__c+ ',';
            }
            if(priceAuthorization.EB_Embeddable_Credentials__c != null && priceAuthorization.EB_Embeddable_Credentials__c != ''){
                strAllPriceCodes += priceAuthorization.EB_Embeddable_Credentials__c+ ',';
            }
            if(priceAuthorization.IoD__c != null && priceAuthorization.IoD__c != ''){
                strAllPriceCodes += priceAuthorization.IoD__c+ ',';
            }
            if(priceAuthorization.VX__c != null && priceAuthorization.VX__c != ''){
                strAllPriceCodes += priceAuthorization.VX__c+ ',';
            }
            if(priceAuthorization.VC__c != null && priceAuthorization.VC__c != ''){
                strAllPriceCodes += priceAuthorization.VC__c+ ',';
            }
            if(priceAuthorization.VI__c != null && priceAuthorization.VI__c != ''){
                strAllPriceCodes += priceAuthorization.VI__c+ ',';
            }
            if(priceAuthorization.VE__c != null && priceAuthorization.VE__c != ''){
                strAllPriceCodes += priceAuthorization.VE__c+ ',';
            }
            if(priceAuthorization.VD__c != null && priceAuthorization.VD__c != ''){
                strAllPriceCodes += priceAuthorization.VD__c+ ',';
            }
            if(priceAuthorization.EC__c != null && priceAuthorization.EC__c != ''){
                strAllPriceCodes += priceAuthorization.EC__c+ ',';
            }
            if(priceAuthorization.EJ_SIO_Processor__c != null && priceAuthorization.EJ_SIO_Processor__c != ''){
                strAllPriceCodes += priceAuthorization.EJ_SIO_Processor__c+ ',';
            }
            if(priceAuthorization.iO__c != null && priceAuthorization.iO__c != ''){
                strAllPriceCodes += priceAuthorization.iO__c+ ',';
            }
            if(priceAuthorization.ED_veriCLASS_Readers__c != null && priceAuthorization.ED_veriCLASS_Readers__c != ''){
                strAllPriceCodes += priceAuthorization.ED_veriCLASS_Readers__c+ ',';
            }
            if(priceAuthorization.EP__c != null && priceAuthorization.EP__c != ''){
                strAllPriceCodes += priceAuthorization.EP__c+ ',';
            }
            if(priceAuthorization.EE_OMNIKEY_Reader_Board__c != null && priceAuthorization.EE_OMNIKEY_Reader_Board__c != ''){
                strAllPriceCodes += priceAuthorization.EE_OMNIKEY_Reader_Board__c+ ',';
            }
            if(priceAuthorization.LO__c != null && priceAuthorization.LO__c != ''){
                strAllPriceCodes += priceAuthorization.LO__c+ ',';
            }
            if(priceAuthorization.EI_Developer_Services_Plus__c != null && priceAuthorization.EI_Developer_Services_Plus__c != ''){
                strAllPriceCodes += priceAuthorization.EI_Developer_Services_Plus__c+ ',';
            }
            if(priceAuthorization.EF_OMNIKEY_Chipsets__c != null && priceAuthorization.EF_OMNIKEY_Chipsets__c != ''){
                strAllPriceCodes += priceAuthorization.EF_OMNIKEY_Chipsets__c+ ',';
            }
            if(priceAuthorization.EL_Embedded_Accessories__c != null && priceAuthorization.EL_Embedded_Accessories__c != ''){
                strAllPriceCodes += priceAuthorization.EL_Embedded_Accessories__c+ ',';
            }
            if(priceAuthorization.EG_SmartID_Reader_Boards__c != null && priceAuthorization.EG_SmartID_Reader_Boards__c != ''){
                strAllPriceCodes += priceAuthorization.EG_SmartID_Reader_Boards__c+ ',';
            }
            if(priceAuthorization.EK_iCLASS_SE_Reader_Modules__c != null && priceAuthorization.EK_iCLASS_SE_Reader_Modules__c != ''){
                strAllPriceCodes += priceAuthorization.EK_iCLASS_SE_Reader_Modules__c+ ',';
            }
            if(priceAuthorization.EH_identiCLASS_Readers__c != null && priceAuthorization.EH_identiCLASS_Readers__c != ''){
                strAllPriceCodes += priceAuthorization.EH_identiCLASS_Readers__c+ ',';
            }
            if(priceAuthorization.EA_ISO_Reader_Boards__c != null && priceAuthorization.EA_ISO_Reader_Boards__c != ''){
                strAllPriceCodes += priceAuthorization.EA_ISO_Reader_Boards__c+ ',';
            }
            if(priceAuthorization.FL_Asure_ID_Software__c != null && priceAuthorization.FL_Asure_ID_Software__c != ''){
                strAllPriceCodes += priceAuthorization.FL_Asure_ID_Software__c+ ',';
            }
            if(priceAuthorization.FM_SDK_S_W_Support__c != null && priceAuthorization.FM_SDK_S_W_Support__c != ''){
                strAllPriceCodes += priceAuthorization.FM_SDK_S_W_Support__c+ ',';
            }
            if(priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c != null && priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c != ''){
                strAllPriceCodes += priceAuthorization.FZ_Standard_Series_DTC1250e_Printers__c+ ',';
            }
            if(priceAuthorization.FN_Extended_Warranties__c != null && priceAuthorization.FN_Extended_Warranties__c != ''){
                strAllPriceCodes += priceAuthorization.FN_Extended_Warranties__c+ ',';
            }
            if(priceAuthorization.FX_Standard_Series_C50_Printers__c != null && priceAuthorization.FX_Standard_Series_C50_Printers__c != ''){
                strAllPriceCodes += priceAuthorization.FX_Standard_Series_C50_Printers__c+ ',';
            }
            if(priceAuthorization.FO_Cameras_Camera_S_W__c != null && priceAuthorization.FO_Cameras_Camera_S_W__c != ''){
            strAllPriceCodes += priceAuthorization.FO_Cameras_Camera_S_W__c+ ',';
            }
            if(priceAuthorization.FC_Print_Heads__c != null && priceAuthorization.FC_Print_Heads__c != ''){
                strAllPriceCodes += priceAuthorization.FC_Print_Heads__c+ ',';
            }
            if(priceAuthorization.FP_Photo_ID_Accessories__c != null && priceAuthorization.FP_Photo_ID_Accessories__c != ''){
                strAllPriceCodes += priceAuthorization.FP_Photo_ID_Accessories__c+ ',';
            }
            if(priceAuthorization.FQ_Spare_Parts_Packages__c != null && priceAuthorization.FQ_Spare_Parts_Packages__c != ''){
                strAllPriceCodes += priceAuthorization.FQ_Spare_Parts_Packages__c+ ',';
            }
            if(priceAuthorization.FR_Spare_Parts_Kits__c != null && priceAuthorization.FR_Spare_Parts_Kits__c != ''){
                strAllPriceCodes += priceAuthorization.FR_Spare_Parts_Kits__c+ ',';
            }
            if(priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c != null && priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c != ''){
                strAllPriceCodes += priceAuthorization.FY_Standard_C50_Regional_Ribbons_Only__c+ ',';
            }
            if(priceAuthorization.FS_Rewriteable_Cards__c != null && priceAuthorization.FS_Rewriteable_Cards__c != ''){
                strAllPriceCodes += priceAuthorization.FS_Rewriteable_Cards__c+ ',';
            }
            if(priceAuthorization.FF_Holo_Film_Overlams__c != null && priceAuthorization.FF_Holo_Film_Overlams__c != ''){
                strAllPriceCodes += priceAuthorization.FF_Holo_Film_Overlams__c+ ',';
            }
            if(priceAuthorization.FT_HDP8500_Printers__c != null && priceAuthorization.FT_HDP8500_Printers__c != ''){
                strAllPriceCodes += priceAuthorization.FT_HDP8500_Printers__c+ ',';
            }
            if(priceAuthorization.FG_Veri_Holo_OVD_Cards__c != null && priceAuthorization.FG_Veri_Holo_OVD_Cards__c != ''){
                strAllPriceCodes += priceAuthorization.FG_Veri_Holo_OVD_Cards__c+ ',';
            }
            if(priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c != null && priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c != ''){
                strAllPriceCodes += priceAuthorization.FU_Industrial_Series_Ribbons_HDP_Film__c+ ',';
            }
            if(priceAuthorization.FH_UltraCards__c != null && priceAuthorization.FH_UltraCards__c != ''){
                strAllPriceCodes += priceAuthorization.FH_UltraCards__c+ ',';
            }
            if(priceAuthorization.FV_Laser_Engravers__c != null && priceAuthorization.FV_Laser_Engravers__c != ''){
                strAllPriceCodes += priceAuthorization.FV_Laser_Engravers__c+ ',';
            }
            if(priceAuthorization.FK_HDPii_Printers__c != null && priceAuthorization.FK_HDPii_Printers__c != ''){
                strAllPriceCodes += priceAuthorization.FK_HDPii_Printers__c+ ',';
            }
            if(priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c != null && priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c != ''){
                strAllPriceCodes += priceAuthorization.FW_Financial_Series_Ribbons_HDP_Film__c+ ',';
            }
            if(priceAuthorization.FA_Prof_Printers__c != null && priceAuthorization.FA_Prof_Printers__c != ''){
                strAllPriceCodes += priceAuthorization.FA_Prof_Printers__c+ ',';
            }
            if(priceAuthorization.FB_Entry_Level_Printers__c != null && priceAuthorization.FB_Entry_Level_Printers__c != ''){
                strAllPriceCodes += priceAuthorization.FB_Entry_Level_Printers__c+ ',';
            }
            if(priceAuthorization.FD_Ribbons_Clear_Film__c != null && priceAuthorization.FD_Ribbons_Clear_Film__c != ''){
                strAllPriceCodes += priceAuthorization.FD_Ribbons_Clear_Film__c+ ',';
            }
            if(priceAuthorization.FE_Entry_Level_Ribbons__c != null && priceAuthorization.FE_Entry_Level_Ribbons__c != ''){
                strAllPriceCodes += priceAuthorization.FE_Entry_Level_Ribbons__c+ ',';
            }
            if(priceAuthorization.PS_Professional_Services__c != null && priceAuthorization.PS_Professional_Services__c != ''){
                strAllPriceCodes += priceAuthorization.PS_Professional_Services__c+ ',';
            }
            if(priceAuthorization.AA__c != null && priceAuthorization.AA__c != ''){
                strAllPriceCodes += priceAuthorization.AA__c+ ',';
            }
            if(priceAuthorization.AF__c != null && priceAuthorization.AF__c != ''){
                strAllPriceCodes += priceAuthorization.AF__c+ ',';
            }
            if(priceAuthorization.AB__c != null && priceAuthorization.AB__c != ''){
                strAllPriceCodes += priceAuthorization.AB__c+ ',';
            }
            if(priceAuthorization.AL__c != null && priceAuthorization.AL__c != ''){
                strAllPriceCodes += priceAuthorization.AL__c+ ',';
            }
            if(priceAuthorization.AH__c != null && priceAuthorization.AH__c != ''){
                strAllPriceCodes += priceAuthorization.AH__c+ ',';
            }
            if(priceAuthorization.AZ__c != null && priceAuthorization.AZ__c != ''){
                strAllPriceCodes += priceAuthorization.AZ__c+ ',';
            }
            if(priceAuthorization.AE__c != null && priceAuthorization.AE__c != ''){
                strAllPriceCodes += priceAuthorization.AE__c+ ',';
            }
            if(priceAuthorization.iM_HID_Mobile_Access__c != null && priceAuthorization.iM_HID_Mobile_Access__c != ''){
                strAllPriceCodes += priceAuthorization.iM_HID_Mobile_Access__c+ ',';
            }
            if(priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c != null && priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c != ''){
                strAllPriceCodes += priceAuthorization.CP_Custom_Special_Products_w_o_Discount__c+ ',';
            }
            if(priceAuthorization.AD__c != null && priceAuthorization.AD__c != ''){
                strAllPriceCodes += priceAuthorization.AD__c+ ',';
            }
            if(priceAuthorization.AG__c != null && priceAuthorization.AG__c != ''){
                strAllPriceCodes += priceAuthorization.AG__c+ ',';
            }
            if(priceAuthorization.AI__c != null && priceAuthorization.AI__c != ''){
                strAllPriceCodes += priceAuthorization.AI__c+ ',';
            }
            if(priceAuthorization.AJ__c != null && priceAuthorization.AJ__c  != ''){
                strAllPriceCodes += priceAuthorization.AJ__c+ ',';
            }          
            
            priceAuthorization.Integration_Price_Codes__c = strAllPriceCodes;
            lstPAFUpdate.add(priceAuthorization);
        }
        if(!lstPAFUpdate.isEmpty()){
            update lstPAFUpdate;
        } 
    }   
   
    
    global void finish(Database.BatchableContext BC) {
       
    }    
   
}