public class extCasedetailEdit {
    public boolean isCaseEdit {get; set;}
    public boolean isCaseNew {get; set;}
    public boolean isLaserCardRecType {get; set;}
    public boolean isPAERecType {get; set;}
    public boolean isRCNHRecType {get; set;}
    public boolean isCustService {get; set;}
    public boolean ispivCLASS {get; set;}
    public boolean isActivIDRecType {get; set;} 
    
    public string strCaseId {get; set;}
    public case objCase {get; set;}
    public CaseComment objCaseComment {get; set;}
    public string strAccName {get; set;}
    
    public boolean isProductAsure {get; set;}
    public boolean isProductEasyLobby {get; set;}
    public boolean isProductPrinters {get; set;}
    public extCasedetailEdit(ApexPages.StandardController controller) {
        isCaseEdit = false;
        isCaseNew = false;
        isLaserCardRecType = false;
        isPAERecType = false;
        isRCNHRecType = false;
        isCustService = false;
        ispivCLASS = false;
        isActivIDRecType = false;
        objCase = new case();
        
        isProductAsure = false;
        isProductEasyLobby = false;
        isProductPrinters = false;
        strCaseId = apexpages.currentpage().getParameters().get('id');
        
        
        
        string strRecTypeId = apexpages.currentpage().getParameters().get('RecordType');
        string strContactId = apexpages.currentpage().getParameters().get('def_contact_id');
        if(strCaseId != null && strCaseId != ''){
            isCaseEdit = true;
            objCase = [select id,ownerid, Asure_ID_Problem_Code__c, Printer_Problem_Code__c, EasyLobby_Problem_Code__c, Reason_for_Contact__c, Account.Name, RecordType.Name, status, RecordTypeId, Reason_Re_opened__c, CaseNumber, Test_Track_Pro_Item_Number__c, 
            ParentId, Origin, ContactId, Priority, AccountId, Support_Level__c, Unique_Company_Name__c, Time_Spent__c, 
            Case_Language__c, Region__c, Firmware__c, Product__c, OS__c, Model__c, OS_Language__c, Configuration_Card_Part__c, 
            Allow_Remote_Support__c, Subject, Description,  Use_Contact_Address_for_Shipping__c, 
            Shipping_From_HID_Region__c, Attention__c, Via__c, Shipping_Address__c, shipping_Account__c, Product_Description_1__c, 
            Quantity_1__c, Product_Description_2__c, Category__c, Quantity_2__c, Product_Description_3__c, Quantity_3__c, 
            Product_Description_4__c, Quantity_4__c, Product_Description_5__c, Quantity_5__c, Product_Description_6__c, 
            Quantity_6__c, RMA_Case__c, RMA_Type__c, RMA_Date_In__c, Oracle_RMA_Creation_Date__c, RMA_SF_Date__c, 
            RMA_Number_In__c, Advanced_Replacement_Created_Date__c, Oracle_Disposition_Date__c, RMA_Received_Date__c, 
            RMA_Type_Out__c, RMA_Tested_Date__c, RMA_Number_Out__c, RMA_Technician__c, Replacement_Shipped_Date__c, 
            RMA_Expiration_Date__c, SuppliedEmail, SuppliedCompany, SuppliedName, SuppliedPhone, Source_System__c, 
            Source_System_ID__c, Checked_for_Spam__c, Purchase_Path__c, Channel_Partner_account__c,
            Serial_License_No_Lookup__c, 
            Loaner_Requested__c, IsVisibleInSelfService, Repair_Time__c, Printer_Serial_Number_or_Asure_ID__c,
            Driver__c, Software__c, Beta__c, Lamination_Type__c, Ribbon_Type__c, Card_Count__c,
            Card_Type__c, Problem_Code_NewList__c, RMA_Date_Out__c, Order_Issue__c, Contract__c,
            Type from case where id =: strCaseId];
            strAccName = objCase.Account.Name;
            if(strRecTypeId != null){
                if(objCase.RecordTypeId != strRecTypeId){
                    objCase.Product__c = null;
                    objCase.Model__c = null;
                    objCase.Problem_Code_NewList__c = null;
                    objCase.Category__c = null;
                }
                objCase.RecordTypeId = strRecTypeId;         
                RecordType objRecType = [select id, Name from RecordType where id =: strRecTypeId];
                if(objRecType.Name == 'LaserCard'){
                    isLaserCardRecType = true;
                }
                if(objRecType.Name == 'Customer Service'){
                    isCustService = true;
                }
                if(objRecType.Name == 'pivCLASS'){
                    ispivCLASS = true;
                }
                if(objRecType.Name == 'Printer/Asure ID/EasyLobby'){
                    isPAERecType = true;
                }
                if(objRecType.Name == 'Readers/Cards/Network Products/HID on the Desktop'){
                    isRCNHRecType = true;
                }
                if(objRecType.Name == 'ActivID'){
                    isActivIDRecType = true;
                }
            }else{
                if(objCase.RecordType.Name == 'LaserCard'){
                    isLaserCardRecType = true;
                }
                if(objCase.RecordType.Name == 'Customer Service'){
                    isCustService = true;
                }
                if(objCase.RecordType.Name == 'pivCLASS'){
                    ispivCLASS = true;
                }
                if(objCase.RecordType.Name == 'Printer/Asure ID/EasyLobby'){
                    isPAERecType = true;
                }
                if(objCase.RecordType.Name == 'Readers/Cards/Network Products/HID on the Desktop'){
                    isRCNHRecType = true;
                }
                if(objCase.RecordType.Name == 'ActivID'){
                    isActivIDRecType = true;
                }   
            }
            if(objCase.ContactId != null){                
                List<Contact> lstContact = [select id, Accountid, Account.Name from Contact where id =: objCase.ContactId];
                if(lstContact.size() > 0){
                    if(lstContact[0].Accountid != null){
                        objCase.AccountId = lstContact[0].Accountid;
                        strAccName = lstContact[0].Account.Name;
                    }
                }
            }
            if(objCase.Product__c != null){
                if(objCase.Product__c == 'Asure ID'){
                    isProductAsure = true;
                }else if(objCase.Product__c == 'EasyLobby'){
                    isProductEasyLobby = true;
                }else if(objCase.Product__c == 'Printers'){
                    isProductPrinters = true;
                }
            }else if(objCase.Asure_ID_Problem_Code__c != null){
                isProductAsure = true;
            }else if(objCase.EasyLobby_Problem_Code__c != null){
                isProductEasyLobby = true;
            }else if(objCase.Printer_Problem_Code__c != null){
                isProductPrinters = true;
            }
        }else{            
            if(strContactId != null){
                objCase.contactId = strContactId;
                List<Contact> lstContact = [select id, Accountid, Account.Name from Contact where id =: objCase.ContactId];
                if(lstContact.size() > 0){
                    if(lstContact[0].Accountid != null){
                        objCase.AccountId = lstContact[0].Accountid;
                        strAccName = lstContact[0].Account.Name;
                    }
                }
            }
            objCase.ownerId = system.userinfo.getuserId();
            if(strRecTypeId != null){
                objCase.RecordTypeId = strRecTypeId;
                RecordType objRecType = [select id, Name from RecordType where id =: strRecTypeId];
                if(objRecType.Name == 'LaserCard'){
                    isLaserCardRecType = true;
                }
                if(objRecType.Name == 'Customer Service'){
                    isCustService = true;
                }
                if(objRecType.Name == 'pivCLASS'){
                    ispivCLASS = true;
                }
                if(objRecType.Name == 'Printer/Asure ID/EasyLobby'){
                    isPAERecType = true;
                }
                if(objRecType.Name == 'Readers/Cards/Network Products/HID on the Desktop'){
                    isRCNHRecType = true;
                }
                if(objRecType.Name == 'ActivID'){
                    isActivIDRecType = true;
                }
            }
            isCaseNew = true;
        }
        
        string strContractId = apexpages.currentpage().getParameters().get('00N80000004aFyy');
        if(strContractId != null && strContractId != ''){
            List<Contract> lstContract = [select id, Accountid,Account.Name, ContractNumber  from Contract where ContractNumber  =: strContractId];
            if(lstContract.size() > 0){
                if(ispivCLASS){
                    objCase.Contract__c = lstContract[0].Id; 
                    objCase.Accountid = lstContract[0].Accountid;    
                    strAccName = lstContract[0].Account.Name;             
                }
            }
        }
        
        
        string strSerialId = apexpages.currentpage().getParameters().get('00N800000045aaF');
        if(strSerialId != null && strSerialId != ''){
            List<Serial_Number_Model_Number__c> lstSerialNum = [select id, Name from Serial_Number_Model_Number__c where id =: strSerialId];
            if(lstSerialNum.size() > 0){
                if(ispivCLASS || isPAERecType || isLaserCardRecType){
                    objCase.Printer_Serial_Number_or_Asure_ID__c = lstSerialNum[0].Name;
                    objCase.Serial_License_No_Lookup__c = lstSerialNum[0].id;
                }
            }
        }
        objCaseComment = new CaseComment();        
    }
    Public pagereference saveCase(){ 
        setAccountName();      
        if(isCaseEdit == true){            
            if(objCase.Purchase_Path__c == 'Direct' && objCase.AccountId != null && objCase.Channel_Partner_account__c == null){
                objCase.Channel_Partner_account__c = objCase.AccountId;
            }
            if(objCase.Purchase_Path__c == 'Unknown'){
                objCase.Channel_Partner_account__c = null;
            }
            try {      
                update objCase;
            }catch (DMLException e){               
                return null;
            }
            if(objCaseComment.CommentBody != null){
                objCaseComment.ParentId = objCase.id;
                insert objCaseComment;
            }
        }else if(isCaseNew == true){
            if(objCase.Purchase_Path__c == 'Direct' && objCase.AccountId != null && objCase.Channel_Partner_account__c == null){
                objCase.Channel_Partner_account__c = objCase.AccountId;
            }
            if(objCase.Purchase_Path__c == 'Unknown'){
                objCase.Channel_Partner_account__c = null;
            }
            try {      
                insert objCase;
            }catch (DMLException e){               
                return null;
            }
            if(objCaseComment.CommentBody != null){
                objCaseComment.ParentId = objCase.id;
                insert objCaseComment;
            }
        }
        pagereference pr = new pagereference('/'+objCase.id);
        return pr;
    }  
    Public pagereference saveAndCloseCase(){
        setAccountName();       
        if(isCaseEdit == true){            
            if(objCase.Purchase_Path__c == 'Direct' && objCase.AccountId != null && objCase.Channel_Partner_account__c == null){
                objCase.Channel_Partner_account__c = objCase.AccountId;
            }
            if(objCase.Purchase_Path__c == 'Unknown'){
                objCase.Channel_Partner_account__c = null;
            }    
            try {      
                update objCase;
            }catch (DMLException e){                
                return null;
            }     
            if(objCaseComment.CommentBody != null){
                objCaseComment.ParentId = objCase.id;
                insert objCaseComment;
            }
        }else if(isCaseNew == true){
            if(objCase.Purchase_Path__c == 'Direct' && objCase.AccountId != null && objCase.Channel_Partner_account__c == null){
                objCase.Channel_Partner_account__c = objCase.AccountId;
            }
            if(objCase.Purchase_Path__c == 'Unknown'){
                objCase.Channel_Partner_account__c = null;
            }
            try {      
                insert objCase;
            }catch (DMLException e){
                system.debug('###########'+e.getmessage());               
                return null;
            } 
            if(objCaseComment.CommentBody != null){
                objCaseComment.ParentId = objCase.id;
                insert objCaseComment;
            }
        }
                           
        pagereference pr = new pagereference('/'+ objCase.id + '/s?retURL=/' + objCase.id);
        return pr;
    }      
    Public void setAccountName(){
        
        string strPurchasePath = apexpages.currentpage().getParameters().get('purcPath');
        List<Contact> lstContact = [select id, Accountid, Account.Name from Contact where id =: objCase.ContactId];
        if(lstContact.size() > 0){
            if(lstContact[0].Accountid != null){
                objCase.AccountId = lstContact[0].Accountid;
                strAccName = lstContact[0].Account.Name;
                if(strPurchasePath == 'Direct' || objCase.Purchase_Path__c == 'Direct'){
                    objCase.Channel_Partner_account__c = lstContact[0].Accountid;
                }else if(objCase.Purchase_Path__c == 'Unknown'){
                    objCase.Channel_Partner_account__c = null;
                }
                //objCase.Account.Name = lstContact[0].Account.Name;
            }
            objCase.ContactId = lstContact[0].id;
        }
        
    }
    
    Public void showProblemCode(){
        string strProduct = apexpages.currentpage().getParameters().get('drdValue');
        isProductAsure = false;
        isProductEasyLobby = false;
        isProductPrinters = false;
        if(strProduct != null){
            if(strProduct == 'Asure ID'){
                isProductAsure = true;
                objCase.Printer_Problem_Code__c = null;
                objCase.EasyLobby_Problem_Code__c = null;
            }else if(strProduct == 'EasyLobby'){
                isProductEasyLobby = true;
                objCase.Printer_Problem_Code__c = null;
                objCase.Asure_ID_Problem_Code__c = null;
            }else if(strProduct == 'Printers'){
                isProductPrinters = true;
                objCase.Asure_ID_Problem_Code__c = null;
                objCase.EasyLobby_Problem_Code__c = null;
            }
        }
    }
    
    Public pagereference cancelCase(){
        pagereference pr;
        if(strCaseId != null && strCaseId != ''){
            pr = new pagereference('/'+strCaseId);
        }else{
            pr = new pagereference('/500/o');
        }
        return pr;
    }
    
}