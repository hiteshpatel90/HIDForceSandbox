@isTest (seealldata= true)

public class TicketSubmissionControllerTest{
       
    static testMethod void submitTicketforActiveContact(){
      
      String char1;
      String char2;
      String char3;
      String char4;
      String char5;
      String char6;
      String input;
      String CaseNumber;     
      String strSelPriority;
      String probDesc;
      String cardCount;
      String remedyProb;
      String first_name;
      String last_name;
      String title;
      String company;
      String address1;
      String address2;
      String city;
      String zipCode;
      String phone;
      String fax;
      String email;
      String confirmEmail; 
      String country;
      String State;
      List<SelectOption> options;
      String ipAddress;
      String useragent;
      String LongDate;
      List<String> characters;
        
        Case objCase = new Case(Priority = 'Medium', Case_Language__c = 'English', Product__c = 'Asure ID', Model__c = 'Asure ID 5.X',
                                Subject = 'Asure ID', Contact_Phone_Web__c = '+49 6123 791 245');       
    
        ApexPages.StandardController contr = new ApexPages.StandardController(objCase);
        ApexPages.CurrentPage().getParameters().put('id', objCase.id);
        apexpages.currentpage().getparameters().put('lang','en');   
        TicketSubmissionController tktSubmitCont = new TicketSubmissionController(contr);
        
        tktSubmitCont.getStatesSelectList();
        
        char1 = tktSubmitCont.getChar1();
        char2 = tktSubmitCont.getChar2();
        char3 = tktSubmitCont.getChar3();
        char4 = tktSubmitCont.getChar4();
        char5 = tktSubmitCont.getChar5();
        char6 = tktSubmitCont.getChar6();
        tktSubmitCont.input = char1+char2+char3+char4+char5+char6;
        tktSubmitCont.country = 'India';
        tktSubmitCont.probDesc = 'Test Problem';
        tktSubmitCont.remedyProb = 'Test Remedy';
        tktSubmitCont.first_name = 'Test First Name';
        tktSubmitCont.last_name = 'Test Last Name';
        tktSubmitCont.company = 'Jade';
        tktSubmitCont.address1 = 'Test add1';
        tktSubmitCont.city = 'Pune';
        tktSubmitCont.cardCount = '2255';
        tktSubmitCont.zipCode = '23566';        
        tktSubmitCont.email = 'jackermann@hidglobal.com';
        tktSubmitCont.confirmEmail = 'jackermann@hidglobal.com';
        tktSubmitCont.validate();
    }
    
  static testMethod void submitTicketforInActiveContact(){
      
      String char1;
      String char2;
      String char3;
      String char4;
      String char5;
      String char6;
      String input;
      String CaseNumber;     
      String strSelPriority;
      String probDesc;
      String cardCount;
      String remedyProb;
      String first_name;
      String last_name;
      String title;
      String company;
      String address1;
      String address2;
      String city;
      String zipCode;
      String phone;
      String fax;
      String email;
      String confirmEmail; 
      String country;
      String State;
      List<SelectOption> options;
      String ipAddress;
      String useragent;
      String LongDate;
      List<String> characters;
        
        Case objCase = new Case(Priority = 'Medium', Case_Language__c = 'English', Product__c = 'Asure ID', Model__c = 'Asure ID 5.X',
                                Subject = 'Asure ID', Contact_Phone_Web__c = '805 698 3574');       
    
        ApexPages.StandardController contr = new ApexPages.StandardController(objCase);
        ApexPages.CurrentPage().getParameters().put('id', objCase.id);
        TicketSubmissionController tktSubmitCont = new TicketSubmissionController(contr);
        
        tktSubmitCont.getStatesSelectList();
        
        char1 = tktSubmitCont.getChar1();
        char2 = tktSubmitCont.getChar2();
        char3 = tktSubmitCont.getChar3();
        char4 = tktSubmitCont.getChar4();
        char5 = tktSubmitCont.getChar5();
        char6 = tktSubmitCont.getChar6();
        tktSubmitCont.input = char1+char2+char3+char4+char5+char6;
        tktSubmitCont.country = 'India';
        tktSubmitCont.probDesc = 'Test Problem';
        tktSubmitCont.remedyProb = 'Test Remedy';
        tktSubmitCont.first_name = 'Test First Name';
        tktSubmitCont.last_name = 'Test Last Name';
        tktSubmitCont.company = 'Jade';
        tktSubmitCont.address1 = 'Test add1';
        tktSubmitCont.city = 'Pune';       
        tktSubmitCont.zipCode = '23566';        
        tktSubmitCont.email = 'abc@xyz.com';
        tktSubmitCont.confirmEmail = 'abc@xyz.com';
        tktSubmitCont.validate();
    }
     
     static testMethod void submitTicketforInvalidCaptcha(){
      
      String char1;
      String char2;
      String char3;
      String char4;
      String char5;
      String char6;
      String input;
      String CaseNumber;     
      String strSelPriority;
      String probDesc;
      String cardCount;
      String remedyProb;
      String first_name;
      String last_name;
      String title;
      String company;
      String address1;
      String address2;
      String city;
      String zipCode;
      String phone;
      String fax;
      String email;
      String confirmEmail; 
      String country;
      String State;
      List<SelectOption> options;
      String ipAddress;
      String useragent;
      String LongDate;
      List<String> characters;
        
        Case objCase = new Case(Priority = 'Medium', Case_Language__c = 'English', Product__c = 'Asure ID', Model__c = 'Asure ID 5.X',
                                Subject = 'Asure ID', Contact_Phone_Web__c = '805 698 3574');       
    
        ApexPages.StandardController contr = new ApexPages.StandardController(objCase);
        ApexPages.CurrentPage().getParameters().put('id', objCase.id);
        TicketSubmissionController tktSubmitCont = new TicketSubmissionController(contr);
        
        tktSubmitCont.getStatesSelectList();
        
        char1 = tktSubmitCont.getChar1();
        char2 = tktSubmitCont.getChar2();
        char3 = tktSubmitCont.getChar3();
        char4 = tktSubmitCont.getChar4();
        char5 = tktSubmitCont.getChar5();
        char6 = tktSubmitCont.getChar6();
        tktSubmitCont.input = char1+char2+char3+char4+char5+char2;
        tktSubmitCont.country = 'India';
        tktSubmitCont.probDesc = 'Test Problem';
        tktSubmitCont.remedyProb = 'Test Remedy';
        tktSubmitCont.first_name = 'Test First Name';
        tktSubmitCont.last_name = 'Test Last Name';
        tktSubmitCont.company = 'Jade';
        tktSubmitCont.address1 = 'Test add1';
        tktSubmitCont.city = 'Pune';       
        tktSubmitCont.zipCode = '23566';        
        tktSubmitCont.email = 'abc@xyz.com';
        tktSubmitCont.confirmEmail = 'abc@xyz.com';
        tktSubmitCont.validate();
    }
}