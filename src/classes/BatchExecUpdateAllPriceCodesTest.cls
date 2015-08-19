@istest
public class BatchExecUpdateAllPriceCodesTest{
    Private Static testmethod void mytestMethod(){
        Account account = new Account(Name = 'Test Account', Channel__c = 'Test Channel', BillingCountry = 'India', BillingState = 'Assam', E_21_Account__c='No',Sub_Region__c =Null, Oracle_Customer_Number__c = Null);insert account;
    
        Contact con = new Contact(FirstName = 'FirstName', LastName = 'LastName', AccountId = account.id, Pricing_Notifications__c = 'No');   
    
        Price_Authorization_Form_Code__c pafc = new Price_Authorization_Form_Code__c(Price_Code__c = 'FA_Prof_Printers__c', Display_Value__c = 'FA55 Gold', Submit_Value__c = 'FA55');                             
        insert pafc; 
          
        Price_Authorization_Form__c paf = new Price_Authorization_Form__c(Account__c = account.id,iR__c = 'iR45', New_HID_Customer__c = 'No', Key_Contact__c = con.Id,L2_Approver__c =UserInfo.getUserId(), Pricing_Effective_Date__c = System.Today(),FA_Prof_Printers__c = 'FA55', FB_Entry_Level_Printers__c = 'FB52');
        paf.MS__c = 'FB52';
        paf.iC__c = 'FB52';
        paf.iD__c = 'FB52';
        paf.VS__c = 'FB52';
        paf.iP__c = 'FB52';
        paf.LV__c = 'FB52';
        paf.MC__c = 'FB52';
        paf.LW_Indala_Credentials__c = 'FB52';
        paf.MD__c = 'FB52';
        paf.ME__c = 'FB52';
        paf.MF__c = 'FB52';
        paf.iE_pivCLASS_Modules_Software__c = 'FB52';
        paf.RA__c = 'FB52';
        paf.iJ_pivCLASS_Modules_Software__c = 'FB52';
        paf.RB__c = 'FB52';
        paf.iF_pivCLASS_Kits__c = 'FB52';
        paf.RC__c = 'FB52';
        paf.iH_pivCLASS_Bundles__c = 'FB52';
        paf.iK_pivCLASS_Mobile_Handheld_Readers__c = 'FB52';
        paf.RD__c = 'FB52';
        paf.EZ_EasyLobby__c = 'FB52';
        paf.RE__c = 'FB52';
        paf.AC__c = 'FB52';
        paf.PC__c = 'FB52';
        paf.OL__c = 'FB52';
        paf.LC__c = 'FB52';
        paf.LR__c = 'FB52';
        paf.EB_Embeddable_Credentials__c = 'FB52';
        paf.IoD__c = 'FB52';
        paf.VX__c = 'FB52';
        paf.VC__c = 'FB52';
        paf.VI__c = 'FB52';
        paf.VE__c = 'FB52';
        paf.VD__c = 'FB52';
        paf.EC__c = 'FB52';
        paf.EJ_SIO_Processor__c = 'FB52';
        paf.iO__c = 'FB52';
        paf.ED_veriCLASS_Readers__c = 'FB52';
        paf.EP__c = 'FB52';
        paf.EE_OMNIKEY_Reader_Board__c = 'FB52';
        paf.LO__c = 'FB52';
        paf.EI_Developer_Services_Plus__c = 'FB52';
        paf.EF_OMNIKEY_Chipsets__c = 'FB52';
        paf.EL_Embedded_Accessories__c = 'FB52';
        paf.EG_SmartID_Reader_Boards__c = 'FB52';
        paf.EK_iCLASS_SE_Reader_Modules__c = 'FB52';
        paf.EH_identiCLASS_Readers__c = 'FB52';
        paf.EA_ISO_Reader_Boards__c = 'FB52';
        paf.FL_Asure_ID_Software__c = 'FB52';
        paf.FM_SDK_S_W_Support__c = 'FB52';
        paf.FZ_Standard_Series_DTC1250e_Printers__c = 'FB52';
        paf.FN_Extended_Warranties__c = 'FB52';
        paf.FX_Standard_Series_C50_Printers__c = 'FB52';
        paf.FO_Cameras_Camera_S_W__c = 'FB52';
        paf.FC_Print_Heads__c = 'FB52';
        paf.FP_Photo_ID_Accessories__c = 'FB52';
        paf.FQ_Spare_Parts_Packages__c = 'FB52';
        paf.FR_Spare_Parts_Kits__c = 'FB52';
        paf.FY_Standard_C50_Regional_Ribbons_Only__c = 'FB52';
        paf.FS_Rewriteable_Cards__c = 'FB52';
        paf.FF_Holo_Film_Overlams__c = 'FB52';
        paf.FT_HDP8500_Printers__c = 'FB52';
        paf.FG_Veri_Holo_OVD_Cards__c = 'FB52';
        paf.FU_Industrial_Series_Ribbons_HDP_Film__c = 'FB52';
        paf.FH_UltraCards__c = 'FB52';
        paf.FV_Laser_Engravers__c = 'FB52';
        paf.FK_HDPii_Printers__c = 'FB52';
        paf.FW_Financial_Series_Ribbons_HDP_Film__c = 'FB52';
        paf.FA_Prof_Printers__c = 'FA55';
        paf.FD_Ribbons_Clear_Film__c = 'FB52';
        paf.FE_Entry_Level_Ribbons__c = 'FB52';
        paf.PS_Professional_Services__c = 'FB52';
        paf.AA__c = 'FB52';
        paf.AF__c = 'FB52';
        paf.AB__c = 'FB52';
        paf.AL__c = 'FB52';
        paf.AH__c = 'FB52';
        paf.AZ__c = 'FB52';
        paf.AE__c = 'FB52';
        paf.iM_HID_Mobile_Access__c = 'FB52';
        paf.CP_Custom_Special_Products_w_o_Discount__c = 'FB52';
        paf.AD__c = 'FB52';
        paf.AG__c = 'FB52';
        paf.AI__c = 'FB52';
        paf.AJ__c = 'FB52';        
        insert paf;
    
        String sQuery= getQueryString('Price_Authorization_Form__c');
        BatchExecUpdateAllPriceCodes batchApex = new BatchExecUpdateAllPriceCodes(sQuery);
        //ID batchprocessid
        Database.executeBatch(batchApex,10); 
    }
    Private Static String getQueryString(String objectName){
        Map<String, Schema.SObjectType> objMap = new Map<String, Schema.SObjectType>();
        objMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = objMap.get(objectName).getDescribe().fields.getMap();
        string queryString = 'select Account__r.BillingCountry,';
        for(Schema.SObjectField field :fieldMap.values()){
            queryString = queryString + field.getDescribe().getName() + ', ';
        }
        queryString = queryString.substring(0,queryString.length() - 2);
        queryString = queryString + ' from ' + objectName;
        return queryString;
    }
}