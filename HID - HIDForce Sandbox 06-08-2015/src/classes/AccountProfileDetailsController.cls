public class AccountProfileDetailsController{
    Id recordId = ApexPages.CurrentPage().getParameters().get('Id');
    public List<Account_Profile__c>acProfile  {get;set;}
    
    Price_Authorization_Form__c priceAuthorization =  new Price_authorization_Form__c();
     
    public AccountProfileDetailsController(ApexPages.StandardController controller) {
    priceAuthorization = [SELECT Account__c FROM Price_Authorization_Form__c where Id =:recordId];
        getAccountProfileDetails();
}

     public void getAccountProfileDetails(){
        acProfile = new List<Account_Profile__c>(); 
        if(priceAuthorization.account__c != null){
            acProfile = [SELECT Business_Segment__c, Partner_Type__c, Tier__c,Sales_Manager__c FROM Account_Profile__c WHERE account__c = :priceAuthorization.account__c];
        }   
    }
}