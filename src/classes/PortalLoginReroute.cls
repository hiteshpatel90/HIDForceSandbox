public class PortalLoginReroute
{   
    public class applicationException extends Exception {}
    //Call the portal authentication controller
    HidPortalAuthenticationController pController = new HidPortalAuthenticationController();
    
    //Token for Authentication
    private string Token;
    
    //Variable to store ID passed in via Encryption.
    public string tempId{get; set;}
    
    //Constructor for MainDisplayPageController       
    public PageReference Authenticate()
    {
        //Checks for string containing Partner_Name__c
        if(ApexPages.currentPage().getParameters().get('u') != null){
            tempId = ApexPages.currentPage().getParameters().get('u');  
            tempid = tempid.replace('+','%2b');
            tempid = tempid.replace(' ','%2b');
        }else{
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.ERROR, 'No partner name passed in through portal.');
            ApexPages.addMessage(myMsg);
        }
    
        //Checks for Token
        if(ApexPages.currentPage().getParameters().get('token') != null){
            token = ApexPages.currentPage().getParameters().get('token');
        }else{
            token = 'None';
        }
    
        //Authentication
        string temp = pController.urlCallout(token);
        if((temp == '1') && (TempId != null)){
            return TestLogin();
        }else
        {
            //If unauthenticaed : return error
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.ERROR, 'Authentication timed out');
            ApexPages.addMessage(myMsg);
            return ApexPages.currentpage();
        }
    }


    public PageReference TestLogin(){
        
        string url         = System.Label.HidPortalSFDC_URL;
        string returl      = '/apex/maindisplaypage'; 
        String username    = System.Label.HidPortalSFDCUsername;
        String password    = System.Label.HidPortalSFDCPassword;
        
        //string url = 'https://test.salesforce.com';
        //string returl = '/apex/maindisplaypage';
        
        //String username = 'rodney@leadmd.com.dev4';
        //String username = 'tvuong@hidglobal.com3';
        //String password = '11qqaazz';
        //String password = 'testingleads2013';
        
        
        
        string encodedUser = EncodingUtil.urlEncode(username, 'UTF-8');
        string encodedPass = EncodingUtil.urlEncode(password, 'UTF-8');
       
        
        string firstPage = url + '?un='+username+'&pw='+password;
        string redirPage = '&startURL=' + EncodingUtil.urlEncode(returl +'?u='+tempID+'&token='+Token, 'UTF-8');
        
        PageReference newpage = new PageReference(firstPage + redirPage);
       // newPage.getParameters().put('retURL', '/apex/mainDisplayPage?u=alksdjflaskjfda&token=' + token );
         newpage.setredirect(true);
        system.debug('Test' + redirPage);
        return newPage;
    }
    




}