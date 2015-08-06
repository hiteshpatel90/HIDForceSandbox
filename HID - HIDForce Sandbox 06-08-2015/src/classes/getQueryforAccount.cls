//  This class is used to get Price Codes for all the fields on Account object for
//  New, Edit & Clone PAF VSF pages.

public class getQueryforAccount{
    public String query = '';
    
    public String getQuery(){
        
        query = 'SELECT iR__c,MS__c,AA__c, AD__c, AG__c, AI__c, AJ__c, AF__c,AB__c,AL__c, AK__c, AM__c, AN__c, AH__c, AZ__c,AE__c,iC__c,SL__c,iD__c,VS__c,iP__c,LV__c,MC__c,LW_Indala_Credenitals__c,MD__c,IB__c,ME__c,PI__c,MF__c,iE_pivCLASS_Modules_Software__c,RA__c,iJ_pivCLASS_Modules_Software__c,RB__c,iF_pivCLASS_Kits__c,iK_pivCLASS_Mobile_Handheld_Readers__c'+
                       ',RC__c,iH_pivCLASS_Bundles__c,RD__c,EZ_EasyLobby__c,RE__c,AC__c,PC__c,OL__c,LC__c,LR__c,EB_Embeddable_Credentials__c,IoD__c,VX__c,VC__c,VI__c,VE__c,VD__c,EC__c,EJ_SIO_Processor__c,iO__c,ED_veriCLASS_Readers__c'+
                       ',EP__c,EE_OMNIKEY_Reader_Board__c,LO__c,EF_OMNIKEY_Chipsets__c,EL_Embedded_Accessories__c,EG_SmartID_Reader_Boards__c,EK_iCLASS_SE_Reader_Modules__c,EH_identiCLASS_Readers__c,EA_ISO_Reader_Boards__c,EI_Developer_Services_Plus__c'+
                       ',FL_Asure_ID_Software__c,FM_SDK_S_W_Support__c,FZ_Standard_Series_DTC1250e_Printers__c,FN_Extended_Warranties__c,FX_Standard_Series_C50_Printers__c,FO_Cameras_Camera_S_W__c,FC_Print_Heads__c,FP_Photo_ID_Accessories__c,FQ_Spare_Parts_Packages__c'+
                       ',FR_Spare_Parts_Kits__c,FY_Standard_C50_Regional_Ribbons_Only__c,FS_Rewriteable_Cards__c,FF_Holo_Film_Overlams__c,FT_HDP8500_Printers__c,FG_Veri_Holo_OVD_Cards__c,FU_Industrial_Series_Ribbons_HDP_Film__c,FH_UltraCards__c,FV_Laser_Engravers__c'+
                       ',FK_HDPii_Printers__c,FW_Financial_Series_Ribbons_HDP_Film__c,FA_Prof_Printers__c,FB_Entry_Level_Printers__c,FD_Ribbons_Clear_Film__c,FE_Entry_Level_Ribbons__c,PS_Professional_Services__c,iM_HID_Mobile_Access__c,CP_Custom_Special_Products_w_o_Discount__c FROM Account WHERE id =:';
        return query;    
    }
}