@isTest
private class extCasedetailEditTest{
    static testMethod void extCasedetailEditTest() {
        Account objAcc = new Account();
        objAcc.Name = 'Don Bilbo';
        insert objAcc;
        
        Contact objCon = new Contact();
        objCon.LastName = 'Test Contact';
        objCon.Accountid = objAcc.id;
        insert objCon;
        
        Case objCase = new Case();
        objCase.AccountId = objAcc.Id;          
        insert objCase;
        
        apexpages.currentpage().getParameters().put('id',objCase.id);
        apexpages.currentpage().getParameters().put('def_contact_id',objCon.id);
        ApexPages.StandardController stdCase = new ApexPages.StandardController(objCase);
        extCasedetailEdit objextCasedetailEdit  = new extCasedetailEdit(stdCase);
        objextCasedetailEdit.saveCase();
        
        apexpages.currentpage().getParameters().put('drdValue','Asure ID');
        objextCasedetailEdit.showProblemCode();
        
        objextCasedetailEdit.cancelCase();        
        Recordtype objRecType = [select id from Recordtype where Recordtype.Name = 'LaserCard' and SobjectType = 'case'];
        
        Case objCase1 = new Case();
        objCase1.AccountId = objAcc.Id; 
        objCase1.recordtypeid =  objRecType.id;      
        insert objCase1;
       
        apexpages.currentpage().getParameters().put('id',objCase1.id);
        objextCasedetailEdit  = new extCasedetailEdit(stdCase);
        apexpages.currentpage().getParameters().put('RecordType',objRecType.id);       
        
         
        ApexPages.StandardController stdCase1 = new ApexPages.StandardController(objCase1);
        extCasedetailEdit objextCasedetailEdit1  = new extCasedetailEdit(stdCase1);
        objextCasedetailEdit1.saveAndCloseCase();
        apexpages.currentpage().getParameters().put('drdValue','EasyLobby');
        objextCasedetailEdit1.showProblemCode();
        Recordtype objRecType2 = [select id from Recordtype where Recordtype.Name = 'Customer Service' and SobjectType = 'case'];
        
        Case objCase2 = new Case();
        objCase2.AccountId = objAcc.Id; 
        objCase2.recordtypeid =  objRecType2.id;      
        insert objCase2;
        
        apexpages.currentpage().getParameters().put('RecordType',null); 
        apexpages.currentpage().getParameters().put('id',objCase2.id);
        objextCasedetailEdit  = new extCasedetailEdit(stdCase);
        
        apexpages.currentpage().getParameters().put('RecordType',objRecType2.id); 
        
        ApexPages.StandardController stdCase2 = new ApexPages.StandardController(objCase2);
        extCasedetailEdit objextCasedetailEdit2  = new extCasedetailEdit(stdCase2);
        apexpages.currentpage().getParameters().put('drdValue','Printers');
        objextCasedetailEdit2.showProblemCode();
        Recordtype objRecType3 = [select id from Recordtype where Recordtype.Name = 'pivCLASS' and SobjectType = 'case'];
        
        Case objCase3 = new Case();
        objCase3.AccountId = objAcc.Id; 
        objCase3.recordtypeid =  objRecType3.id;      
        insert objCase3;
        
        apexpages.currentpage().getParameters().put('RecordType',null);
        apexpages.currentpage().getParameters().put('id',objCase3.id);  
        objextCasedetailEdit  = new extCasedetailEdit(stdCase);
        
        apexpages.currentpage().getParameters().put('RecordType',objRecType3.id); 
              
        ApexPages.StandardController stdCase3 = new ApexPages.StandardController(objCase3);
        extCasedetailEdit objextCasedetailEdit3  = new extCasedetailEdit(stdCase3);
        
        Recordtype objRecType4 = [select id from Recordtype where Recordtype.Name = 'Printer/Asure ID/EasyLobby'  and SobjectType = 'case'];
        
        Case objCase4 = new Case();
        objCase4.AccountId = objAcc.Id; 
        objCase4.recordtypeid =  objRecType4.id;      
        insert objCase4;
        
        apexpages.currentpage().getParameters().put('RecordType',null);
        apexpages.currentpage().getParameters().put('id',objCase4.id);  
        objextCasedetailEdit  = new extCasedetailEdit(stdCase);
        
        apexpages.currentpage().getParameters().put('RecordType',objRecType4.id);
        
        ApexPages.StandardController stdCase4 = new ApexPages.StandardController(objCase4);
        extCasedetailEdit objextCasedetailEdit4  = new extCasedetailEdit(stdCase4);
        
        Recordtype objRecType1 = [select id from Recordtype where Recordtype.Name = 'Readers/Cards/Network Products/HID on the Desktop' and SobjectType = 'case'];
        
        apexpages.currentpage().getParameters().put('RecordType',objRecType1.id); 
        objextCasedetailEdit  = new extCasedetailEdit(stdCase);
        
        apexpages.currentpage().getParameters().put('id',null); 
        
        ApexPages.StandardController stdCase5 = new ApexPages.StandardController(objCase);
        extCasedetailEdit objextCasedetailEdit5  = new extCasedetailEdit(stdCase5);
        objextCasedetailEdit5.saveCase();
        
        
        objextCasedetailEdit5.cancelCase();
        
        
        Recordtype objRecType6 = [select id from Recordtype where Recordtype.Name = 'LaserCard' and SobjectType = 'case'];
        apexpages.currentpage().getParameters().put('RecordType',objRecType6.id); 
        Case objCase6 = new Case();
        objCase6.AccountId = objAcc.Id; 
        objCase6.recordtypeid =  objRecType.id;      
        insert objCase6;     
        
        ApexPages.StandardController stdCase6 = new ApexPages.StandardController(objCase6);
        extCasedetailEdit objextCasedetailEdit6  = new extCasedetailEdit(stdCase6);
        objextCasedetailEdit6.saveAndCloseCase();
        
        Recordtype objRecType7 = [select id from Recordtype where Recordtype.Name = 'Customer Service' and SobjectType = 'case'];
        apexpages.currentpage().getParameters().put('RecordType',objRecType7.id); 
        Case objCase7 = new Case();
        objCase7.AccountId = objAcc.Id; 
        objCase7.recordtypeid =  objRecType7.id;      
        insert objCase7;
        
        ApexPages.StandardController stdCase7 = new ApexPages.StandardController(objCase7);
        extCasedetailEdit objextCasedetailEdit7  = new extCasedetailEdit(stdCase7);
        
        Recordtype objRecType8 = [select id from Recordtype where Recordtype.Name = 'pivCLASS' and SobjectType = 'case'];
        apexpages.currentpage().getParameters().put('RecordType',objRecType8.id); 
        Case objCase8 = new Case();
        objCase8.AccountId = objAcc.Id; 
        objCase8.recordtypeid =  objRecType3.id;      
        insert objCase8;
      
        ApexPages.StandardController stdCase8 = new ApexPages.StandardController(objCase8);
        extCasedetailEdit objextCasedetailEdit8  = new extCasedetailEdit(stdCase8);
        
        Recordtype objRecType9 = [select id from Recordtype where Recordtype.Name = 'Printer/Asure ID/EasyLobby'  and SobjectType = 'case'];
        apexpages.currentpage().getParameters().put('RecordType',objRecType9.id); 
        Case objCase9 = new Case();
        objCase9.AccountId = objAcc.Id; 
        objCase9.recordtypeid =  objRecType9.id;    
        insert objCase9;
        
        ApexPages.StandardController stdCase9 = new ApexPages.StandardController(objCase9);
        extCasedetailEdit objextCasedetailEdit9  = new extCasedetailEdit(stdCase9);        
        objextCasedetailEdit9.objCase.ContactId = objCon.id;
        objextCasedetailEdit9.setAccountName();
        apexpages.currentpage().getParameters().put('purcPath','Direct');
        objextCasedetailEdit9.setAccountName();
    }
}