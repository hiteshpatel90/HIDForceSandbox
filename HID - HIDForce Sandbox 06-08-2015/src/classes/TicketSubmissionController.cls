public class TicketSubmissionController{
    public Case objCase {get;set;}
    public String CaseNumber{get;set;}      
    public String strSelPriority {get;set;}
    public String probDesc {get;set;}
    public String cardCount {get;set;}
    public String remedyProb {get;set;}
    public String first_name {get;set;}
    public String last_name {get;set;}
    public String title {get;set;}
    public String company {get;set;}
    public String address1 {get;set;}
    public String address2 {get;set;}
    public String city {get;set;}
    public String zipCode {get;set;}
    public String phone {get;set;}
    public String fax {get;set;}
    public String email {get;set;}
    public String confirmEmail {get;set;} 
    public String country {get; set;}
    public String State {get;set;}
    public  List<SelectOption> options {get; set;}
    public String ipAddress;
    public String useragent;
    public String LongDate {get; set;}
    List<String> characters;
    public String input {get; set;}
    public String result {get; set;}
    String char1;
    String char2;
    String char3;
    String char4;
    String char5;
    String char6;
    public String secCode {get;set;}
    public String strLanguageCode{get;set;}
    
    public TicketSubmissionController(ApexPages.StandardController controller) {
        cardCount = null;        
        objcase = new Case();
        characters = new List<String>{'a','b','c','d','e','f','g','h',
        'i','j','k','l','m','n','o','p','q','r','s','t','u','v','w',
        'x','y','z','1','2','3','4','5','6','7','8','9','0'};            
        ipAddress = ipAddress = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
        useragent = ApexPages.currentPage().getHeaders().get('User-Agent');
        strLanguageCode = apexpages.currentpage().getparameters().get('lang');     
        getCountriesSelectList();
    }
    
    public List<SelectOption> getCountriesSelectList(){
        options = new List<SelectOption>();
        options.add(new SelectOption('', 'Select Country'));
        
        // Find all the countries in the custom setting
        Map<String, Countries__c> countries = Countries__c.getAll(); 
        
        // Sort them by name
        List<String> countryNames = new List<String>();
        for(Countries__c cntry :countries.values()){
        
            countryNames.add(cntry.Country__c);
        }
        countryNames.sort();
        
        // Create the Select Options.
        for (String countryName : countryNames) {
            //Countries__c country = countries.get(countryName);
            //options.add(new SelectOption(country.Name, country.Country__c));
            options.add(new SelectOption(countryName, countryName));
        }        
        return options;   
    }
    
    public List<SelectOption> getStatesSelectList() {    
        List<SelectOption> options = new List<SelectOption>();
        // Find all the states we have in custom settings.
        Map<String, States__c> allstates = States__c.getAll();
        
        // Filter states that belong to the selected country
        Map<String, States__c> states = new Map<String, States__c>();
        for(States__c state : allstates.values()) {
            if (state.Country__c == this.country) {
                states.put(state.Name, state);
            }
        }
        
        // Sort the states based on their names
        List<String> stateNames = new List<String>();
        stateNames.addAll(states.keySet());
        stateNames.sort();
        
        // Generate the Select Options based on the final sorted list
        for (String stateName : stateNames) {
            States__c state = states.get(stateName);
            options.add(new SelectOption(state.State__c, state.Name));
        }
        
        // If no states are found, just say not required in the dropdown.
        if (options.size() > 0) {
            options.add(0, new SelectOption('', '-- N/A --'));
        } else {
            options.add(new SelectOption('', system.label.Case_State_Not_Req));
            //options.add(new SelectOption('', 'Not Required'));
        }
        return options;
        }
        
        public Integer randomNumber(){
            Integer random = Math.Round(Math.Random() * characters.Size());
            if(random == characters.size()){
            random--;
        }
        return random;
    }
    
    public String getChar1(){
        char1 = characters[randomNumber()];
        secCode = char1;
        return char1;
    }
    public String getChar2(){
        Char2 = characters[randomNumber()];
        secCode += char2;
        return Char2;
    }
    public String getChar3(){
        char3 = characters[randomNumber()];
        secCode += char3;
        return char3;
    }
    public String getChar4(){
        char4 = characters[randomNumber()];
        secCode += char4;
        return char4;
    }
    public String getChar5(){
        char5 = characters[randomNumber()];
        secCode += char5;
        return char5;
    }
    public String getChar6(){
        char6 = characters[randomNumber()];
        secCode += char6;
        return char6;
    }
    
    public PageReference validate(){    
        if(input.length() == 6 && input.subString(0,1) == char1 && input.subString(1,2) == char2 && input.subString(2,3) == char3 && input.subString(3,4) == char4 && input.subString(4,5) == char5  && input.subString(5,6) == char6){
            // result = 'Whoohoo! You got it right.';
            return saveCase();             
        }else{
            //  result = 'Come on...the letters aren\'t matching the image.';
            return null; 
        }
    }
    
    public PageReference saveCase(){
        Datetime cDT = System.now();        
        LongDate = cDT.format('EE MMM dd yyyy HH:mm:ss Z');
        Countries__c con = [SELECT Region__c From Countries__c Where Country__c =:country];
        PageReference pr = null;
        
        List<Contact> conList = new List<Contact>();
        conList = [SELECT Id FROM Contact WHERE Email =: email AND Phone =: objCase.Contact_Phone_Web__c AND Status__c = 'Active'];
        if(conList.size() == 1){        
            objCase.ContactId = conList[0].Id;        
        }
        
        objCase.Region__c = con.Region__c;
        if(cardCount != null && cardCount != ''){        
            objCase.Card_Count__c = Decimal.Valueof(cardCount);
        }
        objCase.SuppliedEmail = email;
        objCase.Subject = objCase.Product__c + ': ' + objCase.Model__c;
        objCase.Origin = 'Web Form: Tech Support'; 
        objCase.Description = 'Problem: '+ probDesc + '\n \n' + 'First Name: '+ first_name + '\n' + 'Last Name: '+last_name+'\n'+ 'Title: '+ title + '\n' +  '\n' + 'Product: '+ objCase.Product__c + '\n'+ 'Model: ' + objCase.Model__c + '\n' + '\n' +
        'Company: '+ company +'\n' + 'Address: '+ address1+'\n'+'Address2: '+ address2 +'\n'+ 'City: '+city +'\n'; 
        if(State == null){
            State = '';
        }
        objCase.Description = objCase.Description + 'State: '+ State + '\n'+ 'Country: '+ country + '\n' + 'Region: '+ con.Region__c + '\n' + 'ZIP Code: '+ zipCode +'\n'+ 'Telephone: ' + objCase.Contact_Phone_Web__c +'\n'+ 'Fax: '+ fax+'\n'+'Email: '+email+'\n'+'Confirm Email: '+confirmEmail+'\n'+'Remedy Problem: ' + remedyProb +'\n' + 'Submit Time: ' +  LongDate + '\n'+ 'IP Address: '+ ipAddress + '\n' + 'User Agent: ' + useragent + '\n';
        
        if(objCase.Priority == null){
        objCase.Priority = '';
        }   
        objCase.Description = objCase.Description + 'Priority: '+ objCase.Priority + '\n';        
        
        objCase.Description = objCase.Description + 'Language: '+ objCase.Case_Language__c + '\n' + 'Product: '+ objCase.Product__c + '\n'+ 'Model: ' + objCase.Model__c + '\n';      
        
        if(objCase.Software__c == null){
            objCase.Software__c = '';
        }                              
        objCase.Description = objCase.Description +'Software: ' + objCase.Software__c + '\n';
        
        if(objCase.Printer_Serial_Number_or_Asure_ID__c == null){
            objCase.Printer_Serial_Number_or_Asure_ID__c = '';
        }
        objCase.Description = objCase.Description + 'Serial Number: ' + objCase.Printer_Serial_Number_or_Asure_ID__c + '\n';
        
        if(objCase.OS__c == null){
            objCase.OS__c = '';
        }  
        objCase.Description = objCase.Description + 'Operating System: ' + objCase.OS__c + '\n' ;
        if(objCase.Firmware__c == null){
            objCase.Firmware__c = '';
        }
        objCase.Description = objCase.Description + 'Firmware: ' +objCase.Firmware__c + '\n';
        if(cardCount == null){
            cardCount = '';      
        }           
        objCase.Description = objCase.Description + 'Card Count: ' + cardCount + '\n';
        if(objCase.Ribbon_Type__c == null){
            objCase.Ribbon_Type__c = '';
        }
        objCase.Description = objCase.Description + 'Ribbon Type: '+ objCase.Ribbon_Type__c +'\n';
        if(objCase.Card_Type__c == null){
            objCase.Card_Type__c = '';
        }
        objCase.Description = objCase.Description +'Card Type: '+ objCase.Card_Type__c + '\n'; 
        if(objCase.Lamination_Type__c == null){
            objCase.Lamination_Type__c = '';
        }
        objCase.Description = objCase.Description + 'Laminate Type: '+objCase.Lamination_Type__c ;
        
        if(objCase.Product__c != 'pivCLASS' || objCase.Product__c != 'Asure ID' || objCase.Product__c != 'EasyLobby' || objCase.Product__c != 'Printers'){
            objCase.RecordTypeId = [SELECT ID FROM RecordType WHERE Name = 'Readers/Cards/Network Products/HID on the Desktop' and SobjectType = 'Case'].Id;
        }
        
        AssignmentRule AR = new AssignmentRule(); 
        AR = [select id from AssignmentRule where SobjectType = 'Case' and Active = true limit 1]; 
        
        if(AR != null){
            //Creating the DMLOptions for "Assign using active assignment rules" checkbox 
            Database.DMLOptions dmlOpts = new Database.DMLOptions();
            dmlOpts.EmailHeader.TriggerUserEmail = true; 
            dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id; 
            dmlOpts.EmailHeader.triggerAutoResponseEmail = true;
            objCase.setOptions(dmlOpts); 
            insert objCase;
            CaseNumber = [SELECT CaseNumber FROM Case where id =: objCase.Id].CaseNumber;
            pr = new PageReference('/apex/ThankYouPage'); 
        }       
        return pr;
    }  
}