/*  Extention Controller class to populate CPO Opportunity Item objects field values.
    Author: JadeGlobal  Date: 1/5/2015
*/

public with sharing class addCPOItemsExtension{

    public Opportunity objOpp {get; set;}
    public string intRowNos;
    integer intRowNo;
    public List<cpoStandardProdWrapper> lstCPOStandardProductWrapper {get; set;}
    public List<CPO_Standard_Product__c> lstCPOStandardProduct;
    public List<cpoCustomProdWrapper> lstCPOSCustomProductWrapper {get; set;}
    public boolean isBOMCostVisible {get; set;}
    public boolean isBOMCostReadOnly {get; set;}
    
    public boolean isPageLoadFirst {get;set;}
    
    public boolean isEuroCurrency {get;set;}
    // Constructor method to initialize variables.
    public addCPOItemsExtension(ApexPages.StandardController controller){
        isPageLoadFirst = true;
        isBOMCostVisible = false;
        isBOMCostReadOnly = false;
        isEuroCurrency = false;
        Id profileId=userinfo.getProfileId();
        
        String user_locale = UserInfo.getLocale();
        if(user_locale.touppercase().contains('EURO')){
            isEuroCurrency = true;
        }
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
        
        List<PermissionSet> lstPermissionSet = [select id, Name from PermissionSet where name = 'CPO_Opportunity_Modify_All'];
        if(!lstPermissionSet.isEmpty()){
            List<PermissionSetAssignment> lstPermissionSetAssignment = [select id, AssigneeId from PermissionSetAssignment where PermissionSetId =: lstPermissionSet[0].id and AssigneeId =: system.userinfo.getuserid()];
            if(!lstPermissionSetAssignment.isEmpty()){
                isBOMCostVisible = true;
            }
        }
        if(profileName == 'HID Engineering User' || profileName == 'HID Product Marketing' || profileName == 'HID Business Administrator' || profileName == 'HID Business Administrator Modify All Data' || profileName == 'System Administrator'){
            isBOMCostVisible = true;
        }
        
        if(profileName == 'HID Finance & Ops User' || profileName == 'HID Pricing Admin'){
            isBOMCostReadOnly = true;
        }
        lstCPOStandardProductWrapper = new List<cpoStandardProdWrapper>();
        lstCPOSCustomProductWrapper = new List<cpoCustomProdWrapper>();
        
        objOpp = (Opportunity)controller.getRecord();
        lstCPOStandardProduct = [select id, Name, Total_Revenue__c, Total_Volume__c, Product__c, Description__c, Product__r.Description,Product__r.isActive,
                                 (select id, CPO_Standard_Product__c, Description__c, BOM_Cost__c, NRE_Estimate__c, Effort_Days__c, Est_Days_to_Implement__c, Customization_Item__c                                                                  
                                  from CPO_Customization_Items__r order by createddate desc),    
                                                                 Y1Q1_Price__c, Y1Q1_Revenue__c, Y1Q1_Volume__c, Y1Q2_Price__c, Y1Q2_Revenue__c, Y1Q2_Volume__c, Y1Q3_Price__c, 
                                                                Y1Q3_Revenue__c, Y1Q3_Volume__c, Y1Q4_Price__c, Y1Q4_Revenue__c, Y1Q4_Volume__c, Year1_Revenue__c, Year1_Price__c,Year1_Volume__c, Year2_Price__c, 
                                                                Year2_Revenue__c, Year2_Volume__c, Year3_Price__c, Year3_Revenue__c, Year3_Volume__c from CPO_Standard_Product__c where Opportunity__c =: objOpp.id];
        
        cpoStandardProdWrapper objcpoStandardProdWrapper;
        cpoCustomProdWrapper objcpoCustomProdWrapper;
        for(CPO_Standard_Product__c cpoStd: lstCPOStandardProduct){
            lstCPOSCustomProductWrapper = new List<cpoCustomProdWrapper>();
             if(cpoStd.CPO_Customization_Items__r != null){
                 for(CPO_Opportunity_Items__c cpoCust: cpoStd.CPO_Customization_Items__r){
                     objcpoCustomProdWrapper = new cpoCustomProdWrapper();
                     objcpoCustomProdWrapper.objCPOCustom = cpoCust;
                     
                     lstCPOSCustomProductWrapper.add(objcpoCustomProdWrapper);
                 }
            }
            objcpoStandardProdWrapper = new cpoStandardProdWrapper();
            objcpoStandardProdWrapper.isDisplayRow = true;
            objcpoStandardProdWrapper.objCPOStandard = cpoStd;
            objcpoStandardProdWrapper.decTotalRevenue = cpoStd.Total_Revenue__c;
            objcpoStandardProdWrapper.decTotalVolume =  cpoStd.Total_Volume__c;
            objcpoStandardProdWrapper.decYear1Revenue = cpoStd.Year1_Revenue__c;
            objcpoStandardProdWrapper.strProductDescription = cpoStd.Product__r.description;
            objcpoStandardProdWrapper.lstCustomizationItem = getCustomizationItem();
            objcpoStandardProdWrapper.lstCPOCustomItemWrapper=lstCPOSCustomProductWrapper;
            lstCPOStandardProductWrapper.add(objcpoStandardProdWrapper);
            System.debug( objcpoStandardProdWrapper.lstCPOCustomItemWrapper);
        }
        
       
    }
    //
    public List<SelectOption> getCustomizationItem() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-- None --'));
        if(objOpp.Business_Segment__c == 'Animal ID' || objOpp.Business_Segment__c == 'Cards and Inlays' || objOpp.Business_Segment__c == 'Industry and Logistics'){
            options.add(new SelectOption('Chip','Chip'));
            options.add(new SelectOption('Color','Color'));
            options.add(new SelectOption('Encoding','Encoding'));
            options.add(new SelectOption('Hardware','Hardware'));
            options.add(new SelectOption('Label','Label'));
            options.add(new SelectOption('Logo','Logo'));
            options.add(new SelectOption('New Product Design','New Product Design'));
            options.add(new SelectOption('Other','Other'));
            options.add(new SelectOption('Packaging','Packaging'));
            options.add(new SelectOption('Tuning','Tuning'));
            
        }else if(objOpp.Business_Segment__c == 'PACS' || objOpp.Business_Segment__c == 'Secure Issuance' || objOpp.Business_Segment__c == 'Identity Assurance' || objOpp.Business_Segment__c == 'Connect'){
            options.add(new SelectOption('Antenna','Antenna'));
            options.add(new SelectOption('Driver','Driver'));
            options.add(new SelectOption('Firmware','Firmware'));
            options.add(new SelectOption('Hardware','Hardware'));
            options.add(new SelectOption('Label','Label'));
            options.add(new SelectOption('Logo','Logo'));
            options.add(new SelectOption('Other','Other'));
            options.add(new SelectOption('Output','Output'));
            options.add(new SelectOption('Packaging','Packaging'));
            options.add(new SelectOption('Protocol','Protocol'));            
            options.add(new SelectOption('Software','Software'));
            options.add(new SelectOption('Tuning','Tuning'));
                       
        }else if(objOpp.Business_Segment__c == 'Government ID'){
            options.add(new SelectOption('Artwork','Artwork'));
            options.add(new SelectOption('Chip','Chip'));
            options.add(new SelectOption('Construction','Construction'));
            options.add(new SelectOption('Layout','Layout'));
            options.add(new SelectOption('Operating System ','Operating System '));
            options.add(new SelectOption('Other','Other'));
            options.add(new SelectOption('Security Features','Security Features'));
            options.add(new SelectOption('Software','Software'));
        }
        
        return options;
    }
        
        
    // Method to add CPO items attribute to the visualforce page. 
    public void addCustomProduct(){
        Integer index = integer.valueof(apexpages.currentpage().getparameters().get('cpoRecordIndex'));
        
        string strStandardProduct = apexpages.currentpage().getparameters().get('stdProd');
        CPO_Opportunity_Items__c objCPOItem = new CPO_Opportunity_Items__c();
        if(strStandardProduct!=null && strStandardProduct!= ''){
            objCPOItem.CPO_Standard_Product__c = strStandardProduct;
        }
        cpoCustomProdWrapper objcpoCustomProdWrapper = new cpoCustomProdWrapper();
        
        objcpoCustomProdWrapper.objCPOCustom = objCPOItem;
        if(lstCPOStandardProductWrapper[index-1].lstCPOCustomItemWrapper == null){
            lstCPOStandardProductWrapper[index-1].lstCPOCustomItemWrapper = new List<cpoCustomProdWrapper>();
        }
        lstCPOStandardProductWrapper[index-1].lstCPOCustomItemWrapper.add(objcpoCustomProdWrapper);
        
    }
    
    // Method to add CPO standard items attribute to the visualforce page. 
    public void addStandardProduct(){
        CPO_Standard_Product__c objStdProd = new CPO_Standard_Product__c();
        objStdProd.Opportunity__c = objOpp.id;
        
        cpoStandardProdWrapper objcpoStandardProdWrapper = new cpoStandardProdWrapper();
        objcpoStandardProdWrapper.isDisplayRow = true;
        objcpoStandardProdWrapper.objCPOStandard = objStdProd;
        objcpoStandardProdWrapper.decTotalRevenue = 0.00;
        objcpoStandardProdWrapper.decTotalVolume = 0.00;
        objcpoStandardProdWrapper.decYear1Revenue = 0.00;
        objcpoStandardProdWrapper.lstCustomizationItem = getCustomizationItem();
        lstCPOStandardProductWrapper.add(objcpoStandardProdWrapper);
        
        integer index = lstCPOStandardProductWrapper.size();
        cpoCustomProdWrapper objcpoCustomProdWrapper = new cpoCustomProdWrapper();
        CPO_Opportunity_Items__c objCPOItem = new CPO_Opportunity_Items__c();
        objcpoCustomProdWrapper.objCPOCustom = objCPOItem;
        if(lstCPOStandardProductWrapper[index-1].lstCPOCustomItemWrapper == null){
            lstCPOStandardProductWrapper[index-1].lstCPOCustomItemWrapper = new List<cpoCustomProdWrapper>();
        }
        lstCPOStandardProductWrapper[index-1].lstCPOCustomItemWrapper.add(objcpoCustomProdWrapper);
        
    }
    public PageReference saveProducts(){
        //cpoStandardProdWrapper objcpoStandardProdWrapper = new cpoStandardProdWrapper();
       // insert objcpoStandardProdWrapper.objCPOStandard ;

       List<CPO_Standard_Product__c> lstCPOStandardProductUpsert = new List<CPO_Standard_Product__c>();
       List<CPO_Opportunity_Items__c> lstCPOCustomProductUpsert = new List<CPO_Opportunity_Items__c>();
        set<id> product2idSet = new set<id>();
        for(cpoStandardProdWrapper cpowr :lstCPOStandardProductWrapper ){
            product2idSet.add(cpowr.objCPOStandard.product__c);
        }
        string strPricebook2Id = objOpp.Pricebook2Id;
        system.debug('########=objOpp.Pricebook2Id#'+objOpp.Pricebook2Id);
        if(objOpp.Pricebook2Id == null || string.valueOf(objOpp.Pricebook2Id) == ''){
            List<Pricebook2> lstPricebook2 = [select id, isActive from Pricebook2 where isActive = true];
            system.debug('########=objOpp.Pricebook2Id#'+objOpp.Pricebook2Id);
            if(lstPricebook2.size() > 0){
                system.debug('########=============lstPricebook2========#'+lstPricebook2);
                Opportunity objOppUpdate = new Opportunity(id=objOpp.id);
                objOppUpdate.Pricebook2Id = lstPricebook2[0].id;
                update objOppUpdate;
                strPricebook2Id = lstPricebook2[0].id;
            }
        }
        
          system.debug('########=============CURRENCY========#'+objOpp.CurrencyIsoCode);
       //List<product2> productList = [select id,isActive,Name from product2 where id in:product2idSet];
        List<product2> productList = [select id, name,isActive, (select id from PricebookEntries where IsActive = true and CurrencyIsoCode =: objOpp.CurrencyIsoCode and Pricebook2id=: strPricebook2Id) from product2 where id in:product2idSet];
        for(product2 pd:productList){
             system.debug('#########'+pd.PricebookEntries);
            system.debug('pd.PricebookEntries.size()'+pd.PricebookEntries.size());
            if(!pd.isActive || pd.PricebookEntries.size() == 0){
               PageReference pg = apexPages.currentPage();
               ApexPages.Message msg=new ApexPages.Message(ApexPages.Severity.Error,'You can\'t select this Product because it is for different Currency Code :- ' + pd.Name + '.');
               ApexPages.addMessage(msg);
               return pg;
            }
        }
       system.debug('@@@@@@@@@'+lstCPOStandardProductWrapper);
       for(cpoStandardProdWrapper cpowr :lstCPOStandardProductWrapper ){
           System.debug('cpowr@@@@@@@@@@@'+cpowr);
           
           system.debug(cpowr.objCPOStandard.product__c);
           System.debug(cpowr.objCPOStandard.product__r.isActive);
           product2 pd = new product2();
           pd.id=cpowr.objCPOStandard.product__c;
           system.debug(pd.id);
           system.debug(pd.isActive);
           String name=pd.ProductCode;
           //if(pd.isActive){
               system.debug('inside if');
               cpowr.objCPOStandard.currencyisocode= objOpp.CurrencyIsoCode;
               lstCPOStandardProductUpsert.add(cpowr.objCPOStandard);
           //}
           
           /*else{
               system.debug('inside else');
               PageReference pg = apexPages.currentPage();
               //ApexPages.Message msg=new ApexPages.Message(ApexPages.Severity.Error,'The Product you selected is inActive, Please select an Active product');
               //ApexPages.addMessage(msg);
               //return pg;
           } */         
       }
       if(!lstCPOStandardProductUpsert.isEmpty()){
           upsert lstCPOStandardProductUpsert;
       }
       
       
       for(cpoStandardProdWrapper cpowr :lstCPOStandardProductWrapper ){               
           if(cpowr.lstCPOCustomItemWrapper != null){
               for(cpoCustomProdWrapper cpoCustWrap: cpowr.lstCPOCustomItemWrapper){
                   //cpoCustWrap.objCPOCustom.CPO_Standard_Product__c = cpowr.objCPOStandard.id;
                   if(cpoCustWrap.objCPOCustom.CPO_Standard_Product__c != null){
                       system.debug('########'+ cpoCustWrap.objCPOCustom.CPO_Standard_Product__c);
                       lstCPOCustomProductUpsert.add(cpoCustWrap.objCPOCustom);
                   }else{
                       system.debug('@@@@@@@@@'+ cpowr.objCPOStandard.id);
                       cpoCustWrap.objCPOCustom.CPO_Standard_Product__c = cpowr.objCPOStandard.id;
                       lstCPOCustomProductUpsert.add(cpoCustWrap.objCPOCustom);
                   }
               }
           }
       }
       
       system.debug('@@@@@@@@@'+ lstCPOCustomProductUpsert.size());
       system.debug('@@@@@@@@@'+ lstCPOCustomProductUpsert);
       if(!lstCPOCustomProductUpsert.isEmpty()){
           upsert lstCPOCustomProductUpsert;
       }
       //PageReference pg = apexPages.currentPage();
       //ApexPages.Message msg=new ApexPages.Message(ApexPages.Severity.CONFIRM,'Record Saved Successfully.Thank you!');
       //ApexPages.addMessage(msg);
       //return pg;
       return null;
    }
    public void updateStandardProduct(){
    
        System.debug('updateStandardProduct');
        // calculate total revenue
        decimal decyear2Revenue = 0.00;
        decimal decyear3Revenue = 0.00; 
        decimal decY1Q1Revenue = 0.00;
        decimal decY1Q2Revenue = 0.00;
        decimal decY1Q3Revenue = 0.00;
        decimal decY1Q4Revenue = 0.00;
        
        Integer index = integer.valueof(apexpages.currentpage().getparameters().get('cpoRecordIndex'));
      
        List<CPO_Standard_Product__c> lstCPOStandard = [select id, Product__c from CPO_Standard_Product__c where Opportunity__c =: objOpp.id and Product__c =: lstCPOStandardProductWrapper[index-1].objCPOStandard.Product__c];
        if(lstCPOStandard.size() > 0 && lstCPOStandardProductWrapper[index-1].objCPOStandard.id != lstCPOStandard[0].id){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.WARNING,'This Product already exists. Please select another Product.');
            ApexPages.addMessage(myMsg);
        }else{
        
            List<Product2> lstSelProd2 = [select description from product2 where id =: lstCPOStandardProductWrapper[index-1].objCPOStandard.Product__c];
            if(lstSelProd2.size() > 0){
                String strdescription= lstSelProd2[0].description;        
                lstCPOStandardProductWrapper[index-1].strProductDescription = strdescription;
                
                
            }else{
                lstCPOStandardProductWrapper[index-1].strProductDescription='';
            }
            
            
            //This will calculate Total Revenue of Standard CPO Product
            
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Year2_Price__c!=null 
               && lstCPOStandardProductWrapper[index-1].objCPOStandard.Year2_Volume__c!=null ){
                decyear2Revenue = lstCPOStandardProductWrapper[index-1].objCPOStandard.Year2_Price__c * lstCPOStandardProductWrapper[index-1].objCPOStandard.Year2_Volume__c;
            }
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Year3_Price__c!=null 
               && lstCPOStandardProductWrapper[index-1].objCPOStandard.Year3_Volume__c!=null){
                decyear3Revenue = lstCPOStandardProductWrapper[index-1].objCPOStandard.Year3_Price__c * lstCPOStandardProductWrapper[index-1].objCPOStandard.Year3_Volume__c;
            }
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q1_Price__c!=null
                    && lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q1_Volume__c!=null){
                decY1Q1Revenue = lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q1_Price__c * lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q1_Volume__c;
                    
            }
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q2_Price__c!=null
                    && lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q2_Volume__c!=null){
                decY1Q2Revenue = lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q2_Price__c * lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q2_Volume__c;
            }
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q3_Price__c!=null
                    && lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q3_Volume__c!=null){
                decY1Q3Revenue = lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q3_Price__c * lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q3_Volume__c;
                    
            }
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q4_Price__c!=null
                    && lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q4_Volume__c!=null){
                decY1Q4Revenue = lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q4_Price__c * lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q4_Volume__c;
            }
            
           
            lstCPOStandardProductWrapper[index-1].decTotalRevenue = decyear2Revenue + decyear3Revenue + decY1Q1Revenue + decY1Q2Revenue + decY1Q3Revenue + decY1Q4Revenue;
            
            lstCPOStandardProductWrapper[index-1].decYear1Revenue = decY1Q1Revenue + decY1Q2Revenue + decY1Q3Revenue + decY1Q4Revenue;
           
            System.debug(lstCPOStandardProductWrapper[index-1].decTotalRevenue);
           
            // calculate total volume        
            decimal decYear1Volume = 0.00;
            decimal decYear2Volume = 0.00; 
            decimal decYear3volume = 0.00;
            
             
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q1_Volume__c != null){
                decYear1Volume += lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q1_Volume__c;
            }
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q2_Volume__c != null){
                decYear1Volume += lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q2_Volume__c;
            }
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q3_Volume__c != null){
                decYear1Volume += lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q3_Volume__c;
            }
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q4_Volume__c != null){
                decYear1Volume += lstCPOStandardProductWrapper[index-1].objCPOStandard.Y1Q4_Volume__c;
            }
            
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Year2_Volume__c != null){
                decYear2Volume = lstCPOStandardProductWrapper[index-1].objCPOStandard.Year2_Volume__c;
            }
            if(lstCPOStandardProductWrapper[index-1].objCPOStandard.Year3_Volume__c != null){
                decYear3volume = lstCPOStandardProductWrapper[index-1].objCPOStandard.Year3_Volume__c;
            }
            lstCPOStandardProductWrapper[index-1].decTotalVolume = decYear1Volume + decYear2Volume + decYear3volume;
            try{
                saveProducts();
            }catch (exception ex){
                //ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getmessage());
                //ApexPages.addMessage(myMsg);
            }
        }
    }
    
    public void updateCustomProduct(){
        Integer index = integer.valueof(apexpages.currentpage().getparameters().get('cpoRecordIndex'));
        Integer indexCustomCPO = integer.valueof(apexpages.currentpage().getparameters().get('cpoRecordCustIndex'));
        
        try{
            saveProducts();
        }catch (exception ex){
            //ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getmessage());
            //ApexPages.addMessage(myMsg);
        }
       
    }
    
    public void callonPageLoad(){
        isPageLoadFirst = false;
        
    }
    public void displayRowVariable(){
        //strDisplayRow = '';
        Integer index = integer.valueof(apexpages.currentpage().getparameters().get('cpoRecordIdIndex'));
        string strDisplayValue = apexpages.currentpage().getparameters().get('displayVal');
        
        if(strDisplayValue == 'none'){
            lstCPOStandardProductWrapper[index-1].isDisplayRow = false;
        }else{
            lstCPOStandardProductWrapper[index-1].isDisplayRow = true;
        }
        
    }
    
    public class cpoStandardProdWrapper{
        public CPO_Standard_Product__c objCPOStandard {get; set;}        
        public List<cpoCustomProdWrapper> lstCPOCustomItemWrapper {get; set;}
        public List<SelectOption> lstCustomizationItem {get; set;}
        public boolean isDisplayRow {get; set;}
        public String strProductDescription{get;set;}
        public decimal decTotalRevenue {get;set;}
        public decimal decTotalVolume {get;set;}
        public decimal decYear1Revenue {get;set;}
    }
    
    public class cpoCustomProdWrapper{
        public CPO_Opportunity_Items__c objCPOCustom {get; set;}
        
    }
    
    //deletes standard CPO product
    public void deleteCPOStandardProduct(){
        Integer index = integer.valueof(apexpages.currentpage().getparameters().get('cpoRecordIndex'));
        CPO_Standard_Product__c objCPOStandardDelete = new CPO_Standard_Product__c();
        if(lstCPOStandardProductWrapper[index-1].objCPOStandard.id!=null){
            objCPOStandardDelete = lstCPOStandardProductWrapper[index-1].objCPOStandard;
            delete objCPOStandardDelete ;
        }
        
        lstCPOStandardProductWrapper.remove(index-1);
        system.debug('lstCPOStandardProductWrapper'+lstCPOStandardProductWrapper);
        }
        
    //deletes custom CPO product
    public void deleteCPOcustomProduct(){
        Integer index = integer.valueof(apexpages.currentpage().getparameters().get('cpoRecordIndex'));
        Integer indexCustomCPO = integer.valueof(apexpages.currentpage().getparameters().get('cpoRecordCustIndex'));
        
        CPO_Opportunity_Items__c objCPOCustomDelete = new CPO_Opportunity_Items__c();
         
        System.debug( lstCPOStandardProductWrapper[index-1]);
        System.debug(indexCustomCPO );
        
        if(lstCPOStandardProductWrapper[index-1].lstCPOCustomItemWrapper[indexCustomCPO].objCPOCustom.id !=null){
            objCPOCustomDelete = lstCPOStandardProductWrapper[index-1].lstCPOCustomItemWrapper[indexCustomCPO].objCPOCustom;
            delete objCPOCustomDelete;
           
         }
         lstCPOStandardProductWrapper[index-1].lstCPOCustomItemWrapper.remove(indexCustomCPO);
    }
}